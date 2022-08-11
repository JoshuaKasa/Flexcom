/// Define arguments
function expression_evaluate(text)
{
	// Remove whitespace and replacing constats and variables
	text = string_replace_all(text, " ", "");
	var vrs = string_split(text, "+");
	for (var i = 0; i < array_length(vrs); i++)
	{
		if (variable_instance_exists(cobject.id, vrs[i])) 
		{
			text = string_replace(text, vrs[i], variable_instance_get(cobject.id, vrs[i]));
		}
	}
	print(text);
	for (var i = 0; i < array_length(global.CONSTANTS); i++)
	{
		text = string_replace(text, global.CONSTANTS[i].name,string(global.CONSTANTS[i].value));
	}
	
	var parenthesisLayer = 0;
	var parenthesisStart, parenthesisEnd;

	for (var i = 1; i <= string_length( text); ++i)
	{
		if (string_char_at( text, i) == "(")
		{
			if (parenthesisLayer++ == 0)
			{
				parenthesisStart = i + 1;
			}
		}
		else if (string_char_at(text, i) == ")")
		{
			if (parenthesisLayer-- == 0)
			{
				parenthesisEnd = i;
			
				var insideParenthesis = string_copy( text, parenthesisStart, parenthesisEnd - parenthesisStart);
			
				var result = expression_evaluate( insideParenthesis);
			
				text = string_replace( text, "(" + insideParenthesis + ")", string(result));
			
				i = 0;
			}
		}
	}

	var tokens = ds_list_create();

	var i = 0;
	while (string_length(text) != string_length(string_digits(text)))
	{
		var sd = string_digits(text);
	
		if (i++ > string_length(text)) then break;
	
		var char = string_char_at(text, i);
		var isCarat = ord(char) == ord("^");
		var isOperator = ord(char) >= ord("*") && ord(char) <= ord("/");
	
		if (isCarat || isOperator)
		{
			var num = string_copy(text, 1, i - 1);
			var operator = string_copy( text, i, 1);
		
			// Check if - is actually a negative sign
			if (operator == "-")
			{
				var prevChar = string_char_at( text, i - 1);
				if(ord(prevChar) < ord("0") || ord(prevChar) > ord("9"))
				{
					continue;
				}
			}
		
			ds_list_add(tokens, num, operator);
		
			text = string_copy( text, i + 1, string_length(text) - i);
		
			i = 0;
		}
	}

	ds_list_add(tokens, text);

	for (var i = 0; i < ds_list_size(tokens); i++)
	{
		if (tokens[| i] == "^")
		{
			var lh = real(tokens[| i - 1]);
			var rh = real(tokens[| i + 1]);
		
			tokens[| i - 1] = power(lh, rh);
		
			ds_list_delete(tokens, i);
			ds_list_delete(tokens, i);
		
			i = 0;
		}
	}

	for (var i = 0; i < ds_list_size(tokens); ++i)
	{
		var isMultiplication = tokens[| i] == "*";
		var isDivision = tokens[| i] = "/";
	
		if (isMultiplication || isDivision)
		{
			var lh = real(tokens[| i - 1]);
			var rh = real(tokens[| i + 1]);
		
			if( isMultiplication)
			{
				tokens[| i - 1] = lh * rh;
			}
			else
			{
				tokens[| i - 1] = lh / rh;
			}
		
			ds_list_delete( tokens, i);
			ds_list_delete( tokens, i);
		
			i = 0;
		}
	}

	for (var i = 0; i < ds_list_size( tokens); i++)
	{
		var isAddition = tokens[| i] == "+";
		var isSubtraction = tokens[| i] == "-";
	
		if (isAddition || isSubtraction)
		{
			var lh = real( tokens[| i - 1]);
			var rh = real( tokens[| i + 1]);
		
			if (isAddition)
			{
				tokens[| i - 1] = lh + rh;
			}
			else
			{
				tokens[| i - 1] = lh - rh;
			}
		
			ds_list_delete( tokens, i);
			ds_list_delete( tokens, i);
		
			i = 0;
		}
	}

	var ret = tokens[| 0];

	ds_list_destroy( tokens);

	return ret;
}

function mov()
{
	room_goto(c[1]);	
}

function out()
{
	if (builtin_exists(c[1]))
	{
		for (var i = 0; i < array_length(global.BUILT_IN); i++)
		{
			if (is_array(global.BUILT_IN[i].value))
			{
				printout_array(global.BUILT_IN[i].value);
			}
			else printout(global.BUILT_IN[i].value);
		}
	}
	else if (constant_exists(c[1]))
	{
		for (var i = 0; i < array_length(global.CONSTANTS); i++)
		{
			if (global.CONSTANTS[i].name == c[1]) 
			{
				if (is_array(global.CONSTANTS[i].value))
				{
					printout_array(global.CONSTANTS[i].value);
				}
				else printout(global.CONSTANTS[i].value);
			}
		}	
	}
	else printout(c[1]);
}

function opn()
{
	if (instance_exists(asset_get_index(c[1])))
	{
		cobject = asset_get_index(c[1]);	
		global.BUILT_IN[0].value = object_get_name(cobject);
		global.BUILT_IN[1].value = variable_instance_get_names(cobject.id);
	}
}

function assign_type(type, value)
{	
	switch (type)
	{
		case "num": return real(value); 
		break;
		case "str": return string(value); 
		break;
		case "cnd": return bool(value); 
		break;
		case "eva": return expression_evaluate(value);
		break;
		case "con": 
		{
			for (var i = 0; i < array_length(global.CONSTANTS); i++)
			{
				if (global.CONSTANTS[i].name == value) then 
				{
					return global.CONSTANTS[i].value;
				}
			}	
		}
		break;
		
		default: show_error("Unkown data type", true);
	}
}

function chg()
{
	var com = string_split_ext(c[1], " ", 3);
	var value = 0;
	
	if (array_length(com) == 2)
	{
		variable_instance_set(cobject.id, com[0], com[1]);
	}
	else
	{
		if (com[2] == ":") 
		{	
			value = assign_type(com[1], com[3]);
			variable_instance_set(cobject.id, com[0], value);
		}
		else if (com[1] == "=>")
		{
			value = variable_instance_get(cobject.id, com[2]);
			variable_instance_set(cobject.id, com[0], value);	
		}
	}
}

function del()
{
	if (instance_exists(cobject))
	{
		instance_destroy(cobject);	
	}
}

function outv()
{
	printout(variable_instance_get(cobject.id, c[1]));
}

function crt()
{
	var lay = layer_create(1000);
	var com = string_split(c[1], " ");
	var inst = (array_length(com) > 1) ? instance_create_layer(real(com[1]),real(com[2]), lay, asset_get_index(com[0])) : instance_create_layer(0,0, lay, asset_get_index(com[0]));
	
	printout("Object created: " + object_get_name(inst.object_index));
	printout("At coordinates: " + string(inst.y) + " : " + string(inst.y));
}

function com() { }

function hld()
{
	oInterpreter.hold_time = c[1];	
}