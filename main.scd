(".tools/osc-in.scd").loadRelative;
~startup = r {

	~corpus = "/Volumes/SAM-DRIVE/newest-corp/";
	//~corpus = "/home/tuckerj/Library/corpi/newest-corp/";
	//~corpus = "/home/tuckerj/Library/smaller-corp/";

	~viscsgui = NetAddr.new("192.168.1.30", 57120);

	Server.default.options.numOutputBusChannels_(4);
	Server.default.options.memSize_(2.pow(20));
	(".tools/corpus-parse.scd").loadRelative;
	(".tools/bag-functions.scd").loadRelative;
	(".tools/ambisonics.scd").loadRelative;
	(".tools/defs.scd").loadRelative;
	(".tools/spawners.scd").loadRelative;
b[

	s.waitForBoot({

		PathName(~corpus++"wav/").entries.do({ arg path, i;
			b = b.add(Buffer.readChannel(s, path.fullPath, 0, -1, 0));
		});

		~dsp_out_gate_val = 0;

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

		~microphone = Synth.new(\mic, [\out, ~todspbus], s.defaultGroup, \addBefore);
		~compressor = Synth.new(\compresso, [\in, ~todspbus, \out, ~toanalysisbus, \out2, ~todiroutbus, \thresh, 0.6, \ratio, 3], ~dspgroup);
		~dirout = Synth.new(\strip, [\in, ~todiroutbus, \out, 0, \mul, 0.6], ~dspgroup, \addAfter);
		~instgate = Synth.new(\bgate, [\in, ~instbus, \out, ~outbus], ~dspgroup, \addBefore);
		~instdspgate = Synth.new(\gate, [\in, ~instdspbus, \out, ~toanalysisbus], ~dspgroup, \addBefore);
		~analyzer = Synth.new(\analyzer, [\in, ~toanalysisbus, \out, ~verbbus], ~analyzergroup);
		~preverbgate = Synth.new(\gate, [\in, ~verbbus, \out, ~toverbbus], ~analyzergroup, \addAfter);
		~verber = Synth.new(\verb, [\in, ~toverbbus, \out, ~dspbus], ~verbgroup);
		~dspb = Synth.new(\bmake, [\in, ~dspbus, \out, ~outbus], ~dspgroup, \addToTail);
		~decoder = Synth.new(\decode, [\in, ~outbus], ~dspgroup, \addAfter);
	});

};
