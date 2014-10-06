type colour = int * int * int

signature PROCESSING = sig
  type t
  val initBasic     : Js.elem -> (t -> unit -> unit) -> (t -> unit -> unit) -> unit
  val initWithState : Js.elem -> (t -> unit -> unit) -> (t -> 'a -> 'a) -> 'a -> unit
  (* val init       : Js.elem -> (t -> unit -> unit) -> (t -> 'a -> 'a) -> 'a -> unit *)
  val width         : t -> int
  val height        : t -> int
  val mouseX        : t -> int
  val mouseY        : t -> int
  val size          : t -> int * int -> unit
  val frameRate     : t -> int -> unit
  val noise1D       : t -> real -> real
  val noStroke      : t -> unit
  val stroke        : t -> colour -> unit
  val strokeWeight  : t -> int -> unit
  val background    : t -> colour -> unit
  val fill          : t -> colour -> unit
  val ellipse       : t -> real * real -> real * real -> unit
  val rect          : t -> real * real -> real * real -> unit
  val line          : t -> real * real -> real * real -> unit
end
