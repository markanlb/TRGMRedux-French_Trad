// private _fnc_scriptName = "TRGM_CLIENT_fnc_missionSetupCamera";
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



showCinemaBorder true;
private _centerPos = getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition");
if !(isNil "TRGM_VAR_CustomCenterPos") then {
    _centerPos = TRGM_VAR_CustomCenterPos;
};

private _pos1 = (_centerPos getPos [(floor(random 5000))+50, (floor(random 360))]);
private _pos2 = (_centerPos getPos [(floor(random 5000))+50, (floor(random 360))]);
_pos1 = [_pos1 select 0,_pos1 select 1,selectRandom[200,300]];
_pos2 = [_pos2 select 0,_pos2 select 1,selectRandom[200,300]];
private _camera = "camera" camCreate _pos1;
_camera cameraEffect ["internal","back"];
_camera camPreparePos _pos2;
_camera camPrepareTarget _centerPos;
_camera camPrepareFOV 0.4;
_camera camCommitPrepared 600;
playMusic TRGM_VAR_IntroMusic;
[format["SelectLoop Music: %1", TRGM_VAR_IntroMusic ], true] call TRGM_GLOBAL_fnc_log;
player setVariable ["TRGM_VAR_Camera", _camera];

true;