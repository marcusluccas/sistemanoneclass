/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_released(vk_escape)) global.pause = !global.pause

if (global.pause)
{
	if (instance_exists(obj_entidade))
	{
		with (obj_entidade)
		{
			velh = 0
			velv = 0
			image_speed = 0
		}
	}
}