/// @description Insert description here
// You can write your code in this editor
draw_self();

draw_set_font(fnt_dialogo);
draw_set_color(c_black);
var _marg = 10
var _x = x + _marg
var _y = y + _marg

draw_text(_x, _y, "SAVE 0" + string(meu_num));

if (meu_save)
{
	draw_text(_x, _y + 20, "CONTINUE")
	draw_text(_x, _y + 50, "LIFE: " + string(meu_save.player.vida_atual / 2))
	
	if (meu_save.player.arma_atual)
	{
		draw_text(_x, _y + 70, "ARMA: ")
		draw_sprite(meu_save.player.arma_atual.spr, meu_save.player.arma_atual.meu_id, _x + sprite_width / 1.5, _y + 80)
	}
}
else
{
	draw_text(_x, _y + 20, "NEW GAME")
}
draw_set_color(-1);
draw_set_font(-1);