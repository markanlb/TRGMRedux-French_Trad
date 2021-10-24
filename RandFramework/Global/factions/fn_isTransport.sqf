// private _fnc_scriptName = "TRGM_GLOBAL_fnc_isTransport";
params[["_className", "", [objNull, ""]]];
// format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



switch (typeName _className) do {
    case ("OBJECT") : {_className = typeOf _className};
};

if !(isClass (configFile >> "CfgVehicles" >> _className)) exitWith {false};

// 8 Is a weapons squad, so anything that can hold a whole squad can be considered a transport.
// Unless it is a non-wheeled vehicle, then 6 allows for hueys and smaller helicopters to be considered transports.
if (_className isKindOf "Car") exitWith {
    getNumber(configFile >> "CfgVehicles" >> _className >> "transportSoldier") >= 8;
};
getNumber(configFile >> "CfgVehicles" >> _className >> "transportSoldier") >= 6;