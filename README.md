# Arma3-EditingNotes

A bunch of misc scripts and links that I've found useful.

## Mission/Scenario Building ##
1. [BI Wiki](https://community.bistudio.com/wiki/Main_Page)
  1. [Scripting Commands List](https://community.bistudio.com/wiki/Category:Scripting_Commands_Arma_3)
  2. [All Items List](https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items)  
  3. [2D Editor](https://community.bistudio.com/wiki/2D_Editor)
    1. [Waypoints](https://community.bistudio.com/wiki/2D_Editor:_Waypoints)
  4. [Description.ext](https://community.bistudio.com/wiki/Description.ext)
  5. [Radio Protocol](https://community.bistudio.com/wiki/Arma_3_Radio_Protocol)
  6. [Commander Guide](https://community.bistudio.com/wiki/Operation_Flashpoint:_Commander_Guide)
  7. [Field Manual](https://community.bistudio.com/wiki/Category:Arma_3:_Field_Manual)
2. [Arma 3 Editing Forums](https://forums.bistudio.com/forum/161-arma-3-editing/)
3. [General Guide on Editing]()

## Mods, Projects, etc ##
1. [Authentic Gameplay Modification](https://github.com/KoffeinFlummi/AGM/wiki)
2. [Advanced Combat Environment 3 - ACE 3](http://ace3mod.com/wiki/feature/)
3. [Enhanced Movement](http://www.armaholic.com/page.php?id=27224)

## Misc ##
1. [Arma 3 Items Sheets - Google Docs](https://docs.google.com/spreadsheets/d/16scX4_d8d8IltXjQXMdYNsSVr1YbV2BsBK1vW3rrxi4/edit#gid=0)


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

//Creates a menu and menu items accessible when selecting a unit in High Command and pressing 6
//Note: call 'hcSelectedUnits player' to get the currently selected units in High Command as the expressions are called with no arguments
missionNamespace setVariable [
  "HC_Custom_0",
  [
    ["Sandbox Actions", true],
    ["Go Dark", [2], "", -5, [["expression", "[] call mymod_fnc_GoDarkHC"]], "1", "1"],
    ["Go Light", [3], "", -5, [["expression", "[] call mymod_fnc_GoLightHC"]], "1", "1"],
    ["Remove All Items", [4], "", -5, [["expression", "[] call mymod_fnc_RemoveAllItemsHC"]], "1", "1"]
  ]
];


//To clear the menu (?)
missionNamespace setVariable ["HC_Missions_0", []];

//TODO: (this)
//Which means we need a system to handle holding onto which menus are active and which ones aren't.
//Each time an item is added or removed, we need to update the variable



//Chemlight on player
_cl1 = "Chemlight_blue" createVehicle position player;  _cl1 attachTo [player, [0.1, 0.1, 0.15], "Pelvis"];  _cl1 setVectorDirAndUp [ [0.5, -0.5, 0], [0.5, 0.5, 0] ];

//better version of chemlight on player belt
_cl1 = "Chemlight_blue" createVehicle position player;  _cl1 attachTo [player, [0.05, 0.15, 0], "Pelvis"];  _cl1 setVectorDirAndUp [ [0, 0, -1], [0, 1, 0] ];


//Early version of sleeping bag on quadbike
sbag = "Land_Ground_sheet_folded_F" createVehicleLocal getPos quadbike1; sbag attachTo [quadbike1, [0, 0.75, 0]];

//attach a sleeping bag to a quadbike
deleteVehicle sbag; sbag = "Land_Sleeping_bag_brown_folded_F" createVehicle getPos quad1; sbag attachTo [quad1, [-0.4, 0.65, -0.45]]; sbag setVectorDirAndUp [[-1, 0, 1], [-1, 0, 0]];

//Attach a canten to a quadbike
deleteVehicle canteen; canteen = "Land_Canteen_F" createVehicle getPos quad1;  canteen attachTo [quad1, [-0.65, -1.05, -0.45]]; canteen setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];


//attach a spotlight to a boat
boatlight = "#lightpoint" createVehicleLocal getPos c_boat1; boatlight setLightBrightness 1.0;  boatlight setLightAmbient [0.0, 1.0, 0.0];  boatlight setLightColor [0.0, 1.0, 0.0];  boatlight attachTo [c_boat1, [0,0,0]];


//Adds a rear light to a Marshall APC
rearlight = "#lightpoint" createVehicleLocal getPos b_hunter; rearlight setLightBrightness 0.75;  rearlight setLightAmbient [1.0, 1.0, 1.0];  rearlight setLightColor [1.0, 1.0, 1.0];  rearlight attachTo [b_hunter, [-1,-8, 0]];


//(Dull yellow rear boarding lights) for APC marshall
leftrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; leftrearlight setLightBrightness 0.15;  leftrearlight setLightAmbient [1, 1, 0.5];  leftrearlight setLightColor [1, 1, 0.5]; leftrearlight setLightUseFlare true; leftrearlight setLightFlareSize 0.5; leftrearlight setLightFlareMaxDistance 500; leftrearlight attachTo [b_hunter, [-0.8,-4.85, -0.31]]; rightrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; rightrearlight setLightBrightness 0.15;  rightrearlight setLightAmbient [1, 1, 0.5];  rightrearlight setLightColor [1, 1, 0.5]; rightrearlight setLightUseFlare true; rightrearlight setLightFlareSize 0.5; rightrearlight setLightFlareMaxDistance 500; rightrearlight attachTo [b_hunter, [0.8,-4.85, -0.31]];


//small front collision light on a full motorboat
boatlight = "#lightpoint" createVehicleLocal getPos c_boat1; boatlight setLightBrightness 0.5;  boatlight setLightAmbient [0.0, 0.1, 0.1];  boatlight setLightColor [0.0, 0.1, 0.1];  boatlight attachTo [c_boat1, [0,3,0]];

//Domelight
deleteVehicle domelight; domelight = "#lightpoint" createVehicleLocal getPos c_offroad; domelight setLightBrightness 0.03;  domelight setLightAmbient [1.0, 1.0, 0.8];  domelight setLightColor [1.0, 1.0, 0.8]; domelight setLightUseFlare true; domelight setLightFlareSize 0.01; domelight setLightFlareMaxDistance 500; domelight attachTo [c_offroad, [0, 0.35, 0.25]];

//Domelight, offroad no bleeding
deleteVehicle domelight; domelight = "#lightpoint" createVehicleLocal getPos c_offroad; domelight setLightBrightness 0.04;  domelight setLightAmbient [0.0, 0.0, 0.0];  domelight setLightColor [1.0, 1.0, 0.8]; domelight setLightUseFlare true; domelight setLightFlareSize 0.01; domelight setLightFlareMaxDistance 500; domelight attachTo [c_offroad, [0, 0.35, 0.0]];

//Hunter domelight
deleteVehicle domelight; domelight = "#lightpoint" createVehicleLocal getPos b_hunter; domelight setLightBrightness 0.08;  domelight setLightAmbient [0.0, 0.0, 0.0];  domelight setLightColor [1.0, 1.0, 0.8]; domelight attachTo [b_hunter, [-0.1, -0.9, 0.22]];

//Bright spotlight 20m in front of the boat
boatlight = "#lightpoint" createVehicleLocal getPos c_boat1; boatlight setLightBrightness 5;  boatlight setLightAmbient [0.0, 0.1, 0.1];  boatlight setLightColor [0.0, 0.1, 0.1];  boatlight attachTo [c_boat1, [0,20,0]];


//create a working streetlight lamp on a server, where lampspot_1 is a 'game logic'
if (isServer) then {
_lamp = createVehicle ["Land_LampStreet_F", getPos lampspot_1,[], 1, "CAN_COLLIDE"];
};

//given a GameLogic object named 'lightspot1', puts a blinking helipad light (pink) in that position
_lamp = createVehicle ["Land_PortableHelipadLight_01_F", getPos lightspot1, [], 1, "CAN_COLLIDE"];
//PortableHelipadLight_01_blue_F
//PortableHelipadLight_01_white_F, red, yellow, etc


//spawn script example
if (isServer) then {0=[this] spawn { while { alive driver (_this select 0) } do { driver (_this select 0) action ["LightOn", (_this select 0)] } } };


//Turn vehicle lights on
player action ["LightOn", _vehicle];
player action ["LightOff", _vehicle];

//Forces lights on (if it's night and the AI behavior allows it), use in init field
driver this action ["lightOn", this];

//Trigger, etc - use a specific vehicle with a driver
driver c_offroad action ["LightOn", c_offroad];


//For planes and choppers
player action ["CollisionLightOn", _vehicle];
player action ["CollisionLightOff", _vehicle];


//Siren bar - Didn't seem to work on a boat
_veh animate ["BeaconStart", 1];
_veh animate ["BeaconStop", 0];



//Adds action menu items to a vehicle for Beacons on (_veh), player must be driver
_veh addAction ["Beacons On",{(_this select 0) animate ["BeaconsStart",1]},[],50,false,true,"","_target animationPhase 'BeaconsStart' < 0.5 AND Alive(_target) AND driver _target == _this"];
_veh addAction ["Beacons Off",{(_this select 0) animate ["BeaconsStart",0]},[],51,false,true,"","_target animationPhase 'BeaconsStart' > 0.5 AND Alive(_target) AND driver _target == _this"];


//Early version of Rear Light (for Marshall)
this addAction ["Rear Light Off", {rearlight=nil},[],50,false,true,"","rearlight != nil AND Alive(_target) AND driver _target == _this"];
this addAction ["Rear Light On", {rearlight = "#lightpoint" createVehicleLocal getPos this; rearlight setLightBrightness 0.75;  rearlight setLightAmbient [1.0, 1.0, 1.0];  rearlight setLightColor [1.0, 1.0, 1.0];  rearlight attachTo [this, [-1,-8, 0]];},[], 51, false, true, "", "rearlight == nil AND !Alive(_target) AND driver _target == _this"];


//Adds an action for cargo lights on a Marshall (bleeds through the bottom and top of the vehicle slightly)
b_hunter setVariable ["cargoLightOn", 0, true]; b_hunter addAction ["Cargo Light Off", {deleteVehicle cargolight; b_hunter setVariable ["cargoLightOn", 0, true];},[],1.5,false,true,"","b_hunter getVariable ""cargoLightOn"" == 1 AND Alive(_target) AND driver _target == _this"];  b_hunter addAction ["Cargo Light On", {cargolight = "#lightpoint" createVehicleLocal getPos b_hunter; cargolight setLightBrightness 0.1;  cargolight setLightAmbient [1, 0, 0];  cargolight setLightColor [1, 0, 0];  cargolight attachTo [b_hunter, [0,-3, -1.5]]; b_hunter setVariable ["cargoLightOn", 1, true];},[], 1.5, false, true, "", "b_hunter getVariable ""cargoLightOn"" == 0 AND Alive(_target) AND driver _target == _this"];

//for huron
b_huron setVariable ["cargoLightOn", 0, true]; b_huron addAction ["Cargo Light Off", {deleteVehicle cargolight; b_huron setVariable ["cargoLightOn", 0, true];},[],1.5,false,true,"","b_huron getVariable ""cargoLightOn"" == 1 AND Alive(_target) AND driver _target == _this"];  b_huron addAction ["Cargo Light On", {

//tesing this part still
cargolight = "#lightpoint" createVehicleLocal getPos b_huron; cargolight setLightBrightness 0.1;  cargolight setLightAmbient [1, 0, 0];  cargolight setLightColor [1, 0, 0];  cargolight attachTo [b_huron, [0,-3, -1.5]];

b_huron setVariable ["cargoLightOn", 1, true];
},[], 1.5, false, true, "", "b_huron getVariable ""cargoLightOn"" == 0 AND Alive(_target) AND driver _target == _this"];


//Adds an option for the player driver of a Marshall APC to turn the rear lights on or off
b_hunter setVariable ["rearLightOn", 0, true]; b_hunter addAction ["Rear Lights Off", {deleteVehicle leftrearlight; deleteVehicle rightrearlight; b_hunter setVariable ["rearLightOn", 0, true];},[],1.5,false,true,"","b_hunter getVariable ""rearLightOn"" == 1 AND Alive(_target) AND driver _target == _this"];  b_hunter addAction ["Rear Lights On", {leftrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; leftrearlight setLightBrightness 0.15;  leftrearlight setLightAmbient [1, 1, 0.5];  leftrearlight setLightColor [1, 1, 0.5]; leftrearlight setLightUseFlare true; leftrearlight setLightFlareSize 0.5; leftrearlight setLightFlareMaxDistance 500; leftrearlight attachTo [b_hunter, [-0.8,-4.85, -0.31]]; rightrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; rightrearlight setLightBrightness 0.15;  rightrearlight setLightAmbient [1, 1, 0.5];  rightrearlight setLightColor [1, 1, 0.5]; rightrearlight setLightUseFlare true; rightrearlight setLightFlareSize 0.5; rightrearlight setLightFlareMaxDistance 500; rightrearlight attachTo [b_hunter, [0.8,-4.85, -0.31]]; b_hunter setVariable ["rearLightOn", 1, true];},[], 1.5, false, true, "", "b_hunter getVariable ""rearLightOn"" == 0 AND Alive(_target) AND driver _target == _this"];


//Adds an action for the player driver of a Hunter to turn the dome light on or off
b_hunter setVariable ["domeLightOn", 0, true]; b_hunter addAction ["Dome Light Off", {deleteVehicle domelight; b_hunter setVariable ["domeLightOn", 0, true];},[],1.5,false,true,"","b_hunter getVariable ""domeLightOn"" == 1 AND Alive(_target) AND driver _target == _this"];  b_hunter addAction ["Dome Light On", {  deleteVehicle domelight; domelight = "#lightpoint" createVehicleLocal getPos b_hunter; domelight setLightBrightness 0.08;  domelight setLightAmbient [0.0, 0.0, 0.0];  domelight setLightColor [1.0, 1.0, 0.8]; domelight attachTo [b_hunter, [-0.1, -0.9, 0.22]]; b_hunter setVariable ["domeLightOn", 1, true];},[], 1.5, false, true, "", "b_hunter getVariable ""domeLightOn"" == 0 AND Alive(_target) AND driver _target == _this"];


//Adds an option for the player driver of a hunter to turn the rear lights on or off
b_hunter setVariable ["rearLightOn", 0, true]; b_hunter addAction ["Rear Lights Off", {deleteVehicle leftrearlight; deleteVehicle rightrearlight; b_hunter setVariable ["rearLightOn", 0, true];},[],1.5,false,true,"","b_hunter getVariable ""rearLightOn"" == 1 AND Alive(_target) AND driver _target == _this"];  b_hunter addAction ["Rear Lights On", {leftrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; leftrearlight setLightBrightness 0.15;  leftrearlight setLightAmbient [1, 1, 0.5];  leftrearlight setLightColor [1, 1, 0.5]; leftrearlight setLightUseFlare true; leftrearlight setLightFlareSize 0.5; leftrearlight setLightFlareMaxDistance 500; leftrearlight attachTo [b_hunter, [-0.8,-4.85, -0.31]]; rightrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; rightrearlight setLightBrightness 0.15;  rightrearlight setLightAmbient [1, 1, 0.5];  rightrearlight setLightColor [1, 1, 0.5]; rightrearlight setLightUseFlare true; rightrearlight setLightFlareSize 0.5; rightrearlight setLightFlareMaxDistance 500; rightrearlight attachTo [b_hunter, [0.8,-4.85, -0.31]]; b_hunter setVariable ["rearLightOn", 1, true];},[], 1.5, false, true, "", "b_hunter getVariable ""rearLightOn"" == 0 AND Alive(_target) AND driver _target == _this"];


//Panther rear lights (I think)
deleteVehicle leftrearlight; leftrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; leftrearlight setLightBrightness 1;  leftrearlight setLightAmbient [1, 1, 0.5];  leftrearlight setLightColor [1, 1, 1]; leftrearlight setLightUseFlare true; leftrearlight setLightFlareSize 0.5; leftrearlight setLightFlareMaxDistance 800; leftrearlight setLightAttenuation [2, 4, 4.31918e-005, 0]; leftrearlight attachTo [b_hunter, [-0.8,-4.85, 2]];


//Hunter - Nice lights but they bleed through the cockpit
deleteVehicle leftrearlight; leftrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; leftrearlight setLightBrightness 0.25;  leftrearlight setLightAmbient [0.9, 1, 1];  leftrearlight setLightColor [0.9, 1, 1]; leftrearlight setLightUseFlare true; leftrearlight setLightFlareSize 0.5; leftrearlight setLightFlareMaxDistance 800; leftrearlight attachTo [b_hunter, [-0.95,-2.8, 0.58]]; deleteVehicle rightrearlight; rightrearlight = "#lightpoint" createVehicleLocal getPos b_hunter; rightrearlight setLightBrightness 0.25;  rightrearlight setLightAmbient [0.9, 1, 1];  rightrearlight setLightColor [0.9, 1, 1]; rightrearlight setLightUseFlare true; rightrearlight setLightFlareSize 0.5; rightrearlight setLightFlareMaxDistance 800; rightrearlight attachTo [b_hunter, [0.95,-2.8, 0.58]];


//for a panther
b_unitVehicle setVariable ["rearLightOn", 0, true]; b_unitVehicle addAction ["Rear Lights Off", {deleteVehicle leftrearlight; deleteVehicle rightrearlight; b_unitVehicle setVariable ["rearLightOn", 0, true];},[],1.5,false,true,"","b_unitVehicle getVariable ""rearLightOn"" == 1 AND Alive(_target) AND driver _target == _this"];  b_unitVehicle addAction ["Rear Lights On", {leftrearlight = "#lightpoint" createVehicleLocal getPos b_unitVehicle; leftrearlight setLightBrightness 0.15;  leftrearlight setLightAmbient [1, 1, 0.5];  leftrearlight setLightColor [1, 1, 0.5]; leftrearlight setLightUseFlare true; leftrearlight setLightFlareSize 0.5; leftrearlight setLightFlareMaxDistance 500; leftrearlight attachTo [b_unitVehicle, [-1,-5, -0.31]]; rightrearlight = "#lightpoint" createVehicleLocal getPos b_unitVehicle; rightrearlight setLightBrightness 0.15;  rightrearlight setLightAmbient [1, 1, 0.5];  rightrearlight setLightColor [1, 1, 0.5]; rightrearlight setLightUseFlare true; rightrearlight setLightFlareSize 0.5; rightrearlight setLightFlareMaxDistance 500; rightrearlight attachTo [b_unitVehicle, [1,-5, -0.31]]; b_unitVehicle setVariable ["rearLightOn", 1, true];},[], 1.5, false, true, "", "b_unitVehicle getVariable ""rearLightOn"" == 0 AND Alive(_target) AND driver _target == _this"];

//What is Splendid camera targeting
BIS_fnc_camera_target

//Command a unit to throw a grenade, smoke grenade or chemlight?
//ChemlightRedMuzzle

//If he has a Green Chemlight in his inventory, will throw that item directly in front of him. This is the "silent" version, no command is issued.
b_medic1 selectWeapon "ChemlightGreenMuzzle";
b_medic1 fire ["Throw", "ChemlightGreenMuzzle", "Chemlight_Green"];


//Still not sure what's going on
b_rifleman1 selectWeapon "ChemlightGreenMuzzle"; b_rifleman1 fire ["Throw","ChemlightGreenMuzzle","Chemlight_Green"];  b_rifleman1 fire ["ChemlightGreenMuzzle","ChemlightGreenMuzzle","Chemlight_Green"];

//Ok this works but there's a delay in how often you can call it between throws and it's not 100% reliable
b_rifleman1 selectWeapon "ChemlightGreenMuzzle"; b_rifleman1 fire ["ChemlightGreenMuzzle", "ChemlightGreenMuzzle", "Chemlight_Green"];

//Yup
b_rifleman1 selectWeapon "SmokeWhiteMuzzle"; b_rifleman1 fire ["SmokeWhiteMuzzle", "SmokeWhiteMuzzle", "SmokeShell"];

//Yup
b_rifleman1 selectWeapon "SmokeShellBlueMuzzle"; b_rifleman1 fire ["SmokeShellBlueMuzzle", "SmokeShellBlueMuzzle", "SmokeShellBlue"];

//Worked...kinda - throws white smoke
b_engineer1 selectWeapon "SmokeShellMuzzle"; b_engineer fire "SmokeShellMuzzle";

//Kinda worked - throws blue smoke
b_engineer1 selectWeapon "SmokeShellBlueMuzzle"; b_engineer1 fire ["SmokeShellBlueMuzzle", "SmokeShellBlueMuzzle"];




```

This is my new stuff. It's just for testing some git commands.
