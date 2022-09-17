~corpus = "/run/media/tuckerj/SAM-DRIVE/test-corp/";
b = Array.new; t = Array.new; l = Array.new; h = Array.new; p = Array.new;
~sdex = Array.new;
~d1 = Bag.new; ~d2 = Bag.new; ~d3 = Bag.new; ~d4 = Bag.new; ~d5 = Bag.new; ~d6 = Bag.new;
~d7 = Bag.new; ~d8 = Bag.new; ~d9 = Bag.new; ~d10 = Bag.new; ~d11 = Bag.new; ~d12 = Bag.new;
~ph1 = Bag.new; ~ph2 = Bag.new; ~ph3 = Bag.new; ~ph4 = Bag.new; ~ph5 = Bag.new; ~ph6 = Bag.new;
~ph7 = Bag.new; ~ph8 = Bag.new; ~ph9 = Bag.new; ~ph10 = Bag.new; ~ph11 = Bag.new; ~ph12 = Bag.new;
~le1 = Bag.new; ~le2 = Bag.new; ~le3 = Bag.new; ~le4 = Bag.new; ~le5 = Bag.new; ~le6 = Bag.new;
~le7 = Bag.new; ~le8 = Bag.new; ~le9 = Bag.new; ~le10 = Bag.new; ~le11 = Bag.new; ~le12 = Bag.new;
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
	~csvload.play; ~averager.play; ~l_indexer.play; ~ph_indexer.play; ~le_indexer.play;
	////////////////////////////////bag check
	~bagcheck = r { var thebag;
		thebag = Set.new;
		thebag = ~dynbag.asSet & ~phbag.asSet;
		thebag = thebag & ~lebag.asSet;
		thebag.size.postln;
		~activebag = thebag.asBag;
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
	/////////////////////////////////DEF
	SynthDef.new(\p, { arg amp=1, out=0, buf, start, end; var bsr,dur, env, sig, ptr;
		bsr = BufSampleRate.kr(buf);
		dur =  ((((end - 5) - start).abs)/bsr);
		ptr = Line.ar(start, (end - 5), dur, doneAction:2);
		sig = BufRd.ar(1, buf, ptr);
		sig = sig * EnvGen.kr(Env([0, 1, 1, 0], [(dur/100), (dur-(dur/5)-(dur/100)), (dur/5)]));
		sig = sig * amp;
		Out.ar(out, sig.dup;);
	}).add;
	////////////////////////////////////////DEF-Handler
	x = { arg inval; var spos, epos; //handles creating new synths.
		if( inval.isNil,
			{ "nilval".postln },
			{
				spos = t[inval[0]][0][inval[1]];
				epos = t[inval[0]][0][inval[1] + 1];
				if( spos.isNil.or(epos.isNil),
					{ "nilval".postln },
					{
						(inval.asString ++ ": " ++ spos ++ " -> " ++ epos ++ " \n").post;
						Synth.new(\p, [\buf, inval[0], \start, spos.asInteger, \end, epos.asInteger]);
					}
				);
			});
	};
	///////////////////////////////////////////load Buffers and notify controller
	s.waitForBoot({
		PathName(~corpus++"wav/").entries.do({ arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
		});
	});
	/////////////////////////////////////////////////////
	~j = {
		arg val;
		("AppClock.play(r {"
			++ val ++ ".do({
			var ind;
			ind = ~activebag.choose;"
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
			var ind;
			ind = ~activebag.choose;"
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
	};, '/sel'
);
