// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Funcoes(){
}
	
global.pause = false;

global.inventory = ds_grid_create(4, 4)

function pega_sequence(layer)
{
	var _lay = layer_get_id(layer);
	
	var _seq = layer_get_all_elements(_lay);
	
	for (var i = 0; i < array_length(_seq); i ++)
	{	
		if (layer_get_element_type(_seq[i]) == layerelementtype_sequence)
		{
			return _seq[i];
			break;
		}
	}
	return false;
}

global.save = 0;
///@fuction desenha_sombra(sprite, escala, [cor], [alpha]
function desenha_sombra(sprite, escala, cor = c_white, alpha = .3){
	draw_sprite_ext(sprite, 0, x, y, escala, escala, 0, cor, alpha)
}

function ajusta_depth(){
	depth = -y;
}

///@function cria_arma(name, desc, spr, hit, [spd])
function cria_arma(_nome, _desc, _spr, _dano, _vel = 1, _esp) constructor
{
	tipo = tipo_item.arma
	static _qtd_arma = 0;
	meu_id = _qtd_arma++;
	nome = _nome;
	desc = _desc;
	spr = _spr;
	dano = _dano;
	vel = _vel;
	esp = _esp
	
	static usa_item = function()
	{
		global.arma_player = global.armas[| meu_id]
	}
	static pega_item = function()
	{
		var _cols = ds_grid_width(global.inventory)
		var _lins = ds_grid_height(global.inventory)
		
		for (var i = 0; i < _lins; i ++)
		{
			for (var j = 0; j < _cols; j ++)
			{
				var _atual = global.inventory[# j, i]
				if (!_atual)
				{
					global.inventory[# j, i] = global.armas[| meu_id]
					
					return true;
				}
			}
		}
	}
}

global.armas = ds_list_create();
global.arma_player = noone;

global.max_vida_player = 6
global.vida_player = global.max_vida_player

enum tipo_item
{
	arma,
	consumiveis
}

enum consumiveis
{
	pocao_vermelha,
	pocao_coracoes
}

enum armas
{
	espada_madeira,
	espada_comum,
	espada_sangue
}

enum saves
{
	save_01,
	save_02,
	save_03
}

var _a = new cria_arma("Espada de madeira", "Uma espada feita de madeira de cerejeira", spr_espada, 1, 1, espada_madeira_especial)
var _b = new cria_arma("Espada comum", "Uma espada comum para um gerreiro comum", spr_espada, 2, .9, espada_comun_especial)
var _c = new cria_arma("Espada de sangue", "Uma espada de ferro coberta de sangue de seus inimigos", spr_espada, 3, .5, espada_sangue_especial)

ds_list_add(global.armas, _a, _b, _c)

function espada_comun_especial()
{
	if (instance_exists(obj_player))
	{
		with (obj_player)
		{
			/*
			var _nova_seq = sequence_get(sq_attack_ex_1)
			
			_nova_seq.tracks[0].keyframes[0].channels[0].spriteIndex = spr_array[0][face]
			_nova_seq.tracks[1].keyframes[0].channels[0].spriteIndex = spr_array[2][face]
			*/
			
			var _nova_seq = ajusta_sprite_seq([spr_array[0, face], spr_array[2, face]], sq_attack_ex_1)
			
			var _layer = layer_create(depth, "attack_especial")
	
			var _seq = layer_sequence_create(_layer, x, y, _nova_seq)
		}
		return _seq;
	}
	return false;
}

function ajusta_sprite_seq(_sprite, _seq)
{
	var _nova_seq = sequence_get(_seq);
	
	var _qtd = array_length(_sprite);
	
	for (var i = 0; i < _qtd; i ++;)
	{
		var _atual = _sprite[i]
		
		if (_atual)
		{
			_nova_seq.tracks[i].keyframes[0].channels[0].spriteIndex = _sprite[i];
		}
	}
	
	return _nova_seq;
}

function espada_madeira_especial()
{
	if (instance_exists(obj_player))
	{
		with(obj_player)
		{
			var _nova_seq = ajusta_sprite_seq([spr_array[2, face]], sq_attack_ex_2);
			
			var _layer = layer_create(depth, "attack_especial");
			
			var _seq = layer_sequence_create(_layer, x, y, _nova_seq);
			
			layer_sequence_xscale(_seq, xscale)
			
			var _dist_x = lengthdir_x(sprite_width, (face * 90))
			var _dist_y = lengthdir_y(sprite_height, (face * 90))
			
			var _tiro = instance_create_layer(x + _dist_x, y - sprite_height / 2 + _dist_y, "attack_especial", obj_tiro)
			
			_tiro.direction = (face * 90)
			_tiro.image_angle = (face * 90) - 90
		}
		return _seq;
	}
	return false;
}

function espada_sangue_especial()
{
	if (instance_exists(obj_player))
	{
		with (obj_player)
		{
			var _layer = layer_create(-10000, "attack_especial")
			
			var _seq = layer_sequence_create(_layer, x, y, sq_attack_ex_3)
		}
		return _seq;
	}
	return false;
}

function screenshake(_treme = 15)
{
	var _screen = instance_create_depth(0, 0, 0, obj_scrrenshake);
	_screen.treme = _treme;
}

function cria_consumiveis(_nome, _desc, _spr, _efeito) constructor
{
	tipo = tipo_item.consumiveis;
	static _qtd_itens = 0;
	meu_id = _qtd_itens++;
	nome = _nome;
	desc = _desc;
	spr = _spr;
	efeito = _efeito
	
	usa_item = function(_pos_x, _pos_y)
	{
		efeito(_pos_x, _pos_y);
	}
	static pega_item = function()
	{
		var _cols = ds_grid_width(global.inventory)
		var _lins = ds_grid_height(global.inventory)
		
		for (var i = 0; i < _lins; i++)
		{
			for (var j = 0; j < _cols; j++)
			{
				var _atual = global.inventory[# j, i]
				if (!_atual)
				{
					global.inventory[# j, i] = global.consumiveis[| meu_id]
					
					return true
				}
			}
		}
		return false;
	}
}

global.consumiveis = ds_list_create();

var _a = new cria_consumiveis("Poção vermelha", "Uma poção vermelha como cereja, mas parece com sangue, efeito cura vida", spr_pocao_vermelha, efeito_pocao_vermelha)
var _b = new cria_consumiveis("Poção de coração", "Um pote em formado de coração com uma cor meia escarlate, efeito não conhecido", spr_pocao_coracao, efeito_pocao_coracao)

ds_list_add(global.consumiveis, _a, _b)

function efeito_pocao_vermelha(_pos_x, _pos_y)
{
	if (global.vida_player != global.max_vida_player)
	{
		var _vida_add = global.max_vida_player - global.vida_player
	
		global.vida_player += _vida_add
	
		global.inventory[# _pos_x, _pos_y] = noone;
	}
}

function efeito_pocao_coracao(_pos_x, _pos_y)
{
	global.max_vida_player += 2
	global.vida_player = global.max_vida_player;
	
	global.inventory[# _pos_x, _pos_y] = noone
}