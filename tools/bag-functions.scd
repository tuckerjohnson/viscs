~bagcheck = r { var thebag;
	thebag = Set.new;
	thebag = ~dynbag.asSet & ~phbag.asSet;
	thebag = thebag & ~lebag.asSet;
	thebag.size.postln;
	~viscsgui.sendMsg("/bag", thebag.size);
	if( thebag.asBag.size == 0,
		{ ~nib = nil },
		{ ~activebag = thebag.asBag; }
	);
};
~specbagcheck = r { arg inval; var thebag;
	thebag = Array.new;
	thebag = thebag++inval.asArray;
	thebag.size.postln;
	~viscsgui.sendMsg("/bag", thebag.size);
	if( thebag.asBag.size == 0,
		{ ~nib = nil },
		{ ~activebag = thebag.asBag; }
	);
};
////////////////////////////////dyn bag
~dyn_bagkiller = r { arg inval; var newbag;
	newbag = Bag.new;
	newbag = newbag++inval.asArray;
	~dynbag = newbag.asBag;
	~bagcheck.reset.play;
};
~dyn_bagfiller = r { arg inval; var thebag;
	thebag = ~dynbag.asArray;
	thebag = thebag++inval.asArray;
	~dynbag = thebag.asBag;
	~bagcheck.reset.play;
};
~dyn_bagcleaner = r { arg inval; var thebag;
	thebag = ~dynbag.asArray;
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	~dynbag = thebag.asBag;
	~bagcheck.reset.play;
};
/////////////////////////////////ph bag
~ph_bagkiller = r { arg inval; var newbag;
	newbag = Bag.new;
	newbag = newbag++inval.asArray;
	~phbag = newbag.asBag;
	~bagcheck.reset.play;
};
~ph_bagfiller = r { arg inval; var thebag;
	thebag = ~phbag.asArray;
	thebag = thebag++inval.asArray;
	~phbag = thebag.asBag;
	~bagcheck.reset.play;
};
~ph_bagcleaner = r { arg inval; var thebag;
	thebag = ~phbag.asArray;
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	~phbag = thebag.asBag;
	~bagcheck.reset.play;
};
/////////////////////////////////le bag
~le_bagkiller = r { arg inval; var newbag;
	newbag = Bag.new;
	newbag = newbag++inval.asArray;
	~lebag = newbag.asBag;
	~bagcheck.reset.play;
};
~le_bagfiller = r { arg inval; var thebag;
	thebag = ~lebag.asArray;
	thebag = thebag++inval.asArray;
	~lebag = thebag.asBag;
	~bagcheck.reset.play;
};
~le_bagcleaner = r { arg inval; var thebag;
	thebag = ~lebag.asArray;
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	thebag.removeEvery(inval.asList);
	~lebag = thebag.asBag;
	~bagcheck.reset.play;
};