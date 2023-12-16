/// @description Insert description here
// You can write your code in this editor
var _cols = ds_list_create();

var _qtd = instance_place_list(x, y, obj_inimigo_pai, _cols, false)

for (var i = 0; i < _qtd; i++)
{
	var _outro = _cols[| i]
	
	if (meu_pai != _outro)
	{
		if (ds_list_find_index(list_atacados, _outro) == -1)
		{
			ds_list_add(list_atacados, _outro)
			var _dano = global.arma_player != noone ? global.arma_player.dano : 0;
			_outro.tomar_dano(_dano)
			_outro.dano_id = meu_pai
		}
	}
}

/*
if (_qtd)
{
	for (var i = 0; i < _qtd; i++)
	{
		var _outro = _cols[| i]
		_outro.tomar_dano();
		_outro.dano_dir = point_direction(x, y, _outro.x, _outro.y)
	}
}
*/

ds_list_destroy(_cols);