// private _fnc_scriptName = "TRGM_GLOBAL_fnc_fireAOFlares";
params ["_Pos"];



if (isNil "_Pos") exitWith {};

private _flareposX = _Pos select 0;
private _flareposY = _Pos select 1;
private _flareposZ = 400;

private _flare1 = "F_40mm_white" createvehicle [_flareposX,_flareposY, _flareposZ];
_flare1 setVelocity [0,0,-10];
private _al_flare_light = "#lightpoint" createVehicle getPosATL _flare1;

TRGM_PUBLIC_fnc_setFlareLightStuff = {
    private _al_flare_light = _this select 0;
    private _flare1 = _this select 1;
    private _al_flare_intensity = 3;
    private _al_flare_range = 1000;

    private _al_color_flare = [1,1,1];
    private _flare_brig = _al_flare_intensity;

    sleep 3;

    _al_flare_light setLightAmbient _al_color_flare;
    _al_flare_light setLightColor _al_color_flare;
    _al_flare_light setLightIntensity _al_flare_intensity;
    _al_flare_light setLightUseFlare true;
    _al_flare_light setLightFlareSize 10;
    _al_flare_light setLightFlareMaxDistance 2000;
    _al_flare_light setLightAttenuation [/*start*/ _al_flare_range, /*constant*/1, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/50,/* hardlimitend*/_al_flare_range-10];
    _al_flare_light setLightDayLight true;

    private _inter_flare = 0;
    waitUntil {
        private _int_mic = 0.05 + random 0.1;
        sleep _int_mic;
        _flare_brig = _al_flare_intensity+random 1;
        _al_flare_light setLightIntensity _flare_brig;
        _inter_flare = _inter_flare + _int_mic;
        _al_flare_light setpos (getPosATL _flare1);
        _inter_flare >= 21
    };

    private _int_mic = 3;
    waitUntil {
        _flare_brig = _flare_brig - 10;
        _al_flare_light setLightIntensity _flare_brig;
        _int_mic = _int_mic-0.03;
        sleep 0.01;
        _int_mic <= 0;
    };
    deleteVehicle _al_flare_light;
};
publicVariable "TRGM_PUBLIC_fnc_setFlareLightStuff";
[_al_flare_light, _flare1] remoteExec ["TRGM_PUBLIC_fnc_setFlareLightStuff", 0];

true;