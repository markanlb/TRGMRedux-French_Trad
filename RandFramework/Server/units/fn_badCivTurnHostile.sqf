// private _fnc_scriptName = "TRGM_SERVER_fnc_badCivTurnHostile";
params ["_badCiv"];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



private _grpName = (createGroup [TRGM_VAR_EnemySide, true]);
[_badCiv] joinSilent _grpName;

[_badCiv] call TRGM_SERVER_fnc_badCivApplyAssingnedArmament;

_badCiv allowFleeing 0;

//remove search Civ action
[_badCiv] remoteExec ["TRGM_SERVER_fnc_badCivRemoveSearchAction",[0, -2] select isMultiplayer,true];


true;