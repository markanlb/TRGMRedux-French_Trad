params[["_player", objNull, [objNull]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (_player != player) exitWith {false;};
_isAdmin = (!isMultiplayer || isMultiplayer && !isDedicated && isServer || isMultiplayer && !isServer && (call BIS_fnc_admin) != 0);
if (_isAdmin && isNull TRGM_VAR_AdminPlayer) then {
    TRGM_VAR_AdminPlayer = player; publicVariable "TRGM_VAR_AdminPlayer";
};

if ((!isNull TRGM_VAR_AdminPlayer && (str player isEqualTo "sl")) || (TRGM_VAR_AdminPlayer isEqualTo player)) then {
    TRGM_VAR_foundManualAOPos = [0,0,0]; publicVariable "TRGM_VAR_foundManualAOPos";
    TRGM_VAR_ManualAOPosFound = false; publicVariable "TRGM_VAR_ManualAOPosFound";
    if (!TRGM_VAR_ManualAOPosFound) then {
        TRGM_VAR_playerIsChoosingManualAOPos = true; publicVariable "TRGM_VAR_playerIsChoosingManualAOPos";
        TRGM_VAR_MapClicked = 0; publicVariable "TRGM_VAR_MapClicked";

        OnMapSingleClick "TRGM_VAR_ClickedPos = _pos; TRGM_VAR_MapClicked = 1; publicVariable ""TRGM_VAR_MapClicked""";
        openMap [true, false];
        hintC (localize "STR_TRGM2_tele_SelectPositionAO");

        while {true} do {
            if (TRGM_VAR_MapClicked isEqualTo 1) then { // player has clicked the map
                OnMapSingleClick "TRGM_VAR_MapClicked = 2; publicVariable ""TRGM_VAR_MapClicked""";
                hintC (localize "STR_TRGM2_InitClickValidPos");
                _ManualAOPosMarker = createMarker [format ["%1", random 10000], TRGM_VAR_ClickedPos];
                _ManualAOPosMarker  setMarkerShape "ICON";
                _ManualAOPosMarker  setMarkerType "hd_dot";
                _ManualAOPosMarker  setMarkerSize [5,5];
                _ManualAOPosMarker  setMarkerColor "ColorRed";
                _ManualAOPosMarker  setMarkerText "AO";
                waitUntil { sleep 1; ((TRGM_VAR_MapClicked isEqualTo 2) || !visibleMap); };
                deleteMarker _ManualAOPosMarker;
                if (TRGM_VAR_MapClicked isEqualTo 2) then {
                    TRGM_VAR_MapClicked = 0; publicVariable "TRGM_VAR_MapClicked";
                    OnMapSingleClick "TRGM_VAR_ClickedPos = _pos; TRGM_VAR_MapClicked = 1; publicVariable ""TRGM_VAR_MapClicked""";
                } else {
                    onMapSingleClick "";
                    openMap [false, false];
                    TRGM_VAR_foundManualAOPos = TRGM_VAR_ClickedPos; publicVariable "TRGM_VAR_foundManualAOPos";
                    TRGM_VAR_ManualAOPosFound = true; publicVariable "TRGM_VAR_ManualAOPosFound";
                };
            };
            sleep 1;
            if (TRGM_VAR_ManualAOPosFound) exitwith {true;};
            if !(visibleMap) then {openMap [true, false]; hintC (localize "STR_TRGM2_tele_SelectPositionAO");};
        };
    };
};

true;