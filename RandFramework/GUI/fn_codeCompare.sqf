// private _fnc_scriptName = "TRGM_GUI_fnc_codeCompare";
/*
 * Author: Trendy
 * Takes an input code for the mission bomb and compares
 * it with the input from a player, if they are the same
 * the bomb is defused, otherwise it blows up.
 *
 * Arguments:
 * 0: The code inputed by the player <ARRAY>
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [CODEINPUT] spawn TRGM_GUI_fnc_codeCompare
 */
params ["_inputCode"];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



private _thisBomb = player getVariable["missionBomb", nil];
private _code = _thisBomb getVariable["missionBombCODE", "NONE"];

private _compare = [_code, _inputCode] call BIS_fnc_areEqual;
private _isWireCut = _thisBomb getVariable["_wireCut", false];

if (_compare && _isWireCut) then {
    cutText[localize "STR_TRGM2_BombCodeEntered", "PLAIN DOWN"];
    //DEFUSED = true;
    playSound "button_close";
    _thisBomb setVariable["_codeEntered", true, true];
    _thisBomb setVariable["isDefused", true, true];
    [_thisBomb] remoteExec["removeAllActions", 0, true];
    closeDialog 0;
} else {
    cutText[localize "STR_TRGM2_IEDOhOh", "PLAIN DOWN"];
    //ARMED = true;
    playSound "button_wrong";
    sleep 1;
    _BOOM = "Bomb_03_F"
    createVehicleLocal([_thisBomb] call TRGM_GLOBAL_fnc_getRealPos);
    _BOOM setDamage 1;
    deleteVehicle _thisBomb;
    closeDialog 0;
};

true;