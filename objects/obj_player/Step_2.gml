/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (place_meeting(x + velh, y, obj_parede))
{
	while(!place_meeting(x + sign(velh), y, obj_parede))
	{
		x += sign(velh)
	}
	velh = 0
}

x += velh

if (place_meeting(x, y + velv, obj_parede))
{
	while(!place_meeting(x, y + sign(velv), obj_parede))
	{
		y += sign(velv)
	}
	velv = 0
}

y += velv