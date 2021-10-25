// private _fnc_scriptName = "TRGM_SERVER_fnc_hackIntel";
params ["_thisLaptop", "_caller", "_id", "_args"];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



private _objParams = _thisLaptop getVariable "ObjectiveParams";
_objParams params ["_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];

[_thisLaptop] call TRGM_SERVER_fnc_updateTask;

if (side _caller isEqualTo TRGM_VAR_FriendlySide && !_bCreateTask) then {
    for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
        if (getMarkerType format["mrkMainObjective%1", _i] isEqualTo "empty") then {
            format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
            [localize "STR_TRGM2_bugRadio_MapUpdated"] spawn TRGM_GLOBAL_fnc_notifyGlobal;
        } else {
            ["HackData", _iTaskIndex] spawn TRGM_GLOBAL_fnc_showIntel;
        };
    };
};

true;