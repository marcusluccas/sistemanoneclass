/// @description Insert description here
// You can write your code in this editor
view_xport[0] = random_range(-treme, treme)
view_yport[0] = random_range(-treme, treme)

treme *= .9

if (treme <= .5)
{
	 instance_destroy();
}