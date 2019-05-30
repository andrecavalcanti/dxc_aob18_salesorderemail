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
}

