/// @description Insert description here
// You can write your code in this editor
ds_grid_clear(global.inventory, -4)

global.inventory[# 2, 2] = global.armas[| armas.espada_madeira]
global.inventory[# 0, 1] = global.armas[| armas.espada_comum]
global.inventory[# 0, 0] = global.armas[| armas.espada_sangue]

global.inventory[# 1, 2] = global.consumiveis[| consumiveis.pocao_vermelha]
global.inventory[# 2, 0] = global.consumiveis[| consumiveis.pocao_vermelha]
global.inventory[# 0, 2] = global.consumiveis[| consumiveis.pocao_coracoes]

dados = noone

iniciou = false

display_set_gui_size(512, 288)

inicia_jogo = function(_dados)
{
	var _seq = pega_sequence("Inicio")
	
	if (layer_sequence_is_finished(_seq))
	{
		iniciou = true;
		if (room == rm_inicio)
		{
			if (!_dados)
			{
				room = rm_modelo;
				var _player = instance_create_layer(256, 160, "Player", obj_player);
				var _transicao = instance_create_depth(_player.x, _player.y, -10000, obj_transicao);
			}
			else
			{
				var _player = instance_create_layer(256, 160, "Player", obj_player);
				carrega_jogo(global.save);
				var _transicao = instance_create_depth(_player.x, _player.y, -10000, obj_transicao);
			}
		}
	}
}

salva_jogo = function(_save)
{
	switch (_save)
	{
		case 0:
		var _arquivo = "Save 01.json"
		break;
		
		case 1:
		var _arquivo = "Save 02.json"
		break;
		
		case 2:
		var _arquivo = "Save 03.json"
		break;
	}

	var _w = ds_grid_width(global.inventory);
	var _h = ds_grid_height(global.inventory);
	for(var i = 0; i < _w; i++)
	{
		for(var j = 0; j < _h; j++)
		{
			inventory_array[i][j] = global.inventory[# i, j];
		}
	}

	var _dados =
	{
		player : 
		{
			meu_x : obj_player.x,
			meu_y : obj_player.y,
			rm : room,
			vida_atual : global.vida_player,
			vida_max : global.max_vida_player,
			arma_atual : global.arma_player,
			inventory : inventory_array,
		},
	}
	
	var _json = json_stringify(_dados);
	
	var _file = file_text_open_write(_arquivo);
	
	file_text_write_string(_file, _json);
	
	file_text_close(_file);
}

carrega_jogo = function(_save)
{
	switch (_save)
	{
		case 0:
		var _arquivo = "Save 01.json"
		break;
		
		case 1:
		var _arquivo = "Save 02.json"
		break;
		
		case 2:
		var _arquivo = "Save 03.json"
		break;
	}
	
	if (file_exists(_arquivo))
	{
	var _file = file_text_open_read(_arquivo);
	
	var _json = file_text_read_string(_file);
	
	file_text_close(_file);
	}
	
	var _dados = json_parse(_json);
	
	obj_player.x = _dados.player.meu_x;
	obj_player.y = _dados.player.meu_y;
	room = _dados.player.rm;
	global.max_vida_player = _dados.player.vida_max;
	global.vida_player = _dados.player.vida_atual;
	global.arma_player = _dados.player.arma_atual;
	
	var _w = ds_grid_width(global.inventory);
	var _h = ds_grid_height(global.inventory);
	
	for (var i = 0; i < _w; i++)
	{
		for (var j = 0; j < _h; j++)
		{
			var _item_atual = _dados.player.inventory[i][j]
			if (_item_atual)
			{
				switch(_item_atual.tipo)
				{
					case tipo_item.arma:
					var _id = _item_atual.meu_id
					global.inventory[# i, j] = global.armas[| _id]
					break;
					
					case tipo_item.consumiveis:
					var _id = _item_atual.meu_id
					global.inventory[# i, j] = global.consumiveis[| _id]
					break;
				}
			}
			else
			{
				global.inventory[# i, j] = noone
			}
		}
	}
}

desenha_coracoes = function(_x, _y)
{
	var _w = sprite_get_width(spr_coracoes) / 1.5
	
	for (var i = 0; i < global.max_vida_player; i += 2)
	{
		draw_sprite(spr_coracoes, 0, _x + (i * _w), _y)
	}
	
	for (var i = 0; i < global.vida_player; i += 2)
	{
		var _img = ((global.vida_player - i) != 1) + 1
		
		draw_sprite(spr_coracoes, _img, _x + (i * _w), _y)
	}
}

tela_pause = function()
{
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();

	draw_set_alpha(.5)
	draw_rectangle_color(0, 0, _gui_w, _gui_h, c_black, c_black, c_black, c_black, false)
	draw_set_alpha(1)
	
	if (!layer_exists("Efeito_Blur"))
	{
		var blur = fx_create("_filter_linear_blur")
		
		layer_create(-10000, "Efeito_Blur")
		
		fx_set_parameter(blur, "g_LinearBlurVector", [5, 5])
		layer_set_fx("Efeito_Blur", blur)
	}
	
	layer_enable_fx("Efeito_Blur", true)
}

desenha_inventario = function()
{
	static _sel_x = 0, _sel_y = 0;
	static _item_mouse = noone
	
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _spr_w = sprite_get_width(spr_inventory_fundo);
	var _spr_h = sprite_get_height(spr_inventory_fundo);
	var _inv_w = _gui_w * .6;
	var _inv_h = _gui_h * .6;
	var _inv_x = _gui_w / 2 - (_inv_w) / 2
	var _inv_y = _gui_h / 2 - (_inv_h) / 2
	var _marg_x = _inv_w * .04;
	var _marg_y = _inv_h * .05;
	var _item_x = _inv_x + _marg_x;
	var _item_y = _inv_y + _marg_y;
	var _item_w = (_inv_w * .7) - _marg_x;
	var _item_h = _inv_h - _marg_y * 2;
	var _desc_x = _item_x + _item_w + _marg_x / 2;
	var _desc_y = _item_y;
	var _desc_w = (_inv_w * .3) - _marg_x * 2;
	var _desc_h = _item_h;
	var _cols = ds_grid_width(global.inventory);
	var _lins = ds_grid_height(global.inventory);
	var _grid_marg_x = _item_w * .02
	var _grid_marg_y = _item_h * .02
	var _grid_w = (_item_w - _cols * _grid_marg_x) div _cols
	var _grid_h = (_item_h - _lins * _grid_marg_y) div _lins
	var _mouse_x = device_mouse_x_to_gui(0)
	var _mouse_y = device_mouse_y_to_gui(0)
	
	var _mouse_na_area = _mouse_x == clamp(_mouse_x, _item_x, _item_x + _item_w) and
	_mouse_y == clamp(_mouse_y, _item_y, _item_y + _item_h)
	
	if (_mouse_na_area)
	{
		var _item_sel = global.inventory[# _sel_x, _sel_y]
		
		if (mouse_check_button_released(mb_right))
		{
			if (_item_sel)
			{
				_item_sel.usa_item(_sel_x, _sel_y)
			}
		}
		if (mouse_check_button_released(mb_left))
		{
			_item_mouse = troca_item(_sel_x, _sel_y, _item_mouse)
		}
	}
	else
	{
		var _qtd_armas = conta_armas(global.arma_player)
		
		if (_item_mouse)
		{
			if (_item_mouse != global.arma_player or _qtd_armas > 0)
			{
				if (mouse_check_button_released(mb_left))
				{
					var _mouse_room_x = mouse_x
					var _mouse_room_y = mouse_y
			
					_item_mouse = joga_item(_mouse_room_x, _mouse_room_y, _item_mouse)
				}
			}
		}
	}
	
	draw_sprite_stretched(spr_inventory_fundo, 0, _inv_x, _inv_y, _inv_w, _inv_h)
	
	//draw_rectangle(_item_x, _item_y, _item_x + _item_w, _item_y + _item_h, true)
	
	//draw_rectangle(_desc_x, _desc_y, _desc_x + _desc_w, _desc_y + _desc_h, true)
	
	var _equip_x = (_inv_x + _inv_w / 2) - _grid_w / 2
	var _equip_y = (_inv_y - _grid_h)
	draw_sprite_stretched(spr_inventory_caixa, 0, _equip_x, _equip_y, _grid_w, _grid_h)
	
	if (global.arma_player)
	{
		var _equip_item_w = _grid_w * .5
		var _equip_item_h = _grid_h * .5 
		var _equip_item_x = _equip_x + _equip_item_w / 2
		var _equip_item_y = _equip_y + _equip_item_h / 2
		
		draw_sprite_stretched(global.arma_player.spr, global.arma_player.meu_id, _equip_item_x, _equip_item_y, _equip_item_w, _equip_item_h)
	}
	
	for (var i = 0; i < _lins; i++)
	{
		for (var j = 0; j < _cols; j++)
		{
			if (_mouse_na_area)
			{
			var _sel_y = (_mouse_y - _item_y - (_grid_marg_y * i)) div _grid_h;
			var _sel_x = (_mouse_x - _item_x - (_grid_marg_x * j)) div _grid_w;
			}
			
			_sel_y = clamp(_sel_y, 0, _lins - 1)
			_sel_x = clamp(_sel_x, 0, _cols - 1)
			
			var _x1 = _item_x + _grid_w * j + (_grid_marg_x * j) + _grid_marg_x
			var _y1 = _item_y + _grid_h * i + (_grid_marg_y * i) + _grid_marg_y
			
			var selecionado = (_sel_x == j and _sel_y == i)
			
			draw_sprite_stretched(spr_inventory_caixa, selecionado, _x1, _y1, _grid_w, _grid_h)
			
			var _item_atual = encontra_item(j, i)
			
			if (_item_atual)
			{
				var _arma_w = _grid_w * .5
				var _arma_h = _grid_h * .5 
				var _arma_x =  _x1 + _arma_w / 2
				var _arma_y =  _y1 + _arma_h / 2
				
				draw_sprite_stretched(_item_atual.spr, _item_atual.meu_id, _arma_x, _arma_y, _arma_w, _arma_h)
			}
			
			var _sel_atual = encontra_item(_sel_x, _sel_y)
			
			if (_sel_atual)
			{
				var _arma_spr_w = sprite_get_width(_sel_atual.spr);
				var _arma_spr_h = sprite_get_height(_sel_atual.spr);
				var _arma_w = (_grid_w * .5);
				var _arma_h = (_grid_h * .5);
				var _arma_escala_w = _arma_w / _arma_spr_w;
				var _arma_escala_h = _arma_h / _arma_spr_h;
				var _arma_x =  _desc_x + _desc_w / 2;
				var _arma_y =  _desc_y + _arma_h;
				var efeito_x = sin(2 * get_timer() / 1000000);
				
				//draw_sprite_stretched(_sel_atual.spr, _sel_atual.meu_id, _arma_x , _arma_y, _arma_w, _arma_h)
				draw_sprite_ext(_sel_atual.spr, _sel_atual.meu_id, _arma_x, _arma_y, efeito_x * _arma_escala_w, _arma_escala_h, 0, c_white, 1)
				
				draw_set_halign(1)
				draw_set_font(fnt_inventory)
				
				//draw_text_ext(_arma_x, _arma_y + _arma_h, _sel_atual.desc, 20, _desc_w)
				var _sep = string_height("I")
				
				draw_set_color(c_black)
				
				draw_text_ext_transformed(_arma_x + 1, _arma_y + _arma_h + 1, _sel_atual.desc, _sep, _desc_w * 5, .2, .2, 0);
				
				draw_set_color(-1)
				
				draw_text_ext_transformed(_arma_x, _arma_y + _arma_h, _sel_atual.desc, _sep, _desc_w * 5, .2, .2, 0);
				
				draw_set_font(-1)
				draw_set_halign(-1)
			}
		}
		if (_item_mouse)
		{
			var _mouse_item_w = _grid_w * .5
			var _mouse_item_h = _grid_h * .5 
			var _mouse_item_x = _mouse_x
			var _mouse_item_y = _mouse_y
			
			draw_sprite_stretched(_item_mouse.spr, _item_mouse.meu_id, _mouse_item_x, _mouse_item_y, _mouse_item_w, _mouse_item_h)
		}
	}
}

encontra_item = function(_x, _y)
{
	return global.inventory[# _x, _y]
}
troca_item = function(_x, _y, _item)
{
	var _item_troca = global.inventory[# _x, _y]
	global.inventory[# _x, _y] = _item
	
	return _item_troca
}
joga_item = function(_x, _y, _item)
{
	var _obj_item = instance_create_layer(_x, _y, layer, obj_item)
	_obj_item.item = _item
	return noone
}
conta_armas = function(_arma)
{
	var _qtd = 0
	for (var i = 0; i < ds_grid_height(global.inventory); i ++)
	{
		for (var j = 0; j < ds_grid_width(global.inventory); j ++)
		{
			if (global.inventory[# i, j] == _arma) _qtd ++;
		}
	}
	return _qtd;
}