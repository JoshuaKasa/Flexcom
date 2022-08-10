// Drawing text to a surface
if (!surface_exists(surf))
{
	// Creating surface
	var width = display_get_gui_width();
	var height = display_get_gui_height();
	surf = surface_create(width,height);
}
// General inizialitaion
surface_copy(surf, 0,0, application_surface);
surface_set_target(surf);

// Drawing background
draw_set_color(make_color_rgb(25,25,25));	
draw_rectangle(0,0, display_get_gui_width(),display_get_gui_height(), false);

// Drawing console
draw_set_font(fConsole);
draw_set_color(TEXT_COLOR);

var fsize = font_get_size(fConsole);
var nlines = array_length(lines);
var scursor = string_copy(line, 1,cursor - 1);
var swidth = string_width(scursor);
var startx = 50;
var starty = 50 + (current_line * (fsize * 2));

// Ouput window
draw_set_color(CONSTANTS_COLOR);
draw_text(display_get_gui_width() - 275,15, "Output:");
draw_set_color(TEXT_COLOR);
draw_line(display_get_gui_width() - 275,50, display_get_gui_width() - 275,display_get_gui_height() - 50);
// Code window
draw_set_color(CONSTANTS_COLOR);
draw_text(37,15, "Code:");
draw_set_color(TEXT_COLOR);
draw_line(37,50, 37,display_get_gui_height() - 50);
draw_set_alpha(round(oscillate(0,1, 30)));
draw_line(startx + swidth + 1,starty, startx + swidth + 1,starty + fsize * 2);
draw_set_alpha(1);
// Drawing input
for (var i = 0; i < nlines; i++)
{
	var sy = 50 + (i * (fsize * 2));
	
	highlight_text(startx,sy, lines[i]);
	if (current_line == i) then draw_set_color(CONSTANTS_COLOR);
	else draw_set_color(TEXT_COLOR);
	draw_text(6,sy, i + 1);
}
highlight_text(startx,starty, line);

// Drawing suggestions
if (line != "")
{
	var checks = string_split(line, " ");
	var ll = array_length(global.WORDS);
	var word_number = array_length(checks);
	var suggestions = [];
	
	for (var i = 0; i < ll; i++)
	{
		var cw = checks[word_number - 1]
		var wrd_len = string_length(cw);
		var copy = string_copy(cw, 1,wrd_len);
		
		if (string_pos(copy, global.WORDS[i]) != 0 && cw != global.WORDS[i]) 
		{
			array_push(suggestions, global.WORDS[i]);
		}
	}
	if (array_length(suggestions) > 0)
	{
		var slen = array_length(suggestions);
		var col_height = font_get_size(fConsole) * 2;
		var s_height = slen * col_height;
		var s_startx = startx + swidth + 3;
		var s_starty = starty + fsize * 2;
		var s_endy = s_starty + s_height;
		var s_endx = s_startx + 200;
		
		draw_set_color(FUNCTION_COLOR);
		draw_rectangle(s_startx,s_starty, s_endx,s_endy, false);
		for (var i = 0; i < slen; i++)
		{
			draw_set_color(TEXT_COLOR);
			draw_text(s_startx + 2,(s_starty + 2) + i * col_height, suggestions[i]);
		}
	}	
}
// Drawing output
for (var i = 0; i < array_length(output); i++)
{
	var sy = 50 + (i * (fsize * 2));
	
	draw_set_color(TEXT_COLOR);
	draw_text(display_get_gui_width() - 250,sy, output[i]);
}

// Resetting surface
surface_reset_target();

// Drawing main surface with shader
shader_set(shConsole);

// Setting shader uniforms
var res = shader_get_uniform(shConsole, "iResolution");
var time = shader_get_uniform(shConsole, "iGlobalTime");

shader_set_uniform_f(res, display_get_gui_width(),display_get_gui_height());
shader_set_uniform_f(time, current_time/1000);

draw_surface(surf, 0,0);

shader_reset();