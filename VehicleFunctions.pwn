/*
	Luis' Vehicle Functions v2.5.
	Copyright © Luis 2016.
	Coding Started (14/01/2013)
	Last Updated (23/06/2016)
	Compatible with 0.3.7.
*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define     USAGE       "{FF0000}USAGE: {FFFFFF}/"
#define     ERROR       "{FF0000}ERROR: {FFFFFF}"

#define     RED         "{FF0000}"
#define     GREEN       "{1DBF00}"

new g_Engine,
	g_Lights,
	g_Alarm,
	g_Doors,
	g_Bonnet,
	g_Boot,
	g_Objective
;

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n-----------------------------------------------------------");
	print(" 	Luis' Vehicle Functions v2.5 | Copyright © Luis 2016");
	print("-----------------------------------------------------------\n");

	CreateVehicle(587, 2040.0201, 1349.6130, 10.8959, 0.0000, -1, -1, 100);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

CMD:plate(playerid, params[]) {
	new g_Plate[8], g_String[128];

	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ERROR "Please spawn or find a vehicle!");
	if(sscanf(params, "s[8]", g_Plate)) return SendClientMessage(playerid, -1, USAGE "plate [plate text]");
	if(strlen(g_Plate) > 8) return SendClientMessage(playerid, -1, ERROR "Plates cannot go over 8 characters.");

	else {
	    SetVehicleNumberPlate(GetPlayerVehicleID(playerid), g_Plate);
	    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
		format(g_String, sizeof g_String, "Your plate has been changed too "#RED"%s", g_Plate);
		SendClientMessage(playerid, -1, g_String);
	}
	return 1;
}

CMD:color(playerid, params[]) {
	new g_Color[2], g_String[128];

	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ERROR "Please spawn or find a vehicle!");
	if(sscanf(params, "iI(0)", g_Color[0], g_Color[1])) return SendClientMessage(playerid, -1, USAGE "color [primary] [secondary (Optional)]");
	if(g_Color[0] < 0 || g_Color[0] > 255) return SendClientMessage(playerid, -1, ERROR "Colors cannot go over 255 or below 0.");
	if(g_Color[1] < 0 || g_Color[1] > 255) return SendClientMessage(playerid, -1, ERROR "Colors cannot go over 255 or below 0.");

	else {
	    ChangeVehicleColor(GetPlayerVehicleID(playerid), g_Color[0], g_Color[1]);
		format(g_String, sizeof g_String, "Your vehicles colours are now, "#RED"%d & %d", g_Color[0], g_Color[1]);
		SendClientMessage(playerid, -1, g_String);
	}
	return 1;
}

CMD:hood(playerid) {
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ERROR "Please spawn or find a vehicle!");

    GetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    if(g_Bonnet == 1) {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, 0, g_Boot, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles hood has been "#RED"closed");
    	g_Bonnet = 0;
	}
	else {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, 1, g_Boot, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles hood has been "#GREEN"opened");
    	g_Bonnet = 1;
	}
	return 1;
}

CMD:trunk(playerid) {
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ERROR "Please spawn or find a vehicle!");

    GetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    if(g_Boot == 1) {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, g_Bonnet, 0, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles trunk has been "#RED"closed");
    	g_Boot = 0;
	}
	else {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, g_Bonnet, 1, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles trunk has been "#GREEN"opened");
    	g_Boot = 1;
	}
	return 1;
}

CMD:engine(playerid) {
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ERROR "Please spawn or find a vehicle!");

    GetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    if(g_Engine == 0) {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), 1, g_Lights, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles engine has been switched "#GREEN"on");
    	g_Engine = 1;
	}
	else {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, g_Lights, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles engine has been switched "#RED"off");
    	g_Engine = 0;
	}
	return 1;
}

CMD:lights(playerid) {
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ERROR "Please spawn or find a vehicle!");

    GetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, g_Lights, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    if(g_Lights == 1) {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, 0, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles lights has been switched "#RED"off");
    	g_Lights = 0;
	}
	else {
    	SetVehicleParamsEx(GetPlayerVehicleID(playerid), g_Engine, 1, g_Alarm, g_Doors, g_Bonnet, g_Boot, g_Objective);
    	SendClientMessage(playerid, -1, "Your vehicles lights has been switched "#GREEN"on");
    	g_Lights = 1;
	}
	return 1;
}
