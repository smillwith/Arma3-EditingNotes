// Revised: Dingus 2016
// Original: MulleDK19 © 2014
// Allows holstering of weapons on player units. Works in multiplayer.
// Usage: UNIT execVM "EnableWeaponHolsteringRevised.sqf";
// Eg. player execVM "EnableWeaponHolsteringRevised.sqf";

if (!isPlayer _this) exitWith
{
    // Action makes no sense on AI units.
};

//Action "Hide binoculars"
//Condition: I am requesting my own action, I have a Binocular, my currentWeapon == (whatever my Binocular is), and I have either a primary weapon or handgun weapon assigned (because if I don't the game adds a menu for me automatically and I don't wan't to duplicate it);
_this addAction ["Hide binoculars*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && binocular _target != """" && currentWeapon _target == binocular _target && (primaryWeapon _target != """" || handgunWeapon _target != """")"];

//Action "Equip binoculars"
//Condition: I am requesting my own action, I'm not in a vehicle, I'm not currently holding my binoculars and I have binoculars of some sort.
_this addAction ["Equip binoculars*", {_unit = _this select 1; _unit selectWeapon binocular _unit;}, [], 1.5, false, true, "", "_this == _target && vehicle _target == _target && currentWeapon _target != binocular _target && binocular _target != """""];

//Action: "Hide weapon" (Primary)
//Condition: I am requesting my own action, I have a primary weapon and I'm currently holding my primary weapon.
_this addAction ["Hide weapon*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && primaryWeapon _target != """" && currentWeapon _target == primaryWeapon vehicle _target"];

//Action: "Hide weapon" (Launcher)
//Condition: I am requesting my own action, I have a secondary weapon and I'm currently holding my secondary weapon.
_this addAction ["Hide weapon*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && secondaryWeapon _target != """" && currentWeapon _target == secondaryWeapon vehicle _target  && (primaryWeapon _target != """" || handgunWeapon _target != """")"];

//Action: "Hide handgun"
_this addAction ["Hide handgun*", {_unit = _this select 1; _unit action ["SwitchWeapon", _unit, _unit, 100];}, [], 1.5, false, true, "", "_this == _target && handgunWeapon _target != """" && currentWeapon _target == handgunWeapon _target"];


//Action: "Primary weapon"
//Note: this was adapted to use a generic name instead of the exact weapon name to allow for situations where the player would drop one weapon and pick up another.
// This version works if you have a weapon or not and you and drop or pick one up at any time without issue.
//Condition: Only I can perform this action (people can't walk up to me and switch my weapon and vice versa)
// When I'm not in a vehicle (I'm my own vehicle)
// When I have no weapon equipped
// But I do have a weapon on me
_weaponAction = "Primary weapon*";
_this addAction [_weaponAction, {_unit = _this select 1; _unit selectWeapon primaryWeapon _unit;}, [], 1.5, false, true, "", "_this == _target && vehicle _target == _target && currentWeapon _target == """" && primaryWeapon _target != """""];

true;
