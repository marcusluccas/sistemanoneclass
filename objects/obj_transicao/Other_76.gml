/// @description Insert description here
// You can write your code in this editor
var _event = event_data [? "event_type"];

if (_event == "sequence event")
{
	switch (event_data [? "message"])
	{
		case "terminei":
		room_goto(room_destino);
		layer_destroy(lay);
		player.x = destino_x;
		player.y = destino_y;
		alarm = room_speed / 2
		break;
		
		case "acabou": 
		instance_destroy();
		break;
	}
}