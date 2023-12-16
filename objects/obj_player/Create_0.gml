/// @description Insert description here
// You can write your code in this editor
// Inherit the parent event
event_inherited();

max_vel = 3;
meu_acel = .1;     
acel = meu_acel;
estado = noone;
estado_txt = "parado";
face = 0;
dano = noone
defendendo = false
transicao = false

sq_especial = noone

sprite = sprite_index;
xscale = 1;
img_ind = 0;
img_spd = 6 / room_speed;
img_numb = 1;
roll_vel = 5;
scala = 1
global.debug = false
npc_dialogo = noone
time_dano = room_speed * 2
timer_dano = 0
time_esquiva = room_speed;
delag_esquiva = 0;

var _cam = instance_create_layer(x, y, layer, obj_camera)

keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("J"), ord("C"));
keyboard_set_map(ord("L"), ord("Z"));
keyboard_set_map(ord("K"), ord("X"));
keyboard_set_map(ord("H"), ord("V"));
keyboard_set_map(vk_enter, vk_space);

#region array sprite

spr_array [0] [0] = spr_player_idle_right
spr_array [0] [1] = spr_player_idle_up
spr_array [0] [2] = spr_player_idle_right
spr_array [0] [3] = spr_player_idle_down

spr_array [1] [0] = spr_player_run_right
spr_array [1] [1] = spr_player_run_up
spr_array [1] [2] = spr_player_run_right
spr_array [1] [3] = spr_player_run_down

spr_array [2] [0] = spr_player_attack_right
spr_array [2] [1] = spr_player_attack_up
spr_array [2] [2] = spr_player_attack_right
spr_array [2] [3] = spr_player_attack_down

spr_array [3] [0] = spr_player_shield_right
spr_array [3] [1] = spr_player_shield_up
spr_array [3] [2] = spr_player_shield_right
spr_array [3] [3] = spr_player_shield_down

spr_array [4] [0] = spr_player_roll_right
spr_array [4] [1] = spr_player_roll_up
spr_array [4] [2] = spr_player_roll_right
spr_array [4] [3] = spr_player_roll_down

spr_array [5] [0] = spr_player_hurt_right
spr_array [5] [1] = spr_player_hurt_up
spr_array [5] [2] = spr_player_hurt_right
spr_array [5] [3] = spr_player_hurt_down

#endregion

#region xscale

	xsca_array [0] = 1
	xsca_array [1] = 1
	xsca_array [2] = -1
	xsca_array [3] = 1

#endregion

ajusta_sprite = function(_indice_spr)
{
	if (sprite != spr_array [_indice_spr] [face])
	{
		img_ind = 0
	}
	
	sprite = spr_array [_indice_spr] [face]
	xscale = xsca_array [face]
	
	img_numb = sprite_get_number(sprite)
	img_ind += img_spd
	img_ind %= img_numb
}
controla_player = function()
{
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _attack = keyboard_check_pressed(ord("C"))
	var _shield = keyboard_check(ord("Z"))
	var _roll = keyboard_check_pressed(ord("X"))
	
	enum dir
	{
		direita,
		cima,
		esquerda,
		baixo
	}
	
	if (_up) face = dir.cima;
	if (_down) face = dir.baixo;
	if (_left) face = dir.esquerda;
	if (_right) face = dir.direita;
	
	var _dir = point_direction(0, 0, (_right - _left), (_down - _up));

	if ((_left xor _right) or (_down xor _up))
	{
		var _max_velh = lengthdir_x(max_vel, _dir);
		velh = lerp(velh, _max_velh, acel);
		var _max_velv = lengthdir_y(max_vel, _dir);
		velv = lerp(velv, _max_velv, acel);
	}
	else
	{
		velh = lerp(velh, 0, acel);
		velv = lerp(velv, 0, acel);
	}
}
tomar_dano = function()
{
		
}
knouckback = function(_x, _y, _force = 1)
{
	var _dir = point_direction(_x, _y, x, y)
	
	velh = lengthdir_x(_force, _dir)
	velv = lengthdir_y(_force, _dir)
}

estado_parado = function()
{
	controla_player();
	
	estado_txt = "parado";
	
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _attack = keyboard_check_pressed(ord("C"))
	var _shield = keyboard_check(ord("Z"))
	var _roll = keyboard_check_pressed(ord("X"))
	var _esp = keyboard_check_pressed(ord("V"))
	
	velh = 0
	velv = 0
	
	delag_esquiva --;
	
	ajusta_sprite(0)
	
	if ((_left xor _right) or (_down xor _up))
	{
		estado = estado_movendo;
	}
	if (_attack && global.arma_player)
	{
		estado = estado_ataque;
	}
	if (_shield)
	{
		estado = estado_defesa;
	}
	if (_roll and (delag_esquiva <= 0))
	{
		estado = estado_esquiva;
		delag_esquiva = time_esquiva
	}
	if (_esp)
	{
		estado = estado_especial
	}
}

estado_movendo = function()
{
	controla_player()
	
	estado_txt = "movendo";
	
	ajusta_sprite(1)
	
	if (clamp(img_ind, 2, 4) == img_ind)
	{
		scala = 1
	}
	else
	{
		scala = .8
	}
	
	delag_esquiva --;
	
	var _attack = keyboard_check_pressed(ord("C"))
	var _shield = keyboard_check(ord("Z"))
	var _roll = keyboard_check_pressed(ord("X"))

	if (abs(velh) <= acel and abs(velv) <= acel)
	{
		estado = estado_parado
	}
	if (_attack && global.arma_player)
	{
		estado = estado_ataque;
	}
	if (_shield)
	{
		estado = estado_defesa;
	}
	if (_roll and (delag_esquiva <= 0))
	{
		estado = estado_esquiva;
		delag_esquiva = time_esquiva;
	}
}

