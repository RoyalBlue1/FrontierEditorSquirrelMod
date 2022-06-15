untyped



global function SetCallback_Toolgun_OnWeaponActivate
global function SetCallback_Toolgun_OnWeaponDeactivate
global function SetCallback_Toolgun_OnWeaponPrimaryAttack
global function SetCallback_Toolgun_OnWeaponStartZoomIn
global function SetCallback_Toolgun_OnWeaponStartZoomOut
global function OnWeaponActivate_weapon_toolgun
global function OnWeaponDeactivate_weapon_toolgun
global function OnWeaponPrimaryAttack_weapon_toolgun
global function OnWeaponStartZoomIn_weapon_toolgun
global function OnWeaponStartZoomOut_weapon_toolgun
#if SERVER
global function OnWeaponNpcPrimaryAttack_weapon_toolgun
#endif





struct {
	vector position
	void functionref(entity weapon) Toolgun_OnWeaponActivate
	void functionref(entity weapon) Toolgun_OnWeaponDeactivate
	void functionref(entity weapon) Toolgun_OnWeaponPrimaryAttack
	void functionref(entity weapon) Toolgun_OnWeaponStartZoomIn
	void functionref(entity weapon) Toolgun_OnWeaponStartZoomOut
}file






void function SetCallback_Toolgun_OnWeaponActivate(void functionref(entity weapon) func)
{
	file.Toolgun_OnWeaponActivate = func
}
void function SetCallback_Toolgun_OnWeaponDeactivate(void functionref(entity weapon) func)
{
	file.Toolgun_OnWeaponDeactivate = func
}
void function SetCallback_Toolgun_OnWeaponPrimaryAttack(void functionref(entity weapon) func)
{
	file.Toolgun_OnWeaponPrimaryAttack = func
}
void function SetCallback_Toolgun_OnWeaponStartZoomIn(void functionref(entity weapon) func)
{
	file.Toolgun_OnWeaponStartZoomIn = func
}
void function SetCallback_Toolgun_OnWeaponStartZoomOut(void functionref(entity weapon) func)
{
	file.Toolgun_OnWeaponStartZoomOut = func
}




void function OnWeaponActivate_weapon_toolgun( entity weapon )
{	
	if(file.Toolgun_OnWeaponActivate!=null)
		file.Toolgun_OnWeaponActivate(weapon)
}

void function OnWeaponDeactivate_weapon_toolgun( entity weapon )
{   

	if(file.Toolgun_OnWeaponDeactivate!=null)
		file.Toolgun_OnWeaponDeactivate(weapon)
}

var function OnWeaponPrimaryAttack_weapon_toolgun( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	if(file.Toolgun_OnWeaponPrimaryAttack!=null)
		file.Toolgun_OnWeaponPrimaryAttack(weapon)
}

void function OnWeaponStartZoomIn_weapon_toolgun( entity weapon )
{
	if(file.Toolgun_OnWeaponStartZoomIn!=null)
		file.Toolgun_OnWeaponStartZoomIn(weapon)
}
void function OnWeaponStartZoomOut_weapon_toolgun( entity weapon )
{	
	if(file.Toolgun_OnWeaponStartZoomOut!=null)
		file.Toolgun_OnWeaponStartZoomOut(weapon)
}

var function OnWeaponNpcPrimaryAttack_weapon_toolgun( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	// do nothing for now, maybe make it launch nukes or something later that could be funny
} 


