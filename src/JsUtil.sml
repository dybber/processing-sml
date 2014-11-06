structure JsUtil = struct
  fun $ id =
      case Js.getElementById Js.document id of 
          SOME e => e
        | NONE => raise Fail ("no element with id '"^id^"' in DOM")

  fun log msg =
      JsCore.exec1 {stmt="console.log(s);",
                    res=JsCore.unit,
                    arg1=("s",JsCore.string)}
                   msg

  fun getInnerHTML e : string =
    JsCore.exec1 {stmt="return e.innerHTML;",
                  arg1=("e",JsCore.fptr),
                  res=JsCore.string}
                 (Js.Element.toForeignPtr e)

  fun installWindowHandler s (f:unit->unit) : unit =
      JsCore.exec1 {stmt="if (window.addEventListener) {" ^
                         "window.addEventListener(\"" ^ s ^ "\", f, false);" ^
                         "} else {" ^
                         "window.attachEvent(\"on" ^ s ^ "\", f); }",
                    res=JsCore.unit,
                    arg1=("f",JsCore.==>(JsCore.unit,JsCore.unit))} f

  fun onloadHandler (f:unit -> unit) : unit = installWindowHandler "load" f


  fun addHandler s e (f:unit->unit) : unit =
    JsCore.exec2 {stmt="e." ^ s  ^ " = f;",
                  arg1=("e",JsCore.fptr),
                  arg2=("f", JsCore.==>(JsCore.unit,JsCore.unit)),
                  res=JsCore.unit}
                 (Js.Element.toForeignPtr e, f)


  fun getElemProperty e t s =
      JsCore.getProperty (Js.Element.toForeignPtr e) t s
  fun setElemPropertyInt e p i =
      JsCore.setProperty (Js.Element.toForeignPtr e) JsCore.int p i
end
