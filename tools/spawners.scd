~sampleSpawner = { arg inval; var spos, epos, hilo; //handles creating new synths.
	if( inval.isNil,
		{ "nil inval".postln },
		{
			spos = t[inval[0]][0][inval[1]];
			epos = t[inval[0]][0][inval[1] + 1];
			if( spos.isNil.or(epos.isNil),
				{ "nil position".postln },
				{
					(inval.asString ++ ": " ++ spos ++ " -> " ++ epos ++ " \n").post;
					Synth.new(\hoa_samplePlayer, [
						\buf, inval[0],
						\start, spos.asInteger, \end, epos.asInteger,
						\out, ~sampleBus, \mout, 800,
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
		~sampleSpawner.value(~sdex[ind]);
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
		~sampleSpawner.value(~sdex[ind]);
		Array.fill(30, {arg i; (300.rand/600)}).choose.wait;
		});
	});").interpret
};

~diatonicPluckMaker = {
	arg val;
	var newPitches;
	newPitches = Scale.major.degrees.drop(1).scramble.keep(2) + val[0];
	Synth.new(\pluckChord,
		[
			\midiPitch, val[0],
			\arpeggio, val[1],
			\pitchA, newPitches[0],
			\pitchB, newPitches[1]
		]
	);
}
