# Slots limiter by class

That script kicks players who use more slots per class than the one determined by cfg. Below is the instructions on how to install on your server.

Call the ``player thread maxalloc_block ();`` in the onplayerconnect function.

```
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
```

place the following function anywhere in your script

```
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
```

Extract and copy the following file to the iw4mAdmin folder

https://github.com/viniciusmdev/Slots-limiter-by-class/releases/download/1.1/copy_to_iw4mAdmin_folder.rar

Set this lines on your cfg file:

``set maxAlloc_enable 1``  // 1 Enable | 0 Disable - Default 1

``set maxAlloc_value 10``  // Max value of slots per classe - Default 10

Compiled script file:
https://github.com/viniciusmdev/Slots-limiter-by-class/releases/download/1.1/_clientids.gsc

Source code:
https://github.com/viniciusmdev/Slots-limiter-by-class/blob/main/_clientids_not_compiled.gsc

I used the Generic Log Parser plugin to communicate the gsc script with the iw4madmin panel, follow the link

https://forum.awog.at/topic/171/release-generic-log-parser

Here is a video of the script working.

https://www.youtube.com/watch?v=0xnyGlV6KIk
