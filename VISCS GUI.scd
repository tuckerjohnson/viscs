~viscs = NetAddr.new("127.0.0.1", 57120);
~viscsmix = NetAddr.new("192.168.0.100", 57120);
//
//net addresses must be set prior to evaluation
//
//color/font
~base03 = Color.fromHexString("#002b36");
~base02 = Color.fromHexString("#073642");
~base01 = Color.fromHexString("#586e75");
~base00 = Color.fromHexString("#657b83");
~base0 = Color.fromHexString("#839496");
~base1 = Color.fromHexString("#83a1a1");
~base2 = Color.fromHexString("#eee8d5");
~base3 = Color.fromHexString("#fdf6e3");
~font = Font("DejaVu Sans Mono", 16);
~yellow = Color.fromHexString("#b58900");
~red = Color.fromHexString("#cb4b16");
~green = Color.fromHexString("#859900");
~blue = Color.fromHexString("#268bd2");
~cyan = Color.fromHexString("#2aa198");
~orange = Color.fromHexString("#cb4b16");
~magenta = Color.fromHexString("#d33682");
w = Window("VISCS-CON", Rect(0, 0, 1200, 715)).front.background_(
		~base03
	).alpha_(0.7);

~window_init = r {
	~gui_init.run;
	~genstate.run;
	~start_state.run;
};

