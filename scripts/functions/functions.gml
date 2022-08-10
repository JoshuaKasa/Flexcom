///@desc IRGE = In Room Game Editor

function print(msg)
{
	show_debug_message(msg);		
}

function wrap(value, min_,max_)
{
	if (value > max_) then return max_;
	else if (value < min_) then return min_;
}	

function array_move_up(array, from)
{
	var len = array_length(array);
	
	for (var i = len; i > from; i--)
	{
		array[i] = array[i - 1];
	}
	
	return array;
}

function string_split(str, divider)
{
	var len = string_length(str);
	var sstr = "";
	var ind = 0;
	var arr = [];
	
	for (var i = 1; i <= len; i++)
	{
		var char = string_char_at(str, i);
		if (char != divider)
		{
			sstr += char;
		}
		else
		{
			if(string_length(sstr) > 0)
			{
				arr[ind] = sstr;
				ind++;
				sstr = "";
			}
		}
	}
	if(string_length(sstr) > 0)
	{
		arr[ind] = sstr;
	}
		
	return arr;
}

function string_split_ext(str, divider, times = 0)
{
	var t = 0;
	var len = string_length(str);
	var sstr = "";
	var ind = 0;
	var arr = [];
	var ch = "";	

	for (var i = 1; i <= len; i++)
	{
		var char = string_char_at(str, i);
		
		if (char != divider) then sstr += char;
		else
		{
			if(string_length(sstr) > 0)
			{
				arr[ind] = sstr;
				ind++;
				sstr = "";
				t += 1;
			}
		}
		if (t >= times)
		{
			break;
			ch = i;
		}
	}
	array_push(arr, string_copy(str, i + 1, len));
	if(string_length(sstr) > 0) then arr[ind] = sstr;
		
	return arr;
}

function array_exists(arr, value)
{
	var len = array_length(arr);
	
	for (var i = 0; i < len; i++)
	{
		if (arr[i] == value) return true;
	}
	
	return false;
}

function string_delete_last(str)
{
	return string_delete(str, string_length(str), 1);
}

function string_is_number(str)
{
	var n = string_length(string_digits(str));
	
	return n > 0 && n == string_length(str) - (string_ord_at(str, 1) == ord("-")) - (string_pos(".", str) != 0);
}

function oscillate(from, to, duration)
{
	var tau = pi * 2;
	var dis = (to - from) / 2;
	duration /= 120;
	 
	return from + dis + sin(((current_time / 1000) + to * tau)/duration) * dis;
}

function array_mesh(array1, array2)
{
	var len = array_length(array2);

	for(var i = 0; i < len; i++) 
	{
		array_push(array1,array2[i]);
	}

	return array1;
}