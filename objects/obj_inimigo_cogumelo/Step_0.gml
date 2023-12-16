/// @description Insert description here
// You can write your code in this editor
if (global.pause or instance_exists(obj_transicao))
{
	exit;
}

if (vida_atual <= 0)
{
	estado = "morte"
}

randomize()
muda_estado()
controla_estado()