# Arma3-EditingNotes

A bunch of misc scripts and links that I've found useful.

## Links ##
1. https://community.bistudio.com/wiki/Description.ext
2. 

## Debugging Missions ##

//Sides can be East, West, Resistance, Guer, Civ

```
{ if ((side _x) == Resistance) then { _x disableAI "target"; _x disableAI "autotarget"; }; } forEach allUnits;
```

## Tweaking Units ##

Basic randomized unit "init" function.

####Usage###

Place this in a trigger that fires when the mission loads:

```SQF
{ _x call coolmod_fnc_unitAssignLoadout; } forEach ["b_unit1", "b_unit2", "b_unit3"];
```

###"funcs.sqf"""

```SQF
coolmod_fnc_unitAssignLoadout = 
{
  params ["_unit"];

  //Remove existing items
  removeAllWeapons _unit;
  removeAllItems _unit;
  removeAllAssignedItems _unit;
  removeUniform _unit;
  removeVest _unit;
  removeBackpack _unit;
  removeHeadgear _unit;
  removeGoggles _unit;
  

  //Add specific uniform
  //_unit forceAddUniform "U_BG_Guerilla3_1";
  
  //Or add a random uniform
  _allUnis = ["U_BG_leader", "U_BG_Guerilla3_1"];
  _uni = _allUnis select floor random count _allUnis;
  _unit forceAddUniform _uni;
  _unit addItemToUniform "FirstAidKit";

  //Add a specific item
  //_unit addHeadgear "H_Shemag_olive";
  
  //Or add a random item
  _allHeadgear = ["H_Shemag_olive", "H_Shemag_khk", "H_Shemag_tan"];
  _headgear = _allHeadgear select floor random count _allHeadgear;
  _unit addHeadgear _headgear;
  
  //Add initial magazines
  _unit addItemToUniform "30Rnd_9x21_Mag";
  _unit addItemToUniform "30Rnd_9x21_Mag";
  _unit addItemToUniform "30Rnd_9x21_Mag";

  //Add weapons
  _unit addWeapon "SMG_02_F";
  
  //Add items
  _unit linkItem "ItemMap";
  _unit linkItem "ItemRadio";

  //Set identity
  _unit setFace "PersianHead_A3_02";
  _unit setSpeaker "Male01PER";

  //join the enemy group
  [_unit] joinSilent enemygroup1;

  //make the unit stand still
  dostop _unit;
};
```

These snippets were designed to be used in a script file/function. Example usage included above.

```SQF
//Adds a random Uniform to the unit
_allUnis = ["U_BG_leader", "U_BG_Guerilla3_1"];
_uni = _allUnis select floor random count _allUnis;
_unit forceAddUniform _uni;
```

```SQF
//Adds a random headgear to the unit
_allHeadgear = ["H_Shemag_olive", "H_Shemag_khk", "H_Shemag_tan"];
_headgear = _allHeadgear select floor random count _allHeadgear;
_unit addHeadgear _headgear;
```

