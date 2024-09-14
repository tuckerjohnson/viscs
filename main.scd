("tools/osc-in.scd").loadRelative;
~startup = r {

    //~corpus = "/home/tuckerj/Documents/audioLib/saxophone-sample/";
    ~corpus = "/home/tuckerj/Documents/REAPER Media/sound libraries/Sound Lib 20240425/";

    ~viscsgui = NetAddr.new("127.0.0.1", 57120);

    Server.default.options.numOutputBusChannels_(12);
    Server.default.options.memSize = 2.pow(20);
    Server.default.options.numWireBufs = 2.pow(9);
    ("tools/corpus-parse.scd").loadRelative;
    ("tools/bag-functions.scd").loadRelative;
    ("tools/synthDefinitions.scd").loadRelative;
    ("tools/spawners.scd").loadRelative;

    s.waitForBoot({

        PathName(~corpus++"wav/").entries.do({ arg path, i;
            b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
        });

        ~dsp_out_gate_val = 0;
        ~currentPitch = 60;

        ~inputGroup = Group.new(s.defaultGroup, \addBefore);
        ~outputGroup = Group.new(s.defaultGroup, \addAfter);
        ~effectsGroup = Group.new(~outputGroup, \addBefore);
        ~effectsManagementGroup = Group.new(~effectsGroup, \addBefore);
        ~analysisGroup = Group.new(~effectsManagementGroup, \addBefore);
        ~sourceManagementGroup = Group.new(~analysisGroup, \addBefore);

        ~toManagementBus = Bus.audio(s, 1);
        ~toAnalysisBus = Bus.audio(s, 1);
        ~sineBus = Bus.audio(s, 1);
        ~sineToEffectsBus = Bus.audio(s, 1);
        ~toSingleSBBus = Bus.audio(s, 1);
        ~singleSBToConvBus = Bus.audio(s, 1);
        ~sampleBus = Bus.audio(s, 3);
        ~effectsBus = Bus.audio(s, 1);
        ~outBus = Bus.audio(s, 3);

        ~microphone = Synth.new(\microphone, [\out, ~toManagementBus], ~inputGroup);
        ~pitchDesciption = Synth.new(\pitchDescriptor, [\in, ~toManagementBus], ~analysisGroup);
        ~compressor = Synth.new(\compressor, [\in, ~toManagementBus, \out, ~toAnalysisBus, \out2, ~toSingleSBBus, \thresh, 0.6, \ratio, 3], ~sourceManagementGroup);
        //~dirout = Synth.new(\channelStrip, [\in, ~todiroutbus, \out, 0, \mul, 0.6], ~dspgroup, \addAfter);
        ~instgate = Synth.new(\gateFirstOrder, [\in, ~sampleBus, \out, ~outBus], ~sourceManagementGroup);
        ~analyzer = Synth.new(\fluidSines, [\in, ~toAnalysisBus, \out, ~sineBus], ~analysisGroup);
        ~preverbgate = Synth.new(\gate, [\in, ~sineBus, \out, ~sineToEffectsBus], ~effectsManagementGroup);
        ~verber = Synth.new(\reverb, [\in, ~sineToEffectsBus, \out, ~effectsBus], ~effectsGroup);
        ~dspb = Synth.new(\bmake, [\in, ~effectsBus, \out, ~outBus], ~outputGroup, \addToHead);
        ~decoder = Synth.new(\decoderFirstOrder, [\in, ~outBus], ~outputGroup, \addToTail);

        OSCFunc(
            {
                arg msg;
                if (msg[4] > 0.9) {
                    ~currentPitch = msg[3];
                    //msg[3].round(0.01).postln;
                } {
                    ~nib = nil;
                };
            },
            "/pitchDescriptor"
        );

    });

};

~startup.run;


s.plotTree;

(
var notes, on, off;
MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);    // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    if( chan == 3,
		{
            notes[num] = Synth(\freqShifter, [\pitch, num.midicps, \out, ~effectsBus], ~analysisGroup);
            num.postln;
        },
		{ ~nib = nil }
	);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    if( chan == 3,
		{ notes[num].set(\gate,0); notes[num].release; },
		{ ~nib = nil }
	);
});

q = { on.free; off.free; };
)
