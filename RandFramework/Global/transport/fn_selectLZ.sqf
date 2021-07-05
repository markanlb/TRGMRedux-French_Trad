params ["_vehicle",["_isPickup", false]];
format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;

_redZonePositions = TRGM_VAR_ObjectivePossitions-TRGM_VAR_ClearedPositions-TRGM_VAR_HiddenPossitions;
_radius = 900;
_minimumDistance = 300;
_markers = [];

_baseRadius = 500;



//vehicle setUnitPos
// set base LZ for the way back.
if (objNull isEqualTo (_vehicle getVariable ["baseLZ", objNull])) then {
    // initial setup
    _flyHeight = 20;
    _vehicle flyInHeight _flyHeight;
    _vehicle FlyinheightASL [_flyHeight,_flyHeight,_flyHeight];
    _vehicle enableCopilot true;

    _vehicle setVariable ["baseLZ", position _vehicle, true];
};




// Objective Zones
{
    _markers pushBack ([_x, _radius] call TRGM_GLOBAL_fnc_selectLzCreateBolckedAreaMarker);
} forEach _redZonePositions;

// Base LZ
_baseLZPos = _vehicle getVariable ["baseLZ",objNull];
_baseReturnAllowed = _baseLZPos distance _vehicle > _baseRadius;
if (_baseReturnAllowed) then {
    _markers pushBack ([_baseLZPos ,_baseRadius , "ColorGreen" ] call TRGM_GLOBAL_fnc_selectLzCreateBolckedAreaMarker);
} else {
    _markers pushBack ([_baseLZPos vectorAdd [0.1,0.1,0],_baseRadius , "ColorWhite" ] call TRGM_GLOBAL_fnc_selectLzCreateBolckedAreaMarker);
};


// Chopper location when on ground
_vehiclePositon = objNull;
if (!([_vehicle] call TRGM_GLOBAL_fnc_helicopterIsFlying)) then {
    _vehiclePositon = position _vehicle;
    if (_baseLZPos distance2D _vehiclePositon > 100) then { // prevent double marker at base (colition with base restriction marker)
        _markers pushBack ([_vehiclePositon,_minimumDistance , "ColorWhite" ] call TRGM_GLOBAL_fnc_selectLzCreateBolckedAreaMarker);
    };
};



[_vehicle, _redZonePositions, _vehiclePositon,_baseLZPos, _radius,_minimumDistance, _markers,_baseRadius,_baseReturnAllowed,_isPickup] onMapSingleClick TRGM_GLOBAL_fnc_selectLzOnMapClick;

openMap true;
titleText[localize "STR_TRGM2_transport_fnselectLZ_SelectOutsideAO", "PLAIN"];
waitUntil {sleep 2; !visibleMap || !alive player};
onMapSingleClick "";
{ deleteMarkerLocal _X; } forEach _markers;

true;