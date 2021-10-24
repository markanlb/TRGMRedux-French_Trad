// private _fnc_scriptName = "TRGM_SERVER_fnc_exitCampaign";

format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



private _bAllow = true;
if (isMultiplayer) then {
    private _bSLAlive = false;
    private _bK1_1Alive = false;
    if (!isnil "sl") then {
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
    private _mrkHQPos = getMarkerPos "mrkHQ";
    private _AOCampPos = [endMissionBoard2] call TRGM_GLOBAL_fnc_getRealPos;
    bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers)) isEqualTo ({ (alive _x) } count (call BIS_fnc_listPlayers));

    if (TRGM_VAR_SaveType != 0) then {
        [TRGM_VAR_SaveType,false] spawn TRGM_SERVER_fnc_serverSave;
    };

    if (bAllAtBase2) then {
        [(localize "STR_TRGM2_exitCampaign_RepSaaved")] call TRGM_GLOBAL_fnc_notify;
        ["end4", true, 7] remoteExec ["BIS_fnc_endMission"];
        bAttemptedEnd = false; publicVariable "bAttemptedEnd";
    }
    else {
        [(localize "STR_TRGM2_exitCampaign_CampaignSaaved")] call TRGM_GLOBAL_fnc_notify;
    };
};


true;