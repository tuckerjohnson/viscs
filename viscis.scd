(
b = Array.new;
t = Array.new;
l = Array.new;
h = Array.new;
p = Array.new;
~ff = Bag.new;
~f = Bag.new;
~mf = Bag.new;
~mp = Bag.new;
~p = Bag.new;
~pp = Bag.new;
~corpus = "/home/tuckerj/Library/small-test-corp/"
///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
~csvload = r {
	PathName(~corpus++"loudness/").entries.do({
		arg path;
		l = l.add(CSVFileReader.read(path.fullPath)).asArray;
	});

	PathName(~corpus++"p-loudness/").entries.do({
		arg path;
		p = p.add(CSVFileReader.read(path.fullPath)).asArray;
	});

	PathName(~corpus++"h-loudness/").entries.do({
		arg path;
		h = h.add(CSVFileReader.read(path.fullPath)).asArray;
	});

	PathName(~corpus++"tslices/").entries.do({
		arg path;
		t = t.add(CSVFileReader.read(path.fullPath)).asArray;
	});
};
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
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
)
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
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
			{ test.asFloat.exclusivelyBetween(-9, 5) } { ~ff.add([outeri, ini, i]) }
			{ test.asFloat.exclusivelyBetween(-15, -9) } { ~f.add([outeri, ini, i]) }
			{ test.asFloat.exclusivelyBetween(-21, -15) } { ~mf.add([outeri, ini, i]) }
			{ test.asFloat.exclusivelyBetween(-27, -21) } { ~mp.add([outeri, ini, i]) }
			{ test.asFloat.exclusivelyBetween(-35, -27) } { ~p.add([outeri, ini, i]) }
			{ test.asFloat.inclusivelyBetween(-100, -35) } { ~pp.add([outeri, ini, i]) };
		});
	});
});


~bagfiller = r {
	arg inval;
	var thebag;
	thebag = Array.new;
	inval.asArray.postln;
	thebag = thebag++inval.asArray;
	thebag.postln;
	~activebag = thebag;
};

s.boot;

~audio.entries.do({
	arg path, i;
	b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
});


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
	inval.postln;
	spos = t[inval[0]][0][inval[1]];
	epos = t[inval[0]][0][inval[1] + 1];
	(inval.asString ++ ": " ++ spos ++ " -> " ++ epos ++ " ").post;
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
	20.rand.do({
		x.reset.value(~activebag.choose);
		Array.fill(30, {arg i; (300.rand/400)}).choose.wait;
	});
};



z.reset.play;
y.reset.play;
w.reset.play;

~activebag.size;
~bagfiller.reset.value(~pp.asArray);
~bagfiller.reset.value(~p.asArray);
~bagfiller.reset.value(~p.asArray,~mp.asArray);
~bagfiller.reset.value(~mp.asArray);
~bagfiller.reset.value(~mf.asArray);
~bagfiller.reset.value(~f.asArray,~ff.asArray);
