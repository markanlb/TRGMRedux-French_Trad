// private _fnc_scriptName = "TRGM_CLIENT_fnc_isAdmin";
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



if (!isMultiplayer) exitWith {true;};

if (!isNil "TRGM_VAR_AdminPlayer" && !isNull TRGM_VAR_AdminPlayer) exitwith { player isEqualTo TRGM_VAR_AdminPlayer;};

if ((call BIS_fnc_admin) != 0) exitWith {true;};

if (str player isEqualTo "sl") exitWith {true;};

if (leader group player isEqualTo player) exitWith {true;};

false;