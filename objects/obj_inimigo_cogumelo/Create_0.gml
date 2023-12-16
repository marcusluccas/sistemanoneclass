 /// @description Insert description here
// You can write your code in this editor
// Inherit the parent event
event_inherited();
vida_max = 3
vida_atual = vida_max
dano_id = noone
meu_dano = 1
time_descanso = room_speed * 5
timer_descanso = time_descanso

sprites = [spr_cogumelo_right, spr_cogumelo_up, spr_cogumelo_right, spr_cogumelo_down]

olhando = function()
{
	var _player = collision_circle(x, y, campo_visao, obj_player, false, true)
	if (_player and t_persegue <= 0)
	{
		estado = "persegue"
		alvo = _player
		campo_visao = campo_visao * 1.5
		t_persegue = tempo_persegue
		tempo = tempo_estado
	}
	else if (!_player)
	{
		campo_visao	= 100
		alvo = noone
	}
}

muda_estado = function()
{
	var _mouse_sobre = position_meeting(mouse_x, mouse_y, id)
	var _click_middle = mouse_check_button_released(mb_middle)

	if (_mouse_sobre and _click_middle)
	{
		estado = get_string("Qual é o estado", "parado")
	}
}

controla_estado = function()
{
	switch (estado)
	{
		#region parado
		
		case "parado" :
		
			image_blend = c_white
			
			image_speed = 4  / room_speed
		
			velh = 0;
			velv = 0;
			
			tempo --;
			
			t_persegue --;
			
			if (tempo <= 0)
			{
					estado = choose("parado", "andando");
					
					tempo = tempo_estado;
			}
			olhando()
			
		break;
		
		#endregion
		
		#region andando
		
		case "andando" :
		
			image_blend = c_white
			
			image_speed = 8 / room_speed;
			
			tempo --;
			
			t_persegue --;
			
			var _dist = point_distance(x, y, distino_x, distino_y)
			
			if (distino_x == noone or distino_y = noone or _dist < max_vel)
			{
				distino_x = random_range(64, room_width - 64)
				distino_y = random_range(64, room_height - 64)
			}	
			var _dir = point_direction(x, y, distino_x, distino_y)
			
			var _col = place_meeting(x + velh, y + velv, obj_block)
			
			if (_col)
			{
				estado = "parado"
				distino_x = noone
				distino_y = noone
				tempo = tempo_estado
			}
			
			ajusta_sprite()
			
			velh = lengthdir_x(max_vel, _dir)
			velv = lengthdir_y(max_vel, _dir)
			
			if (tempo <= 0)
			{
				estado = choose("parado", "andando", "andando")
				
				distino_x = noone
				distino_y = noone
				
				tempo = tempo_estado
			}
			olhando()
			
		break;
		
		#endregion
		
		#region persegue
		
		case "persegue" :
		
		image_blend = c_orange
		
		image_speed = 12 / room_speed
		
		if (alvo)
		{
			distino_x = alvo.x
			distino_y = alvo.y
		}
		else
		{
			estado = choose("parado", "parado", "andando")
			distino_x = noone
			distino_y = noone
			tempo = tempo_estado
		}
		
		var _dir = point_direction(x, y, distino_x, distino_y)
			
		var _col = place_meeting(x + velh, y + velv, obj_block)
			
		if (_col)
		{
			estado = "parado"
			
			distino_x = noone
			distino_y = noone
			tempo = tempo_estado
		}
		
		ajusta_sprite()
		
		velh = lengthdir_x(max_vel, _dir)
		velv = lengthdir_y(max_vel, _dir)
		
		var _dist = point_distance(x, y, distino_x, distino_y)
		
		if (_dist < campo_visao / 3)
		{
			estado = "carrega_ataque"
			indice_color = 128
		}
		show_debug_message(_dist)
		
		olhando()
		
		break;
		
		#endregion
		
		#region carrega_ataque
		
		case "carrega_ataque" :
		
		image_blend = make_color_rgb(255, indice_color, 0)
		
		image_speed = 0
		
		indice_color = lerp(indice_color, 0, 0.1)
		velh = 0
		velv = 0
		if (image_blend == make_color_rgb(255, 0, 0))
		{
			estado = "ataque";
		}
		
		break;
		
		#endregion
		
		#region ataque
		
		case "ataque" :
		
		image_blend = c_red
		
		image_speed = 12 / room_speed
		
		tempo --;
		
		var _dir = point_direction(x, y, distino_x, distino_y)
			
		var _col = place_meeting(x + velh, y + velv, obj_block)
		
		if (_col)
		{
			estado = "parado"
		
			distino_x = noone
			distino_y = noone
			
			tempo = tempo_estado
		}
			
		ajusta_sprite()
		
		velh = lengthdir_x(max_vel * 3, _dir)
		velv = lengthdir_y(max_vel * 3, _dir)
		
		aplica_dano_player();
		
		var _dist = point_distance(x, y, distino_x, distino_y)
		
		if (_dist <= 5 or tempo_estado <= 0)
		{
			estado = "parado"
			distino_x = noone
			distino_y = noone
			alvo = noone
			campo_visao	= 100
		}
		break;
		 
		#endregion
		
		#region dano
		
		case "dano":
		
		timer_dano --;
		timer_pisca --;
		velh = 0;
		velv = 0;
			
			if (dano > 0)
			{
				vida_atual -= dano;
				timer_pisca = tempo_pisca;
				dano = 0;
			}
			
			knockback(dano_id.x, dano_id.y)
			
			if (timer_dano <= 0)
			{
				image_blend = c_white;
				timer_dano = tempo_dano;
				if (vida_atual > 0)
				{
				estado = "parado";
				}
				else
				{
					estado = "morte"
				}
			}
			
			break;
		
		#endregion
		
		#region morendo
		
		case "morte":
		
		timer_pisca --;
		image_speed = 0;
		
		if (image_alpha > 0)
		{
			image_alpha -= .01
		}
		else
		{
			instance_destroy();
		}
		
		#endregion
		
		#region descanso
		
		case "descanso":
		velh = 0;
		velv = 0;
		image_blend = c_white;
		image_speed = 8 / room_speed;
		timer_descanso --;
		
		if (timer_descanso <= 0)
		{
			estado = choose("parado", "andando");
			timer_descanso = time_descanso;
		}
		break;
		
		#endregion
	}
}

