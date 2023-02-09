~corpus = "/home/tuckerj/Library/corpi/newest-corp/";
~viscsgui = NetAddr.new("127.0.0.1", 57120);
Server.default.options.numOutputBusChannels_(4);
Server.default.options.memSize_(2.pow(20));
b = Array.new; t = Array.new; l = Array.new; h = Array.new; p = Array.new;
~sdex = Array.new;
~d1 = Bag.new; ~d2 = Bag.new; ~d3 = Bag.new; ~d4 = Bag.new; ~d5 = Bag.new; ~d6 = Bag.new;
~d7 = Bag.new; ~d8 = Bag.new; ~d9 = Bag.new; ~d10 = Bag.new; ~d11 = Bag.new; ~d12 = Bag.new;
~ph1 = Bag.new; ~ph2 = Bag.new; ~ph3 = Bag.new; ~ph4 = Bag.new; ~ph5 = Bag.new; ~ph6 = Bag.new;
~ph7 = Bag.new; ~ph8 = Bag.new; ~ph9 = Bag.new; ~ph10 = Bag.new; ~ph11 = Bag.new; ~ph12 = Bag.new;
~le1 = Bag.new; ~le2 = Bag.new; ~le3 = Bag.new; ~le4 = Bag.new; ~le5 = Bag.new; ~le6 = Bag.new;
~le7 = Bag.new; ~le8 = Bag.new; ~le9 = Bag.new; ~le10 = Bag.new; ~le11 = Bag.new; ~le12 = Bag.new;
~spedbag = Bag.new; ~specbag_1 = Bag.new; ~specbag_2 = Bag.new; ~specbag_3 = Bag.new;
~ambag = Bag.new;
~dsp_out_gate_val = 0;
////////////////////////////////////////////////////////
~csvload = r {
	PathName(~corpus++"loudness/").entries.do({ arg path; l = l.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"p-loudness/").entries.do({ arg path; p = p.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"h-loudness/").entries.do({ arg path; h = h.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"nslices/").entries.do({ arg path; t = t.add(CSVFileReader.read(path.fullPath)).asArray; });
};
////////////////////////////////////////////////////////
~averager = r {
	l.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat.dbamp.squared + total;
			});
			avg = total / item.size;
			l[outeri][ini] = Array.with([avg.sqrt.ampdb]);
		});
	});
	p.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat.dbamp.squared + total;
			});
			avg = total / item.size;
			p[outeri][ini] = Array.with([avg.sqrt.ampdb]);
		});
	});
	h.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat.dbamp.squared + total;
			});
			avg = total / item.size;
			h[outeri][ini] = Array.with([avg.sqrt.ampdb]);
		});
	});
};
////////////////////////////////////////////////////////
~l_indexer = r { var dex, cnt, size;
	cnt = -1; dex = Array.new;
	l.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var test, ini;
			ini = i;
			item.size.do({ arg i;
				dex = (dex++[[outeri, ini]]);
				cnt = cnt + 1;
				test = item[i][0].asFloat;
				case
				{ test.asFloat.inclusivelyBetween(-4, 10) } { ~d1.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-8, -4) } { ~d2.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-12, -8) } { ~d3.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-16, -12) } { ~d4.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-20, -16) } { ~d5.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-24, -20) } { ~d6.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-28, -24) } { ~d7.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-32, -28) } { ~d8.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-36, -32) } { ~d9.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-40, -36) } { ~d10.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-44, -40) } { ~d11.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-500, -44) } { ~d12.add(cnt) };
				case
				{ outeri.asFloat.inclusivelyBetween(432, 456) } { ~specbag_1.add(cnt) }
				{ outeri.asFloat.inclusivelyBetween(645, 651) } { ~specbag_2.add(cnt) }
				{ outeri.asFloat.inclusivelyBetween(671, 778) } { ~specbag_3.add(cnt) };
			});
		});
	});
	~sdex = ~sdex++dex;
};
////////////////////////////////////////////////////////
~ph_indexer = r { var cnt, test;
	cnt = -1;
	p.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var perc, harm, ini;
			ini = i;
			item.size.do({ arg i;
				cnt = cnt + 1;
				perc = item[i][0].asFloat;
				harm = h[outeri][ini][0][0].asFloat;
				test = ((perc/harm)-1)*100;
				case
				{ test.asFloat.inclusivelyBetween(250, 500) } { ~ph1.add(cnt) }
				{ test.asFloat.inclusivelyBetween(200, 250) } { ~ph2.add(cnt) }
				{ test.asFloat.inclusivelyBetween(150, 200) } { ~ph3.add(cnt) }
				{ test.asFloat.inclusivelyBetween(100, 150) } { ~ph4.add(cnt) }
				{ test.asFloat.inclusivelyBetween(50, 100) } { ~ph5.add(cnt) }
				{ test.asFloat.inclusivelyBetween(0, 50) } { ~ph6.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-50, 0) } { ~ph7.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-100, -50) } { ~ph8.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-150, -100) } { ~ph9.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-200, -150) } { ~ph10.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-250, -200) } { ~ph11.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-500, -250) } { ~ph12.add(cnt) };
			});
		});
	});
};
////////////////////////////////////////////////////////
~length_indexer = r { var cnt, test;
	cnt = -1;
	t.do({ arg val, i;
		val[0].do({ arg item, i;
			if( i == 0, {
				~nib = nil;
			}, {
				cnt = cnt + 1;
				test = (item.asFloat-val[0][i-1].asFloat)/44100;
				case
				{ test.inclusivelyBetween(0, 0.1) } { ~le1.add(cnt) }
				{ test.inclusivelyBetween(0.1, 0.2) } { ~le2.add(cnt) }
				{ test.inclusivelyBetween(0.2, 0.4) } { ~le3.add(cnt) }
				{ test.inclusivelyBetween(0.4, 0.7) } { ~le4.add(cnt) }
				{ test.inclusivelyBetween(0.7, 1.2) } { ~le5.add(cnt) }
				{ test.inclusivelyBetween(1.2, 2.0) } { ~le6.add(cnt) }
				{ test.inclusivelyBetween(2.0, 3.3) } { ~le7.add(cnt) }
				{ test.inclusivelyBetween(3.3, 5.4) } { ~le8.add(cnt) }
				{ test.inclusivelyBetween(5.4, 8.8) } { ~le9.add(cnt) }
				{ test.inclusivelyBetween(8.8, 14.3) } { ~le10.add(cnt) }
				{ test.inclusivelyBetween(14.3, 23.4) } { ~le11.add(cnt) }
				{ test.inclusivelyBetween(23.4, 300) } { ~le12.add(cnt) };
			});
		});
	});
};

