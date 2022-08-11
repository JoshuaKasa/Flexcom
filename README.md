# ***Flexcom***

Flexcom is a intepreted command language written in GML (GameMaker Studio 2.3).
It can be used for debugging purposes or for any game that requires a console, for example a game about programming.
Flexcom also comes with a built-in IDE with full customisable colors and functions.

# **Installation**

Installing Flexcom is very straight forward.
Download the project, open it inside GMS and then go to:

`Tools -> Create Local Package -> Name it however you want`

Once you've created the package you can go into your own project and import it by:

`Tools -> Import Local Package -> Package name`

After this you've succesfully installed and imported Flexcom!

# **Documentation**

For using Flexcom and it's console you can just select the `oConsole` and the `oInterpreter` file and put it inside your desired room.

## **Executing code**

Your Flexcom code must always start with the `run` function, followed by how many times you want to run your code.

When you're ready to run your code just press `f1`, then the code will be intepreted and executed.
error will not be shown until the line returning the error is executed.

![carbon (11)](https://user-images.githubusercontent.com/87675824/184041346-8ec4c59a-6c9c-4769-84a9-f4a89bbca3c7.png)

This will print "Hello world" to the output window 2 times.

## **Functions**

Here you can find a list of functions and how to use them.

Inside the project, all the Flexcom functions are located in the ``InterpreterFunctions`` script.

Following, a list of all the functions the number next the dollar sign symbolize how many arguments the functions takes.

```
$1 mov Room name, this function is used for moving to another room.
$1 out Text, with this function you can print phrases, constants, Flexcom functions, built in variables and constants.
$1 outv Variable name, differently from the 'out' function, this one is used for printing variables. Note that if the target object isn't set this will return an error 
$1 opn Object name, this function is one of the most useful ones, with this you can change your target object.
$2-3 chg (Arguments change based on what you want to change, see in-depth documentation below), with the 'chg' you can change the variable of your target object.
$1 del Object name, as the name says, this function deletes your target object
$1 run Run times, this is the most important function in Flexcom, it's used for setting how many times the code has to run. Without this the code will not run.
$1 crt Object name, with this function you can create an object from the name of it.
$1 com Text, com is used for setting a line as a comment.
$1 hld Seconds, this function set the seconds between each code run. Note that this function can be ONLY used at the end of your script. 
```

Sure that can tell you what functions do, but here is a more in-depth guide on how to use some of them.

![carbon (8)](https://user-images.githubusercontent.com/87675824/184041092-1e300b2c-ac9a-4d00-a9f4-da785d95e0dd.png)

This is a basic example of a Flexcom script, here we are first setting how many times the code should run (1) then setting the target object (Object1, note that the
target object is very important, since it's the one that all the object related functions will use) and after setting it we print out it's ``default_var`` variable and setting the wait time to be 1 second using the ``hld``, so that it will wait 1 second before iterating through the code again (in this case this wasn't necessary since we only do 1 iteration).

Let's now see how we can create set and change the variable of your target object.
For this we will use the ``chg`` function, which is probably the most complicated one in the whole Flexcom language.

![carbon (9)](https://user-images.githubusercontent.com/87675824/184041208-c61c6a2a-9fe5-4a6f-8c44-e29b4ee47ef9.png)

You can see how we use the ``chg`` function for setting the ``default_var`` variable into a number (type ``num``, scroll down for more informations about types),
the ``chg`` function is very strange because it works in 2 different ways based on what you want to do (the first argument will always be the same, the variable name). 

In this case since we want to set it to a magic number or a non variable then we need to first set the value type and then set the variable value.

If you wants to set the variable to another variable you'll need to do another process.

![carbon (10)](https://user-images.githubusercontent.com/87675824/184041287-d046f8de-eeff-4c9e-a022-a9ddf61e20f8.png)

In this case we're instead setting the variable ``default_var`` to the variable ``second_variable``, you can see that instead of ``:`` we're using ``=>``, this is very important, because ``:`` is used for setting a variable to a non variable and ``=>`` is used for setting a variable to another variable.

Also note how we're not setting the type here, since the type of a variable is already defined by the variable.

This is what we can do with all the functions we know.

![carbon (7)](https://user-images.githubusercontent.com/87675824/184041004-0a29bdd8-139e-4a8c-9102-8da9aad3bf6d.png)

## **Costants**

The Flexcom constants are not the same as the GameMaker constants, and here is a list of all of them:

```
fun, list of all functions.
typ, list of all value types.
blt, list of all built-in variables.
pi, 3.14159265359.
tau PI * 2, 6.28318530718.
e Euler's constant, 0.5772156649.
gld Golden ratio, 1.61803398875.
sq2 Square root of 2, 1.41421356237.
```
Constants are a pretty important part of Flexcom, since they can be used for setting values and printing all the functions, types and built-in variables names.

Following, a couple of ways of how constants can be used.

![carbon (14)](https://user-images.githubusercontent.com/87675824/184043428-13a67b1f-ab27-4ae0-9742-b539ad1df26b.png)

Printing TAU

![carbon (13)](https://user-images.githubusercontent.com/87675824/184043385-9824bc03-b4d8-4899-a792-a5cfa1e49421.png)

Here we are changing a variable into a ``con`` (constant) type value









