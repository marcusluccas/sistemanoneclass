/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
randomize();
size = sprite_get_width(spr_parede)

gera_sala = function()
{
	var _larg = size * irandom_range(100, 300)
	var _alt = _larg div 1.77777777;
	
	room_width = _larg;
	room_height = _alt;
	
	var _cols = _larg div size;
	var _lins = _alt div size;
	var _grid = ds_grid_create(_cols, _lins)
	
	ds_grid_clear(_grid, 1)
	
	instance_create_layer((_cols div 2) * size + 16, (_lins div 2) * size + 16, layer, obj_player)
	
	_grid = gera_mundo(_grid);
	
	preenche_sala(_grid);
}

gera_mundo = function(_grid)
{
	var _cols = ds_grid_width(_grid);
	var _lins = ds_grid_height(_grid);
	
	var _repete = irandom_range(_cols * 18, _cols * 32);
	
	var _x = ds_grid_width(_grid) div 2;
	var _y = ds_grid_height(_grid) div 2;
	
	_grid[# _x, _y] = 0
	
	var _dir = irandom(3)
	repeat(_repete)
	{		
		var _chance = irandom(100)
		if (_chance > 30)
		{
			var _dir = irandom(3)
		}
		
		switch(_dir)
		{
			case 0: _x += 1; break;
			case 1: _y -= 1; break;
			case 2: _x -= 1; break;
			case 3: _y += 1; break;
		}
		
		_x = clamp(_x, 1, _cols -2)
		_y = clamp(_y, 1, _lins -2)
		
		_grid[# _x, _y] = 0
		
		if (!instance_exists(obj_coin))
		{
			var _chance = random(100);
			
			if (_chance > 99.99)
			{
				var _x_coin = (_x) * size + 16
				var _y_coin = (_y) * size + 16
				var _coin = instance_create_layer(_x_coin, _y_coin, layer, obj_coin)
				if (_x_coin == obj_player.x and _y_coin == obj_player.y) game_restart();
			}
		}
	}
	if (!instance_exists(obj_coin))
	{
		game_restart();
	}
	return _grid
}

preenche_sala = function(_grid)
{
	for (var i = 0; i < ds_grid_height(_grid); i++)
	{
		for (var j = 0; j < ds_grid_width(_grid); j++)
		{
			var _celula = _grid[# j, i];
			if (_celula)
			{
				var _wall = instance_create_layer(j * size, i * size, layer, obj_parede);
			}
		}
	}
}

gera_sala()