class InvasionPromoButton extends moButton;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super(GUIMenuOption).InitComponent(MyController, MyOwner);

    MyButton = GUIButton(MyComponent);
    //MyButton.OnClick = InternalOnClick;
    MyButton.Caption = ButtonCaption;
}

defaultproperties
{
}
