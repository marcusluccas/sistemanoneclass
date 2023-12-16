/// @description Insert description here
// You can write your code in this editor

draw_text(20, 20, global.pause)

if (room != rm_inicio && !instance_exists(obj_transicao))
desenha_coracoes(20, 80)

if (global.pause)
{
	tela_pause()
	desenha_inventario()
}
else
{
	layer_enable_fx("Efeito_Blur", false)
}