estado_ataque = function()
{
	estado_txt = "ataque";
	
	static _dano = noone
	
	velh = 0
	velv = 0
	
	if (!_dano)
	{
		var _dano_x = x + lengthdir_x(sprite_width, face * 90)
		var _dano_y = y + lengthdir_y(sprite_height, face * 90)
		var _add = face == 1 ? sprite_height / 2 : 0;
		
		
		_dano = instance_create_depth(_dano_x, _dano_y - sprite_height / 2 + _add, depth, obj_dano)
		_dano.meu_pai = id
	}
	
	ajusta_sprite(2);
	
	if (img_ind + img_spd >= img_numb)
	{
		estado = estado_parado;
		instance_destroy(_dano)
		_dano = noone
	}
}

estado_defesa = function()
{
	estado_txt = "defesa"
	
	controla_player();
	
	var _shield = keyboard_check(ord("Z"))
	
	velh = 0
	velv = 0
	
	if (defendendo)
	{
		knouckback(dano.x, dano.y)
		defendendo = false
	}

	ajusta_sprite(3)
	
	if (!_shield)
	{
		velh = 0
		velv = 0
		estado = estado_parado;
	}
}

estado_esquiva = function()
{
	if (estado_txt != "esquiva")
	{
		var _left = keyboard_check(vk_left);
		var _right = keyboard_check(vk_right);
		var _up = keyboard_check(vk_up);
		var _down = keyboard_check(vk_down);
		
		if ((_up xor _down) or (_right xor _left))
		{
			var _dir = point_direction(0, 0, _right - _left, _down - _up)
		
		velh = lengthdir_x(roll_vel, _dir)
		velv = lengthdir_y(roll_vel, _dir)
		}
		else
		{
			var _dir = face * 90
			
			velh = lengthdir_x(roll_vel, _dir)
			velv = lengthdir_y(roll_vel, _dir)
		}
	}
	
	estado_txt = "esquiva"
	
	ajusta_sprite(4)
	
	img_spd = sprite_get_number(sprite) / (room_speed / 3)
	
	if (img_ind + img_spd >= img_numb)
	{
		estado = estado_parado;
		img_spd = 6 / room_speed
	}
}

estado_go_dialogo = function()
{
	estado_txt = "indo para o diálogo"
	velh = 0
	velv = 0
	ajusta_sprite(1)
	if (npc_dialogo)
	{
		var _marg = 5
		var _x = npc_dialogo.x
		var _y = npc_dialogo.y + _marg
		if (bbox_top != _y)
		{
			velv = sign(_y - bbox_top)
			face = velv > 0 ? 3 : 1
			y = round(y)
			
		}
		else if (x != _x)
		{
			face = 0
			velh = sign(_x - x)
			xscale = velh
			x = round(x)
		}
		else
		{
			estado = estado_dialogo;
		}
	}
}

estado_dialogo = function()
{
	estado_txt = "diálogo"
	velh = 0
	velv = 0
	face = 1
	ajusta_sprite(0)
	
	if (!instance_exists(obj_dialogo))
	{
		var _obj_dialogo = instance_create_depth(0, 0, 0, obj_dialogo)
		_obj_dialogo.player = id
		
		with (npc_dialogo)
		{
			_obj_dialogo.dialogo = dialogo
		}
	}
}

estado_especial = function()
{
	estado_txt = "especial"
	
	velh = 0
	velv = 0
	
	if (global.arma_player)
	{
		if (!sq_especial)
		{
			sq_especial = global.arma_player.esp()
			image_alpha = 0
		}
	}
	else
	{
		image_alpha = 1
		estado = estado_parado;
	}
	if (sq_especial)
	{
		if (layer_sequence_is_finished(sq_especial))
		{
			if (layer_exists("attack_especial"))
			{
				layer_destroy("attack_especial")
			}
			image_alpha = 1
			sq_especial = noone
			estado = estado_parado;
		}
	}
}

estado_dano = function()
{
	estado_txt = "Tomando Dano"
	velh = 0
	velv = 0
	ajusta_sprite(5)
	
	knouckback(dano.x, dano.y);
	
	if (timer_dano < time_dano - room_speed / 2)
	{
		estado = estado_parado
	}
}

toma_dano = function(_dano = 1)
{
	if (timer_dano <= 0)
	{
		var _ang_dif = abs(angle_difference((face * 90 - 180), point_direction(dano.x, dano.y, x, y)));
		
		var _defesa = _ang_dif < 60 && estado == estado_defesa;
		
		if (_defesa) 
		{
		defendendo = true;
		return;
		}
		
		if (_defesa or estado == estado_esquiva) return;
		
		estado = estado_dano;
		timer_dano = time_dano;
		img_spd = 6 / room_speed
		global.vida_player -= _dano;
	}
}

efeito_dano = function()
{
	if (timer_dano > 0)
	{
		timer_dano --;
		max_vel = 2
		var img_a = abs(sin(get_timer() / 200000))
		shader_set(sh_pisca_branco);
		draw_sprite_ext(sprite, img_ind, x, y, xscale, image_yscale, image_angle, image_blend, img_a)
		shader_reset();
	}
	else
	{
		max_vel = 3
		var img_a = 0
	}
}	

estado = estado_movendo;