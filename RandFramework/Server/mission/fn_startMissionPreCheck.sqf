// private _fnc_scriptName = "TRGM_SERVER_fnc_startMissionPreCheck";
params ["_isFinal"];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



if (isNil "_isFinal") exitWith {};

private _bAllow = true;

if (isMultiplayer) then {

    private _bSLAlive = false;
    private _bK1_1Alive = false;
    if (!isnil "sl") then { //sl is leader of K1 - k2_1 is leader of K2
        _bSLAlive = alive sl;
    };
    if (!isnil "k2_1") then {
        _bK1_1Alive = alive k2_1;
    };

    if (_bSLAlive && str(player) != "sl") then {
        [(localize "STR_TRGM2_attemptendmission_Kilo1")] call TRGM_GLOBAL_fnc_notify;
        _bAllow = false;
    };

    if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
        [(localize "STR_TRGM2_attemptendmission_Kilo2")] call TRGM_GLOBAL_fnc_notify;
        _bAllow = false;
    };
    if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
            [(localize "STR_TRGM2_attemptendmission_Kilo1")] call TRGM_GLOBAL_fnc_notify;
            _bAllow = false;
    };


};

if (_bAllow) then {
    if (_isFinal) then {
        TRGM_VAR_FinalMissionStarted=true; publicVariable "TRGM_VAR_FinalMissionStarted";
    };

    chopper1 setVariable ["baseLZ", ([heliPad1] call TRGM_GLOBAL_fnc_getRealPos), true];
    [chopper1] spawn TRGM_GLOBAL_fnc_flyToBase;
    chopper1 setPos ([heliPad1] call TRGM_GLOBAL_fnc_getRealPos);
    chopper2 setPos ([airSupportHeliPad] call TRGM_GLOBAL_fnc_getRealPos);
    "transportChopper" setMarkerPos ([chopper1] call TRGM_GLOBAL_fnc_getRealPos);
    chopper1 engineOn false;
    chopper2 engineOn false;
    private _escortPilot = driver chopper2;
    {
        deleteWaypoint _x
    } foreach waypoints group _escortPilot;

    [15, TRGM_VAR_iMissionIsCampaign] spawn TRGM_GLOBAL_fnc_populateLoadingWait;
    sleep 0.2;
    [] remoteExec ["TRGM_SERVER_fnc_startMission",0,true];
    //[(localize "STR_TRGM2_attemptendmission_Ending")] call TRGM_GLOBAL_fnc_notify;
    //[] spawn TRGM_SERVER_fnc_endMission;
};

true;