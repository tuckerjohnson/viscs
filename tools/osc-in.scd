OSCdef.new(\viscs, {
	arg msg;
	case
	{ msg[1] == 0 } { "viscs test".postln }
	{ msg[1] == 1 } { ~startup.play }
	{ msg[1] == 2 } { s.defaultGroup.freeAll }
	{ msg[1] == 3 } { s.killAll }
	{ msg[1] == 14 } { ~instgate.set(\gate, 1) }
	{ msg[1] == 15 } { ~instgate.set(\gate, 0) }
	{ msg[1] == 10 } { ~microphone.set(\gate, 1) }
	{ msg[1] == 11 } { ~microphone.set(\gate, 0) }
	{ msg[1] == 12 } { ~instdspgate.set(\gate, 1) }
	{ msg[1] == 13 } { ~instdspgate.set(\gate, 0) }
	{ msg[1] == 12 } { ~instdspgate.set(\gate, 1) }
	{ msg[1] == 41 } { ~preverbgate.set(\fade, 5, \gate, 0); }
	{ msg[1] == 42 } { ~preverbgate.set(\fade, 0.2, \gate, 1); }
	{ msg[1] == 43 } { ~dsp_out_gate_val = (~dsp_out_gate_val + 0.1).clip(0.1,2); ~analyzer.set(\amp, ~dsp_out_gate_val); }
	{ msg[1] == 44 } { ~dsp_out_gate_val = (~dsp_out_gate_val - 0.1).clip(0.1,2); ~analyzer.set(\amp, ~dsp_out_gate_val); }
	};, '/con'
);

OSCdef.new(\viscspl, {
	arg msg;
	case
	{ msg[1] == 0 } { "viscspl test".postln }
	{ msg[1] == 1 } { ~j.value(1) }
	{ msg[1] == 2 } { ~j.value(5+3.rand) }
	{ msg[1] == 3 } { ~j.value(10+5.rand) }
	{ msg[1] == 4 } { ~j.value(20+10.rand) }
	{ msg[1] == 5 } { ~j.value(30+20.rand) }
	{ msg[1] == 6 } { ~j.value(50+30.rand) }
	{ msg[1] == 7 } { ~n.value(3) }
	{ msg[1] == 8 } { ~n.value(5) }
	{ msg[1] == 9 } { ~n.value(8) }
	{ msg[1] == 10 } { ~n.value(13) }
	{ msg[1] == 11 } { ~n.value(21) }
	{ msg[1] == 20 } { ~diatonicPluckMaker.value([~currentPitch, exprand(0.08, 1.8)]) }
	{ msg[1] == 401 } { ~am1 = 1; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 402 } { ~am2 = 1; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 403 } { ~am3 = 1; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 404 } { ~am4 = 1; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 405 } { ~am1 = 0; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 406 } { ~am2 = 0; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 407 } { ~am3 = 0; ~ambisonic_panstate.reset.play; }
	{ msg[1] == 408 } { ~am4 = 0; ~ambisonic_panstate.reset.play; }
	};, '/play'
);

