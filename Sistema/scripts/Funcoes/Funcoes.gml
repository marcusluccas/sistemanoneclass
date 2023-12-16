// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Funcoes(){
}
///@fuction desenha_sombra(sprite, escala, [cor], [alpha]
function desenha_sombra(sprite, escala, cor = c_white, alpha = .3){
	draw_sprite_ext(sprite, 0, x, y, escala, escala, 0, cor, alpha)
}

function ajusta_depth(){
	depth = -y;
}