global function GamemodeEditor_Init

//global function addReadMessageCallback





struct line{
	vector begin
	vector end
	int red
	int green
	int blue
	bool isObstructed
}

struct{
	table<string,line> lines
	table<string,array<void functionref(table data)> > readMessageCallbacks
}file

void function GamemodeEditor_Init()
{
	PrecacheModel( MODEL_ATTRITION_BANK )
	
	NSInitSocket(9999)
	thread readSocket()
	
	thread renderStuff()
	AddCallback_GameStateEnter(eGameState.Playing,Editor_GameStarted)
	SetConVarInt("sv_cheats",1)
	SetConVarInt("enable_debug_overlays",1)
	addReadMessageCallback("line",createLine)
	addReadMessageCallback("deleteLine",deleteLine)
	AddCallback_OnPlayerRespawned(playerRespawnedEditor)
	Riff_ForceBoostAvailability( eBoostAvailability.Disabled )
	Riff_ForceTitanAvailability( eTitanAvailability.Never )
	PlayerEarnMeter_SetEnabled(false)
	SetTimerBased(false)
}


void function Editor_GameStarted()
{
	print("OUT OF BOUNDS DISABLED")
	if("disableOutOfBounds" in level)
		level.disableOutOfBounds = true
	else
		level.disableOutOfBounds <- true

	
}

void function playerRespawnedEditor(entity player)
{

		TakeAllWeapons(player)
		player.GiveWeapon("mp_weapon_toolgun")
		player.GiveOffhandWeapon("mp_ability_toolability",OFFHAND_LEFT)
}

void function createLine(table data)
{
	if(networkJsonContainsKeys(data,["startX","startY","startZ","endX","endY","endZ","red","green","blue","isObstructed","lineKey"]))
	{
		line l
		l.begin = < string(data["startX"]).tofloat(), string(data["startY"]).tofloat(), string(data["startZ"]).tofloat()>
		l.end = < string(data["endX"]).tofloat(), string(data["endY"]).tofloat(), string(data["endZ"]).tofloat()>
		l.red = string(data["red"]).tointeger()
		l.green = string(data["green"]).tointeger()
		l.blue = string(data["blue"]).tointeger()
		l.isObstructed = (string(data["isObstructed"])=="true")
		file.lines[string(data["lineKey"])] <- l
		printt("added line",string(data["lineKey"]))
	}

}

void function deleteLine(table data)
{
	if(networkJsonContainsKeys(data,["lineKey"]))
		delete file.lines[string(data["lineKey"])]
	
}

void function readSocket()
{
	while(true)
	{
		string message = NSReadSocketMessage()
		while(message!="")
		{
			printt(message)
			table data = DecodeJSON(message)
			if("type" in data)
			{
				if(string(data["type"]) in file.readMessageCallbacks)
					foreach(void functionref(table data) func in file.readMessageCallbacks[string(data["type"])])
						func(data)
			}
			else
			{
				printt("decode no worky")
			}
			message = NSReadSocketMessage()
		}
		WaitFrame()
	}
}

void function sendTableSocket(table data)
{
	NSSendSocketMessage(EncodeJSON(data))
}


const float renderDelay = 3

void function renderStuff()
{
	float lastTime = Time()
	wait renderDelay
	while(true)
	{
		float currentTime = Time()
		float deltaTime = currentTime -lastTime
		float lastTime = currentTime
		int index
		foreach(string key,line l in file.lines){
			DebugDrawLine(l.begin, l.end,l.red, l.green, l.blue,l.isObstructed,deltaTime)
			if(index%100==99)
				wait 0.2
			index++
		}

		wait renderDelay
	}
}


void function addReadMessageCallback(string type,void functionref(table data) callbackFunk)
{
	//callback has to make sure all used data is in the table
	if(!(type in file.readMessageCallbacks))
		file.readMessageCallbacks[type] <- []
	
	file.readMessageCallbacks[type].append(callbackFunk)
}

void function removeReadMessageCallback(string type,void functionref(table data) callbackFunk)
{
	if(type in file.readMessageCallbacks)
		return
	file.readMessageCallbacks[type].fastremovebyvalue(callbackFunk)
}

void function selectModelForToolgun(table data)
{
	if(networkJsonContainsKeys(data,["model"]))
	{
		
	}
}

bool function networkJsonContainsKeys(table data,array<string> keys)
{
	foreach(string u in keys)
	{
		if(!(u in data))
		{
			printt("Key missing: ",u)
			NSSendSocketMessage("{\"type\":\"error\",\"errorType\":\"missingKey\",\"key\":\""+u+"\"}")
			return false
		}
	}
	return true
}