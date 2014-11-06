  val basislibs = ["Initial","General","Option", "List", "ListPair",
                   "Vector",
                   "Array2",
                   "StringCvt", "Substring", "Bool", "IntInfRep",
                   "Word32", "Word8", "Word31", "Pack32Little", "Pack32Big", "Byte",
                   "Int32", "Int31",
                   "Math", "Real",
                   "IntInf",
                   "Time", "Random", "Path", "Date", "Timer", "TextIO",
                   "JsCore", "Js", "Html", "Rwp", "dojo",
                   "JsUtil", "Processing"
                  ]

(* val topelem = Js.documentElement Js.document *)
(* fun appendScript path = *)
(*     case Js.firstChild topelem of *)
(*         SOME head => let val e = (Js.Element.taga0 "script" [("type","text/javascript"), ("src", path)]) *)
(*                      in *)
(*                          JsUtil.log ("<script type=\"text/javascript\" src=\"" ^ path ^ "\"></script>"); *)
(*                          Js.appendChild head e *)
(*                      end *)
(*       | NONE => raise Fail "appendScript" *)

val editor = ref NONE

fun initAce e =
  let val editorObj = JsCore.exec1 {stmt="var editor = ace.edit(e);" ^
                                         "editor.setTheme('ace/theme/textmate');" ^
                                         "editor.setShowPrintMargin(false);" ^
                                         "editor.getSession().setMode('ace/mode/sml');" ^
                                         "editor.getSession().setUseSoftTabs(true);" ^
                                         "return editor;",
                                    arg1=("e",JsCore.string),
                                    res=JsCore.fptr}
                                   e
  in editor := SOME editorObj;
     editorObj
  end

fun getValue e : string =
    JsCore.exec1 {stmt="return e.getValue();",
                  arg1=("e",JsCore.fptr),
                  res=JsCore.string}
                 e

fun getEditor () = case !editor of
                       NONE => raise Fail "Editor not initialized correctly"
                     | SOME e => e

val () = _export("getEditor", getEditor)


fun appendContent e msg : unit =
    JsCore.exec2 {stmt="return e.innerHTML +=msg;",
                  arg1=("e",JsCore.fptr),
                  arg2=("msg",JsCore.string),
                  res=JsCore.unit}
                 (Js.Element.toForeignPtr e, msg)


fun compileit editorObj () =
  let
    open JsUtil
    open SmlToJsComp

    val usercode = getValue editorObj
    val openProcessing = "open Processing;"
    val runFunction = "fun run s = Processing.init \"canvas0\" (fn p => (canvasSize p (400,400); s p));"
    (* val _ = print ("Code: " ^ usercode) *)

    fun load_env n =
        let val eb_s = JsCore.exec0{stmt="return " ^ n ^ "_sml_eb;",
                                    res=JsCore.string}()
        in Pickle.unpickle Env.pu eb_s
        end

    fun load_envs f e nil = f e
      | load_envs f e (n::ns) = load_envs f (Env.plus (e, load_env n)) ns

    (* fun basispath n = "/home/dybber/git/mlkit/js/basis/MLB/Js/" ^ n ^ ".sml.o.eb.js" *)
    (* val script_paths = List.map basispath basislibs *)
    (* val () = List.app appendScript script_paths *)

    val code = openProcessing ^ runFunction ^ usercode

    fun run initEnv = 
      let val (e',mc) = compile (initEnv, code)
          (* val _ = print ("modcode: " ^ pp mc) *)
      in
          execute mc
      end
  in
      load_envs run (Env.initial()) basislibs
  end

fun init () = 
    let open JsUtil
        val editor = initAce "editor"
        val _ = addHandler "onclick" ($ "compilebutton") (compileit editor)

        val console = $ "console"
        val _ = Control.printer_set (appendContent console)
    in
        ()
    end

val _ = JsUtil.onloadHandler init
