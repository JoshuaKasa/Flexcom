function replace_line()
{
	line = lines[current_line];
	lines[current_line] = "";
	cursor = string_length(line) + 1;
}

function add_line()
{
	lines[current_line] = line;
	array_move_up(lines, current_line);
	line = "";	
	current_line += 1;
	lines[current_line] = line;
}

function delete_word()
{
	var i = string_length(line);
	var char = string_char_at(line, i);
	
	while (char != " " && i > 0)
	{
		char = string_char_at(line, i);
		line = string_delete_last(line);
		i -= 1;
	}	
}	

function constant_exists(value)
{
	for (var i = 0; i < array_length(global.CONSTANTS); i++)
	{
		if (value == global.CONSTANTS[i].name) then return true;	
	}
	return false;
}
function builtin_exists(value)
{
	for (var i = 0; i < array_length(global.BUILT_IN); i++)
	{
		if (value == global.BUILT_IN[i].name) then return true;	
	}
	return false;
}

// This is super slow, if you find a better way of doing this make a pull request!
function highlight_text(x_,y_, str)
{
	var words = string_split(str, " ");
	var len = array_length(words);

	for (var i = 0; i < len; i++)
	{
		var wrd = words[i];

		// Syntax check		
		if (array_exists(FUNCTIONS, wrd)) then draw_set_color(FUNCTION_COLOR);
		else if (array_exists(TYPES, wrd)) then draw_set_color(TYPES_COLOR);
		else if (builtin_exists(wrd)) then draw_set_color(BUILTIN_COLOR);
		else if (constant_exists(wrd)) then draw_set_color(CONSTANTS_COLOR);
		else if (string_is_number(wrd)) then draw_set_color(NUMBERS_COLOR);
		else draw_set_color(TEXT_COLOR);
		
		draw_text(x_,y_, wrd);
		x_ += (string_width(wrd + " "));
	}
}

function printout(text)
{
	array_push(oConsole.output, text);
}

function printout_array(arr)
{
	for (var i = 0; i < array_length(arr); i++)
	{
		array_push(oConsole.output, arr[i]);
	}
}

function clear_output()
{
	output = [];	
}