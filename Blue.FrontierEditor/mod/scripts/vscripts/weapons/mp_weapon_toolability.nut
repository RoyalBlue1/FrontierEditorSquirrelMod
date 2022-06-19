global function ToolAbility_Init
global function OnWeaponPrimaryAttack_ToolAbility

struct {
    void functionref(entity weapon) callback_OnWeaponPrimaryAttack
}file

void function ToolAbility_Init()
{   
    
    #if SERVER
    file.callback_OnWeaponPrimaryAttack = toggleNoclip
    #endif
}

var function OnWeaponPrimaryAttack_ToolAbility( entity weapon, WeaponPrimaryAttackParams attackParams )
{
    if(file.callback_OnWeaponPrimaryAttack!= null)
        file.callback_OnWeaponPrimaryAttack(weapon)
}
#if SERVER
void function toggleNoclip(entity weapon)
{
    entity player = weapon.GetWeaponOwner()
    if(player.IsNoclipping())
        EntFireByHandle(player,"AddOutput","movetype 2",0,null,null)
    else
        EntFireByHandle(player,"AddOutput","movetype 9",0,null,null)
    
}
#endif