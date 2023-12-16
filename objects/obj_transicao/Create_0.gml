/// @description Insert description here
// You can write your code in this editor
player = noone;
room_destino = noone;
destino_x = 0;
destino_y = 0;

alarm[0] = room_speed / 2

cria_transicao = function(_seq)
{
	lay = layer_create(depth, "Transicao");

	if (instance_exists(obj_player))
	{
		var _gui_w = display_get_gui_width();
		var _gui_h = display_get_gui_height();
		var _pos_x = obj_player.x;
		_pos_x = clamp(_pos_x, _gui_w / 2, room_width - _gui_w / 2);
		var _pos_y = obj_player.y;
		_pos_y = clamp(_pos_y, _gui_h / 2, room_height - _gui_h / 2);
		layer_sequence_create(lay, _pos_x, _pos_y, _seq);
	}
	else
	{
		var _gui_w = display_get_gui_width();
		var _gui_h = display_get_gui_height();
		var _pos_x = x;
		_pos_x = clamp(_pos_x, _gui_w / 2, room_width - _gui_w / 2);
		var _pos_y = y;
		_pos_y = clamp(_pos_y, _gui_h / 2, room_height - _gui_h / 2);
		layer_sequence_create(lay, _pos_x, _pos_y, _seq);
	}
}

cria_transicao(sq_transicao_ini)