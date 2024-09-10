("tools/osc-in.scd").loadRelative;
~startup = r {

	//~corpus = "/home/tuckerj/Documents/audioLib/saxophone-sample/";
	~corpus = "/home/tuckerj/Documents/audioLib/cur-corp/";

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

		~microphone = Synth.new(\microphone, [\out, ~todspbus], s.defaultGroup, \addBefore);
		~pitchDesciption = Synth.new(\pitchDescriptor, [\in, ~todspbus], ~dspgroup);
		~compressor = Synth.new(\compressor, [\in, ~todspbus, \out, ~toanalysisbus, \out2, ~todiroutbus, \thresh, 0.6, \ratio, 3], ~dspgroup);
		//~dirout = Synth.new(\channelStrip, [\in, ~todiroutbus, \out, 0, \mul, 0.6], ~dspgroup, \addAfter);
		~instgate = Synth.new(\gateFirstOrder, [\in, ~instbus, \out, ~outbus], ~dspgroup, \addBefore);
		~instdspgate = Synth.new(\gate, [\in, ~instdspbus, \out, ~toanalysisbus], ~dspgroup, \addBefore);
		~analyzer = Synth.new(\fluidSines, [\in, ~toanalysisbus, \out, ~verbbus], ~analyzergroup);
		~preverbgate = Synth.new(\gate, [\in, ~verbbus, \out, ~toverbbus], ~analyzergroup, \addAfter);
		~verber = Synth.new(\reverb, [\in, ~toverbbus, \out, ~dspbus], ~verbgroup);
		~dspb = Synth.new(\bmake, [\in, ~dspbus, \out, ~outbus], ~dspgroup, \addToTail);
		~decoder = Synth.new(\decoderFirstOrder, [\in, ~outbus], ~dspgroup, \addAfter);

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
