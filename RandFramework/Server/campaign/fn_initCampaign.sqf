// private _fnc_scriptName = "TRGM_SERVER_fnc_initCampaign";
//call script to start campaign if campaign picked
//show noticboard to player
//    - Current Reputation Points and report
//    - a random mission will have started, when RTB, welldone message and tell to go to board for next assignment (when picked, fade out and in with new weather/time settings)
//            - show label on screen as fade in "Day 2 : 18:46 PM - Destroy Cache near XXX"
//    - option to request asset or recrute unit
//    - if 10 rep, then the mission to load will be a main mission, with 2 optional sides for intel only!  (may have to be negative 10??? instead of rewritig the rep stuff)

format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



call CUSTOM_MISSION_fnc_CustomCampaignObjectives;

if (TRGM_VAR_SaveType isEqualTo 0) then {
    ["INIT"] remoteExec ["TRGM_SERVER_fnc_setMissionBoardOptions",0,true];
    TRGM_VAR_MaxBadPoints =  1; publicVariable "TRGM_VAR_MaxBadPoints";
}
else {
    ["MISSION_COMPLETE"] remoteExec ["TRGM_SERVER_fnc_setMissionBoardOptions",0,true];
};

{
    if (!isPlayer _x) then {
        deleteVehicle _x;
    };
} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});

TRGM_VAR_CampaignInitiated =  true; publicVariable "TRGM_VAR_CampaignInitiated";

true;