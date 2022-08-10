#macro FUNCTIONS ["mov", "out", "opn", "chg", "del", "run", "outv", "crt", "com", "hld"]
// mov = move to another room
// out = prints a variable
// opn = opens an object to edit or check variables
// del = deletes an objecst
// run = set the program running times
// outv = prints a variable from the opened object
// crt = creates a object at the specified coordinates
// com = comment a line
// hld = set the time of which the code will be stopped every time it runs
#macro TYPES ["num", "str", "cnd", "con", "eva", ":", "=>"]
// num = integer, float or double
// str = string
// cnd = condition value (boolean)
// con = constant value
// eva = evaluates the given expression
// : = used to asign a variable a value
// => = used to asign a variable the value of another variable
global.BUILT_IN = [
				 new Value("obj", "None"),
				 new Value("vrs", "None"),
				 new Value("cur", room_get_name(room)),
				 new Value("rob", all),
				 new Value("nob", instance_number(all))
];
#macro BUILTIN ["obj", "cur", "rob", "nob"]
// obj = current opened object
// cur = current room name
// rob = all room objects
// nob = number of objects in the room	
global.CONSTANTS = [
					new Value("fun", FUNCTIONS),
					new Value("typ", TYPES),
					new Value("blt", BUILTIN),
					new Value("pi", pi),
					new Value("tau", pi * 2),
					new Value("e", 2.7182818),
					new Value("glr", 1.618),
					new Value("sq2", sqrt(2))
];
#macro CONST ["fun", "typ", "blt", "pi", "tau", "e", "glr", "sq2"]
// fun = list with all the fuctions
// typ = list with all the variable types
// blt = list of built-in variables
// pi = pi
// tau = pi * 2
// e = Euler's constant
// glr = golden ratio
// sq2 = square root of 2
global.WORDS = array_mesh(array_mesh(FUNCTIONS,TYPES),array_mesh(BUILTIN,CONST));
print(global.WORDS);
// list of all functions, constants, built in variables and types