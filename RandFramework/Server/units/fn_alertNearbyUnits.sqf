// private _fnc_scriptName = "TRGM_SERVER_fnc_alertNearbyUnits";
/*
 * Author: TheAce0296
 * Alerts nearby enemy units to converge onto a positon.
 *
 * Arguments:
 * 0: A condition that must be true for the units to be/stay alerted. <CODE> or <BOOL>
 * 1: A central position units should converge towards. <POSITION>
 * 2: Radius from the center position to apply alertness to. <NUMBER>
 * 3: Whether to repeat the function if the condition was true. <BOOL>
 *    TRY NOT TO USE CYCLE MODE IF THE CONDITION IS NOT OF <CODE> TYPE!
 *    A safer alternative is to use a trigger, or a while loop to call TRGM_SERVER_fnc_alertNearbyUnits.
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [alive player, position player, 1500, false] spawn TRGM_SERVER_fnc_alertNearbyUnits
 */
params[
    ["_condition", {true}, [{},true]],
    ["_centerPos", []],
    ["_radius", 1500],
    ["_cycleMode", false]
];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



if (isNil "_condition" || isNil "_centerPos") exitWith {};

private _groupsAlerted = [];
private _conditionBool = _condition;
if (_conditionBool isEqualType {}) then {
    _conditionBool = call _condition;
};

if (_conditionBool) then {
    {
        private _group = _x;
        { deleteWaypoint _x; } forEach waypoints _group;
        if (!(_group in _groupsAlerted) && {(side _group isEqualTo TRGM_VAR_EnemySide || side _group isEqualTo TRGM_VAR_InsSide)}) then {
            private _groupLeader = leader _group;
            if (!((vehicle _groupLeader) isKindOf "Air") && {([_groupLeader] call TRGM_GLOBAL_fnc_getRealPos) distance _centerPos < _radius}) then {
                {
                    private _unit = _x;
                    _unit enableAI "ALL";
                    _unit setCombatMode "RED";
                    _unit setBehaviour "AWARE";
                    _unit forceSpeed -1;
                    _unit doMove _centerPos;
                    _unit setDestination [_centerPos, "FORMATION PLANNED", false];
                    _unit setSuppression 0;
                    _unit setUnitPosWeak "UP";
                } forEach units _group;
            };
        };
        _groupsAlerted pushBack _group;
    } forEach allGroups;
    sleep 60;
    if (_cycleMode) then {
        [_condition, _centerPos, _radius, _cycleMode] spawn TRGM_SERVER_fnc_alertNearbyUnits;
    };
};

true;