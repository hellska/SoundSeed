//// S P R E A D   C A L C U L A T I O N
//// empirically we define the range of spread between 0 and 20
//// we reascale it by a factor of 0.000001
SynthDef(\fileSpecSpread, {|
	buffer,
	meanbuffer,
	loop = 1,
	gate = 1,
	amp = 0.5,
	centNum = 5,
	outbus = 0,
	rescale = 0.000001,
	outCbus|
	var source, env, out, chain, spread;
	source = PlayBuf.ar(1, buffer, loop: loop);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	chain = FFT(LocalBuf(512), out);
	// calculate spread
	spread = FFTSpread.kr(chain) * rescale;
	spread.poll(5,\spread);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, spread)
}).send(s);
SynthDef(\soundinSpecSpread, {|
	inbus = 0,
	meanbuffer,
	loop = 1,
	gate = 1,
	amp = 0.0,
	outbus = 0,
	rescale = 0.000001,
	outCbus|
	var source, env, out, chain, spread;
	source = SoundIn.ar(inbus);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	chain = FFT(LocalBuf(512), out);
	// calculate spread
	spread = FFTSpread.kr(chain) * rescale;
	spread.poll(5,\spread);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, spread)
}).send(s);

/*
d = Synth(\fileSpecSpread,[\buffer, ~ss_filebuf,\outCbus, ~featurebus[3]]);
d.free

f = Synth(\soundinSpecSpread); f.set(\amp,0);
f.free;
g = { LFNoise2.ar(10800) }.play;
g = { SinOsc.ar(440) }.play;
g.free
*/