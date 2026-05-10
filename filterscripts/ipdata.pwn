#include <a_samp>
#include <sscanf2> //required
#include <ipdata>
#include <zcmd>

public OnFilterScriptInit()
{
	print("IP Lookup loaded!");
	return 1;
}

public OnFilterScriptExit() return 1;

public OnPlayerConnect(playerid)
{
    GetPlayerIPData(playerid);
	return 1;
}

new searchip[16];
new PlayerChecking;

public DataReceived(playerid,success_type)
{
	if(playerid != CHECK_NOTFOR_PLAYER)
	{
	    if(success_type == CHECK_SUCCESS)
	    {
			printf("Lookup for player %d was successful.",playerid);
	    }
	}
	else
	{
	    new string[128];
		format(string,sizeof(string),"%s's lookup",searchip);
		SendClientMessage(PlayerChecking, -1, string);
		format(string,sizeof(string),"Country: %s",IPLocData[country_2]);
		SendClientMessage(PlayerChecking, -1, string);
		format(string,sizeof(string),"ISP: %s",IPLocData[i_provider_2]);
		SendClientMessage(PlayerChecking, -1, string);
		format(string,sizeof(string),"Hostname: %s",IPLocData[host_name_2]);
		SendClientMessage(PlayerChecking, -1, string);
		format(string,sizeof(string),"Region: %s",IPLocData[region_2]);
		SendClientMessage(PlayerChecking, -1, string);
		format(string,sizeof(string),"GMT: %s",IPLocData[i_gmt_2]);
		SendClientMessage(PlayerChecking, -1, string);
		format(string,sizeof(string),"Latitude: %f | Longtitude: %f",IPLocData[latitude_2],IPLocData[longitude_2]);
		SendClientMessage(PlayerChecking, -1, string);
		if(IPLocData[i_type_2]) SendClientMessage(PlayerChecking, -1, "Proxy connection");
		else SendClientMessage(PlayerChecking, -1, "Normal connection");
	    PlayerChecking = INVALID_PLAYER_ID;
	}
	return 1;
}

CMD:checkip(playerid,params[])
{
    if(!IsPlayerAdmin(playerid)) return 1; //rcon admin
  	new giveplayerid;
	if(sscanf(params, "r", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /checkip [playerid/playername]");
	new name[MAX_PLAYER_NAME];
	GetPlayerName(giveplayerid,name,MAX_PLAYER_NAME);
	new string[128];
	format(string,sizeof(string),"%s's lookup",name);
	SendClientMessage(playerid, -1, string);
	format(string,sizeof(string),"Country: %s",GetCountry(giveplayerid));
	SendClientMessage(playerid, -1, string);
	format(string,sizeof(string),"ISP: %s",GetISP(giveplayerid));
	SendClientMessage(playerid, -1, string);
	format(string,sizeof(string),"Hostname: %s",GetHost(giveplayerid));
	SendClientMessage(playerid, -1, string);
	format(string,sizeof(string),"Region: %s",GetRegion(giveplayerid));
	SendClientMessage(playerid, -1, string);
	format(string,sizeof(string),"GMT: %s",GetGMT(giveplayerid));
	SendClientMessage(playerid, -1, string);
	format(string,sizeof(string),"Latitude: %f | Longtitude: %f",GetLatitude(giveplayerid),GetLongitude(giveplayerid));
	SendClientMessage(playerid, -1, string);
	if(GetProxy(giveplayerid)) SendClientMessage(playerid, -1, "Proxy connection");
	else SendClientMessage(playerid, -1, "Normal connection");
	return 1;
}

CMD:ipdata(playerid,params[])
{
    if(!IsPlayerAdmin(playerid)) return 1; //rcon admin
	if(sscanf(params, "s[16]", searchip)) return SendClientMessage(playerid, -1, "USAGE: /ipdata [IP]");
	PlayerChecking = playerid;
	GetIPData(searchip);
	return 1;
}


