// private _fnc_scriptName = "TRGM_SERVER_fnc_searchGoodCiv";
params ["_thisCiv","_player"];
format[localize "STR_TRGM2_debugFunctionString", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;



_thisCiv disableAI "MOVE";

private _hintText = selectRandom [localize "STR_TRGM2_SearchGoodCiv_Result1",localize "STR_TRGM2_SearchGoodCiv_Result2",localize "STR_TRGM2_SearchGoodCiv_Result3"];
[_hintText] call TRGM_GLOBAL_fnc_notify;

// allow the civ to walk free again, but wait a few seconds so the player could send him away or restrain him.
sleep 5;
_thisCiv enableAI "MOVE";


true;