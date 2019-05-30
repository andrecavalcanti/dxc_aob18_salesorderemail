pageextension 50058 "pageextension50103" extends "Customer Report Selections" //9657
{    
    layout
    {
        addafter("Email Body Layout Description")
        {
            field("DXC Ship-to Code";"DXC Ship-to Code")
            {
              ApplicationArea = All;
            }
            field("DXC Hide Mail Dialog";"DXC Hide Mail Dialog")
            {
              ApplicationArea = All;
            }
        }
        modify(Usage2)
        {
            OptionCaptionML = ENU='Quote,Confirmation Order,Invoice,Credit Memo,Customer Statement,Job Quote,Shipment',ESM='Cotización,Pedido de confirmación,Factura,Nota de crédito,Estado de cuenta de cliente,Cotización de trabajo',FRC='Devis,Commande confirmation,Facture,Note de crédit,Relevé client,Devis projet,Shipment',ENC='Quote,Confirmation Order,Invoice,Credit Memo,Customer Statement,Job Quote,Shipment';
            
            trigger OnAfterValidate();
              begin        
                 
              // >> AOB-18
              // Usage2::"DXC Shipment":
              //   Usage := Usage::"S.Shipment";
              // << AOB-18
              end;
        }     
    }
}

