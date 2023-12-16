/// @description Insert description here
// You can write your code in this editor
larg = 30;
marg = 5;
alt = 20;

dialogo = 
{
	txt : ["Hoje eu lei o hobbit, você gosta de ler?","Qual é seu livro preferido Qual é seu livro preferido Qual é seu livro preferido Qual é seu livro preferido"],
	retrato : [spr_retrato_npc, spr_retrato_player],
	txt_vel : .2
}

debug_area = function()
{
	var x1, x2, y1, y2;
	x1 = x - larg / 2;
	y1 = y + marg;
	x2 = x + larg / 2;
	y2 = y1 + alt;
	draw_rectangle(x1, y1, x2, y2, true)
}

dialogo_area = function()
{
	var _x1, _x2, _y1, _y2;
	_x1 = x - larg / 2;
	_y1 = y + marg;
	_x2 = x + larg / 2;
	_y2 = _y1 + alt;
	
	var _player = collision_rectangle(_x1, _y1, _x2, _y2, obj_player, false, true)
	
	if (_player)
	{
		with (_player)
		{
			if (keyboard_check_pressed(vk_space))
			{
				if (estado != estado_dialogo)
				{
						estado = estado_go_dialogo;
						npc_dialogo = other;
				}
			}
		}
		if (keyboard_check_released(vk_escape))
		{
			with (_player)
			{
				estado = estado_parado;
				instance_destroy(obj_dialogo)
			}
		}
	}
}