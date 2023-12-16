/// @description Insert description here
// You can write your code in this editor
if (!transicao)
{
	if (instance_exists(obj_transicao)) instance_destroy(obj_transicao)
	transicao = instance_create_depth(0, 0, -10000, obj_transicao);
	transicao.player = other.id;
	transicao.room_destino = room_destino;
	transicao.destino_x = destino_x;
	transicao.destino_y = destino_y;
}