~gui_init = r {
	~karray = ["gra", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "da", "eq", "bac", "q", "w", "e", "r",
		"y", "u", "i", "o", "p", "obr", "cbr", "bsl", "a", "s", "d", "f", "h", "j", "k", "l", "sc", "ap",
		"ret", "lsh", "z", "x", "c", "v", "n", "m", "com", "per", "fsl", "rsh", "lctl", "lalt", "ralt", "rctl"];
	////line 1
	~kgra = Button(w, Rect(15, 315, 65, 65)).font_(~font).canFocus_(false);
	~k1 = Button(w, Rect(95, 315, 65, 65)).font_(~font).canFocus_(false);
	~k2 = Button(w, Rect(175, 315, 65, 65)).font_(~font).canFocus_(false);
	~k3 = Button(w, Rect(255, 315, 65, 65)).font_(~font).canFocus_(false);
	~k4 = Button(w, Rect(335, 315, 65, 65)).font_(~font).canFocus_(false);
	~k5 = Button(w, Rect(415, 315, 65, 65)).font_(~font).canFocus_(false);
	~k6 = Button(w, Rect(495, 315, 65, 65)).font_(~font).canFocus_(false);
	~k7 = Button(w, Rect(575, 315, 65, 65)).font_(~font).canFocus_(false);
	~k8 = Button(w, Rect(655, 315, 65, 65)).font_(~font).canFocus_(false);
	~k9 = Button(w, Rect(735, 315, 65, 65)).font_(~font).canFocus_(false);
	~k0 = Button(w, Rect(815, 315, 65, 65)).font_(~font).canFocus_(false);
	~kda = Button(w, Rect(895, 315, 65, 65)).font_(~font).canFocus_(false);
	~keq = Button(w, Rect(975, 315, 65, 65)).font_(~font).canFocus_(false);
	~kbac = Button(w, Rect(1055, 315, 130, 65)).font_(~font).canFocus_(false);
	////line2
	~kq = Button(w, Rect(160, 395, 65, 65)).font_(~font).canFocus_(false);
	~kw = Button(w, Rect(240, 395, 65, 65)).font_(~font).canFocus_(false);
	~ke = Button(w, Rect(320, 395, 65, 65)).font_(~font).canFocus_(false);
	~kr = Button(w, Rect(400, 395, 65, 65)).font_(~font).canFocus_(false);
	~ky = Button(w, Rect(560, 395, 65, 65)).font_(~font).canFocus_(false);
	~ku = Button(w, Rect(640, 395, 65, 65)).font_(~font).canFocus_(false);
	~ki = Button(w, Rect(720, 395, 65, 65)).font_(~font).canFocus_(false);
	~ko = Button(w, Rect(800, 395, 65, 65)).font_(~font).canFocus_(false);
	~kp = Button(w, Rect(880, 395, 65, 65)).font_(~font).canFocus_(false);
	~kobr = Button(w, Rect(960, 395, 65, 65)).font_(~font).canFocus_(false);
	~kcbr = Button(w, Rect(1040, 395, 65, 65)).font_(~font).canFocus_(false);
	~kbsl = Button(w, Rect(1120, 395, 65, 65)).font_(~font).canFocus_(false);
	////line3
	~ka = Button(w, Rect(170, 475, 65, 65)).font_(~font).canFocus_(false);
	~ks = Button(w, Rect(250, 475, 65, 65)).font_(~font).canFocus_(false);
	~kd = Button(w, Rect(330, 475, 65, 65)).font_(~font).canFocus_(false);
	~kf = Button(w, Rect(410, 475, 65, 65)).font_(~font).canFocus_(false);
	~kh = Button(w, Rect(570, 475, 65, 65)).font_(~font).canFocus_(false);
	~kj = Button(w, Rect(650, 475, 65, 65)).font_(~font).canFocus_(false);
	~kk = Button(w, Rect(730, 475, 65, 65)).font_(~font).canFocus_(false);
	~kl = Button(w, Rect(810, 475, 65, 65)).font_(~font).canFocus_(false);
	~ksc = Button(w, Rect(890, 475, 65, 65)).font_(~font).canFocus_(false);
	~kap = Button(w, Rect(970, 475, 65, 65)).font_(~font).canFocus_(false);
	~kret = Button(w, Rect(1050, 475, 135, 65)).font_(~font).canFocus_(false);
	////line4
	~klsh = Button(w, Rect(15, 555, 175, 65)).font_(~font).canFocus_(false);
	~kz = Button(w, Rect(205, 555, 65, 65)).font_(~font).canFocus_(false);
	~kx = Button(w, Rect(285, 555, 65, 65)).font_(~font).canFocus_(false);
	~kc = Button(w, Rect(365, 555, 65, 65)).font_(~font).canFocus_(false);
	~kv = Button(w, Rect(445, 555, 65, 65)).font_(~font).canFocus_(false);
	~kn = Button(w, Rect(605, 555, 65, 65)).font_(~font).canFocus_(false);
	~km = Button(w, Rect(685, 555, 65, 65)).font_(~font).canFocus_(false);
	~kcom = Button(w, Rect(765, 555, 65, 65)).font_(~font).canFocus_(false);
	~kper = Button(w, Rect(845, 555, 65, 65)).font_(~font).canFocus_(false);
	~kfsl = Button(w, Rect(925, 555, 65, 65)).font_(~font).canFocus_(false);
	~krsh = Button(w, Rect(1005, 555, 180, 65)).font_(~font).canFocus_(false);
	////line5
	~klctl = Button(w, Rect(15, 635, 160, 65)).font_(~font).canFocus_(false);
	~klalt = Button(w, Rect(190, 635, 160, 65)).font_(~font).canFocus_(false);
	~kralt = Button(w, Rect(765, 635, 100, 65)).font_(~font).canFocus_(false);
	~krctl = Button(w, Rect(880, 635, 100, 65)).font_(~font).canFocus_(false);
};
/////////////////////////////////////////////
~genstate = r {
	~karray.do({
		arg val;
		var k, string;
		k = "~k" ++ val;
		string = val;
		case
		{ val == "lctl" } { string = "ctrl" }
		{ val == "rctl" } { string = "ctrl" }
		{ val == "lalt" } { string = "alt" }
		{ val == "ralt" } { string = "alt" }
		{ val == "com" } { string = "," }
		{ val == "per" } { string = "." }
		{ val == "fsl" } { string = "/" }
		{ val == "rsh" } { string = "shift" }
		{ val == "lsh" } { string = "shift" }
		{ val == "sc" } { string = ";" }
		{ val == "ap" } { string = "'" }
		{ val == "ret" } { string = "return" }
		{ val == "gra" } { string = "`" }
		{ val == "da" } { string = "-" }
		{ val == "eq" } { string = "=" }
		{ val == "bac" } { string = "backspace" }
		{ val == "obr" } { string = "[" }
		{ val == "cbr" } { string = "]" }
		{ val == "bsl" } { string = "\\\\" };
		(k ++ ".states_([[\"" ++ string ++
			"\", ~base0, ~base03] ,[\"" ++ string ++
			"\", ~base3, ~orange], [\"" ++ string ++
			"\", ~base3, ~yellow], [\"" ++ string ++
			"\", ~base3, ~magenta], [\"" ++ string ++
			"\", ~base3, ~green], [\"" ++ string ++
			"\", ~base3, ~cyan]]);").interpret;
	});
};
/////////////////////////////////////////////////////
~startupgo = r {
	~viscs.sendMsg("/con", 1);
	w.view.keyDownAction = { nil };
	w.view.keyUpAction = { nil };
	160.do({
		arg val;
		case
		{ val%(8) == 0 } { ~ka.value_(rrand(1,5)); ~kk.value_(0); }
		{ val%(8) == 1 } { ~ks.value_(rrand(1,5)); ~kl.value_(0);  }
		{ val%(8) == 2 } { ~kd.value_(rrand(1,5)); ~ka.value_(0);  }
		{ val%(8) == 3 } { ~kf.value_(rrand(1,5)); ~ks.value_(0);  }
		{ val%(8) == 4 } { ~kh.value_(rrand(1,5)); ~kd.value_(0);  }
		{ val%(8) == 5 } { ~kj.value_(rrand(1,5)); ~kf.value_(0);  }
		{ val%(8) == 6 } { ~kk.value_(rrand(1,5)); ~kh.value_(0);  }
		{ val%(8) == 7 } { ~kl.value_(rrand(1,5)); ~kj.value_(0);  };
		0.08.yield;
	});
	~kk.value_(0); ~kl.value_(0); ~dyn_state.run; ~kgra.value_(0);
};
~vcon = r { arg val;
	~viscs.sendMsg("/con", val);
};
~vsel = r { arg val;
	~viscs.sendMsg("/sel", val);
};
~vpl = r { arg val;
	~viscs.sendMsg("/play", val);
};
////////////////////////////////////////////////////////
~start_state = r {
	w.view.keyDownAction = {
		|doc, char, mod, unicode, keycode, key|
		case
		{ keycode == 96 } { ~kgra.value_(3); AppClock.play(~startupgo); } //`
		{ keycode == 49 } { ~k1.value_(4); ~vcon.reset.value(0); } //1
		{ keycode == 50 } { ~k2.value_(4); ~vcon.reset.value(0); } //2
		{ keycode == 51 } { ~k3.value_(4); ~vcon.reset.value(0); } //3
		{ keycode == 52 } { ~k4.value_(4); ~vcon.reset.value(0); } //4
		{ keycode == 53 } { ~k5.value_(4); ~vcon.reset.value(0); } //5
		{ keycode == 54 } { ~k6.value_(4); ~vcon.reset.value(0); } //6
		{ keycode == 55 } { ~k7.value_(4); ~vcon.reset.value(0); } //7
		{ keycode == 56 } { ~k8.value_(4); ~vcon.reset.value(0); } //8
		{ keycode == 57 } { ~k9.value_(4); ~vcon.reset.value(0); } //9
		{ keycode == 48 } { ~k0.value_(4); ~vcon.reset.value(0); } //0
		{ keycode == 45 } { ~kda.value_(4);  ~vcon.reset.value(0); } //-
		{ keycode == 61 } { ~keq.value_(4); ~vcon.reset.value(0); } //=
		{ keycode == 65288 } { ~kbac.value_(3); ~vcon.reset.value(0); } //backspace
		{ keycode == 113 } { ~kq.value_(2); ~vsel.reset.value(0); } //q
		{ keycode == 119 } { ~kw.value_(2); ~vsel.reset.value(0); } //w
		{ keycode == 101 } { ~ke.value_(2); ~vsel.reset.value(0); } //e
		{ keycode == 114 } { ~kr.value_(2); ~vsel.reset.value(0); } //r
		{ keycode == 81 } { ~kq.value_(1); ~vsel.reset.value(0); } //Q
		{ keycode == 87 } { ~kw.value_(1); ~vsel.reset.value(0); }  //W
		{ keycode == 69 } { ~ke.value_(1); ~vsel.reset.value(0); }  //E
		{ keycode == 82 } { ~kr.value_(1); ~vsel.reset.value(0); }  //R
		{ keycode == 121 } { ~ky.value_(5); } //y
		{ keycode == 117 } { ~ku.value_(5); } //u
		{ keycode == 105 } { ~ki.value_(5); } //i
		{ keycode == 111 } { ~ko.value_(5); } //o
		{ keycode == 112 } { ~kp.value_(5); } //p
		{ keycode == 91 } { ~kobr.value_(5); } //[
		{ keycode == 93 } { ~kcbr.value_(5); } //]
		{ keycode == 92 } { ~kbsl.value_(1); } //\
		{ keycode == 97 } { ~ka.value_(2); } //a
		{ keycode == 115 } { ~ks.value_(2); } //s
		{ keycode == 100 } { ~kd.value_(2); } //d
		{ keycode == 102 } { ~kf.value_(2); } //f
		{ keycode == 65 } { ~ka.value_(1); } //A
		{ keycode == 83 } { ~ks.value_(1); } //S
		{ keycode == 68 } { ~kd.value_(1); } //D
		{ keycode == 70 } { ~kf.value_(1); } //F
		{ keycode == 104 } { ~kh.value_(5); ~vpl.reset.value(0); } //h
		{ keycode == 106 } { ~kj.value_(5); ~vpl.reset.value(0); } //j
		{ keycode == 107 } { ~kk.value_(5); ~vpl.reset.value(0); } //k
		{ keycode == 108 } { ~kl.value_(5); ~vpl.reset.value(0); } //l
		{ keycode == 59 } { ~ksc.value_(5); ~vpl.reset.value(0); } //;
		{ keycode == 39 } { ~kap.value_(5); ~vpl.reset.value(0); } //'
		{ keycode == 65293 } { ~kret.value_(1); } //return
		{ keycode == 65505 } { ~klsh.value_(3); } //lsift
		{ keycode == 122 } { ~kz.value_(2); } //z
		{ keycode == 120 } { ~kx.value_(2); } //x
		{ keycode == 99 } { ~kc.value_(2); } //c
		{ keycode == 118 } { ~kv.value_(2); } //v
		{ keycode == 90 } { ~kz.value_(1); } //Z
		{ keycode == 88 } { ~kx.value_(1); } //X
		{ keycode == 67 } { ~kc.value_(1); } //C
		{ keycode == 86 } { ~kv.value_(1); } //V
		{ keycode == 110 } { ~kn.value_(5); } //n
		{ keycode == 109 } { ~km.value_(5); } //m
		{ keycode == 44 } { ~kcom.value_(5); } //,
		{ keycode == 46 } { ~kper.value_(5); } //.
		{ keycode == 47 } { ~kfsl.value_(5); } ///
		{ keycode == 65506 } { ~krsh.value_(3); } //rshift
		{ keycode == 65507 } { ~klctl.value_(3); } //lctl
		{ keycode == 65513 } { ~klalt.value_(3); } //lalt
		{ keycode == 65514 } { ~kralt.value_(3); } //ralt
		{ keycode == 65508 } { ~krctl.value_(3); }; //rctl
	};
	w.view.keyUpAction = {
		|doc, char, mod, unicode, keycode, key|
		case
		{ keycode == 96 } { ~kgra.value_(0); } //`
		{ keycode == 49 } { ~k1.value_(0); } //1
		{ keycode == 50 } { ~k2.value_(0); } //2
		{ keycode == 51 } { ~k3.value_(0); } //3
		{ keycode == 52 } { ~k4.value_(0); } //4
		{ keycode == 53 } { ~k5.value_(0); } //5
		{ keycode == 54 } { ~k6.value_(0); } //6
		{ keycode == 55 } { ~k7.value_(0); } //7
		{ keycode == 56 } { ~k8.value_(0); } //8
		{ keycode == 57 } { ~k9.value_(0); } //9
		{ keycode == 48 } { ~k0.value_(0); } //0
		{ keycode == 45 } { ~kda.value_(0); } //-
		{ keycode == 61 } { ~keq.value_(0); } //=
		{ keycode == 65288 } { ~kbac.value_(0); } //backspace
		{ keycode == 113 } { ~kq.value_(0); } //q
		{ keycode == 119 } { ~kw.value_(0); } //w
		{ keycode == 101 } { ~ke.value_(0); } //e
		{ keycode == 114 } { ~kr.value_(0); } //r
		{ keycode == 81 } { ~kq.value_(0); } //Q
		{ keycode == 87 } { ~kw.value_(0); } //W
		{ keycode == 69 } { ~ke.value_(0); } //E
		{ keycode == 82 } { ~kr.value_(0); } //R
		{ keycode == 121 } { ~ky.value_(0); } //y
		{ keycode == 117 } { ~ku.value_(0); } //u
		{ keycode == 105 } { ~ki.value_(0); } //i
		{ keycode == 111 } { ~ko.value_(0); } //o
		{ keycode == 112 } { ~kp.value_(0); } //p
		{ keycode == 91 } { ~kobr.value_(0); } //[
		{ keycode == 93 } { ~kcbr.value_(0); } //]
		{ keycode == 92 } { ~kbsl.value_(0); } //\
		{ keycode == 97 } { ~ka.value_(0); } //a
		{ keycode == 115 } { ~ks.value_(0); } //s
		{ keycode == 100 } { ~kd.value_(0); } //d
		{ keycode == 102 } { ~kf.value_(0); } //f
		{ keycode == 65 } { ~ka.value_(0); } //A
		{ keycode == 83 } { ~ks.value_(0); } //S
		{ keycode == 68 } { ~kd.value_(0); } //D
		{ keycode == 70 } { ~kf.value_(0); } //F
		{ keycode == 104 } { ~kh.value_(0); } //h
		{ keycode == 106 } { ~kj.value_(0); } //j
		{ keycode == 107 } { ~kk.value_(0); } //k
		{ keycode == 108 } { ~kl.value_(0); } //l
		{ keycode == 59 } { ~ksc.value_(0); } //;
		{ keycode == 39 } { ~kap.value_(0); } //'
		{ keycode == 65293 } { ~kret.value_(0); } //return
		{ keycode == 65505 } { ~klsh.value_(0); } //lsift
		{ keycode == 122 } { ~kz.value_(0); } //z
		{ keycode == 120 } { ~kx.value_(0); } //x
		{ keycode == 99 } { ~kc.value_(0); } //c
		{ keycode == 118 } { ~kv.value_(0); } //v
		{ keycode == 90 } { ~kz.value_(0); } //Z
		{ keycode == 88 } { ~kx.value_(0); } //X
		{ keycode == 67 } { ~kc.value_(0); } //C
		{ keycode == 86 } { ~kv.value_(0); } //V
		{ keycode == 110 } { ~kn.value_(0); } //n
		{ keycode == 109 } { ~km.value_(0); } //m
		{ keycode == 44 } { ~kcom.value_(0); } //,
		{ keycode == 46 } { ~kper.value_(0); } //.
		{ keycode == 47 } { ~kfsl.value_(0); } ///
		{ keycode == 65506 } { ~krsh.value_(0); } //rshift
		{ keycode == 65507 } { ~klctl.value_(0); } //lctl
		{ keycode == 65513 } { ~klalt.value_(0); } //lalt
		{ keycode == 65514 } { ~kralt.value_(0); } //ralt
		{ keycode == 65508 } { ~krctl.value_(0); }; //rctl
	};
};
///////////////////////////////////////////////////
~dyn_switches = [0,0,0,0,0,0,0,0,0,0,0,0];
~dyn_state = r {
	 ~k1.value_(4);
	~switches = [["~kq", "~kw", "~ke", "~kr", "~ka", "~ks", "~kd", "~kf", "~kz", "~kx", "~kc", "~kv"],
		[12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25]];
	~switches[0].do({
		arg val, i;
		(val ++ ".value_(~dyn_switches[" ++ i ++ "])").interpret;
	});
	~switch = r {
		arg inval;
		if ( (~switches[0][inval] ++ ".value").interpret == 0,
			{ (~switches[0][inval] ++ ".value_(2)").interpret; ~vsel.reset.value(~switches[1][inval]); },
			{ if ( (~switches[0][inval] ++ ".value").interpret == 2,
				{ (~switches[0][inval] ++ ".value_(0)").interpret; ~vsel.reset.value(~switches[2][inval]); },
				{ (~switches[0][inval] ++ ".value_(0)").interpret }
			)}
		);
	};
	~offswitch = r {
		arg inval;
		~switches[0].do({
			arg val;
			(val ++ ".value_(0)").interpret;
		});
		(inval ++ ".value_(2)").interpret;
	};
	~dyn_state_store = r {
		~dyn_switches = [~kq.value, ~kw.value, ~ke.value, ~kr.value,
			~ka.value, ~ks.value, ~kd.value, ~kf.value,
			~kz.value, ~kx.value, ~kc.value, ~kv.value];
	};
	w.view.keyDownAction = {
		|doc, char, mod, unicode, keycode, key|
		case
		{ keycode == 96 } { ~kgra.value_(3); ~vcon.reset.value(2); } //`
		{ keycode == 50 } { ~k2.value_(4); ~k1.value_(0); ~dyn_state_store.reset.run; ~ph_state.reset.run; } //2
		{ keycode == 51 } { ~k3.value_(4); } //3
		{ keycode == 52 } { ~k4.value_(4); } //4
		{ keycode == 53 } { ~k5.value_(4); } //5
		{ keycode == 54 } { ~k6.value_(4); } //6
		{ keycode == 55 } { ~k7.value_(4); } //7
		{ keycode == 56 } { ~k8.value_(4); } //8
		{ keycode == 57 } { ~k9.value_(4); } //9
		{ keycode == 48 } { ~k0.value_(4); } //0
		{ keycode == 45 } { ~kda.value_(4); } //-
		{ keycode == 61 } { ~keq.value_(4); } //=
		{ keycode == 65288 } { ~kbac.value_(3); } //backspace
		{ keycode == 113 } { ~switch.reset.value(0);} //q
		{ keycode == 119 } { ~switch.reset.value(1);} //w
		{ keycode == 101 } { ~switch.reset.value(2);} //e
		{ keycode == 114 } { ~switch.reset.value(3);} //r
		{ keycode == 81 } { ~offswitch.reset.value("~kq"); ~vsel.reset.value(24); } //Q
		{ keycode == 87 } { ~offswitch.reset.value("~kw"); ~vsel.reset.value(23); }  //W
		{ keycode == 69 } { ~offswitch.reset.value("~ke"); ~vsel.reset.value(22); }  //E
		{ keycode == 82 } { ~offswitch.reset.value("~kr"); ~vsel.reset.value(21); }  //R
		{ keycode == 121 } { ~ky.value_(5); } //y
		{ keycode == 117 } { ~ku.value_(5); } //u
		{ keycode == 105 } { ~ki.value_(5); } //i
		{ keycode == 111 } { ~ko.value_(5); } //o
		{ keycode == 112 } { ~kp.value_(5); } //p
		{ keycode == 91 } { ~kobr.value_(5); } //[
		{ keycode == 93 } { ~kcbr.value_(5); } //]
		{ keycode == 92 } { ~kbsl.value_(1); } //\
		{ keycode == 97 } { ~switch.reset.value(4);} //a
		{ keycode == 115 } { ~switch.reset.value(5);} //s
		{ keycode == 100 } { ~switch.reset.value(6);} //d
		{ keycode == 102 } { ~switch.reset.value(7);} //f
		{ keycode == 65 } { ~offswitch.reset.value("~ka"); ~vsel.reset.value(20); } //A
		{ keycode == 83 } { ~offswitch.reset.value("~ks"); ~vsel.reset.value(19); } //S
		{ keycode == 68 } { ~offswitch.reset.value("~kd"); ~vsel.reset.value(18); } //D
		{ keycode == 70 } { ~offswitch.reset.value("~kf"); ~vsel.reset.value(17); } //F
		{ keycode == 104 } { ~kh.value_(5); ~vpl.reset.value(1);  } //h
		{ keycode == 106 } { ~kj.value_(5); ~vpl.reset.value(2); } //j
		{ keycode == 107 } { ~kk.value_(5); ~vpl.reset.value(3); } //k
		{ keycode == 108 } { ~kl.value_(5); ~vpl.reset.value(4); } //l
		{ keycode == 59 } { ~ksc.value_(5); ~vpl.reset.value(5); } //;
		{ keycode == 39 } { ~kap.value_(5); ~vpl.reset.value(6); } //'
		{ keycode == 65293 } { ~kret.value_(1); } //return
		{ keycode == 65505 } { ~klsh.value_(3); } //lsift
		{ keycode == 122 } { ~switch.reset.value(8);} //z
		{ keycode == 120 } { ~switch.reset.value(9);} //x
		{ keycode == 99 } { ~switch.reset.value(10);} //c
		{ keycode == 118 } { ~switch.reset.value(11);} //v
		{ keycode == 90 } { ~offswitch.reset.value("~kz"); ~vsel.reset.value(16); } //Z
		{ keycode == 88 } { ~offswitch.reset.value("~kx"); ~vsel.reset.value(15); } //X
		{ keycode == 67 } { ~offswitch.reset.value("~kc"); ~vsel.reset.value(14); } //C
		{ keycode == 86 } { ~offswitch.reset.value("~kv"); ~vsel.reset.value(13); } //V
		{ keycode == 110 } { ~kn.value_(5); ~vpl.reset.value(7); } //n
		{ keycode == 109 } { ~km.value_(5); ~vpl.reset.value(8); } //m
		{ keycode == 44 } { ~kcom.value_(5); ~vpl.reset.value(9); } //,
		{ keycode == 46 } { ~kper.value_(5); ~vpl.reset.value(10); } //.
		{ keycode == 47 } { ~kfsl.value_(5); ~vpl.reset.value(11); } ///
		{ keycode == 65506 } { ~krsh.value_(3); } //rshift
		{ keycode == 65507 } { ~klctl.value_(3); } //lctl
		{ keycode == 65513 } { ~klalt.value_(3); } //lalt
		{ keycode == 65514 } { ~kralt.value_(3); } //ralt
		{ keycode == 65508 } { ~krctl.value_(3); }; //rctl
	};
	w.view.keyUpAction = {
		|doc, char, mod, unicode, keycode, key|
		case
		{ keycode == 96 } { ~kgra.value_(0); } //`
		{ keycode == 45 } { ~kda.value_(0); } //-
		{ keycode == 61 } { ~keq.value_(0); } //=
		{ keycode == 65288 } { ~kbac.value_(0); } //backspace
		{ keycode == 121 } { ~ky.value_(0); } //y
		{ keycode == 117 } { ~ku.value_(0); } //u
		{ keycode == 105 } { ~ki.value_(0); } //i
		{ keycode == 111 } { ~ko.value_(0); } //o
		{ keycode == 112 } { ~kp.value_(0); } //p
		{ keycode == 91 } { ~kobr.value_(0); } //[
		{ keycode == 93 } { ~kcbr.value_(0); } //]
		{ keycode == 92 } { ~kbsl.value_(0); } //\
		{ keycode == 104 } { ~kh.value_(0); } //h
		{ keycode == 106 } { ~kj.value_(0); } //j
		{ keycode == 107 } { ~kk.value_(0); } //k
		{ keycode == 108 } { ~kl.value_(0); } //l
		{ keycode == 59 } { ~ksc.value_(0); } //;
		{ keycode == 39 } { ~kap.value_(0); } //'
		{ keycode == 65293 } { ~kret.value_(0); } //return
		{ keycode == 65505 } { ~klsh.value_(0); } //lsift
		{ keycode == 110 } { ~kn.value_(0); } //n
		{ keycode == 109 } { ~km.value_(0); } //m
		{ keycode == 44 } { ~kcom.value_(0); } //,
		{ keycode == 46 } { ~kper.value_(0); } //.
		{ keycode == 47 } { ~kfsl.value_(0); } ///
		{ keycode == 65506 } { ~krsh.value_(0); } //rshift
		{ keycode == 65507 } { ~klctl.value_(0); } //lctl
		{ keycode == 65513 } { ~klalt.value_(0); } //lalt
		{ keycode == 65514 } { ~kralt.value_(0); } //ralt
		{ keycode == 65508 } { ~krctl.value_(0); }; //rctl
	};
};
///////////////////////////////////////////////////////////////////////////////////
~ph_switches = [0,0,0,0,0,0,0,0,0,0,0,0];
~ph_state = r {
	~switches[0].do({
		arg val, i;
		(val ++ ".value_(~ph_switches[" ++ i ++ "])").interpret;
	});
	~switches = [["~kq", "~kw", "~ke", "~kr", "~ka", "~ks", "~kd", "~kf", "~kz", "~kx", "~kc", "~kv"],
		[48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37], [72, 71, 70, 69, 68, 67, 66, 65, 64, 63, 62, 61]];
	~switch = r {
		arg inval;
		if ( (~switches[0][inval] ++ ".value").interpret == 0,
			{ (~switches[0][inval] ++ ".value_(2)").interpret; ~vsel.reset.value(~switches[1][inval]); },
			{ if ( (~switches[0][inval] ++ ".value").interpret == 2,
				{ (~switches[0][inval] ++ ".value_(0)").interpret; ~vsel.reset.value(~switches[2][inval]); },
				{ (~switches[0][inval] ++ ".value_(0)").interpret }
			)}
		);
	};
	~offswitch = r {
		arg inval;
		~switches[0].do({
			arg val;
			(val ++ ".value_(0)").interpret;
		});
		(inval ++ ".value_(2)").interpret;
	};
	~ph_state_store = r {
		~ph_switches = [~kq.value, ~kw.value, ~ke.value, ~kr.value,
			~ka.value, ~ks.value, ~kd.value, ~kf.value,
			~kz.value, ~kx.value, ~kc.value, ~kv.value];
	};
	w.view.keyDownAction = {
		|doc, char, mod, unicode, keycode, key|
		case
		{ keycode == 96 } { ~kgra.value_(3); ~vcon.reset.value(2); } //`
		{ keycode == 49 } { ~k1.value_(4); ~k2.value_(0);  ~ph_state_store.reset.run; ~dyn_state.reset.run; } //1
		{ keycode == 51 } { ~k3.value_(4); } //3
		{ keycode == 52 } { ~k4.value_(4); } //4
		{ keycode == 53 } { ~k5.value_(4); } //5
		{ keycode == 54 } { ~k6.value_(4); } //6
		{ keycode == 55 } { ~k7.value_(4); } //7
		{ keycode == 56 } { ~k8.value_(4); } //8
		{ keycode == 57 } { ~k9.value_(4); } //9
		{ keycode == 48 } { ~k0.value_(4); } //0
		{ keycode == 45 } { ~kda.value_(4); } //-
		{ keycode == 61 } { ~keq.value_(4); } //=
		{ keycode == 65288 } { ~kbac.value_(3); } //backspace
		{ keycode == 113 } { ~switch.reset.value(0);} //q
		{ keycode == 119 } { ~switch.reset.value(1);} //w
		{ keycode == 101 } { ~switch.reset.value(2);} //e
		{ keycode == 114 } { ~switch.reset.value(3);} //r
		{ keycode == 81 } { ~offswitch.reset.value("~kq"); ~vsel.reset.value(60); } //Q
		{ keycode == 87 } { ~offswitch.reset.value("~kw"); ~vsel.reset.value(59); }  //W
		{ keycode == 69 } { ~offswitch.reset.value("~ke"); ~vsel.reset.value(58); }  //E
		{ keycode == 82 } { ~offswitch.reset.value("~kr"); ~vsel.reset.value(57); }  //R
		{ keycode == 121 } { ~ky.value_(5); } //y
		{ keycode == 117 } { ~ku.value_(5); } //u
		{ keycode == 105 } { ~ki.value_(5); } //i
		{ keycode == 111 } { ~ko.value_(5); } //o
		{ keycode == 112 } { ~kp.value_(5); } //p
		{ keycode == 91 } { ~kobr.value_(5); } //[
		{ keycode == 93 } { ~kcbr.value_(5); } //]
		{ keycode == 92 } { ~kbsl.value_(1); } //\
		{ keycode == 97 } { ~switch.reset.value(4);} //a
		{ keycode == 115 } { ~switch.reset.value(5);} //s
		{ keycode == 100 } { ~switch.reset.value(6);} //d
		{ keycode == 102 } { ~switch.reset.value(7);} //f
		{ keycode == 65 } { ~offswitch.reset.value("~ka"); ~vsel.reset.value(56); } //A
		{ keycode == 83 } { ~offswitch.reset.value("~ks"); ~vsel.reset.value(55); } //S
		{ keycode == 68 } { ~offswitch.reset.value("~kd"); ~vsel.reset.value(54); } //D
		{ keycode == 70 } { ~offswitch.reset.value("~kf"); ~vsel.reset.value(53); } //F
		{ keycode == 104 } { ~kh.value_(5); ~vpl.reset.value(1);  } //h
		{ keycode == 106 } { ~kj.value_(5); ~vpl.reset.value(2); } //j
		{ keycode == 107 } { ~kk.value_(5); ~vpl.reset.value(3); } //k
		{ keycode == 108 } { ~kl.value_(5); ~vpl.reset.value(4); } //l
		{ keycode == 59 } { ~ksc.value_(5); ~vpl.reset.value(5); } //;
		{ keycode == 39 } { ~kap.value_(5); ~vpl.reset.value(6); } //'
		{ keycode == 65293 } { ~kret.value_(1); } //return
		{ keycode == 65505 } { ~klsh.value_(3); } //lsift
		{ keycode == 122 } { ~switch.reset.value(8);} //z
		{ keycode == 120 } { ~switch.reset.value(9);} //x
		{ keycode == 99 } { ~switch.reset.value(10);} //c
		{ keycode == 118 } { ~switch.reset.value(11);} //v
		{ keycode == 90 } { ~offswitch.reset.value("~kz"); ~vsel.reset.value(52); } //Z
		{ keycode == 88 } { ~offswitch.reset.value("~kx"); ~vsel.reset.value(51); } //X
		{ keycode == 67 } { ~offswitch.reset.value("~kc"); ~vsel.reset.value(50); } //C
		{ keycode == 86 } { ~offswitch.reset.value("~kv"); ~vsel.reset.value(49); } //V
		{ keycode == 110 } { ~kn.value_(5); ~vpl.reset.value(7); } //n
		{ keycode == 109 } { ~km.value_(5); ~vpl.reset.value(8); } //m
		{ keycode == 44 } { ~kcom.value_(5); ~vpl.reset.value(9); } //,
		{ keycode == 46 } { ~kper.value_(5); ~vpl.reset.value(10); } //.
		{ keycode == 47 } { ~kfsl.value_(5); ~vpl.reset.value(11); } ///
		{ keycode == 65506 } { ~krsh.value_(3); } //rshift
		{ keycode == 65507 } { ~klctl.value_(3); } //lctl
		{ keycode == 65513 } { ~klalt.value_(3); } //lalt
		{ keycode == 65514 } { ~kralt.value_(3); } //ralt
		{ keycode == 65508 } { ~krctl.value_(3); }; //rctl
	};
	w.view.keyUpAction = {
		|doc, char, mod, unicode, keycode, key|
		case
		{ keycode == 96 } { ~kgra.value_(0); } //`
		{ keycode == 45 } { ~kda.value_(0); } //-
		{ keycode == 61 } { ~keq.value_(0); } //=
		{ keycode == 65288 } { ~kbac.value_(0); } //backspace
		{ keycode == 121 } { ~ky.value_(0); } //y
		{ keycode == 117 } { ~ku.value_(0); } //u
		{ keycode == 105 } { ~ki.value_(0); } //i
		{ keycode == 111 } { ~ko.value_(0); } //o
		{ keycode == 112 } { ~kp.value_(0); } //p
		{ keycode == 91 } { ~kobr.value_(0); } //[
		{ keycode == 93 } { ~kcbr.value_(0); } //]
		{ keycode == 92 } { ~kbsl.value_(0); } //\
		{ keycode == 104 } { ~kh.value_(0); } //h
		{ keycode == 106 } { ~kj.value_(0); } //j
		{ keycode == 107 } { ~kk.value_(0); } //k
		{ keycode == 108 } { ~kl.value_(0); } //l
		{ keycode == 59 } { ~ksc.value_(0); } //;
		{ keycode == 39 } { ~kap.value_(0); } //'
		{ keycode == 65293 } { ~kret.value_(0); } //return
		{ keycode == 65505 } { ~klsh.value_(0); } //lsift
		{ keycode == 110 } { ~kn.value_(0); } //n
		{ keycode == 109 } { ~km.value_(0); } //m
		{ keycode == 44 } { ~kcom.value_(0); } //,
		{ keycode == 46 } { ~kper.value_(0); } //.
		{ keycode == 47 } { ~kfsl.value_(0); } ///
		{ keycode == 65506 } { ~krsh.value_(0); } //rshift
		{ keycode == 65507 } { ~klctl.value_(0); } //lctl
		{ keycode == 65513 } { ~klalt.value_(0); } //lalt
		{ keycode == 65514 } { ~kralt.value_(0); } //ralt
		{ keycode == 65508 } { ~krctl.value_(0); }; //rctl
	};
};
///////////////////////////////////////////////////
~window_init.reset.run;