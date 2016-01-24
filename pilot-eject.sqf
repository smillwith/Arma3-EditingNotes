//Supposed to allow you to set a Waypoint or Trigger and call:
// null = [heli1, squad1] execVM "pilot-eject.sqf";

_veh = _this select 0;
_grp = _this select 1;

{
  unassignVehicle _x;
  _x action ["EJECT", _veh];
  sleep 0.5;
} forEach (units _grp);

{
  _x action ["openParachute", _x];
  sleep 0.5;
} forEach (units _grp);
