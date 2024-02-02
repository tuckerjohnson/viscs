SynthDef.new(
	\samplePlay,
	{
		arg amp=0.2, out, mout, plo=(-1.0), phi=1.0, buf, start, end;
		var bsr ,dur, env, sig, ptr, w, x, y;
		bsr = BufSampleRate.kr(buf);
		dur =  ((((end - 5) - start).abs)/bsr);
		ptr = Line.ar(start, (end - 5), dur, doneAction:2);
		sig = BufRd.ar(1, buf, ptr);
		sig = sig * EnvGen.kr(Env([0, 1, 1, 0], [(dur/100), (dur-(dur/5)-(dur/100)), (dur/5)]));
		sig = sig * amp;
		Out.ar(mout, sig);
		Out.ar(out, PanB2.ar(sig, Rand(plo,phi).wrap(-1,1)));
	}
).add;

SynthDef("pitchDescriptor",
	{
		arg in, windowSize = 4096;
		var sig, freq, conf, latency, env, newSig;
		latency = windowSize / SampleRate.ir;
		sig = SoundIn.ar(in);
		# freq, conf = FluidPitch.kr(sig, unit:1, windowSize:windowSize);
		SendReply.kr(Impulse.kr(10), '/pitchDescriptor', [freq, conf]);
	}
).add;

SynthDef("pluckChord",
	{
		arg midiPitch, out = 0, arpeggio = 1, pitchA, pitchB;
		var signal;
		pitchB = pitchB-12;
		EnvGen.kr(Env.new([0, 0], [11, arpeggio * 1]), 1, 1, 1, 1, 2);
		signal = Mix.ar(
			[
				DelayC.ar(
					Pluck.ar(PinkNoise.ar, 1, midiPitch.midicps.reciprocal, midiPitch.midicps.reciprocal, 10),
					(0.5 * arpeggio),
					(0.5 * arpeggio)
				),
				DelayC.ar(
					Pluck.ar(PinkNoise.ar, 1, pitchA.midicps.reciprocal, pitchA.midicps.reciprocal, 10),
					(1 * arpeggio),
					(1 * arpeggio)
				),
				Pluck.ar(PinkNoise.ar, 1, pitchB.midicps.reciprocal, pitchB.midicps.reciprocal, 10)
		]);
		Out.ar(out, signal*0.5)
	}
).add;

SynthDef.new(\gateFirstOrder, {
	arg in, out, gate, fade=0.5;
	var amp, w, x, y;
	#w, x, y = In.ar(in, 3);
	amp = EnvGate.new(0, gate, fade, 0);
	w = w * amp;
	x = x * amp;
	y = y * amp;
	Out.ar(out, [w, x, y]);
}).add;

SynthDef.new(\gate, {
	arg in, out, gate, fade=0.5;
	var sig;
	sig = In.ar(in) * EnvGate.new(0, gate, fade, 0);
	Out.ar(out, sig);
}).add;

SynthDef.new(\decoderFirstOrder, {
	arg in;
	var w,x,y,a,b,c,d;
	#w, x, y = In.ar(in, 3);
	#a, b, c, d = DecodeB2.ar(4, w, x, y);
	Out.ar(0, [a, b, d, c]);
}).add;

SynthDef.new(\microphone, {
	arg out, gate, fade=0.5;
	var sig;
	sig = SoundIn.ar * EnvGate.new(0, gate, fade, 0);
	Out.ar(out, sig);
}).add;

SynthDef.new(\fluidSines, {
	arg in, amp=0.5, out;
	var sig;
	sig = FluidSines.ar(In.ar(in);, detectionThreshold:-30,minTrackLen:2,windowSize:8192,fftSize: 8192)[0];
	sig = sig * amp;
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out, mix=0.5, dec=15, predel=0.03, lpf=1500;
	var sig, wet;
	sig = In.ar(in);
	wet = DelayN.ar(sig, 0.1, predel);
	wet = 4.collect({
		CombC.ar(wet, 0.1, LFNoise1.kr(0.02).exprange(0.01, 0.02), dec)
	});
	wet = LPF.ar(wet, lpf);
	sig = wet * 0.2;
	Out.ar(out, sig);
}).add;

SynthDef.new(\bmake, {
	arg in, out, gate, fade=0.3;
	var sig, aw, ax, ay, bw, bx, by, cw, cx, cy, dw, dx, dy;
	sig = In.ar(in) * EnvGate.new(0, gate, fade, 0);
	#aw, ax, ay = PanB2.ar(sig, 0);
	#bw, bx, by = PanB2.ar(sig, 0.5);
	#cw, cx, cy = PanB2.ar(sig, (-0.5));
	#dw, dx, dy = PanB2.ar(sig, 1);
	Out.ar(out, [(aw+bw+cw+dw),(ax+bx+cx+dx),(ay+by+cy+dy)]);
}).add;

SynthDef.new(\compressor, {
	arg in, out, out2, thresh, ratio, clamp=0.01, relax=0.5;
	var sig;
	ratio = ratio.reciprocal;
	sig = In.ar(in);
	sig = Compander.ar(sig, sig, thresh, 1, ratio, clamp, relax);
	Out.ar(out, sig);
	Out.ar(out2, sig);
}).add;

SynthDef.new(\channelStrip, {
	arg in, out, mul;
	var sig;
	sig = In.ar(in);
	Out.ar(out, Pan2.ar(sig, 0, mul));
}).add;