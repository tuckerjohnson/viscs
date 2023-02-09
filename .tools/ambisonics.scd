~ambag = Bag.new;

~ambisonic_panstate = r { arg bob; var bag;
	bag = Bag.new;
	case
	{ ~am1 == 1 } { bag++[[-1.25, -0.75]] };
	case
	{ ~am2 == 1 } { bag++[[-0.75, -0.25]] };
	case
	{ ~am3 == 1 } { bag++[[-0.25, 0.25]] };
	case
	{ ~am4 == 1 } { bag++[[0.25, 0.75]] };
	~ambag = bag;
};