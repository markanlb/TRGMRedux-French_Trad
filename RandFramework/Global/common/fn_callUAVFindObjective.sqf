format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;
[[], {

    [HQMan,localize "STR_TRGM2_callUAVFindObjective_UAVInbound"] remoteExecCall ["sideChat",0,false];
    sleep 10;

    //TRGM_VAR_AODetails select 0
    _sTargetName = format["objInformant%1",(TRGM_VAR_AODetails select 0) select 0];
    _officerObject = missionNamespace getVariable [_sTargetName , objNull];
    _targetPos = [_officerObject] call TRGM_GLOBAL_fnc_getRealPos;

    //HEREE  If pos is zero or target is not alive, show message saying that... and fail task too if target not supose to be dead??
    if (!(alive _officerObject) || _targetPos select 0 isEqualTo 0) then {
        //if task is still active, and teh target is dead, this must mean the task required the target to be alive (otherwise would have completed), so thereofre fail the task
        if (!(["InfSide0"] call FHQ_fnc_ttAreTasksCompleted)) then {
            sName = format["InfSide%1",0]; //zero because we only ever have the UAV option on the main objective
            [sName, "failed"] remoteExec ["FHQ_fnc_ttSetTaskState", 0];
            [[], {[(localize "STR_TRGM2_UAV_HTV_DEAD")] call TRGM_GLOBAL_fnc_notify;}] remoteExec ["call", 0];
        };
        [HQMan,(localize "STR_TRGM2_UAV_Fail")] remoteExecCall ["sideChat",0,false];

    }
    else {
        [HQMan,localize "STR_TRGM2_callUAVFindObjective_UAVScanned"] remoteExecCall ["sideChat",0,false];
        _test = nil;
        _markerName = format["MrkTargetLocation%1%2",_targetPos select 0, _targetPos select 1];
        _test = createMarker [_markerName, _targetPos];
        _test setMarkerShape "ICON";
        _test setMarkerType "o_inf";
        _test setMarkerText (localize "STR_TRGM2_callUAVFindObjective_HVTLocation");
        sleep 30;
        deleteMarker _markerName;
    };


}] remoteExec ["spawn", 2];

true;