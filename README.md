# Arma3-EditingNotes

//Sides can be East, West, Resistance, Guer?
{ if ((side _x) == Resistance) then { _x disableAI "target"; _x disableAI "autotarget"; }; } forEach allUnits;

