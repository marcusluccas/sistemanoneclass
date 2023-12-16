/// @description Insert description here
// You can write your code in this editor
scala = image_index < 1 ? .7 : .9

	if (timer_pisca > 0)
	{
		shader_set(sh_pisca_branco)
		
		draw_self();
		
		shader_reset();
	}
	else
	{
		draw_self()
	}

if (global.debug)
{
	draw_set_halign(1);
	draw_set_valign(1);
	draw_text(x, y - sprite_height * 2, estado);
	draw_set_halign(-1);
	draw_set_valign(-1);
	draw_circle(distino_x, distino_y, 16, false)
	draw_circle(x, y, campo_visao, true)
}

draw_text(x, y - sprite_height * 2, vida_atual);