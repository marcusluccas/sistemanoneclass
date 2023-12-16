/// @description Insert description here
// You can write your code in this editor
dialogo = noone
txt_index = 1
pag = 0
player = noone

libera_player = function()
{
	if (player)
	{
		with (player)
		{
		estado = estado_parado;
		player = noone
		}
	}
	instance_destroy();
}

cria_dialogo = function(dialogo)
{
	static gui_w = display_get_gui_width();
	static gui_h = display_get_gui_height();
	static spr_w = sprite_get_width(spr_caixa_dialogo);
	static spr_h = sprite_get_height(spr_caixa_dialogo);
	
	draw_set_font(fnt_dialogo)
	
	var _txt = dialogo.txt[pag]
	var _txt_vel = dialogo.txt_vel
	var _txt_atual = string_copy(_txt, 1, txt_index)
	var _txt_size = string_length(_txt)
	var _xscale = gui_w / spr_w
	var _yscale = (gui_h * .3) / spr_h
	var _marg = string_height("I")
	var _alt = string_height(_txt)
	var _yy = gui_h - _yscale * spr_h
	var _retrato = dialogo.retrato[pag]
	var _ret_h = (gui_h * .2) / sprite_get_height(_retrato)
	var _ret_yy = _yy + (sprite_get_height(_retrato) * _ret_h / 2) / 2
	var _ret_w = sprite_get_width(_retrato) * _ret_h
	var _qtd_pag = array_length(dialogo.txt) - 1;
	
	draw_sprite_ext(spr_caixa_dialogo, 0, 0, _yy, _xscale, _yscale, 0, c_white, 1)
	
	draw_sprite_ext(_retrato, 0, _marg, _ret_yy, _ret_h, _ret_h, 0, c_white, 1)
	
	if (keyboard_check_pressed(vk_space))
	{
		if (txt_index < _txt_size) txt_index = _txt_size
		
		else if (pag < _qtd_pag)
		{
		txt_index = 1
		pag ++;
		}
		else
		{
			libera_player()
		}
	}
	
	if (txt_index <= _txt_size) txt_index += _txt_vel
	
	draw_text_ext(_marg * 2 + _ret_w, _yy + _marg, _txt_atual, _alt, gui_w - _marg * 2 - _ret_w)
	
	draw_set_font(-1)
}