/// @description Insert description here
// You can write your code in this edito
if (global.pause)
{
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

show_debug_message(img_ind)
show_debug_message(img_numb)