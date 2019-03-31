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
	source = Saw.ar(freqs,mul:amps) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1])) * env;
	rescale = source * (amp / 2); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) +
		Saw.ar(freqs[10],mul:amps[10]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) +
		Saw.ar(freqs[10],mul:amps[10]) +
		Saw.ar(freqs[11],mul:amps[11]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) +
		Saw.ar(freqs[10],mul:amps[10]) +
		Saw.ar(freqs[11],mul:amps[11]) +
		Saw.ar(freqs[12],mul:amps[12]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) +
		Saw.ar(freqs[10],mul:amps[10]) +
		Saw.ar(freqs[11],mul:amps[11]) +
		Saw.ar(freqs[12],mul:amps[12]) +
		Saw.ar(freqs[13],mul:amps[13]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) +
		Saw.ar(freqs[10],mul:amps[10]) +
		Saw.ar(freqs[11],mul:amps[11]) +
		Saw.ar(freqs[12],mul:amps[12]) +
		Saw.ar(freqs[13],mul:amps[13]) +
		Saw.ar(freqs[14],mul:amps[14]) ) * env;
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
		Saw.ar(freqs[0],mul:amps[0]) +
		Saw.ar(freqs[1],mul:amps[1]) +
		Saw.ar(freqs[2],mul:amps[2]) +
		Saw.ar(freqs[3],mul:amps[3]) +
		Saw.ar(freqs[4],mul:amps[4]) +
		Saw.ar(freqs[5],mul:amps[5]) +
		Saw.ar(freqs[6],mul:amps[6]) +
		Saw.ar(freqs[7],mul:amps[7]) +
		Saw.ar(freqs[8],mul:amps[8]) +
		Saw.ar(freqs[9],mul:amps[9]) +
		Saw.ar(freqs[10],mul:amps[10]) +
		Saw.ar(freqs[11],mul:amps[11]) +
		Saw.ar(freqs[12],mul:amps[12]) +
		Saw.ar(freqs[13],mul:amps[13]) +
		Saw.ar(freqs[14],mul:amps[14]) +
		Saw.ar(freqs[15],mul:amps[15]) ) * env;
	rescale = source * (amp / 16); // rescale the amplitude by the number of oscillators
	out = Pan2.ar(rescale,pan);
	Out.ar(outBus, out)
}).send(s);