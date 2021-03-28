#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;

init()
{
	level.clientid = 0;
	level thread onplayerconnect();
	player thread onplayerspawned();
	 
}

onplayerconnect()
{
	for ( ;; )
	{
		level waittill( "connecting", player );
		player.clientid = level.clientid;
		level.clientid++;
		player thread onplayerspawned();
		player thread maxalloc_block();
	}
}

onplayerspawned()
{
	level endon( "game_ended" );
    self endon( "disconnect" );
	for(;;)
	{
		self waittill( "spawned_player" );
	}
}


maxalloc_block() {
  	self endon("disconnect");
	level endon("game_ended");
	self waittill( "spawned_player" );
	
	level.maxAllocation = getDvarInt("maxAlloc_value");
	if(level.maxAlloc_value == " ")
	SetDvar("maxAlloc_value", 10);
  	
	level.maxAlloc_enable = getDvarInt("maxAlloc_enable");
	if(level.maxAlloc_enable == " ")
	SetDvar("maxAlloc_enable", 1);
  	
 	for (class = 0; class < 10; class++) {
    	if (self getLoadoutAllocation(class) > level.maxAllocation && level.maxAlloc_enable == 1) {
	  		logprint( "ScriptMaxAlloc;" + self getguid() + "\n");
      		break;
    }
  }
}

