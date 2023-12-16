/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_text(20, 20, string(x) + " " + string(y))
if (instance_exists(obj_coin))
{
draw_text(20, 80, string(obj_coin.x) + " " + string(obj_coin.y))
}