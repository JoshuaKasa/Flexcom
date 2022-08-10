// Setting cursor
if (can_write == true)
{
	if (keyboard_check_pressed(vk_left)) then cursor -= 1;
	else if (keyboard_check_pressed(vk_right)) then cursor += 1;
	cursor = clamp(cursor, 1,string_length(line) + 1);

	if (keyboard_check_pressed(vk_up) && current_line != 0) 
	{
		lines[current_line] = line;
		current_line -= 1;
		line = lines[current_line];
		lines[current_line] = "";
		cursor = string_length(line) + 1;
	}
	else if (keyboard_check_pressed(vk_down) && current_line != array_length(lines) && current_line != array_length(lines) - 1) 
	{
		lines[current_line] = line;
		current_line += 1;
		line = (current_line == array_length(lines)) ? "" : lines[current_line];
		lines[current_line] = "";
		cursor = string_length(line) + 1;
	}
	current_line = clamp(current_line, 0,array_length(lines));

	// Getting text
	if (keyboard_check(vk_shift))
	{
		if (keyboard_check_pressed(vk_anykey))
		{
			if (keyboard_key != vk_backspace && keyboard_key != vk_shift)
			{
				line = string_insert(keyboard_lastchar, line, cursor);
				cursor += 1;
			}
		}
	}
	else if (keyboard_check(vk_control))
	{
		if (keyboard_check_pressed(vk_anykey))
		{
			if (keyboard_key == vk_backspace)	
			{
				delete_word();
			}
		}
	}
	else if (keyboard_check_pressed(vk_anykey))
	{
		if (keyboard_lastkey != vk_left && keyboard_lastkey != vk_right && keyboard_lastkey != vk_up && keyboard_lastkey != vk_down && keyboard_lastkey != vk_alt && keyboard_lastkey != vk_f1)
		{
			switch (keyboard_key)
			{
				case vk_enter:
					add_line();
				break;
			
				case vk_backspace:
					if (line != "")
					{
						line = string_delete(line, cursor - 1, 1);
						cursor -= 1;
					}
					else if (current_line > 0)
					{
						array_delete(lines, current_line, 1);
						current_line -= 1;
						replace_line();
					}
				break;
			
				case vk_tab:
					if (string_width(line) < display_get_gui_width() - 275)
					{
						line = string_insert("     ", line, cursor)
						cursor += 5;
					}
				break;
			
				default:
					if (string_width(line) < display_get_gui_width() - 275)
					{
						line = string_insert(keyboard_lastchar, line, cursor);
						cursor += 1;
					}
				break;
			}
		}
	}
}