pageextension 50082 "pageextension50101" extends "Sales Order Shipment" //10026
{
    actions
    {
        addafter("Post and &Print")
        {
            action(DXCPostAndSend)
            {
                ApplicationArea = Basic,Suite;
                CaptionML = ENU='Post and Send',
                            ESM='Registrar y enviar',
                            FRC='Reporter et envoyer',
                            ENC='Post and Send';
                Ellipsis = true;
                Image = PostMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTipML = ENU='Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.',
                            ESM='Permite finalizar y preparar el documento para enviarlo según el perfil que cuenta con las preferencias de envío del cliente, por ejemplo, adjunto en un correo electrónico. La ventana "Enviar documento a" se abre primero para que se pueda confirmar o seleccionar un perfil de envío.',
                            FRC='Finalisez et préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un courriel. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.',
                            ENC='Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                trigger OnAction();
                var
                    ApprovalsMgmt : Codeunit "Approvals Mgmt.";
                    PrepaymentMgt : Codeunit "Prepayment Mgt.";
                    SalesPostSend : Codeunit "Sales-Post and Send";
                    // SalesLine : Record "Sales Line";
                begin
                    // >> AOB-18
                    if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then begin
                      if PrepaymentMgt.TestSalesPrepayment(Rec) then
                        ERROR(STRSUBSTNO(Text001,"Document Type","No."));

                      if PrepaymentMgt.TestSalesPayment(Rec) then
                        ERROR(STRSUBSTNO(Text002,"Document Type","No."));

                      // SalesLine.VALIDATE("Document Type","Document Type");
                      // SalesLine.VALIDATE("Document No.","No.");
                      // SalesLine.InsertFreightLine(FreightAmount);
                      //  CODEUNIT.RUN(CODEUNIT::"Ship-Post (Yes/No)",Rec);
                      //  IF "Shipping No." = '-1' THEN
                      //    ERROR('');
                    end;

                    if not IsApprovedForPosting then
                      exit;

                    SalesPostSend.SetFromShipment(true);
                    SalesPostSend.RUN(Rec);
                    if "Shipping No." = '-1' then
                      ERROR('');
                    // << AOB-18
                end;
            }
        }
    }   

    var            
      Text001 : TextConst ENU='There are non posted Prepayment Amounts on %1 %2.',ESM='No hay cantidades anticipo registradas en %1 %2.',FRC='Il y a des montants de paiement anticipé non reportés sur %1 %2.',ENC='There are non posted Prepayment Amounts on %1 %2.';
      Text002 : TextConst ENU='There are unpaid Prepayment Invoices related to %1 %2.',ESM='Existen facturas anticipo sin abonar relacionadas con %1 %2.',FRC='Il y a des factures pour paiement anticipé non payées associées à %1 %2.',ENC='There are unpaid Prepayment Invoices related to %1 %2.';
}

