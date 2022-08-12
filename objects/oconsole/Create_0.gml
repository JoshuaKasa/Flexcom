application_surface_draw_enable(false);

lines = [
"run 1",
"dec b uch => num 1",
"dec c uch => num 1",
"dec n uch => eva b + c",
"set b => c",
"set c => n",
"set n eva : b + c",
];
line = "";
current_line = 0;

cursor = 0;
surf = -1;

can_write = true;

output = [];

display_set_gui_size(1366,768)