signature Processing = sig
  type canvas
  type colour = int * int * int
  val initBasic     : Js.elem -> (canvas -> unit) -> (canvas -> unit -> unit) -> canvas
  val initWithState : Js.elem -> (canvas -> unit) -> (canvas -> 'a -> 'a) -> 'a -> unit
  val init          : string -> (canvas -> unit) -> (canvas -> 'a -> 'a) -> 'a -> unit
  val exit          : canvas -> unit
  val width         : canvas -> int
  val height        : canvas -> int
  val mouseX        : canvas -> int
  val mouseY        : canvas -> int
  val canvasSize    : canvas -> int * int -> unit
  val frameRate     : canvas -> int -> unit
  val noise1D       : canvas -> real -> real
  val noStroke      : canvas -> unit
  val stroke        : canvas -> colour -> unit
  val strokeWeight  : canvas -> int -> unit
  val background    : canvas -> colour -> unit
  val fill          : canvas -> colour -> unit
  val ellipse       : canvas -> real * real -> real * real -> unit
  val rect          : canvas -> real * real -> real * real -> unit
  val line          : canvas -> real * real -> real * real -> unit
end
