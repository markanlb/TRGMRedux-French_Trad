// private _fnc_scriptName = "TRGM_SERVER_fnc_setAdmin";
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



{
    if (!isMultiplayer) exitWith {
        TRGM_VAR_AdminPlayer = _x; publicVariable "TRGM_VAR_AdminPlayer";
    };

    if ((admin owner _x) != 0 && (isNil "TRGM_VAR_AdminPlayer" || isNull TRGM_VAR_AdminPlayer)) then {
        TRGM_VAR_AdminPlayer = _x; publicVariable "TRGM_VAR_AdminPlayer";
    };

    if (str _x isEqualTo "sl" && (isNil "TRGM_VAR_AdminPlayer" || isNull TRGM_VAR_AdminPlayer)) then {
        TRGM_VAR_AdminPlayer = _x; publicVariable "TRGM_VAR_AdminPlayer";
    };

    if (leader group _x isEqualTo _x && (isNil "TRGM_VAR_AdminPlayer" || isNull TRGM_VAR_AdminPlayer)) then {
        TRGM_VAR_AdminPlayer = _x; publicVariable "TRGM_VAR_AdminPlayer";
    };
} forEach (allPlayers - entities "HeadlessClient_F");

true;