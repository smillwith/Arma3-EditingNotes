# Arma3-EditingNotes

A bunch of misc scripts and links that I've found useful.

## Mission/Scenario Building ##
1. [BI Wiki](https://community.bistudio.com/wiki/Main_Page)
  1. [Scripting Commands List](https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3)
  2. [All Items List](https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items)  
  3. [2D Editor](https://community.bistudio.com/wiki/2D_Editor)
    1. [Waypoints](https://community.bistudio.com/wiki/2D_Editor:_Waypoints)
  4. [Description.ext](https://community.bistudio.com/wiki/Description.ext)
2. [Arma 3 Editing Forums](https://forums.bistudio.com/forum/161-arma-3-editing/)

## Mods, Projects, etc ##
1. [Authentic Gameplay Modification](https://github.com/KoffeinFlummi/AGM/wiki)
2. [Advanced Combat Environment 3 - ACE 3](http://ace3mod.com/wiki/feature/)
3. [Enhanced Movement](http://www.armaholic.com/page.php?id=27224)

## Debugging Missions ##

```SQF
//Disables "shooting" on all units for the given side.
//Sides can be East, West, Resistance, Guer, Civ
{ if ((side _x) == Resistance) then { _x disableAI "target"; _x disableAI "autotarget"; }; } forEach allUnits;
```

## Tweaking Units ##

Basic randomized unit "init" function.

####Usage###

Place this in a trigger that fires when the mission loads:

```SQF
{ _x call coolmod_fnc_unitAssignLoadout; } forEach ["b_unit1", "b_unit2", "b_unit3"];
```

###funcs.sqf###

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

##Misc Sandbox things##

```SQF
//Fire smoke grenade
unitname fire ["SmokeShellMuzzle","SmokeShellMuzzle","Smokeshellred"];


//Opens the side doors for a GhostHawk
b_ghosthawk1 animateDoor ['door_R', 1];
b_ghosthawk1 animateDoor ['door_L', 1];



//This worked, I knew the crewman not the vehicle name
vehicle b_crewman1 animateDoor ['door_R', 1];


//Add stuff for me when I start
this assignItem "Binocular";


//Go dark
{ _x addPrimaryWeaponItem "muzzle_snds_H"; _x addPrimaryWeaponItem "muzzle_snds_H_MG"; _x addPrimaryWeaponItem "muzzle_snds_338_black"; _x linkItem "NVGoggles"; } forEach units recongroup;


//Go dark alternate
//acc_flashlight
//acc_pointer_IR

//Go light
{ _x removePrimaryWeaponItem "acc_pointer_IR"; _x removePrimaryWeaponItem "muzzle_snds_H"; _x removePrimaryWeaponItem "muzzle_snds_H_MG"; _x removePrimaryWeaponItem "muzzle_snds_338_black"; _x unlinkItem "NVGoggles"; } forEach units recongroup;
```

