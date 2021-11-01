// private _fnc_scriptName = "TRGM_GLOBAL_fnc_setCustomLoadout";
params [["_unit", objNull, [objNull]], ["_type", "", [""]]];



if (isNil "TRGM_VAR_useCustomFriendlyFactionLoadouts") then { TRGM_VAR_useCustomFriendlyFactionLoadouts = false; publicVariable "TRGM_VAR_useCustomFriendlyFactionLoadouts"; };
if (isNil "TRGM_VAR_useCustomEnemyFactionLoadouts")    then { TRGM_VAR_useCustomEnemyFactionLoadouts = false; publicVariable "TRGM_VAR_useCustomEnemyFactionLoadouts"; };
if (isNil "TRGM_VAR_useCustomMilitiaFactionLoadouts")  then { TRGM_VAR_useCustomMilitiaFactionLoadouts = false; publicVariable "TRGM_VAR_useCustomMilitiaFactionLoadouts"; };

if (TRGM_VAR_useCustomFriendlyFactionLoadouts || TRGM_VAR_useCustomEnemyFactionLoadouts || TRGM_VAR_useCustomMilitiaFactionLoadouts) then {
    private _unitClassName = [_type, typeOf _unit] select (_type isEqualTo "");
    private _configPath = (configFile >> "CfgVehicles" >> _unitClassName);

    private _riflemen = (configFile >> "CfgVehicles" >> "B_Soldier_F");
    private _leaders = _riflemen;
    private _atsoldiers = _riflemen;
    private _aasoldiers = _riflemen;
    private _engineers = _riflemen;
    private _grenadiers = _riflemen;
    private _medics = _riflemen;
    private _autoriflemen = _riflemen;
    private _snipers = _riflemen;
    private _explosiveSpecs = _riflemen;
    private _pilots = _riflemen;
    private _uavOps = _riflemen;

    switch (side _unit) do {
        case WEST: {
            if !(TRGM_VAR_useCustomFriendlyFactionLoadouts) exitWith {};
            _riflemen = (missionConfigFile >> "BluRifleman");
            _leaders = (missionConfigFile >> "BluLeader");
            _atsoldiers = (missionConfigFile >> "BluAT");
            _aasoldiers = (missionConfigFile >> "BluAA");
            _engineers = (missionConfigFile >> "BluEngineer");
            _grenadiers = (missionConfigFile >> "BluGrenadier");
            _medics = (missionConfigFile >> "BluMedic");
            _autoriflemen = (missionConfigFile >> "BluAutorifleman");
            _snipers = (missionConfigFile >> "BluSniper");
            _explosiveSpecs = (missionConfigFile >> "BluExplosiveSpec");
            _pilots = (missionConfigFile >> "BluPilot");
            _uavOps = (missionConfigFile >> "BluUavOp");
        };
        case EAST: {
            if !(TRGM_VAR_useCustomEnemyFactionLoadouts) exitWith {};
            _riflemen = (missionConfigFile >> "OpfRifleman");
            _leaders = (missionConfigFile >> "OpfLeader");
            _atsoldiers = (missionConfigFile >> "OpfAT");
            _aasoldiers = (missionConfigFile >> "OpfAA");
            _engineers = (missionConfigFile >> "OpfEngineer");
            _grenadiers = (missionConfigFile >> "OpfGrenadier");
            _medics = (missionConfigFile >> "OpfMedic");
            _autoriflemen = (missionConfigFile >> "OpfAutorifleman");
            _snipers = (missionConfigFile >> "OpfSniper");
            _explosiveSpecs = (missionConfigFile >> "OpfExplosiveSpec");
            _pilots = (missionConfigFile >> "OpfPilot");
            _uavOps = (missionConfigFile >> "OpfUavOp");
        };
        case INDEPENDENT: {
            if !(TRGM_VAR_useCustomMilitiaFactionLoadouts) exitWith {};
            _riflemen = (missionConfigFile >> "IndRifleman");
            _leaders = (missionConfigFile >> "IndLeader");
            _atsoldiers = (missionConfigFile >> "IndAT");
            _aasoldiers = (missionConfigFile >> "IndAA");
            _engineers = (missionConfigFile >> "IndEngineer");
            _grenadiers = (missionConfigFile >> "IndGrenadier");
            _medics = (missionConfigFile >> "IndMedic");
            _autoriflemen = (missionConfigFile >> "IndAutorifleman");
            _snipers = (missionConfigFile >> "IndSniper");
            _explosiveSpecs = (missionConfigFile >> "IndExplosiveSpec");
            _pilots = (missionConfigFile >> "IndPilot");
            _uavOps = (missionConfigFile >> "IndUavOp");
        };
    };

    [_unitClassName, getText(_configPath >> "displayName"), getText(_configPath >> "icon"), getText(_configPath >> "textSingular"), getNumber(_configPath >> "attendant"), getNumber(_configPath >> "engineer"), getNumber(_configPath >> "canDeactivateMines"), getNumber(_configPath >> "uavHacker")] params ["_className", "_dispName", "_icon", "_calloutName", "_isMedic", "_isEngineer", "_isExpSpecialist", "_isUAVHacker"];

    if (isNil "_className" ||isNil "_dispName" || isNil "_icon" || isNil "_calloutName") then {

    } else {
        if ([_configPath] call TRGM_GLOBAL_fnc_ignoreUnit) then {
            _unit setUnitLoadout _riflemen;
        } else {
            switch (_icon) do {
                case "iconManEngineer":     { _unit setUnitLoadout _engineers; };
                case "iconManMedic":      { _unit setUnitLoadout _medics; };
                case "iconManExplosive": { _unit setUnitLoadout _explosiveSpecs; };
                case "iconManLeader":     { _unit setUnitLoadout _leaders; };
                case "iconManOfficer":     { _unit setUnitLoadout _leaders; };
                case "iconManMG":         { _unit setUnitLoadout _autoriflemen; };
                case "iconManAT":         { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _aasoldiers; } else { _unit setUnitLoadout _atsoldiers; }; };
                default {
                    if (_isEngineer isEqualTo 1) then { _unit setUnitLoadout _engineers; };
                    if (_isMedic isEqualTo 1) then { _unit setUnitLoadout _medics; };
                    if (_isExpSpecialist isEqualTo 1) then { _unit setUnitLoadout _explosiveSpecs; };
                    if (_isUAVHacker isEqualTo 1) then { _unit setUnitLoadout _uavOps; };
                    if (["Auto", _dispName, true] call BIS_fnc_inString || ["Machine", _dispName, true] call BIS_fnc_inString) then { _unit setUnitLoadout _autoriflemen; };
                    if (_calloutName isEqualTo "AT soldier") then { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _aasoldiers; } else { _unit setUnitLoadout _atsoldiers; }; };
                    if ((_icon isEqualTo "iconMan")) then { if (_calloutName isEqualTo "sniper") then { _unit setUnitLoadout _snipers; } else { if (["Grenadier", _dispName] call BIS_fnc_inString || ["Grenadier", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _grenadiers; } else { if (["Pilot", _dispName] call BIS_fnc_inString || ["Pilot", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _pilots; } else { _unit setUnitLoadout _riflemen; }; }; }; };
                };
            };
        };
    };
};

true;