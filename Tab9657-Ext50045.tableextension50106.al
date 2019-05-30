tableextension 50045 "tableextension50106" extends "Custom Report Selection" //9657
{    
    fields
    {
        field(50000;"DXC Ship-to Code";Code[10])
        {
            CaptionML = ENU='Ship-to Code',
                        ESM='Cód. dirección envío cliente',
                        FRC='Code de livraison',
                        ENC='Ship-to Code';
            DataClassification = ToBeClassified;
            Description = 'AOB-18';
            TableRelation = "Ship-to Address".Code WHERE ("Customer No."=FIELD("Source No."));           
        }
        field(50001;"DXC Hide Mail Dialog";Boolean)
        {
            Caption = 'Suppress Email Dialog';
            DataClassification = ToBeClassified;
            Description = 'AOB-18';
        }
    }    

}

