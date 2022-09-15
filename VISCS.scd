~corpus = "/home/tuckerj/Lib/smaller-corp/";
b = Array.new; t = Array.new; l = Array.new; h = Array.new; p = Array.new;
~sdex = Array.new;
~d1 = Bag.new; ~d2 = Bag.new; ~d3 = Bag.new; ~d4 = Bag.new; ~d5 = Bag.new; ~d6 = Bag.new;
~d7 = Bag.new; ~d8 = Bag.new; ~d9 = Bag.new; ~d10 = Bag.new; ~d11 = Bag.new; ~d12 = Bag.new;
~ph1 = Bag.new; ~ph2 = Bag.new; ~ph3 = Bag.new; ~ph4 = Bag.new; ~ph5 = Bag.new; ~ph6 = Bag.new;
~ph7 = Bag.new; ~ph8 = Bag.new; ~ph9 = Bag.new; ~ph10 = Bag.new; ~ph11 = Bag.new; ~ph12 = Bag.new;
~csvload = r {
	PathName(~corpus++"loudness/").entries.do({ arg path; l = l.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"p-loudness/").entries.do({ arg path; p = p.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"h-loudness/").entries.do({ arg path; h = h.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"nslices/").entries.do({ arg path; t = t.add(CSVFileReader.read(path.fullPath)).asArray; });
};
~averager = r {
	l.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat + total;
			});
			avg = total / item.size; l[outeri][ini] = Array.with([avg])
		});
	});
	p.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat + total;
			});
			avg = total / item.size; p[outeri][ini] = Array.with([avg])
		});
	});
	h.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat + total;
			});
			avg = total / item.size; h[outeri][ini] = Array.with([avg])
		});
	});
};
~l_indexer = r { var dex, cnt, size;
	cnt = 0; dex = Array.new;
	l.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var test, ini;
			ini = i;
			item.size.do({ arg i;
				dex = (dex++[[outeri, ini]]);
				cnt = cnt + 1;
				test = item[i][0].asFloat;
				case
				{ test.asFloat.inclusivelyBetween(-3.33, 10) }      { ~d1.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-6.66, -3.33) }   { ~d2.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-10, -6.66) }     { ~d3.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-13.33, 10) }     { ~d4.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-16.66, -13.33) } { ~d5.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-20, -16.66) }    { ~d6.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-23.33, -20) }    { ~d7.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-26.66, -23.33) } { ~d8.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-30, -26.66) }    { ~d9.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-33.33, -30) }    { ~d10.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-36.66, -33.33) } { ~d11.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-500, -36.66) }   { ~d12.add(cnt) };
			});
		});
	});
	~sdex = ~sdex++dex;
};
~ph_avg = r { var cnt, mean, pmost, pleast, hmost, hleast;
	mean = Array.new; pleast = 0; pmost = -100; hleast = 0; hmost = -100;
	cnt = 0;
	p.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var perc, harm, ini;
			ini = i;
			item.size.do({ arg i;
				cnt = cnt + 1;
				perc = item[i][0].asFloat;
				harm = h[outeri][ini][0][0].asFloat;
				mean = ((perc/harm)-1)*100;
				mean.postln;
			});
		});
	});
	p.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var perc, harm, ini;
			ini = i;
			item.size.do({ arg i;
				cnt = cnt + 1;

			});
		});
	});
};
~ph_avg.play;
~startup = r {
	~csvload.play; ~averager.play; ~l_indexer.play;
	////////////////////////////////dyn bag
	~bagkiller = r { arg inval; var newbag;
		newbag = Bag.new; inval.postln;
		newbag = newbag++inval.asArray; newbag.postln;
		~activebag = newbag.asBag;
	};
	~bagfiller = r { arg inval; var thebag;
		inval.postln;
		thebag = ~activebag.asArray;
		thebag = thebag++inval.asArray;
		thebag.postln;
		~activebag = thebag.asBag;
	};
	~bagcleaner = r { arg inval; var thebag;
		inval.postln;
		thebag = ~activebag.asArray;
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.removeEvery(inval.asList);
		thebag.size;
		~activebag = thebag.asBag;
	};
	/////////////////////////////////

	/////////////////////////////////DEF
	SynthDef.new(\p, { arg amp=1, out=0, buf, start, end; var sig, ptr;
		ptr = Line.ar(start, (end - 100), ((((end - 100) - start).abs)/BufSampleRate.kr(buf)), doneAction:2);
		sig = BufRd.ar(1, buf, ptr);
		sig = sig * amp;
		Out.ar(out, sig.dup;);
	}).add;
	////////////////////////////////////////
	x = { arg inval; var spos, epos; //handles creating new synths.
		if( inval == nil,
			{ "nilval".postln },
			{
				spos = t[inval[0]][0][inval[1]];
				epos = t[inval[0]][0][inval[1] + 1];
				(inval.asString ++ ": " ++ spos ++ " -> " ++ epos ++ " \n").post;
				Synth.new(\p, [\buf, inval[0], \start, spos.asInteger, \end, epos.asInteger]);
		});
	};
	////////////////////////////////////////////////////////////////
	s.waitForBoot({
		PathName(~corpus++"wav/").entries.do({ arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
		});
	});

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
	{ msg[1] == 7 } { ~j.value(50+30.rand) }
	{ msg[1] == 8 } { ~n.value(3) }
	{ msg[1] == 9 } { ~n.value(5) }
	{ msg[1] == 10 } { ~n.value(8) }
	{ msg[1] == 11 } { ~n.value(13) }
	{ msg[1] == 12 } { ~n.value(19) }
	};, '/play'
);

