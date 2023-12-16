/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(sprite, img_ind, x, y, xscale, image_yscale, image_angle, image_blend, image_alpha)

efeito_dano()

if (global.debug)
{
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text(x, y - sprite_height * 2, estado_txt)
	draw_set_halign(-1)
	draw_set_valign(-1)
}