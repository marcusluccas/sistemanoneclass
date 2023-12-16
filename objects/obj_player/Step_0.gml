/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
velh = (keyboard_check(vk_right) - keyboard_check(vk_left)) * vel;
velv = (keyboard_check(vk_down) - keyboard_check(vk_up)) * vel;

if (place_meeting(x, y, obj_coin))
{
	show_message("Parabéns!")
	game_restart();
}