////////////////////////////////////////////////////////
~startup = r {
	~csvload.play; ~averager.play; ~l_indexer.play; ~ph_indexer.play; ~length_indexer.play;
	////////////////////////////////bag check
	~bagcheck = r { var thebag;
		thebag = Set.new;
		thebag = ~dynbag.asSet & ~phbag.asSet;
		thebag = thebag & ~lebag.asSet;
		thebag.size.postln;
		~viscsgui.sendMsg("/bag", thebag.size);
		if( thebag.asBag.size == 0,
			{ ~nib = nil },
			{ ~activebag = thebag.asBag; }
		);
	};
	~specbagcheck = r { arg inval; var thebag;
		thebag = Array.new;
		thebag = thebag++inval.asArray;
		thebag.size.postln;
		~viscsgui.sendMsg("/bag", thebag.size);
		if( thebag.asBag.size == 0,
			{ ~nib = nil },
			{ ~activebag = thebag.asBag; }
		);
	};
	////////////////////////////////dyn bag
	~dyn_bagkiller = r { arg inval; var newbag;
		newbag = Bag.new;
		newbag = newbag++inval.asArray;
		~dynbag = newbag.asBag;
		~bagcheck.reset.play;
	};
	~dyn_bagfiller = r { arg inval; var thebag;
		thebag = ~dynbag.asArray;
		thebag = thebag++inval.asArray;
		~dynbag = thebag.asBag;
		~bagcheck.reset.play;
	};
	~dyn_bagcleaner = r { arg inval; var thebag;
		thebag = ~dynbag.asArray;
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		~dynbag = thebag.asBag;
		~bagcheck.reset.play;
	};
	/////////////////////////////////ph bag
	~ph_bagkiller = r { arg inval; var newbag;
		newbag = Bag.new;
		newbag = newbag++inval.asArray;
		~phbag = newbag.asBag;
		~bagcheck.reset.play;
	};
	~ph_bagfiller = r { arg inval; var thebag;
		thebag = ~phbag.asArray;
		thebag = thebag++inval.asArray;
		~phbag = thebag.asBag;
		~bagcheck.reset.play;
	};
	~ph_bagcleaner = r { arg inval; var thebag;
		thebag = ~phbag.asArray;
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		~phbag = thebag.asBag;
		~bagcheck.reset.play;
	};
	/////////////////////////////////le bag
	~le_bagkiller = r { arg inval; var newbag;
		newbag = Bag.new;
		newbag = newbag++inval.asArray;
		~lebag = newbag.asBag;
		~bagcheck.reset.play;
	};
	~le_bagfiller = r { arg inval; var thebag;
		thebag = ~lebag.asArray;
		thebag = thebag++inval.asArray;
		~lebag = thebag.asBag;
		~bagcheck.reset.play;
	};
	~le_bagcleaner = r { arg inval; var thebag;
		thebag = ~lebag.asArray;
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		~lebag = thebag.asBag;
		~bagcheck.reset.play;
	};
	/////////////////////////////////ambisonic pan state
	~ambisonic_panstate = r { arg bob; var bag;
		bag = Bag.new;
		case
		{ ~am1 == 1 } { bag++[[-1.25, -0.75]] };
		case
		{ ~am2 == 1 } { bag++[[-0.75, -0.25]] };
		case
		{ ~am3 == 1 } { bag++[[-0.25, 0.25]] };
		case
		{ ~am4 == 1 } { bag++[[0.25, 0.75]] };
		~ambag = bag;
	};
	/////////////////////////////////DEF
	SynthDef.new(\p, { arg amp=0.2, out, mout, plo=(-1.0), phi=1.0, buf, start, end; var bsr ,dur, env, sig, ptr, w, x, y;
		bsr = BufSampleRate.kr(buf);
		dur =  ((((end - 5) - start).abs)/bsr);
		ptr = Line.ar(start, (end - 5), dur, doneAction:2);
		sig = BufRd.ar(1, buf, ptr);
		sig = sig * EnvGen.kr(Env([0, 1, 1, 0], [(dur/100), (dur-(dur/5)-(dur/100)), (dur/5)]));
		sig = sig * amp;
		Out.ar(mout, sig);
		Out.ar(out, PanB2.ar(sig, Rand(plo,phi).wrap(-1,1)));
	}).add;
	SynthDef.new(\bgate, { arg in, out, gate, fade=0.5; var amp, w, x, y;
		#w, x, y = In.ar(in, 3);
		amp = EnvGate.new(0, gate, fade, 0);
		w = w * amp;
		x = x * amp;
		y = y * amp;
		Out.ar(out, [w, x, y]);
	}).add;
	SynthDef.new(\gate, { arg in, out, gate, fade=0.5; var sig;
		sig = In.ar(in) * EnvGate.new(0, gate, fade, 0);
		Out.ar(out, sig);
	}).add;
	SynthDef.new(\decode, { arg in; var w,x,y,a,b,c,d;
		#w, x, y = In.ar(in, 3);
		#a, b, c, d = DecodeB2.ar(4, w, x, y);
		Out.ar(0, [a, b, d, c]);
	}).add;
	SynthDef.new(\mic, { arg out, gate, fade=0.5; var sig;
		sig = SoundIn.ar * EnvGate.new(0, gate, fade, 0);
		Out.ar(out, sig);
	}).add;
	SynthDef.new(\analyzer, { arg in, amp=0.5, out; var sig;
		sig = FluidSines.ar(In.ar(in);, detectionThreshold:-30,minTrackLen:2,windowSize:8192,fftSize: 8192)[0];
		sig = sig * amp;
		Out.ar(out, sig);
	}).add;
	SynthDef.new(\verb, { arg in, out, mix=0.5, dec=15, predel=0.03, lpf=1500; var sig, wet;
		sig = In.ar(in);
		wet = DelayN.ar(sig, 0.1, predel);
		wet = 4.collect({
			CombC.ar(wet, 0.1, LFNoise1.kr(0.02).exprange(0.01, 0.02), dec)
		});
		wet = LPF.ar(wet, lpf);
		sig = sig.blend(wet, mix) * 0.2;
		Out.ar(out, sig);
	}).add;
	SynthDef.new(\bmake, { arg in, out, gate, fade=0.3; var sig, aw, ax, ay, bw, bx, by, cw, cx, cy, dw, dx, dy;
		sig = In.ar(in) * EnvGate.new(0, gate, fade, 0);
		#aw, ax, ay = PanB2.ar(sig, 0);
		#bw, bx, by = PanB2.ar(sig, 0.5);
		#cw, cx, cy = PanB2.ar(sig, (-0.5));
		#dw, dx, dy = PanB2.ar(sig, 1);
		Out.ar(out, [(aw+bw+cw+dw),(ax+bx+cx+dx),(ay+by+cy+dy)]);
	}).add;
	SynthDef.new(\compresso, { arg in, out, out2, thresh, ratio, clamp=0.01, relax=0.5; var sig;
		ratio = ratio.reciprocal;
		sig = In.ar(in);
		sig = Compander.ar(sig, sig, thresh, 1, ratio, clamp, relax);
		Out.ar(out, sig);
		Out.ar(out2, sig);
	}).add;
	SynthDef.new(\strip, { arg in, out, mul; var sig;
		sig = In.ar(in);
		Out.ar(out, Pan2.ar(sig, 0, mul));
	}).add;
	////////////////////////////////////////DEF-Handler
	x = { arg inval; var spos, epos, hilo; //handles creating new synths.
		if( inval.isNil,
			{ "nilval".postln },
			{
				spos = t[inval[0]][0][inval[1]];
				epos = t[inval[0]][0][inval[1] + 1];
				if( spos.isNil.or(epos.isNil),
					{ "nilval".postln },
					{
						(inval.asString ++ ": " ++ spos ++ " -> " ++ epos ++ " \n").post;
						Synth.new(\p, [
							\buf, inval[0],
							\start, spos.asInteger, \end, epos.asInteger,
							\out, ~instbus, \mout, ~instdspbus,
							\plo, ~hilo[1], \phi, ~hilo[0]]);
					}
				);
			});
	};
	///////////////////////////////////////OSC-
	///////////////////////////////////////////load Buffers and notify controller
	s.waitForBoot({
		PathName(~corpus++"wav/").entries.do({ arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
		});
		~dspgroup = Group.new(s.defaultGroup, \addAfter);
		~analyzergroup = Group.new(~dspgroup);
		~verbgroup = Group.new(~analyzergroup, \addAfter);
		~todspbus = Bus.audio(s, 1);
		~toanalysisbus = Bus.audio(s, 1);
		~todiroutbus = Bus.audio(s, 1);
		~instdspbus = Bus.audio(s, 1);
		~instbus = Bus.audio(s, 3);
		~verbbus = Bus.audio(s, 1);
		~toverbbus = Bus.audio(s, 1);
		~dspbus = Bus.audio(s, 1);
		~outbus = Bus.audio(s, 3);
		~microphone = Synth.new(\mic, [\out, ~todspbus], s.defaultGroup, \addBefore);
		~compressor = Synth.new(\compresso, [\in, ~todspbus, \out, ~toanalysisbus, \out2, ~todiroutbus, \thresh, 0.6, \ratio, 3], ~dspgroup);
		~dirout = Synth.new(\strip, [\in, ~todiroutbus, \out, 0, \mul, 0.6], ~dspgroup, \addAfter);
		~instgate = Synth.new(\bgate, [\in, ~instbus, \out, ~outbus], ~dspgroup, \addBefore);
		~instdspgate = Synth.new(\gate, [\in, ~instdspbus, \out, ~toanalysisbus], ~dspgroup, \addBefore);
		~analyzer = Synth.new(\analyzer, [\in, ~toanalysisbus, \out, ~verbbus], ~analyzergroup);
		~preverbgate = Synth.new(\gate, [\in, ~verbbus, \out, ~toverbbus], ~analyzergroup, \addAfter);
		~verber = Synth.new(\verb, [\in, ~toverbbus, \out, ~dspbus], ~verbgroup);
		~dspb = Synth.new(\bmake, [\in, ~dspbus, \out, ~outbus], ~dspgroup, \addToTail);
		~decoder = Synth.new(\decode, [\in, ~outbus], ~dspgroup, \addAfter);
	});
	/////////////////////////////////////////////////////
	~j = {
		arg val;
		("AppClock.play(r {"
			++ val ++ ".do({
			var ind, hilo;
			~hilo = ~ambag.choose; ind = ~activebag.choose;"
			++ val ++ ".post;
			x.value(~sdex[ind]);
			Array.fill(30, {arg i; (300.rand/4000)}).choose.wait;
			});
		});").interpret
	};
	~n = {
		arg val;
		("AppClock.play(r {"
			++ val ++ ".do({
			var ind, hilo;
			~hilo = ~ambag.choose; ind = ~activebag.choose;"
			++ val ++ ".post;
			x.value(~sdex[ind]);
			Array.fill(30, {arg i; (300.rand/600)}).choose.wait;
			});
		});").interpret
	};
};
////////////////////////////////////////////////////
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
