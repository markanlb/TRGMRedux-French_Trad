// private _fnc_scriptName = "TRGM_CLIENT_fnc_findValidHQPosition";
params[["_player", objNull, [objNull]]];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



if (_player != player) exitWith {false;};

if ((call TRGM_CLIENT_fnc_isAdmin) && (isNil "TRGM_VAR_AdminPlayer" || isNull TRGM_VAR_AdminPlayer)) then {
    TRGM_VAR_AdminPlayer = player; publicVariable "TRGM_VAR_AdminPlayer";
};

if (TRGM_VAR_AdminPlayer isEqualTo player) then {
    if (!TRGM_VAR_HQPosFound) then {
        TRGM_VAR_playerIsChoosingHQpos = true; publicVariable "TRGM_VAR_playerIsChoosingHQpos";
        TRGM_VAR_MapClicked = 0; publicVariable "TRGM_VAR_MapClicked";

        OnMapSingleClick "TRGM_VAR_ClickedPos = _pos; TRGM_VAR_MapClicked = 1; publicVariable ""TRGM_VAR_MapClicked""";
        openMap [true, false];
        hintC (localize "STR_TRGM2_InitClickSomewhere");

        while {true} do {
            if (TRGM_VAR_MapClicked isEqualTo 1) then { // player has clicked the map
                private _foundPickupPos = [TRGM_VAR_ClickedPos, 0,50,25,0,0.15,0,[],[[0,0,0],[0,0,0]]] call TRGM_GLOBAL_fnc_findSafePos; // find a valid pos
                private _nearRoad = [_foundPickupPos,20] call BIS_fnc_nearestRoad;
                if ((!isNull _nearRoad) || ((0 isEqualTo (_foundPickupPos select 0)) && (0 isEqualTo (_foundPickupPos select 1))) || (TRGM_VAR_ClickedPos isEqualTo _foundPickupPos)) then {
                    // INVALID POS
                    TRGM_VAR_MapClicked = false;
                    hintC (localize "STR_TRGM2_InitClickInvalidPos");
                } else {
                    // VALID POS - Ask the player if they want to use the pos...
                    OnMapSingleClick "TRGM_VAR_MapClicked = 2; publicVariable ""TRGM_VAR_MapClicked""";
                    hintC (localize "STR_TRGM2_InitClickValidPos");
                    private _HQPosMarker = createMarker [format ["%1", random 10000], _foundPickupPos];
                    _HQPosMarker  setMarkerShape "ICON";
                    _HQPosMarker  setMarkerType "hd_dot";
                    _HQPosMarker  setMarkerSize [5,5];
                    _HQPosMarker  setMarkerColor "ColorGreen";
                    _HQPosMarker  setMarkerText "HQ Location";
                    waitUntil { sleep 1; ((TRGM_VAR_MapClicked isEqualTo 2) || !visibleMap); };
                    deleteMarker _HQPosMarker;
                    if (TRGM_VAR_MapClicked isEqualTo 2) then {
                        TRGM_VAR_MapClicked = 0; publicVariable "TRGM_VAR_MapClicked";
                        OnMapSingleClick "TRGM_VAR_ClickedPos = _pos; TRGM_VAR_MapClicked = 1; publicVariable ""TRGM_VAR_MapClicked""";
                    } else {
                        onMapSingleClick "";
                        openMap [false, false];
                        TRGM_VAR_foundHQPos = _foundPickupPOS;
                        publicVariable "TRGM_VAR_foundHQPos";
                        TRGM_VAR_HQPosFound = true; publicVariable "TRGM_VAR_HQPosFound";
                    };
                };
            };
            if (TRGM_VAR_HQPosFound) exitwith {true;};
            if !(visibleMap) then {openMap [true, false]; hintC (localize "STR_TRGM2_InitClickSomewhere");};
        };
    };
};