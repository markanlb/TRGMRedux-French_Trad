format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;
if(!hasInterface) exitWith {};

params ["_thisCiv"];

_actionID = _thisCiv addaction [localize "STR_TRGM2_civillians_fnbadCivAddSearchAction_Button",{_this spawn TRGM_SERVER_fnc_badCivSearch}, nil,1.5,true,true,"","true",5];
_thisCiv setVariable ["searchActionID",_actionID];

true;