local
  structure P = Processing
  fun init canvas setup draw start =
    JsUtil.onloadHandler (fn () => P.initWithState (JsUtil.$ canvas) setup draw start)

  val red   = (255,  0,  0)
  val white = (255,255,255)

fun revolvingBall p t =
  let val _ = P.background p white
      fun toRad a = a * Math.pi/180.0
      val (w,h) = (real (P.width p), real (P.height p))
      fun pos t = (w/2.0 + 150.0 * Math.cos (toRad (real t)),
                   h/2.0 + 150.0 * Math.sin (toRad (real t)))
      val _ = P.fill p red
      val _ = P.ellipse p (pos t) (40.0, 40.0)
  in t + 10
  end

fun ball p (x,y, xspeed,yspeed) = 
  let val _ = P.background p red;
      val _ = P.ellipse p (x, y) (40.0, 40.0)
      val (w,h) = (P.width p, P.height p)
      val newxspeed = if x > real w orelse x < 0.0 then ~ xspeed else xspeed
      val newyspeed = if y > real h orelse y < 0.0 then ~ yspeed else yspeed
      (* val _ = JsUtil.log (Real.toString x ^ "x" ^ Real.toString y) *)
  in (x + newxspeed, y + newyspeed,
      newxspeed, newyspeed)
  end

fun randomCircles p rng = 
  let fun randomColour rng = 
          let val (r,g,b) = (255.0*Random.random rng,
                             255.0*Random.random rng,
                             255.0*Random.random rng)
          in (floor r, floor g, floor b) end
      val (w,h) = (P.width p, P.height p)
      val (x,y) = (real w*Random.random rng, real h*Random.random rng)
      val s = 100.0*Random.random rng
      val _ = P.fill p (randomColour rng)
      val _ = P.ellipse p (x, y) (s,s)
  in rng
  end

fun mouse p () = 
  let val (w,h) = (real (P.width p), real (P.height p))
      val (mx,my) = (real (P.mouseX p), real (P.mouseY p))
      val _ = P.line p (0.0,0.0) (mx,my)
      val _ = P.line p (w,  0.0) (mx,my)
      val _ = P.line p (0.0,h)   (mx,my)
      val _ = P.line p (w,  h)   (mx,my)
  in ()
  end

fun noise p (r,tx,ty) = 
  let val (w,h) = (real (P.width p), real (P.height p))
      val (x,y) = (P.noise1D p tx, P.noise1D p ty)
      val _ = P.stroke p (r,0,0)
      val _ = P.line p (0.0,0.0) (x*w,y*h)
      val _ = P.line p (w,  0.0) (x*w,y*h)
      val _ = P.line p (0.0,h)   (x*w,y*h)
      val _ = P.line p (w,  h)   (x*w,y*h)
  in ((r + 1) mod 255,
      tx+0.01, ty+0.01)
  end


fun simpleMouse p () = 
  let val (w,h) = (real (P.width p), real (P.height p))
      val (mx,my) = (real (P.mouseX p), real (P.mouseY p))
      val _ = P.background p white;
      val _ = P.line p (0.0,0.0) (mx,my)
  in ()
  end

fun setup p _ = (P.size p (500,500);
                 P.background p white;
                 P.frameRate p 60)
in
  val _ = init "canvas0" setup simpleMouse ();
  val _ = init "canvas1" setup mouse ();
  val _ = init "canvas2" setup revolvingBall 0;
  val _ = init "canvas3" setup ball (100.0, 100.0, 10.0, 13.0);
  val _ = init "canvas4" setup randomCircles (Random.newgen ());
  val _ = init "canvas5" setup noise (0, 0.0,10000.0);
end
