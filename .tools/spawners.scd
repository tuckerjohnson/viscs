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