OSCdef.new(\viscssel, {
	arg msg;
	case
	{ msg[1] == 0 } { "viscsdyn test".postln }
	{ msg[1] == 1 } { ~dyn_bagfiller.reset.value(~d1) }
	{ msg[1] == 2 } { ~dyn_bagfiller.reset.value(~d2) }
	{ msg[1] == 3 } { ~dyn_bagfiller.reset.value(~d3) }
	{ msg[1] == 4 } { ~dyn_bagfiller.reset.value(~d4) }
	{ msg[1] == 5 } { ~dyn_bagfiller.reset.value(~d5) }
	{ msg[1] == 6 } { ~dyn_bagfiller.reset.value(~d6) }
	{ msg[1] == 7 } { ~dyn_bagfiller.reset.value(~d7) }
	{ msg[1] == 8 } { ~dyn_bagfiller.reset.value(~d8) }
	{ msg[1] == 9 } { ~dyn_bagfiller.reset.value(~d9) }
	{ msg[1] == 10 } { ~dyn_bagfiller.reset.value(~d10) }
	{ msg[1] == 11 } { ~dyn_bagfiller.reset.value(~d11) }
	{ msg[1] == 12 } { ~dyn_bagfiller.reset.value(~d12) }
	{ msg[1] == 13 } { ~dyn_bagkiller.reset.value(~d1) }
	{ msg[1] == 14 } { ~dyn_bagkiller.reset.value(~d2) }
	{ msg[1] == 15 } { ~dyn_bagkiller.reset.value(~d3) }
	{ msg[1] == 16 } { ~dyn_bagkiller.reset.value(~d4) }
	{ msg[1] == 17 } { ~dyn_bagkiller.reset.value(~d5) }
	{ msg[1] == 18 } { ~dyn_bagkiller.reset.value(~d6) }
	{ msg[1] == 19 } { ~dyn_bagkiller.reset.value(~d7) }
	{ msg[1] == 20 } { ~dyn_bagkiller.reset.value(~d8) }
	{ msg[1] == 21 } { ~dyn_bagkiller.reset.value(~d9) }
	{ msg[1] == 22 } { ~dyn_bagkiller.reset.value(~d10) }
	{ msg[1] == 23 } { ~dyn_bagkiller.reset.value(~d11) }
	{ msg[1] == 24 } { ~dyn_bagkiller.reset.value(~d12) }
	{ msg[1] == 25 } { ~dyn_bagcleaner.reset.value(~d1) }
	{ msg[1] == 26 } { ~dyn_bagcleaner.reset.value(~d2) }
	{ msg[1] == 27 } { ~dyn_bagcleaner.reset.value(~d3) }
	{ msg[1] == 28 } { ~dyn_bagcleaner.reset.value(~d4) }
	{ msg[1] == 29 } { ~dyn_bagcleaner.reset.value(~d5) }
	{ msg[1] == 30 } { ~dyn_bagcleaner.reset.value(~d6) }
	{ msg[1] == 31 } { ~dyn_bagcleaner.reset.value(~d7) }
	{ msg[1] == 32 } { ~dyn_bagcleaner.reset.value(~d8) }
	{ msg[1] == 33 } { ~dyn_bagcleaner.reset.value(~d9) }
	{ msg[1] == 34 } { ~dyn_bagcleaner.reset.value(~d10) }
	{ msg[1] == 35 } { ~dyn_bagcleaner.reset.value(~d11) }
	{ msg[1] == 36 } { ~dyn_bagcleaner.reset.value(~d12) }
	{ msg[1] == 37 } { ~ph_bagfiller.reset.value(~ph1) }
	{ msg[1] == 38 } { ~ph_bagfiller.reset.value(~ph2) }
	{ msg[1] == 39 } { ~ph_bagfiller.reset.value(~ph3) }
	{ msg[1] == 40 } { ~ph_bagfiller.reset.value(~ph4) }
	{ msg[1] == 41 } { ~ph_bagfiller.reset.value(~ph5) }
	{ msg[1] == 42 } { ~ph_bagfiller.reset.value(~ph6) }
	{ msg[1] == 43 } { ~ph_bagfiller.reset.value(~ph7) }
	{ msg[1] == 44 } { ~ph_bagfiller.reset.value(~ph8) }
	{ msg[1] == 45 } { ~ph_bagfiller.reset.value(~ph9) }
	{ msg[1] == 46 } { ~ph_bagfiller.reset.value(~ph10) }
	{ msg[1] == 47 } { ~ph_bagfiller.reset.value(~ph11) }
	{ msg[1] == 48 } { ~ph_bagfiller.reset.value(~ph12) }
	{ msg[1] == 49 } { ~ph_bagkiller.reset.value(~ph1) }
	{ msg[1] == 50 } { ~ph_bagkiller.reset.value(~ph2) }
	{ msg[1] == 51 } { ~ph_bagkiller.reset.value(~ph3) }
	{ msg[1] == 52 } { ~ph_bagkiller.reset.value(~ph4) }
	{ msg[1] == 53 } { ~ph_bagkiller.reset.value(~ph5) }
	{ msg[1] == 54 } { ~ph_bagkiller.reset.value(~ph6) }
	{ msg[1] == 55 } { ~ph_bagkiller.reset.value(~ph7) }
	{ msg[1] == 56 } { ~ph_bagkiller.reset.value(~ph8) }
	{ msg[1] == 57 } { ~ph_bagkiller.reset.value(~ph9) }
	{ msg[1] == 58 } { ~ph_bagkiller.reset.value(~ph10) }
	{ msg[1] == 59 } { ~ph_bagkiller.reset.value(~ph11) }
	{ msg[1] == 60 } { ~ph_bagkiller.reset.value(~ph12) }
	{ msg[1] == 61 } { ~ph_bagcleaner.reset.value(~ph1) }
	{ msg[1] == 62 } { ~ph_bagcleaner.reset.value(~ph2) }
	{ msg[1] == 63 } { ~ph_bagcleaner.reset.value(~ph3) }
	{ msg[1] == 64 } { ~ph_bagcleaner.reset.value(~ph4) }
	{ msg[1] == 65 } { ~ph_bagcleaner.reset.value(~ph5) }
	{ msg[1] == 66 } { ~ph_bagcleaner.reset.value(~ph6) }
	{ msg[1] == 67 } { ~ph_bagcleaner.reset.value(~ph7) }
	{ msg[1] == 68 } { ~ph_bagcleaner.reset.value(~ph8) }
	{ msg[1] == 69 } { ~ph_bagcleaner.reset.value(~ph9) }
	{ msg[1] == 70 } { ~ph_bagcleaner.reset.value(~ph10) }
	{ msg[1] == 71 } { ~ph_bagcleaner.reset.value(~ph11) }
	{ msg[1] == 72 } { ~ph_bagcleaner.reset.value(~ph12) }
	{ msg[1] == 73 } { ~le_bagfiller.reset.value(~le1) }
	{ msg[1] == 74 } { ~le_bagfiller.reset.value(~le2) }
	{ msg[1] == 75 } { ~le_bagfiller.reset.value(~le3) }
	{ msg[1] == 76 } { ~le_bagfiller.reset.value(~le4) }
	{ msg[1] == 77 } { ~le_bagfiller.reset.value(~le5) }
	{ msg[1] == 78 } { ~le_bagfiller.reset.value(~le6) }
	{ msg[1] == 79 } { ~le_bagfiller.reset.value(~le7) }
	{ msg[1] == 80 } { ~le_bagfiller.reset.value(~le8) }
	{ msg[1] == 81 } { ~le_bagfiller.reset.value(~le9) }
	{ msg[1] == 82 } { ~le_bagfiller.reset.value(~le10) }
	{ msg[1] == 83 } { ~le_bagfiller.reset.value(~le11) }
	{ msg[1] == 84 } { ~le_bagfiller.reset.value(~le12) }
	{ msg[1] == 85 } { ~le_bagkiller.reset.value(~le1) }
	{ msg[1] == 86 } { ~le_bagkiller.reset.value(~le2) }
	{ msg[1] == 87 } { ~le_bagkiller.reset.value(~le3) }
	{ msg[1] == 88 } { ~le_bagkiller.reset.value(~le4) }
	{ msg[1] == 89 } { ~le_bagkiller.reset.value(~le5) }
	{ msg[1] == 90 } { ~le_bagkiller.reset.value(~le6) }
	{ msg[1] == 91 } { ~le_bagkiller.reset.value(~le7) }
	{ msg[1] == 92 } { ~le_bagkiller.reset.value(~le8) }
	{ msg[1] == 93 } { ~le_bagkiller.reset.value(~le9) }
	{ msg[1] == 94 } { ~le_bagkiller.reset.value(~le10) }
	{ msg[1] == 95 } { ~le_bagkiller.reset.value(~le11) }
	{ msg[1] == 96 } { ~le_bagkiller.reset.value(~le12) }
	{ msg[1] == 97 } { ~le_bagcleaner.reset.value(~le1) }
	{ msg[1] == 98 } { ~le_bagcleaner.reset.value(~le2) }
	{ msg[1] == 99 } { ~le_bagcleaner.reset.value(~le3) }
	{ msg[1] == 100 } { ~le_bagcleaner.reset.value(~le4) }
	{ msg[1] == 101 } { ~le_bagcleaner.reset.value(~le5) }
	{ msg[1] == 102 } { ~le_bagcleaner.reset.value(~le6) }
	{ msg[1] == 103 } { ~le_bagcleaner.reset.value(~le7) }
	{ msg[1] == 104 } { ~le_bagcleaner.reset.value(~le8) }
	{ msg[1] == 105 } { ~le_bagcleaner.reset.value(~le9) }
	{ msg[1] == 106 } { ~le_bagcleaner.reset.value(~le10) }
	{ msg[1] == 107 } { ~le_bagcleaner.reset.value(~le11) }
	{ msg[1] == 108 } { ~le_bagcleaner.reset.value(~le12) }
	{ msg[1] == 600 } { ~specbagcheck.reset.value(~specbag_1) }
	{ msg[1] == 601 } { ~specbagcheck.reset.value(~specbag_2) }
	{ msg[1] == 602 } { ~specbagcheck.reset.value(~specbag_3) }
	};, '/sel'
);
