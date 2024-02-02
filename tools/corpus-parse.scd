b = Array.new;
t = Array.new;
l = Array.new;
h = Array.new;
p = Array.new;
~sdex = Array.new;
~d1 = Bag.new; ~d2 = Bag.new; ~d3 = Bag.new; ~d4 = Bag.new; ~d5 = Bag.new; ~d6 = Bag.new;
~d7 = Bag.new; ~d8 = Bag.new; ~d9 = Bag.new; ~d10 = Bag.new; ~d11 = Bag.new; ~d12 = Bag.new;
~ph1 = Bag.new; ~ph2 = Bag.new; ~ph3 = Bag.new; ~ph4 = Bag.new; ~ph5 = Bag.new; ~ph6 = Bag.new;
~ph7 = Bag.new; ~ph8 = Bag.new; ~ph9 = Bag.new; ~ph10 = Bag.new; ~ph11 = Bag.new; ~ph12 = Bag.new;
~le1 = Bag.new; ~le2 = Bag.new; ~le3 = Bag.new; ~le4 = Bag.new; ~le5 = Bag.new; ~le6 = Bag.new;
~le7 = Bag.new; ~le8 = Bag.new; ~le9 = Bag.new; ~le10 = Bag.new; ~le11 = Bag.new; ~le12 = Bag.new;
~spedbag = Bag.new; ~specbag_1 = Bag.new; ~specbag_2 = Bag.new; ~specbag_3 = Bag.new;

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
				total = item[i].asFloat.dbamp.squared + total;
			});
			avg = total / item.size;
			l[outeri][ini] = Array.with([avg.sqrt.ampdb]);
		});
	});
	p.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat.dbamp.squared + total;
			});
			avg = total / item.size;
			p[outeri][ini] = Array.with([avg.sqrt.ampdb]);
		});
	});
	h.do({ arg val, i; var outeri; outeri = i;
		val.do({ arg item, i; var total=0.0, avg, ini; ini = i;
			item.size.do({ arg i;
				total = item[i].asFloat.dbamp.squared + total;
			});
			avg = total / item.size;
			h[outeri][ini] = Array.with([avg.sqrt.ampdb]);
		});
	});
};

~l_indexer = r { var dex, cnt, size;
	cnt = -1; dex = Array.new;
	l.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var test, ini;
			ini = i;
			item.size.do({ arg i;
				dex = (dex++[[outeri, ini]]);
				cnt = cnt + 1;
				test = item[i][0].asFloat;
				case
				{ test.asFloat.inclusivelyBetween(-4, 10) } { ~d1.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-8, -4) } { ~d2.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-12, -8) } { ~d3.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-16, -12) } { ~d4.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-20, -16) } { ~d5.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-24, -20) } { ~d6.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-28, -24) } { ~d7.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-32, -28) } { ~d8.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-36, -32) } { ~d9.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-40, -36) } { ~d10.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-44, -40) } { ~d11.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-500, -44) } { ~d12.add(cnt) };
				case
				{ outeri.asFloat.inclusivelyBetween(432, 456) } { ~specbag_1.add(cnt) }
				{ outeri.asFloat.inclusivelyBetween(645, 651) } { ~specbag_2.add(cnt) }
				{ outeri.asFloat.inclusivelyBetween(671, 778) } { ~specbag_3.add(cnt) };
			});
		});
	});
	~sdex = ~sdex++dex;
};

~ph_indexer = r { var cnt, test;
	cnt = -1;
	p.do({ arg val, i; var outeri;
		outeri = i;
		val.do({ arg item, i; var perc, harm, ini;
			ini = i;
			item.size.do({ arg i;
				cnt = cnt + 1;
				perc = item[i][0].asFloat;
				harm = h[outeri][ini][0][0].asFloat;
				test = ((perc/harm)-1)*100;
				case
				{ test.asFloat.inclusivelyBetween(250, 500) } { ~ph1.add(cnt) }
				{ test.asFloat.inclusivelyBetween(200, 250) } { ~ph2.add(cnt) }
				{ test.asFloat.inclusivelyBetween(150, 200) } { ~ph3.add(cnt) }
				{ test.asFloat.inclusivelyBetween(100, 150) } { ~ph4.add(cnt) }
				{ test.asFloat.inclusivelyBetween(50, 100) } { ~ph5.add(cnt) }
				{ test.asFloat.inclusivelyBetween(0, 50) } { ~ph6.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-50, 0) } { ~ph7.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-100, -50) } { ~ph8.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-150, -100) } { ~ph9.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-200, -150) } { ~ph10.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-250, -200) } { ~ph11.add(cnt) }
				{ test.asFloat.inclusivelyBetween(-500, -250) } { ~ph12.add(cnt) };
			});
		});
	});
};

~length_indexer = r { var cnt, test;
	cnt = -1;
	t.do({ arg val, i;
		val[0].do({ arg item, i;
			if( i == 0, {
				~nib = nil;
			}, {
				cnt = cnt + 1;
				test = (item.asFloat-val[0][i-1].asFloat)/44100;
				case
				{ test.inclusivelyBetween(0, 0.1) } { ~le1.add(cnt) }
				{ test.inclusivelyBetween(0.1, 0.2) } { ~le2.add(cnt) }
				{ test.inclusivelyBetween(0.2, 0.4) } { ~le3.add(cnt) }
				{ test.inclusivelyBetween(0.4, 0.7) } { ~le4.add(cnt) }
				{ test.inclusivelyBetween(0.7, 1.2) } { ~le5.add(cnt) }
				{ test.inclusivelyBetween(1.2, 2.0) } { ~le6.add(cnt) }
				{ test.inclusivelyBetween(2.0, 3.3) } { ~le7.add(cnt) }
				{ test.inclusivelyBetween(3.3, 5.4) } { ~le8.add(cnt) }
				{ test.inclusivelyBetween(5.4, 8.8) } { ~le9.add(cnt) }
				{ test.inclusivelyBetween(8.8, 14.3) } { ~le10.add(cnt) }
				{ test.inclusivelyBetween(14.3, 23.4) } { ~le11.add(cnt) }
				{ test.inclusivelyBetween(23.4, 300) } { ~le12.add(cnt) };
			});
		});
	});
};

~csvload.play;
~averager.play;
~l_indexer.play; //found in corpus-parse.scd
~ph_indexer.play;
~length_indexer.play;