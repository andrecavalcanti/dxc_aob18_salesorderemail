codeunit 50005 "DXC Send Sales Confirm. Email"
{    
    TableNo = "Job Queue Entry";

    trigger OnRun();
    begin

        SalesHeader.SETRANGE("DXC Release Date",TODAY);
        if SalesHeader.FINDFIRST then
          repeat
            SendEmailConfirmation(SalesHeader);
          until SalesHeader.NEXT = 0;
    end;

    var
        SalesHeader : Record "Sales Header";

    local procedure SendEmailConfirmation(PSalesHeader : Record "Sales Header");
    var
        DocPrint : Codeunit "Document-Print";
    begin

        DocPrint.EmailSalesHeader(PSalesHeader);
    end;
}

