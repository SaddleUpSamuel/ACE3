#include "..\script_component.hpp"
/*
 * Author: Glowbal, Ruthberg
 * Handles wind deflection for projectiles. Called from the unified fired EH only for players on foot and their vehicles if required by settings.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(common,firedEH)
 *
 * Return Value:
 * None
 *
 * Example:
 * [clientFiredBIS-XEH] call ace_winddeflection_fnc_handleFired
 *
 * Public: No
 */

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];
TRACE_10("firedEH:",_unit,_weapon,_muzzle,_mode,_ammo,_magazine,_projectile,_vehicle,_gunner,_turret);

if (missionNamespace getVariable [QEGVAR(advanced_ballistics,enabled), false] && {_projectile isKindOf "BulletBase" && {_unit isKindOf "Man"}}) exitWith {};

if (!((_projectile isKindOf "BulletBase") || {_projectile isKindOf "GrenadeBase"})) exitWith {};
if (_unit distance ACE_player > 2000) exitWith {};

if (!local _unit && {_projectile isKindOf "BulletBase"} && {!(_projectile getShotInfo 4)}) exitWith {}; // 4=shownTracer

GVAR(trackedBullets) pushBack [_projectile, getNumber(configFile >> "CfgAmmo" >> _ammo >> "airFriction")];
