// Generatore di Grani
(

~ss_basepath = "".resolveRelative;

// time variables
~grain_dur = 140; // duration of single grain
~overlap = 20; // overlap of grains, due to calculation function should be less than ~grain_dur
~rnd = ~overlap / 1000 / 4;
~timestep = 0.03; // sequencer's single step length

~overall_amp = 1;
// ~rnd = 0.03; // randomic component of tempo (addeed to step length)
// parameter for the serie calculation
~freqserie = 0; // Define the default series type (0=armonic serie)
~bsfreq = 40.midicps; // fundamental freq of the serie 82~ Hz
~alpha = 1.0;
~beta = 1.0;
~gamma = 0;

~ss_cyclemode = 0; // set if CA restart when reach a quiet state(no oscillatory states)
~gridside = 18; // set the grid side with border for Life to work in a correct way
~wolframRule = 30; // why 30?! http://mathworld.wolfram.com/Rule30.html
~wolfCurrRow = 1; // counter for Wolfram CA progression (one row each pattern read)
~wolfMaxRows = 16; // max number of Wolfram CA rows
~currca = "gol"; // define the current ca executed
~sized = 0; // Affect Random Function and define if it is sized or not
~currloop = 0; // cycle to count pattern loop
~maxloops = 16; //
~synthez = "sinegrain"; // basename for the synth
// Synth Definition
SynthDef("sinegrain1", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = 40,
	amps = 1,
	pan = 0|
	var source, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = SinOsc.ar(freqs,mul:amps) * env;
	out = Pan2.ar(source,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain2", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80],
	amps = #[1,0.5],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1])) * env;
	rescale = source * (amp / 2); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
// 3 bank oscillator
SynthDef("sinegrain3", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160],
	amps = #[1,0.5,0.333],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) ) * env;
	rescale = source * (amp / 3); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
// 4 bank oscillator
SynthDef("sinegrain4", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320],
	amps = #[1,0.5,0.333,0.25],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) ) * env;
	rescale = source * (amp / 4); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain5", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320,640],
	amps = #[1,0.5,0.333,0.25,0.2],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) ) * env;
	rescale = source * (amp / 5); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain6", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320,640,1280],
	amps = #[1,0.5,0.333,0.25,0.2,0.166],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) ) * env;
	rescale = source * (amp / 6); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain7", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320,640,1280,2560],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) ) * env;
	rescale = source * (amp / 7); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain8", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320,640,1280,2560,5120],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) ) * env;
	rescale = source * (amp / 8); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain9", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320,640,1280,2560,5120,10240],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) ) * env;
	rescale = source * (amp / 9); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain10", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,160,320,640,1280,2560,5120,10240,20480],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) ) * env;
	rescale = source * (amp / 10); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain11", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,120,160,200,240,280,320,360,400,440],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1,0.09],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) +
		SinOsc.ar(freqs[10],mul:amps[10]) ) * env;
	rescale = source * (amp / 11); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain12", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,120,160,200,240,280,320,360,400,440,480],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1,0.09,0.083],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) +
		SinOsc.ar(freqs[10],mul:amps[10]) +
		SinOsc.ar(freqs[11],mul:amps[11]) ) * env;
	rescale = source * (amp / 12); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain13", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,120,160,200,240,280,320,360,400,440,480,520],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1,0.09,0.083,0.076],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) +
		SinOsc.ar(freqs[10],mul:amps[10]) +
		SinOsc.ar(freqs[11],mul:amps[11]) +
		SinOsc.ar(freqs[12],mul:amps[12]) ) * env;
	rescale = source * (amp / 13); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain14", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,120,160,200,240,280,320,360,400,440,480,520,560],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1,0.09,0.083,0.076,0.071],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) +
		SinOsc.ar(freqs[10],mul:amps[10]) +
		SinOsc.ar(freqs[11],mul:amps[11]) +
		SinOsc.ar(freqs[12],mul:amps[12]) +
		SinOsc.ar(freqs[13],mul:amps[13]) ) * env;
	rescale = source * (amp / 14); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain15", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,120,160,200,240,280,320,360,400,440,480,520,560,600],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1,0.09,0.083,0.076,0.071,0.066],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) +
		SinOsc.ar(freqs[10],mul:amps[10]) +
		SinOsc.ar(freqs[11],mul:amps[11]) +
		SinOsc.ar(freqs[12],mul:amps[12]) +
		SinOsc.ar(freqs[13],mul:amps[13]) +
		SinOsc.ar(freqs[14],mul:amps[14]) ) * env;
	rescale = source * (amp / 15); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
