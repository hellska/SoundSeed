// sound seed composition
// an exploration of the spectral space generated using two cellular automata to control the granular synthesis
s.meter;
s.makeGui;
~ciao = Rand.new(0.7);
8.rand;

// Random 8 channel selection - step/channel
(
~readcol = {|col|
	var my2d,bfreq,freq,length,amp,dur,harmonics,synthez,synthid;
	bfreq = ~bsfreq ; // 80;
	harmonics = ~gridside-2;
	freq = List[];
	length = List[];
	amp = List[];
	my2d = Array2D.fromArray(~gridside,~gridside,~cagrid.getNodeStates.flat);
	// dur = rand(~ss_deltadur) + ~ss_mindur;
	dur = ~grain_dur;
	my2d.colAt(col).do{
		|me,idx|
		if (idx>0) { // avoid initial column border
			if (idx<=harmonics) { // avoid end column border
				if (me==1) {

					freq.add(~generalizedserie.value(bfreq,idx + 1,~alpha,~beta,~gamma));

					// freq.add(idx + 1 * bfreq/2);
					// different length for each sine of the column
					// length.add(rand(200) + 50);
					// same length for each sine of the column
					length.add(dur);
					amp.add(~overall_amp/(idx)); // rescale is done inside the synth
				}
			}
		}
	};
	if (freq.size>0) {
		var freqs, amps, outbus;
		freqs = Array.fill(freq.size, {|idx| freq[idx] });
		amps = Array.fill(amp.size, {|idx| amp[idx] });
		synthez = (~synthez++freq.size);
		// random outbus
		outbus = 8.rand;
		Synth(synthez,[\outBus, outbus, \freqs, freqs, \length, dur, \amps, amps, \pan, -1]);
	};
};
)

// set recording channels to export sounds in RT
s.recChannels = 8;

// Fibonacci to compute note length
(
~start1 = 1;
~start2 = 3;
~startn = Array.newClear;
~starttmp = ~startn.add(~start1);
~startn = ~starttmp;
~starttmp = ~startn.add(~start2);
~startn = ~starttmp;
40.do{|idx| var sum;
	sum = ~start1 + ~start2;
	~starttmp = ~startn.add(sum);
	~startn = ~starttmp;
	~start1 = ~start2;
	~start2 = sum;
	// ("Index: "+idx+" value: "+sum).postln;
	// ("STARRT1: "+~start1+" Start2: "+~start2).postln;
};
~startn.postln;
// note duration on reverse spiral
~maxlen = 5.3;
~timetable = Array.newClear;
~startn.do{|val, idx| var time;
//	("Index: "+idx+" Value: "+val).postln;
	time = ~maxlen / val;
	~timetabletmp = ~timetable.add(time);
	~timetable = ~timetabletmp;
};
~timetable.postln;
)

// comoute pan positions
~panarray = Array.newClear;
8.do{|idx| var step, panv;
	step = 2 / 8;
	panv = -1 + (idx * step);
	~panarraytmp = ~panarray.add(panv);
	~panarray = ~panarraytmp;
};
~panarray.postln;
// never in the center array for pan
~panarray = [ -1, -0.75, -0.5, -0.25, 0.25, 0.5, 0.75, 1 ];
~panarray[~panarray.size.rand];


1134903170 + 1836311903;

Index:  44  value:  1836311903
STARRT1:  1134903170  Start2:  1836311903
Index:  45  value:  -1323752223
STARRT1:  1836311903  Start2:  -1323752223
Index:  46  value:  512559680
STARRT1:  -1323752223  Start2:  512559680

// [ 1, 3, 4, 7, 11, 18, 29, 47, 76, 123, 199, 322, 521, 843, 1364, 2207, 3571, 5778, 9349, 15127, 24476, 39603, 64079, 103682, 167761, 271443, 439204, 710647, 1149851, 1860498, 3010349, 4870847, 7881196, 12752043, 20633239, 33385282, 54018521, 87403803, 141422324, 228826127, 370248451, 599074578 ]
// [ 5.3, 1.7666666666667, 1.325, 0.75714285714286, 0.48181818181818, 0.29444444444444, 0.18275862068966, 0.11276595744681, 0.069736842105263, 0.043089430894309, 0.026633165829146, 0.016459627329193, 0.010172744721689, 0.0062870699881376, 0.0038856304985337, 0.0024014499320344, 0.0014841781013722, 0.00091727241259952, 0.00056690555139587, 0.0003503668936339, 0.00021653865010623, 0.00013382824533495, 8.2710404344637e-05, 5.1117841091028e-05, 3.1592563229833e-05, 1.9525277866808e-05, 1.20672853617e-05, 7.4579925...etc...

// index: 1 - grain 5.3, overlap 0.8 - geometric series - GoL (random start)
// index: 2 - grain 1.766, overlap 0.5 - geometric series - GoL
// index: 3 - grain 1.325, overlap 0.3 - geometric series - GoL
// index: 4 - grain 0.757, overlap 0.2 - geometric series - Wolf
// index: 5 - grain 0.481, overlap 0.12 - geometric series - Wolf
// index: 6 - grain 0.294, overlap 0.08 - compressed series / Harmonic series - Wolf
// index: 7 - grain 0.182, overlap 0.03 - 