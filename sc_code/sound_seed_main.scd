// Generatore di Grani
(

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
// draw GUI objects

~ss_basepath = "".resolveRelative;
(~ss_basepath++"sound_seed_pitch_detection.scd").standardizePath.load; // load pitch detection
(~ss_basepath++"sound_seed_GUI.scd").standardizePath.load; // load GUI
//(~ss_basepath++"sound_seed_GUI.scd").standardizePath.postln
/*
~sound_seed_GUI_creator = {
	~soundseed_w = Window.new("Sound Seed", Rect(10, 500, 600, 350)).front;
	~cagrid = BoxGrid.new(~soundseed_w,bounds:Rect(20, 20, 300, 300),columns:~gridside,rows:~gridside);
	~stepgrid = BoxGrid.new(~soundseed_w,Rect(37,322,266,16),16,1);
// sequencer controls
	~caplay = Button(~soundseed_w,Rect(350,20,30,35));
	~carestart_label = StaticText(~soundseed_w,Rect(385,20,60,15))
	.backColor_(Color.white).string_("mode").align_(\center);
	~caloops_label = StaticText(~soundseed_w,Rect(445,20,60,15))
	.backColor_(Color.white).string_("cycle").align_(\center);
	~caloop_current_label = StaticText(~soundseed_w,Rect(505,20,60,15))
	.backColor_(Color.white).string_("loop").align_(\center);
	~carestart = Button(~soundseed_w,Rect(390,35,50,20));
	~caloops = NumberBox(~soundseed_w,Rect(450,35,50,20))
	.value_(~maxloops).clipLo_(0).clipHi_(10000).decimals_(0)
	.action_{|me| ~maxloops = me.value };
	~caloop_current = NumberBox(~soundseed_w,Rect(510,35,50,20))
	.value_(~currloop).clipLo_(0).decimals_(0).enabled_(false);
// granular synthesis controls
	~graintype = Button(~soundseed_w,Rect(350,60,50,30));
	~grainfreqserie = Button(~soundseed_w,Rect(410,60,140,30));
	~seriebasefreq = NumberBox(~soundseed_w,Rect(552,60,40,30));
	~grain_dur_label = StaticText(~soundseed_w,Rect(350,95,50,15))
	.backColor_(Color.white).string_("grain").align_(\center);
	~grain_overlap_label =StaticText(~soundseed_w,Rect(400,95,60,15))
	.backColor_(Color.white).string_(" overlap").align_(\center);
	~grain_random_density_label = StaticText(~soundseed_w,Rect(460,95,60,15))
	.backColor_(Color.white).string_("rnd").align_(\center);
	~serie_alpha_label = StaticText(~soundseed_w,Rect(520,95,30,15))
	.backColor_(Color.white).string_("α").align_(\center);
	~serie_beta_label = StaticText(~soundseed_w,Rect(550,95,30,15))
	.backColor_(Color.white).string_("β").align_(\center);

	~grain_dur_number = NumberBox(~soundseed_w,Rect(350,110,45,20))
	.value_(~grain_dur/1000).clipLo_(0.04).clipHi_(20).decimals_(3).step_(0.005)
	.action_{|me|
		var old_dur, delta_dur, bpm;
		old_dur = ~grain_dur;
		~grain_dur = me.value * 1000;
		delta_dur = ~grain_dur - old_dur;
		// fix tempo
		if (~grain_fix_timestep.value==1){
			~overlap = ~overlap + ( delta_dur );
			~grain_overlap_number.value_(~overlap/1000);
		};
		~timestep = ~timestep_calc.value(~grain_dur,~overlap);
		// bpm = 60 / ~timestep;
		bpm = ~timestep * 16;
		~timestep_viewer.string_("dT:"++~timestep++"c:"++bpm);
		~grain_overlap_number.clipHi = (me.value-0.01);
	};

	~grain_fix_timestep = Button(~soundseed_w,Rect(395,112,15,15))
	.states_([["<>",Color.black,Color.gray],["<>",Color.black,Color.green]])
	.font_("Courier",8);

	~grain_overlap_number = NumberBox(~soundseed_w,Rect(410,110,45,20))
	.value_(~overlap/1000).clipLo_(0).clipHi_(5).decimals_(3).step_(0.005)
	.action_{|me|
		var old_ove, delta_ove, bpm;
		old_ove = ~overlap;
		~overlap = me.value*1000;
		delta_ove = ~overlap - old_ove;
		if (~grain_fix_timestep.value==1){
			~grain_dur = ~grain_dur + ( delta_ove );
			~grain_dur_number.value_(~grain_dur/1000);
		};
		~timestep = ~timestep_calc.value(~grain_dur,~overlap);
		// bpm = 60 / ~timestep;
		bpm = ~timestep * 16;
		~timestep_viewer.string_("dT:"++~timestep++"c:"++bpm);
	};
	~timestep_viewer = StaticText(~soundseed_w,Rect(350,132,115,15))
	.backColor_(Color.black).string_("dT:"++~timestep++"c:"++(~timestep*16)).stringColor_(Color.green);

	~grain_random_density_number = NumberBox(~soundseed_w,Rect(467,110,46,20))
	.value_(~rnd).clipLo_(0).clipHi_(20).decimals_(3).step_(0.005)
	.action_{|me|
		~rnd = me.value
	};
	~serie_alpha = Knob(~soundseed_w,Rect(520,110,30,30))
	.value_(~alpha).step_(0.001)
	.action_{|me|
		var val;
		val = ((me.value*~alphamul)+~alphadd).round(0.001);
		~serie_alpha_view.string=("α:"++val); ~alpha=val };
	~serie_alpha_view = StaticText(~soundseed_w,Rect(520,142,60,12))
	.backColor_(Color.black).stringColor_(Color.green).align_(\left)
	.font_("Courier").string_("α:"++~alpha);
	~serie_beta = Knob(~soundseed_w,Rect(550,110,30,30))
	.value_(~beta).step_(0.001)
	.action_{|me|
		var val;
		val = ((me.value*~betamul)+~betaadd).round(0.001);
		~serie_beta_view.string=("β:"++val); ~beta=val };
	~serie_beta_view = StaticText(~soundseed_w,Rect(520,154,60,12))
	.backColor_(Color.black).stringColor_(Color.green).align_(\left)
	.font_("Courier").string_("β:"++~beta);

	~overall_amp_control = Slider(~soundseed_w,Rect(530,180,40,130)).value_(~overall_amp)
	.action_{|me| ~overall_amp = me.value; ~overall_amp_value.value = me.value.ampdb };
	~overall_amp_value = NumberBox(~soundseed_w,Rect(530,310,40,20))
	.value_(~overall_amp.ampdb).align_(\center).enabled_(false).backColor_(Color.gray);
// CA Controls
	~golButton = Button(~soundseed_w,Rect(370,170,40,30));
	~wolfButton = Button(~soundseed_w,Rect(440,170,40,30));
	~wolfRuleNumber = NumberBox(~soundseed_w,Rect(482,170,30,30))
	.value_(~wolframRule).clipLo_(1).clipHi_(256).decimals_(0)
	.action_{|me| ~wolframRule = me.value.asInt };
	~carandConfig = Button(~soundseed_w,Rect(370,210,60,30));
	~carandConfigSized = Button(~soundseed_w,Rect(440,210,40,30));
	~carandConfigSizedNbox = NumberBox(~soundseed_w,Rect(482,210,30,30));
// grid controls
	~cleargridButton = Button(~soundseed_w,Rect(332,279,50,20));
	~drawmodeButton = Button(~soundseed_w,Rect(332,301,50,20));
// define GUI objects behaviour
	~stepgrid
	.setFillColor_(Color.red)
	.setBackgrColor_(Color.white);
	~caplay
	.states_([
		[">",Color.black,Color.gray],
		[">",Color.black,Color.green]])
	.action_({|me|
		if (me.value==1){
			~tas.play
		} {
			~tas.stop
	}});
	~carestart
	.states_([
		["single",Color.black,Color.gray],
		["loop",Color.black,Color.green]])
	.action_({|me|
		~ss_cyclemode = me.value;
	});
	~graintype
	.states_([
		["Sine",Color.black,Color.white],
		["Saw",Color.black,Color.yellow],
		["Square",Color.black,Color.red]])
	.action_({|me|
		case
		{me.value==0} {~synthez="sinegrain"}
		{me.value==1} {~synthez="sawgrain"}
		{me.value==2} {~synthez="pulsegrain"};
	})
	.enabled_(false);
	~carandConfig
	.states_([["Random",Color.black,Color.gray]])
	.action_({|me|
		if (~currca=="wolf") { ~wolfCurrRow = 1 };
		if (~carandConfigSized.value==0) {
			~randConfig.value(~gridside)
		} {
			~randConfigSized.value(~gridside,~carandConfigSizedNbox.value)
		}
	});
	~carandConfigSized
	.states_([
		["cells",Color.black,Color.gray],
		["cells",Color.black,Color.green]])
	.action_{|me|
		~sized = me.value;
		~sized.postln;
	};
	~carandConfigSizedNbox.value_(45);
	~grainfreqserie
	.states_([
		["harmonic serie",Color.black,Color.cyan],
		["geometric serie",Color.black,Color.green],
		["expanded harmonic",Color.black,Color.white],
		["compressed harmonic",Color.white,Color.black]
	])
	.action_({|me|
		case
		{ me.value==0 } { ~freqserie = 0;
			~alpha = 1.000;
			~alphamul = 0;
			~alphadd = 1.000;
			~beta = 1.000;
			~betamul = 0;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(false);
			~serie_beta.enabled_(false);
		}
		{ me.value==1 } { ~freqserie = 1; // 0,1.456,0
			~alpha = 0.000;
			~alphamul = 0;
			~alphadd = 0;
			~beta = 1.456;
			~betamul = 0.55;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(false);
			~serie_beta.enabled_(true);
		}
		{ me.value==2 } { ~freqserie = 2; // 1.5,1,0
			~alpha = 1.500;
			~alphamul = 5.000;
			~alphadd = 1.000;
			~beta = 1.000;
			~betamul = 0;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(true);
			~serie_beta.enabled_(false);
		}
		{ me.value==3 } { ~freqserie = 3; // 0.5,1,0
			~alpha = 0.500;
			~alphamul = 1;
			~alphadd = 0;
			~beta = 1.000;
			~betamul = 0;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(true);
			~serie_beta.enabled_(false);
		};
		~serie_alpha.value = ~alpha;
		~serie_alpha_view.string = ("α:"++~alpha);
		~serie_beta.value = ~beta;
		~serie_beta_view.string = ("β:"++~beta);
	});
	~seriebasefreq.value_(~bsfreq)
	.action_({|me| ~bsfreq = me.value });
	~golButton
	.states_([["GoL",Color.black,Color.gray]])
	.action_({ ~currca = "gol" });
	~wolfButton
	.states_([["Wolf",Color.black,Color.gray]])
	.action_({|me| ~currca = "wolf"; ~wolfCurrRow = 1 });
	~cleargridButton
	.states_([["clear",Color.black,Color.gray]])
	.action_({|me| ~cagrid.clearGrid });
	~drawmodeButton
	.states_([["delete",Color.black,Color.cyan],["trail",Color.black,Color.magenta]])
	.action_({|me|
		if (me.value==0) { ~cagrid.setTrailDrag_(false) };
		if (me.value==1) { ~cagrid.setTrailDrag_(true) };
	});
	~serie_alpha.enabled_(false);
	~serie_beta.enabled_(false);
}; */
////////// GUI END ///////////
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