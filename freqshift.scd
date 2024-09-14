s.boot;
s.plotTree;
s.meter;
s.freeAll;
s.quit;

MIDIdef.noteOn(\noteOn, {
	arg ...args;
	args.postln;
	Synth.new(\freqShifter, [\pitch, args[1].midicps]);
});



SynthDef.new(\freqShifter, {
	arg freq, amp=1, gate=1;
	var sig, env;
	env = EnvGen.kr(Env.asr(0.01, amp, 2), gate, doneAction:2);
	sig = FreqShift.ar(SoundIn.ar(8, 0.5), freq).dup * env;
	Out.ar(0, sig);
}).add;


(
var notes, on, off;

MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);    // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
	num.postln;
	notes[num] = Synth(\freqShifter, [\pitch, num.midicps]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
	num.postln;
	notes[num].set(\gate,0);
    notes[num].release;
});

q = { on.free; off.free; };
)
