structure Processing : PROCESSING = struct
  type t = foreignptr
  fun initBasic canvas setupFn drawFn =
      JsCore.exec3 {stmt = "function sketch(pjs) {" ^ 
                           "pjs.draw = drawFn(pjs); pjs.setup = setupFn(pjs);};" ^
                           "var p = new Processing(canvas, sketch);" ^
                           "return p",
                    arg1 = ("canvas",  JsCore.fptr),
                    arg2 = ("drawFn",  JsCore.==>(JsCore.fptr, JsCore.==>(JsCore.unit,JsCore.unit))),
                    arg3 = ("setupFn", JsCore.==>(JsCore.fptr, JsCore.==>(JsCore.unit,JsCore.unit))),
                    res  = JsCore.unit
                   }
                   (Js.Element.toForeignPtr canvas, drawFn, setupFn)

  fun initWithState canvas setupFn drawFn startState =
      let val state = ref startState
          fun stateDraw p () = state := (drawFn p (!state))
      in initBasic canvas setupFn stateDraw
      end

  (* fun init canvas setup draw start = *)
  (*   JsUtil.onloadHandler (fn () => initWithState canvas setup draw start) *)

  fun width p =
      JsCore.exec1 {stmt="return p.width;",
                    res=JsCore.int,
                    arg1=("p",JsCore.fptr)}
                   p

  fun height p =
      JsCore.exec1 {stmt="return p.height;",
                    res=JsCore.int,
                    arg1=("p",JsCore.fptr)}
                   p


  fun mouseX p =
      JsCore.exec1 {stmt="return p.mouseX;",
                    res=JsCore.int,
                    arg1=("p",JsCore.fptr)}
                   p

  fun mouseY p =
      JsCore.exec1 {stmt="return p.mouseY;",
                    res=JsCore.int,
                    arg1=("p",JsCore.fptr)}
                   p

  fun size p (w,h) =
      JsCore.exec3 {stmt="p.size(a1,a2);",
                    res=JsCore.unit,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.int),
                    arg3=("a2",JsCore.int)}
                   (p,w,h)

  fun frameRate p fps =
      JsCore.exec2 {stmt="p.frameRate(a1);",
                    res=JsCore.unit,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.int)}
                   (p,fps)


  fun noise1D p i =
      JsCore.exec2 {stmt="return p.noise(a1);",
                    res=JsCore.real,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.real)}
                   (p,i)


  fun noStroke p =
      JsCore.exec1 {stmt="p.noStroke();",
                    res=JsCore.unit,
                    arg1=("p",JsCore.fptr)}
                   p

  fun strokeWeight p fps =
      JsCore.exec2 {stmt="p.strokeWeight(a1);",
                    res=JsCore.unit,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.int)}
                   (p,fps)

  fun stroke p (r,g,b) =
      JsCore.exec4 {stmt="p.stroke(a1,a2,a3);",
                    res=JsCore.unit,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.int),
                    arg3=("a2",JsCore.int),
                    arg4=("a3",JsCore.int)}
                   (p,r,g,b)

  fun background p (r,g,b) =
      JsCore.exec4 {stmt="p.background(a1,a2,a3);",
                    res=JsCore.unit,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.int),
                    arg3=("a2",JsCore.int),
                    arg4=("a3",JsCore.int)}
                   (p,r,g,b)

  fun fill p (r,g,b) =
      JsCore.exec4 {stmt="p.fill(a1,a2,a3);",
                    res=JsCore.unit,
                    arg1=("p", JsCore.fptr),
                    arg2=("a1",JsCore.int),
                    arg3=("a2",JsCore.int),
                    arg4=("a3",JsCore.int)}
                   (p,r,g,b)

  fun ellipse p (x, y) (w, h) =
      JsCore.exec5 {stmt="p.ellipse(a1,a2,a3,a4);",
                    res=JsCore.unit,
                    arg1=("p",JsCore.fptr),
                    arg2=("a1",JsCore.real),
                    arg3=("a2",JsCore.real),
                    arg4=("a3",JsCore.real),
                    arg5=("a4", JsCore.real)}
                   (p,x,y,w,h)

  fun rect p (x, y) (w, h) =
      JsCore.exec5 {stmt="p.rect(a1,a2,a3,a4);",
                    res=JsCore.unit,
                    arg1=("p",JsCore.fptr),
                    arg2=("a1",JsCore.real),
                    arg3=("a2",JsCore.real),
                    arg4=("a3",JsCore.real),
                    arg5=("a4", JsCore.real)}
                   (p,x,y,w,h)

  fun line p (x1, y1) (x2, y2) =
      JsCore.exec5 {stmt="p.line(a1,a2,a3,a4);",
                    res=JsCore.unit,
                    arg1=("p",JsCore.fptr),
                    arg2=("a1",JsCore.real),
                    arg3=("a2",JsCore.real),
                    arg4=("a3",JsCore.real),
                    arg5=("a4", JsCore.real)}
                   (p,x1,y1,x2,y2)
end



