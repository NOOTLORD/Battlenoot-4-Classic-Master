class InvasionProScriptedController extends ScriptedController;

function SetNewScript(ScriptedSequence NewScript)
{
    MyScript = NewScript;
    SequenceScript = NewScript;
    Focus = None;
    ClearScript();
    SetEnemyReaction(3);
    //SequenceScript.SetActions(self);
}

defaultproperties
{
}
