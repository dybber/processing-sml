Processing SML Webeditor-documentation
======================================

This documents the webeditor available at http://www.diku.dk/~dybber/processing-sml/

Initialization
--------------
Initializing a drawing is done using the run command:

```SML
  val run : (canvas -> unit)
         -> (canvas -> 'a -> 'a)
         -> 'a
         -> unit
```

Which takes 3 parameters:

 * A `setup` functions that is executed once, as the first thing after
   initialization. The function takes a "canvas"-object which can be
   painted on using the functions below

 * A `draw` function which is executed again again. How often defaults
   to 60 times per second (60 FPS). This can be changed in `setup` by
   executing `frameRate 30` to get 30 FPS)

 * A `start` value. The first time `draw` is called it will receive
   this value as input. When `draw` returns it can update the value
   (to pass state from iteration to iteration)


Drawing commands
----------------
```SML
  val rect          : canvas -> real * real -> real * real -> unit
  val ellipse       : canvas -> real * real -> real * real -> unit
  val line          : canvas -> real * real -> real * real -> unit
```

Draw a rectangle, ellipse or a line.


Mouse coordinates
-----------------
Obtain mouse X/Y coordinates

```SML
  val mouseX        : canvas -> int
  val mouseY        : canvas -> int
```

Colors and strokes
------------------
Change the color used with the drawing command issued after this
command (RGB);

```SML
  type colour = int * int * int
  val stroke        : canvas -> colour -> unit
  val fill          : canvas -> colour -> unit
```

Set stroke weight or disable strokes
```SML
  val strokeWeight  : canvas -> int -> unit
  val noStroke      : canvas -> unit
```

Clear the canvas. Erase everything and use the given colour instead.
```SML
  val background    : canvas -> colour -> unit
```

