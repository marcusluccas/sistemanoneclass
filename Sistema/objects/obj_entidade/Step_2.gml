/// @description Insert description here
// You can write your code in this editor
var _chao = instance_place(x + velh, y, obj_block);

if (_chao)
{
	if (velh > 0)
	{
		x = _chao.bbox_left + (x - bbox_right);
	}
	else if (velh < 0)
	{
		x = _chao.bbox_right + (x - bbox_left);
	}
	
	velh = 0;
}

x += velh;

var _chao = instance_place(x, y + velv, obj_block);

if (_chao)
{
	if (velv > 0)
	{
		y = _chao.bbox_top + (y - bbox_bottom);
	}
	else if (velv < 0)
	{
		y = _chao.bbox_bottom + (y - bbox_top);
	}
	
	velv = 0;
}

y += velv;

ajusta_depth()