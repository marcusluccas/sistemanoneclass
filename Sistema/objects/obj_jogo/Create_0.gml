/// @description Insert description here
// You can write your code in this editor
global.pause = false;

global.inventory = ds_grid_create(4, 4)

ds_grid_clear(global.inventory, 0)

display_set_gui_size(512, 288)

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
	var _desc_x = _item_x + _item_w + _marg_x;
	var _desc_y = _item_y;
	var _desc_w = (_inv_w * .3) - _marg_x * 2;
	var _desc_h = _item_h;
	var _lins = ds_grid_width(global.inventory);
	var _cols = ds_grid_height(global.inventory);
	var _grid_marg_x = _item_w * .02
	var _grid_marg_y = _item_h * .02
	var _grid_w = (_item_w - _lins * _grid_marg_x) div _lins
	var _grid_h = (_item_h - _cols * _grid_marg_y) div _cols
	var _mouse_x = device_mouse_x_to_gui(0)
	var _mouse_y = device_mouse_y_to_gui(0)
	
	draw_sprite_stretched(spr_inventory_fundo, 0, _inv_x, _inv_y, _inv_w, _inv_h)
	
	draw_rectangle(_item_x, _item_y, _item_x + _item_w, _item_y + _item_h, true)
	
	draw_rectangle(_desc_x, _desc_y, _desc_x + _desc_w, _desc_y + _desc_h, true)
	
	for (var i = 0; i < _lins; i++)
	{
		for (var j = 0; j < _cols; j++)
		{
			var _sel_y = (_mouse_y - _item_y - (_grid_marg_y * j)) div _grid_h
			var _sel_x = (_mouse_x - _item_x - (_grid_marg_x * i)) div _grid_w
			
			var _x1 = _item_x + _grid_w * i + (_grid_marg_x * i) + _grid_marg_x
			var _y1 = _item_y + _grid_h * j + (_grid_marg_y * j) + _grid_marg_y
			
			
			var selecionado = (_sel_x == i and _sel_y == j)
			
			draw_sprite_stretched(spr_inventory_caixa, selecionado, _x1, _y1, _grid_w, _grid_h)
		}
	}
}