#pragma semicolon 1
#pragma newdecls required

// Hud Element hiding flags
#define		HIDEHUD_WEAPONSELECTION			( 1<<0 )    // Hide ammo count & weapon selection
#define		HIDEHUD_FLASHLIGHT				( 1<<1 )
#define		HIDEHUD_ALL						( 1<<2 )
#define		HIDEHUD_HEALTH					( 1<<3 )    // Hide health & armor / suit battery
#define		HIDEHUD_PLAYERDEAD				( 1<<4 )    // Hide when local player's dead
#define		HIDEHUD_NEEDSUIT				( 1<<5 )    // Hide when the local player doesn't have the HEV suit
#define		HIDEHUD_MISCSTATUS				( 1<<6 )    // Hide miscellaneous status elements (trains, pickup history, death notices, etc)
#define		HIDEHUD_CHAT					( 1<<7 )    // Hide all communication elements (saytext, voice icon, etc)
#define		HIDEHUD_CROSSHAIR				( 1<<8 )    // Hide crosshairs
#define		HIDEHUD_VEHICLE_CROSSHAIR		( 1<<9 )    // Hide vehicle crosshair
#define		HIDEHUD_INVEHICLE				( 1<<10 )
#define		HIDEHUD_BONUS_PROGRESS			( 1<<11 )    // Hide bonus progress display (for bonus map challenges)

#define		HIDEHUD_BITCOUNT			12 

bool g_Hud[MAXPLAYERS+1];

public Plugin myinfo =
{
	name = "Hide hud",
	author = "",
	description = "",
	version = "1.0",
	url = ""
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_hidehud", Command_Hud, "Toggles hud.");
}

public Action Command_Hud(int client, int args)
{
	if (!client)
        return Plugin_Handled;
	
	g_Hud[client] = !g_Hud[client];
	
	int hudflags = GetEntProp(client, Prop_Send, "m_iHideHUD");
	
	if (g_Hud[client])
	{
		hudflags |= HIDEHUD_PLAYERDEAD;
		
		SetEntProp(client, Prop_Send, "m_iHideHUD", hudflags);
	}
	else
	{
		hudflags = 0;
		SetEntProp(client, Prop_Send, "m_iHideHUD", hudflags);
	}

	PrintToChat(client, "Your hud is now %s.", g_Hud[client] ? "Disabled" : "Enabled");

	return Plugin_Handled;
}