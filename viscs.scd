
b = Array.new;
t = Array.new;
l = Array.new;
h = Array.new;
p = Array.new;
~d1 = Bag.new; ~d2 = Bag.new; ~d3 = Bag.new; ~d4 = Bag.new; ~d5 = Bag.new; ~d6 = Bag.new;
~d7 = Bag.new; ~d8 = Bag.new; ~d9 = Bag.new; ~d10 = Bag.new; ~d11 = Bag.new; ~d12 = Bag.new;
~corpus = "/home/tuckerj/Library/test-corp/";
~csvload = r {
	PathName(~corpus++"loudness/").entries.do({ arg path; l = l.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"p-loudness/").entries.do({ arg path; p = p.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"h-loudness/").entries.do({ arg path; h = h.add(CSVFileReader.read(path.fullPath)).asArray; });
	PathName(~corpus++"tslices/").entries.do({ arg path; t = t.add(CSVFileReader.read(path.fullPath)).asArray; });
};
~averager = r {
	l.do({
		arg val, i;
		var outeri;
		outeri = i;
		val.do({
			arg item, i;
			var total=0.0, avg, ini;
			ini = i;
			item.size.do({
				arg i;
				total = item[i].asFloat + total;
			});
			avg = total / item.size;
			l[outeri][ini] = Array.with([avg])
		});
	});

	p.do({
		arg val, i;
		var outeri;
		outeri = i;
		val.do({
			arg item, i;
			var total=0.0, avg, ini;
			ini = i;
			item.size.do({
				arg i;
				total = item[i].asFloat + total;
			});
			avg = total / item.size;
			p[outeri][ini] = Array.with([avg])
		});
	});

	h.do({
		arg val, i;
		var outeri;
		outeri = i;
		val.do({
			arg item, i;
			var total=0.0, avg, ini;
			ini = i;
			item.size.do({
				arg i;
				total = item[i].asFloat + total;
			});
			avg = total / item.size;
			h[outeri][ini] = Array.with([avg])
		});
	});
};
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
~startup = r {
	~csvload.play;
	~averager.play;

	l.do({
		arg val, i;
		var outeri;
		outeri = i;
		val.do({
			arg item, i;
			var test, ini;
			ini = i;
			item.size.do({
				arg i;
				test = item[i][0].asFloat;
				case
				{ test.asFloat.exclusivelyBetween(-3.33, 10) } { ~d1.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-6.66, -3.33) } { ~d2.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-10, -6.66) } { ~d3.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-13.33, 10) } { ~d4.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-16.66, -13.33) } { ~d5.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-20, -16.66) } { ~d6.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-23.33, -20) } { ~d7.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-26.66, -23.33) } { ~d8.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-30, -26.66) } { ~d9.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-33.33, -30) } { ~d10.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-36.66, -33.33) } { ~d11.add([outeri, ini, i]) }
				{ test.asFloat.exclusivelyBetween(-100, -36.66) } { ~d12.add([outeri, ini, i]) };
			});
		});
	});

	~bagkiller = r {
		arg inval;
		var newbag;
		newbag = Array.new;
		inval.postln;
		newbag = newbag++inval.asArray;
		newbag.postln;
		~activebag = newbag;
	};

	~bagfiller = r {
		arg inval;
		var thebag;
		inval.postln;
		thebag = ~activebag;
		thebag = thebag++inval.asArray;
		thebag.postln;
		~activebag = thebag;
	};

	SynthDef.new(\p, {
		arg amp=1, out=0, buf, start, end;
		var sig, ptr;
		ptr = Line.ar(start, (end - 100), ((((end - 100) - start).abs)/BufSampleRate.kr(buf)), doneAction:2);
		sig = BufRd.ar(1, buf, ptr);
		sig = sig * amp;
		Out.ar(out, sig.dup;);
	}).add;

	x = r {
		arg inval;
		var spos, epos;
		spos = t[inval[0]][0][inval[1]];
		epos = t[inval[0]][0][inval[1] + 1];
		(inval.asString ++ ": " ++ spos ++ " -> " ++ epos ++ " \n").post;
		Synth.new(\p, [\buf, inval[0], \start, spos.asInteger, \end, epos.asInteger]).yield;
	};

	z = r {
		40.rand.do({
			x.reset.value(~activebag.choose);
			Array.fill(30, {arg i; (300.rand/6000)}).choose.wait;
		});
	};

	y = r {
		7.rand.do({
			x.reset.value(~activebag.choose);
			Array.fill(30, {arg i; (300.rand/6000)}).choose.wait;
		});
	};

	w = r {
		(20.rand+20).do({
			arg val;
			val.post;
			x.reset.value(~activebag.choose);
			Array.fill(30, {arg i; (300.rand/400)}).choose.wait;
		});
	};

	s.waitForBoot({
		PathName(~corpus++"wav/").entries.do({
			arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
		});
	});

	OSCdef.new(\viscstrig, {
		arg msg;
		case
		{ msg[1] == 1 } { w.reset.play }
		{ msg[1] == 2 } { z.reset.play }
		{ msg[1] == 3 } { y.reset.play };
	};, '/trig');

		OSCdef.new(\viscsdyn, {
		arg msg;
		case
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
	};, '/dyn');

};
