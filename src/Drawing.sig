signature Drawing =
sig
    type state
    val start : state
    val setup : Processing.canvas -> unit -> unit
    val draw : Processing.canvas -> state -> state
end
