// private _fnc_scriptName = "TRGM_SERVER_fnc_finalSetupCleaner";
//loop through TRGM_VAR_friendlySentryCheckpointPos
//check if any of TRGM_VAR_CheckPointAreas + TRGM_VAR_SentryAreas are near
//if so, delete any friendly units
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;
{
    private _currentFriendCpPos = _x;
    private _enemyNear = false;
    //check if enemy near
    {
        if (side _x isEqualTo TRGM_VAR_EnemySide) then {
            _enemyNear = true;
        };
    } forEach nearestObjects [_currentFriendCpPos, ["Man","Car","Tank"], 400];
    //if enemy is near, then delete this friendly checkpoint
    if (_enemyNear) then {
        {
            if ((side _x isEqualTo TRGM_VAR_FriendlySide)) then {
                deleteVehicle _x;
            };
        } forEach nearestObjects [_currentFriendCpPos, ["Man","Car","Tank"], 100];
    };
} forEach TRGM_VAR_friendlySentryCheckpointPos;

//check AO camp pos, any enemy units within 150meters, delete
if (TRGM_VAR_iStartLocation isEqualTo 1) then {//move to ao camp
    {
        //if (_y distance getPos _x > TRGM_VAR_PunishmentRadius) then {
        if ((side _x isEqualTo TRGM_VAR_EnemySide)) then {
            deleteVehicle _x;
        };
        //};
    } forEach nearestObjects [TRGM_VAR_AOCampPos, ["Man","Car","Tank"], 100];
};
true;