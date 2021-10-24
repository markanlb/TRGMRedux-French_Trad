// private _fnc_scriptName = "TRGM_GLOBAL_fnc_adjustMaxBadPoints";
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;


if (isNil "TRGM_VAR_CoreCompleted") then { TRGM_VAR_CoreCompleted =   false; publicVariable "TRGM_VAR_CoreCompleted"; };
if (!TRGM_VAR_CoreCompleted) exitWith {};

sleep random [1,2.5,5]; //to increase the chance of not fireing at same time! (not convinsed that the "PointsUpdating" variable actually helped)

waitUntil {sleep 2; !(TRGM_Logic getVariable "PointsUpdating")};
TRGM_Logic setVariable ["PointsUpdating", true, true];

params ["_pointsToAdd","_message"];


TRGM_VAR_MaxBadPoints = TRGM_VAR_MaxBadPoints + _pointsToAdd;
publicVariable "TRGM_VAR_MaxBadPoints";

TRGM_VAR_BadPointsReason = TRGM_VAR_BadPointsReason + format["<br /><t color='#00ff00'>%1 (+%2)</t>",_message,_pointsToAdd];
publicVariable "TRGM_VAR_BadPointsReason";

TRGM_Logic setVariable ["PointsUpdating", false, true];


TRGM_VAR_MaxBadPoints;