OSCdef.new(\viscssel, {
	arg msg;
	case
	{ msg[1] == 0 } { "viscsdyn test".postln }
	{ msg[1] == 1 } { ~bagfiller.reset.value(~d1) }
	{ msg[1] == 2 } { ~bagfiller.reset.value(~d2) }
	{ msg[1] == 3 } { ~bagfiller.reset.value(~d3) }
	{ msg[1] == 4 } { ~bagfiller.reset.value(~d4) }
	{ msg[1] == 5 } { ~bagfiller.reset.value(~d5) }
	{ msg[1] == 6 } { ~bagfiller.reset.value(~d6) }
	{ msg[1] == 7 } { ~bagfiller.reset.value(~d7) }
	{ msg[1] == 8 } { ~bagfiller.reset.value(~d8) }
	{ msg[1] == 9 } { ~bagfiller.reset.value(~d9) }
	{ msg[1] == 10 } { ~bagfiller.reset.value(~d10) }
	{ msg[1] == 11 } { ~bagfiller.reset.value(~d11) }
	{ msg[1] == 12 } { ~bagfiller.reset.value(~d12) }
	{ msg[1] == 13 } { ~bagkiller.reset.value(~d1) }
	{ msg[1] == 14 } { ~bagkiller.reset.value(~d2) }
	{ msg[1] == 15 } { ~bagkiller.reset.value(~d3) }
	{ msg[1] == 16 } { ~bagkiller.reset.value(~d4) }
	{ msg[1] == 17 } { ~bagkiller.reset.value(~d5) }
	{ msg[1] == 18 } { ~bagkiller.reset.value(~d6) }
	{ msg[1] == 19 } { ~bagkiller.reset.value(~d7) }
	{ msg[1] == 20 } { ~bagkiller.reset.value(~d8) }
	{ msg[1] == 21 } { ~bagkiller.reset.value(~d9) }
	{ msg[1] == 22 } { ~bagkiller.reset.value(~d10) }
	{ msg[1] == 23 } { ~bagkiller.reset.value(~d11) }
	{ msg[1] == 24 } { ~bagkiller.reset.value(~d12) }
	{ msg[1] == 25 } { ~bagcleaner.reset.value(~d1) }
	{ msg[1] == 26 } { ~bagcleaner.reset.value(~d2) }
	{ msg[1] == 27 } { ~bagcleaner.reset.value(~d3) }
	{ msg[1] == 28 } { ~bagcleaner.reset.value(~d4) }
	{ msg[1] == 29 } { ~bagcleaner.reset.value(~d5) }
	{ msg[1] == 30 } { ~bagcleaner.reset.value(~d6) }
	{ msg[1] == 31 } { ~bagcleaner.reset.value(~d7) }
	{ msg[1] == 32 } { ~bagcleaner.reset.value(~d8) }
	{ msg[1] == 33 } { ~bagcleaner.reset.value(~d9) }
	{ msg[1] == 34 } { ~bagcleaner.reset.value(~d10) }
	{ msg[1] == 35 } { ~bagcleaner.reset.value(~d11) }
	{ msg[1] == 36 } { ~bagcleaner.reset.value(~d12) }
	};, '/sel'
);
