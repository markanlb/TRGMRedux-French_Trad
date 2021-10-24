// private _fnc_scriptName = "TRGM_SERVER_fnc_weatherAffectsAI";
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



private _iWeatherOption = call TRGM_GETTER_fnc_aWeatherOption;
if (_iWeatherOption >= 11 && {_iWeatherOption != 99}) then {
    [format["Mission Core: %1", "Weather Dependant AI Skill"], true] call TRGM_GLOBAL_fnc_log;
    //Set enemy skill
    {
        if (Side _x isEqualTo TRGM_VAR_EnemySide) then {
            _x setskill ["aimingAccuracy",0.01];
            _x setskill ["aimingShake",0.01];
            _x setskill ["aimingSpeed",0.01];
            _x setskill ["spotDistance",0.01];
            _x setskill ["spotTime",0.01];
        };
    } forEach allUnits;
    sleep 18030;
    //reset enemy skill
    {
        if (Side _x isEqualTo TRGM_VAR_EnemySide) then {
            _x setskill ["aimingAccuracy",0.15];
            _x setskill ["aimingShake",0.1];
            _x setskill ["aimingSpeed",0.2];
            _x setskill ["spotDistance",0.5];
            _x setskill ["spotTime",0.5];
        };
    } forEach allUnits;
    //reset enemy skill
};