SynthDef("sinegrain16", {
	|outBus = 0,
	amp = 1,
	gate = 1,
	length = 50,
	freqs = #[40,80,120,160,200,240,280,320,360,400,440,480,520,560,600,640],
	amps = #[1,0.5,0.333,0.25,0.2,0.166,0.142,0.125,0.111,0.1,0.09,0.083,0.076,0.071,0.066,0.062],
	pan = 0|
	var source, rescale, out, env, dur;
	dur = 1 / 1000 * length;
	env = EnvGen.kr(Env([0, amp, 0], [dur/2, dur/2], \sine),doneAction:2); //Gaussian-shaped
	source = (
		SinOsc.ar(freqs[0],mul:amps[0]) +
		SinOsc.ar(freqs[1],mul:amps[1]) +
		SinOsc.ar(freqs[2],mul:amps[2]) +
		SinOsc.ar(freqs[3],mul:amps[3]) +
		SinOsc.ar(freqs[4],mul:amps[4]) +
		SinOsc.ar(freqs[5],mul:amps[5]) +
		SinOsc.ar(freqs[6],mul:amps[6]) +
		SinOsc.ar(freqs[7],mul:amps[7]) +
		SinOsc.ar(freqs[8],mul:amps[8]) +
		SinOsc.ar(freqs[9],mul:amps[9]) +
		SinOsc.ar(freqs[10],mul:amps[10]) +
		SinOsc.ar(freqs[11],mul:amps[11]) +
		SinOsc.ar(freqs[12],mul:amps[12]) +
		SinOsc.ar(freqs[13],mul:amps[13]) +
		SinOsc.ar(freqs[14],mul:amps[14]) +
		SinOsc.ar(freqs[15],mul:amps[15]) ) * env;
	rescale = source * (amp / 16); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
////////////////////////
////
~ss_extractors = Array.fill(5,0); // array for synts

//// EXTRACTOR BUSSES
~featurebus = Array.fill(5,Bus.control(s,1)); // array for control busses



(~ss_basepath++"sound_seed_pitch_detection.scd").standardizePath.load; // load pitch detection

//// GUI
(~ss_basepath++"sound_seed_GUI.scd").standardizePath.load; // load GUI


// read column from the CA BoxGrid
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
		var freqs, amps;
		freqs = Array.fill(freq.size, {|idx| freq[idx] });
		amps = Array.fill(amp.size, {|idx| amp[idx] });
		synthez = (~synthez++freq.size);
		Synth(synthez,[\freqs, freqs, \length, dur, \amps, amps]);
	};
};
// sequencer - read each column every timestep - skip borders cause not used in Conway gameOfLife
~sequencer = {|cols|
	var step,columns;
	columns = cols - 2;
	columns.do{|i|
		if (~rnd==nil){~rnd=0};
		step = ~timestep + rand(~rnd);
		// show the current step
		~stepgrid.gridNodes[0][i].setState_(true);
		if (i>0) { ~stepgrid.gridNodes[0][i-1].setState_(false) };
		if (i==0) { ~stepgrid.gridNodes[0][columns-1].setState_(false) };
		~stepgrid.refresh;
		~readcol.value(i+1);
		step.wait;
	}
};
// calculate the timestep using grain and ovarlap values
~timestep_calc = {|grain_dur, overlap|
	var step;
	step = (grain_dur / 1000) - (overlap / 1000);
	if (step <= 0){
		step = grain_dur / 1000;
		"Overlap set to 0 due to a value higer than graindur".postln
	};
	step
};
// generation of random configuration
~randConfig = {|side|
	var matrix;
	matrix = Array.fill(side*side, { rrand(0,1) }).clump(side);
	~cagrid.setNodeStates_(matrix);
};
// generate a fixed number of active cells in random positions
~randConfigSized = {|side,size|
	var matrix;
	matrix = Array.fill(side*side, 0).clump(side);
	size.do{
		var x,y;
		x = rand(side);
		y = rand(side);
		matrix[x][y] = 1;
	};
	~cagrid.setNodeStates_(matrix);
};
// generalized serie used for spectral design
~generalizedserie = {|base,n,alpha,beta,gamma|
	var freq;
	freq = base * ( n.pow(alpha) * beta.pow(n) + gamma );
	/*	Theory
	α=1,β=1andγ=0generatestheharmonicseries;
	α=0,β>1andγ=0generatesthegeometricseries;
	α>1,β=1andγ=0generatestheexpanded-harmonicseries;
	α<1,β=1andγ=0generatesthecompressed-harmonicseries;
	*/
};
// determines stale states and the duration of the stale state
~checkgridstatus = {
	var current, last,status, continue;
	current = ~ss_gridcontent;
	// check if it's the first time the CA reached a stationary configuration
	if (~ss_gridcontentlast!=nil){
		// check if in cycle mode
		if (~ss_cyclemode==1) {
			// Check if current configuration is equal to the last config
			if (~ss_gridcontentlast==~ss_gridcontent){
				// check if reached the max poop number
				if (~currloop>=~maxloops) {
					~currloop = 0;
					// check if random is normal or sized
					if (~sized==0) {
						"here".postln;
						~randConfig.value(~gridside);
					} {
						{ ~randConfigSized.value(~gridside,~carandConfigSizedNbox.value) }.defer
					};
				} {
					~currloop = ~currloop + 1
				};
				{ ~caloop_current.value = ~currloop }.defer;
			};
		};
	};
	~ss_gridcontentlast=~ss_gridcontent
};
// select the actice CA to use and calls the ca function
~caSelect = {|ca|
	case
	{ ca == "gol" } { ~ss_gridcontent = ~gameOfLife.value(~cagrid,~gridside,~gridside); }
	{ ca == "wolf" } { ~ss_gridcontent = ~wolfram.value(~wolfCurrRow,~wolframRule,~cagrid,16,16) };
	~checkgridstatus.value();
};
// CA implementation of Conway Game Of Life
~gameOfLife = {|boxGrid,rows=16,cols=16|
	var grid,newgrid,x,y,liceCellCount,xmap,ymap;
	liceCellCount = 0;
	xmap = [-1,-1,-1,0,0,1,1,1];
	ymap = [-1,0,1,-1,1,-1,0,1];
	grid = Array2D.fromArray(rows,cols,boxGrid.getNodeStates.flat);
	newgrid = Array.fill(rows*cols, 0).clump(rows);
	x = grid.cols -2;
	y = grid.rows -2;
	y.do{|row|
		x.do{|col|
			var xc,yc,cell,neiCount;
			neiCount = 0;
			// calc array2D indexs to avoid borders
			xc = col+1;
			yc = row+1;
			cell = grid[yc,xc];
			// count live cells
			if (cell==1){ liceCellCount = liceCellCount+1 };
			// count the neighbours
			xmap.size.do{|idx|
				var neighbour,nx,ny;
				nx = xc + xmap[idx];
				ny = yc + ymap[idx];
				neighbour = grid[ny,nx];
				if (neighbour==1){neiCount = neiCount+1};
			};
			// Conway rules
			if (cell==1) {
				newgrid[yc][xc] = 1; // substitute conway rule 2
				// conway rule 1
				if (neiCount<2) {
					newgrid[yc][xc] = 0;
//					("apply rule 1 on x: "++yc++" y: "++xc).postln;
				};

				// conway rule 3
				if (neiCount>3) {
					newgrid[yc][xc] = 0;
//					("apply rule 3 on x: "++yc++" y: "++xc).postln;
				};
			};
			if (cell==0) {
				// conway rule 4
				if (neiCount==3) {
					newgrid[yc][xc] = 1;
//					("apply rule 4 on x: "++yc++" y: "++xc).postln;
				};
			}
		}
	};
	boxGrid.setNodeStates_(newgrid);
	newgrid
};
// implementation of Wolfram CA
~wolfram = {|row,rule,boxgrid,rows=16,cols=16|
	var thisgrid, newgrid, pattern, binrule, rowlimit;
	rowlimit = rows - 1;
	thisgrid = boxgrid.getNodeStates;
	if (rule>255) { rule = 30; { ~wolfRuleNumber.value = 30 }.defer };
	binrule = rule.asBinaryDigits.reverse;
	for(1,cols,{|col|
		var pos;
		pattern = Array.fill(3,0);
		pattern[0] = thisgrid[row][col-1];
		pattern[1] = thisgrid[row][col];
		pattern[2] = thisgrid[row][col+1];
		// get the pattern correspondent value from rule
		pos = pattern.convertDigits(2);
		if (binrule[pos]==1){
			thisgrid[row+1][col] = 1;
		};
	});
	boxgrid.setNodeStates_(thisgrid);
	if (row<rowlimit) { ~wolfCurrRow = ~wolfCurrRow + 1 };
	if (row==rowlimit) { ~wolfCurrRow = 1 };
	thisgrid
};
// the play button task (start sequencer and synthesis)
~tas = Task{ loop{
	~sequencer.value(~gridside,~timestep,~rnd); // Controls also the time
	~caSelect.value(~currca); // change the CA after a pattern complete read
	}
};
///////////////////////
// E X E C U T I O N //
///////////////////////
// calculate the timetep according to ~grain_dur ~overlap
~timestep = ~timestep_calc.value(~grain_dur,~overlap);
// execute the gui creator to start playing around with the synth
~sound_seed_GUI_creator.value();
// generate the first configuration
~randConfig.value(~gridside)
)
//The amphichiral elementary cellular automata are 0, 1, 4, 5, 18, 19, 22, 23, 32, 33, 36, 37, 50, 51, 54, 55, 72, 73, 76, 77, 90, 91, 94, 95, 104, 105, 108, 109, 122, 123, 126, 127, 128, 129, 132, 133, 146, 147, 150, 151, 160, 161, 164, 165, 178, 179, 182, 183, 200, 201, 204, 205, 218, 219, 222, 223, 232, 233, 236, 237, 250, 251, 254, and 255.

/* Use this to write the frequency for each row to show in the GUI
(
var freq, freqs;
~alpha = 1;
~beta = 1;
~gamma = 0;
freq = 80;
freqs = Array(16);
16.do{|idx| freqs.add(~generalizedserie.value(freq,idx + 1,~alpha,~beta,~gamma)) };
freqs
)
*/