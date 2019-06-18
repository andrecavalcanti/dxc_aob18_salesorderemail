codeunit 50004 "DXC Email Ship. Invoice Handle"
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure HandleAfterReleaseSalesDocOnReleaseSalesDoc(var SalesHeader : Record "Sales Header";PreviewMode : Boolean;LinesWereModified : Boolean);
    begin

        if (SalesHeader."DXC Release Date" = 0D) then
          SalesHeader."DXC Release Date" := TODAY;
    end;

    [EventSubscriber(ObjectType::Table, 77, 'OnBeforeSendEmailDirectly', '', false, false)]
    local procedure HandleBeforeSendEmailDirectlyOnReportSelections(var PShowDialog : Boolean;PReportSelections : Record "Report Selections");
    begin

        PShowDialog := PReportSelections."Use for Email Body";
    end;

    [EventSubscriber(ObjectType::Table, 77, 'OnBeforeSendEmailToCustDirectly', '', false, false)]
    local procedure "DXCHandleBeforeSendEmailToCustDirectlyOnReport Selections"(var Sender : Record "Report Selections";RecordVariant : Variant;var TempShipToAddress : Record "Ship-to Address" temporary);
    var
        RecRef : RecordRef;
        DataTypeMngt : Codeunit "Data Type Management";
        SalesHeader : Record "Sales Header";
    begin
        // >> AOB-18
        DataTypeMngt.GetRecordRef(RecordVariant,RecRef);
         case RecRef.NUMBER of
          DATABASE::"Sales Header":
            begin
              RecRef.SETTABLE(SalesHeader);
              //if (SalesHeader."Ship-to Code" <> '') then
              TempShipToAddress.Init;
              TempShipToAddress."Customer No." := SalesHeader."Sell-to Customer No.";
              TempShipToAddress.Code := SalesHeader."Ship-to Code";
              TempShipToAddress.insert;
              //ShipToCode := SalesHeader."Ship-to Code";              
            end;
        end;
        // << AOB-18
    end;

    [EventSubscriber(ObjectType::Table, 77, 'OnBeforeCopyToReportSelection', '', false, false)]
    local procedure "DXCHandleOnBeforeCopyToReportSelectionOnReportSelections"(var Sender : Record "Report Selections";var CustomReportSelection : Record "Custom Report Selection";var TempShipToAddress : Record  "Ship-to Address" temporary);
           
    begin
        // >> AOB-18
        if TempShipToAddress.FindFirst then
            CustomReportSelection.SetRange("DXC Ship-to Code",TempShipToAddress.Code)
        else
            CustomReportSelection.SetRange("DXC Ship-to Code",'')
        
        // << AOB-18
    end;
}

