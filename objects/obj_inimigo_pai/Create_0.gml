/// @description Insert description here
// You can write your code in this editor
#region variaveis

vida_max = 1;
vida_atual = vida_max;

max_vel = 2;

dano = 0;
meu_dano = 1
dano_dir = 0;
estado = "descanso";
tempo_estado = room_speed * 3;
tempo_persegue = room_speed * 5;
tempo = tempo_estado;
t_persegue = 0;
alvo = noone;
distino_x = noone;
distino_y = noone;
indice_color = 128;
campo_visao = 100;
scala = 1;
tempo_dano = room_speed / 2;
timer_dano = tempo_dano;
tempo_pisca = 8;
timer_pisca = 0;

sprites = []

image_speed = 8 / room_speed;

knockback = function(_x, _y)
{
	var _dir = point_direction(_x, _y, x, y)
	
	velh = lengthdir_x(1, _dir);
	velv = lengthdir_y(1, _dir);
}

ajusta_sprite = function()
{
	var _dir = point_direction(0, 0, velh, velv);
			
	var _face = _dir div 90;
	
	switch (_face)
	{
		case 0:
		sprite_index = sprites[0];
		image_xscale = 1;
			
		break;

		case 1:
		sprite_index = sprites[1];
		image_xscale = 1
		
		break;
		
		case 2:
		sprite_index = sprites[2]
		image_xscale = -1
		
		break;
		
		case 3:
		sprite_index = sprites[3];
		image_xscale = 1
		
		break;
	}
}

#endregion

// Inherit the parent event
event_inherited();

tomar_dano = function(_dano = 1)
{
	if (estado != "morte")
	{
	estado = "dano"
	dano = _dano
	}
}

aplica_dano_player = function()
{
	var _player = instance_place(x, y, obj_player)
	
	if (_player)
	{
		_player.dano = id
		_player.toma_dano(meu_dano)
		estado = "descanso"
	}
}