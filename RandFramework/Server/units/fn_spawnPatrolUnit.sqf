// private _fnc_scriptName = "TRGM_SERVER_fnc_spawnPatrolUnit";
params ["_wayX","_wayY", "_group","_index","_IncludTeamLeader"];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;


call TRGM_SERVER_fnc_initMissionVars;

private _startPos = [_wayX + 5 + floor random 10,_wayY + 5 + floor random 10];
private _sUnitType = selectRandom [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
if (_index isEqualTo 0 && _IncludTeamLeader) then {
    _sUnitType = (call sTeamleaderToUse);
};
[_group, _sUnitType, _startPos, [], 0, "NONE"] call TRGM_GLOBAL_fnc_createUnit;