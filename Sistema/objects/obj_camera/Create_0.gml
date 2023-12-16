/// @description Insert description here
// You can write your code in this editor
alvo = noone;
estado = noone;
escala = 1;
cam_w = camera_get_view_width(view_camera[0])
cam_h = camera_get_view_height(view_camera[0])

zoom = function()
{
	camera_set_view_size(view_camera[0], cam_w * escala, cam_h * escala)
	
	if (mouse_wheel_up())
	{
		escala -= .1
	}
	
	else if (mouse_wheel_down())
	{
		escala += .1
	}
	escala = clamp(escala, 1, 1.5)
}

segue_alvo = function()
{
	var _cam_w = camera_get_view_width(view_camera[0])
	var _cam_h = camera_get_view_height(view_camera[0])
	
	var _cam_x = x - _cam_w / 2
	var _cam_y = y - _cam_h / 2
	
	_cam_x = clamp(_cam_x, 0, room_width - _cam_w)
	_cam_y = clamp(_cam_y, 0, room_height - _cam_h)
	
	x = lerp(x, alvo.x, .1)
	y = lerp(y, alvo.y, .1)
	
	camera_set_view_pos(view_camera[0], round(_cam_x), round(_cam_y))
}
segue_player = function()
{
	var _player = instance_exists(obj_player)
	if (_player)
	{
		alvo = obj_player
	}
	else
	{
		estado = segue_nada;
	}
	
	segue_alvo();
	
	//if (keyboard_check_released(vk_space)) estado = segue_inimigo
}
segue_nada = function()
{
	alvo = noone
}
segue_inimigo = function()
{
	alvo = obj_inimigo
	
	segue_alvo();
	if (keyboard_check_released(vk_space)) estado = segue_player
}

estado = segue_player;