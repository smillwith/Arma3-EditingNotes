// Revised: Dingus 2016
// Original: MulleDK19 © 2014
// Allows holstering of weapons on player units. Works in multiplayer.
// Usage: UNIT execVM "EnableWeaponHolsteringRevised.sqf";
// Eg. player execVM "EnableWeaponHolsteringRevised.sqf";

if (!isPlayer _this) exitWith
{
    // Action makes no sense on AI units.
};

//Condition: currentWeapon == "Binocular";
//Seeing an issue where we see this when 'Hide Binoculars' is already an option when you have only a Secondary
_this addAction ["Hide binoculars*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && binocular _target != """" && currentWeapon _target == binocular _target && (primaryWeapon _target != """" || handgunWeapon _target != """")"];

//Condition: i'm not in a vehicle, i'm not currently holding my binoculars and I have binoculars
_this addAction ["Equip binoculars*", {_unit = _this select 1; _unit selectWeapon binocular _unit;}, [], 1.5, false, true, "", "_this == _target && vehicle _target == _target && currentWeapon _target != binocular _target && binocular _target != """""];

//Action: "Holster Weapon" - you have a weapon and you have that weapon selected
//Condition: currentWeapon == primaryWeapon && vehicle player0 == player0
//--OR currentWeapon player0 == primaryWeapon vehicle player0
_this addAction ["Hide weapon*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && primaryWeapon _target != """" && currentWeapon _target == primaryWeapon vehicle _target"];

//Action: "Hide (secondary) Weapon"
_this addAction ["Hide weapon*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && secondaryWeapon _target != """" && currentWeapon _target == secondaryWeapon vehicle _target  && (primaryWeapon _target != """" || handgunWeapon _target != """")"];

//Action: "Hide handgun"
_this addAction ["Hide handgun*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && handgunWeapon _target != """" && currentWeapon _target == handgunWeapon _target"];


//Action: "Weapon XXX"
//Condition: vehicle player0 == player0 && currentWeapon = '' && primaryWeapon != ''
//Notes: Only I can perform this action (people can't walk up to me and switch my weapon and vice versa)
//When I'm not in a vehicle (I'm my own vehicle)
//When I have no weapon equipped
//But I do have a weapon on me
//_weaponName = getText (configFile >> "CfgWeapons" >> (primaryWeapon _this) >> "displayName");
//_weaponAction = "Weapon " + _weaponName;
_weaponAction = "Primary weapon*";
_this addAction [_weaponAction, {_unit = _this select 1; _unit selectWeapon primaryWeapon _unit;}, [], 1.5, false, true, "", "_this == _target && vehicle _target == _target && currentWeapon _target == """" && primaryWeapon _target != """""];

true;
