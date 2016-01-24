# Arma3-EditingNotes

A bunch of misc scripts that I've found useful.

## Debugging Missions ##

//Sides can be East, West, Resistance, Guer?
`{ if ((side _x) == Resistance) then { _x disableAI "target"; _x disableAI "autotarget"; }; } forEach allUnits;`

## Tweaking Units ##

//Adds a random Uniform to the unit
```_allUnis = ["U_BG_leader", "U_BG_Guerilla3_1"];
_uni = _allUnis select floor random count _allUnis;
_unit forceAddUniform _uni;```

//Adds random headgear to the unit
```_allHeadgear = ["H_Shemag_olive", "H_Shemag_khk", "H_Shemag_tan"];
_headgear = _allHeadgear select floor random count _allHeadgear;
_unit addHeadgear _headgear;```

