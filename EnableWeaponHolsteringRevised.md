## Enable Weapon Holstering Revised

This completely revised version of Enable Weapon Holstering includes the following features:
- Works with any combination of weapons (no weapons, pistol only, binoculars only, only pistol and launcher, etc).
- Multiplayer compatible
- No need for addtional "waitUntil" or "spawn" options
- Fully responsive to the player dropping or acquiring new weapons

## Usage

```SQF
  //One player - place in init.sqf:
  player execVM "EnableWeaponHolsteringRevised.sqf";
  
  //All playable units - place in init.sqf:
  { _x execVM "EnableWeaponHolsteringRevised.sqf"; } forEach playableUnits;
  
```

## Download EnableWeaponHolsteringRevised.sqlf below.

* [EnableWeaponHolstering.sqf (View)](https://github.com/smillwith/Arma3-EditingNotes/blob/master/EnableWeaponHolsteringRevised.sqf)
* [EnableWeaponHolstering.sqf (Raw)](https://raw.githubusercontent.com/smillwith/Arma3-EditingNotes/master/EnableWeaponHolsteringRevised.sqf)

## Known Issues

The game currently forces the user to select a weapon when exiting a vehicle.

