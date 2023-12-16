/// @description Insert description here
// You can write your code in this edito
if (global.pause or transicao)
{
velh = 0
velv = 0
exit;
}

var _gelo = instance_place(x, y, obj_gelo);

if (_gelo)
{
	acel = _gelo.meu_acel;
}
else
{
	acel = meu_acel;
}

var _tab = keyboard_check_pressed(vk_tab)
if (_tab)
{
	global.debug = !global.debug
}

estado();
