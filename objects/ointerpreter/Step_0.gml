// Starting program
if (keyboard_check_pressed(vk_f1))
{
	running = true
	with (oConsole)
	{
		lines[current_line] = line;
		line = "";
		can_write = !can_write;
		clear_output();
	}
	
	code = oConsole.lines;
	
	// Getting run times
	var code_line = string_split(code[0], " ");

	if (code_line[0] != "run") then show_error("First line of code should tell run times", true);
	else 
	{
		run_times = real(code_line[1]);
	}
}

if (running == true)
{
	// Interpreting code
	if (hold_time > 0) hold_time -= 1;
	if (run_times > 0 && hold_time == 0)
	{
		for (var i = 1; i < array_length(code); i++)
		{
			if (code[i] != "")
			{
				c = string_split_ext(code[i], " ", 1);
				var func = c[0];
				
				if (func != "hld")
				{
					if (string_letters(func) != "")
					{
						func = asset_get_index(func);
						script_execute(func);
					}
				}
				else
				{
					if (i == array_length(code) - 1) then hold_time = c[1];
					else show_error("Can only waiy second at the end of code", true);
				}
			}
		}
		run_times -= 1;
		current_i += 1;
		global.BUILT_IN[5].value = current_i;
	}
	else if (run_times == 0)
	{
		with (oConsole)
		{
			replace_line();
			can_write = true;
		}	
		running = false;
	}	
}