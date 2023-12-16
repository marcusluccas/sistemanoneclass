/// @description Insert description here
// You can write your code in this editor
meu_y_inicial = 81;
image_alpha = .2;
red = 255;
green = 255;
blue = 255;
transicao = noone;

image_blend = make_color_rgb(red, green, blue)

global.iniciou = false

meu_slot = function()
{
	static num = 0;
	return ++num;
}

meu_num = meu_slot();

meu_save = noone
switch (meu_num)
{
	case 1:
	meu_arquivo = "Save 01.json";
	break;
	
	case 2:
	meu_arquivo = "Save 02.json";
	break;
	
	case 3:
	meu_arquivo = "Save 03.json";
	break;
}

meu_efeito = function()
{
	image_blend = make_color_rgb(red, green, blue)
	var _mouse_sobre = position_meeting(mouse_x, mouse_y, id);
	var _mouse_click = mouse_check_button_released(mb_left);
	
	if (_mouse_sobre)
	{
		y = lerp(y, meu_y_inicial - 10, .1);
		image_alpha = lerp(image_alpha, .8, .1);
		red = lerp(red, 50, .1);
		green = lerp(green, 180, .1);
		blue = lerp(blue, 50, .1);
		
		if (_mouse_click && !global.iniciou)
		{
			global.iniciou = true;
			
			global.save = meu_num -1
			
			var _seq = pega_sequence("Inicio")
			layer_sequence_play(_seq)
			
		if (instance_exists(obj_jogo))
		{
			obj_jogo.dados = meu_save;
		}
		}
	}
	else
	{
		y = lerp(y, meu_y_inicial, .1);
		image_alpha = lerp(image_alpha, .2, .1);
		red = lerp(red, 255, .1);
		green = lerp(green, 255, .1);
		blue = lerp(blue, 255, .1);
	}
}

pega_save = function()
{
	var _file = file_text_open_read(meu_arquivo);
	if(_file == -1) return false;
	
	var _code = file_text_read_string(_file);
	
	var _json = json_parse(_code);
	return _json;
}

meu_save = pega_save();