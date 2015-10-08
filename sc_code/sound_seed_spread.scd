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
//	spread.poll(5,\spread);
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
//	spread.poll(5,\spread);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, spread)
}).send(s);
///// P I T C H   M A P P I N G ///////
// we are using a normalization factor of 0.000001 to make the spreand in the range of 0-20
// for possible values larger than 20 the spread is clipped to 20
~spread2seriebasefreq = Task{ loop{
	~mapping_busses_matrix.at(2,0).get{|val|
		~bsfreq = val.linlin(~spreadminval,~spreadmaxval,~mapminfreq,~mapmaxfreq);
		{ ~seriebasefreq.value_(~bsfreq) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(2,0,~spread2seriebasefreq);
// map spread 2 grain duration
~spread2grain_dur = Task{ loop{
	~mapping_busses_matrix.at(2,1).get{|val|
		var mval;
//		mval = val.linlin(200,800,~mapmaxdur,~mapmindur) * 1000;
		mval = val.linlin(~spreadminval,~spreadmaxval,~mapmindur,~mapmaxdur) * 1000;
		~grain_dur = mval;
		{ ~grain_dur_number.value_(~grain_dur/1000) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(2,1,~spread2grain_dur);
// map spread 2 timestep (density of granular synthesis)
~spread2timestep = Task{ loop{
	~mapping_busses_matrix.at(2,2).get{|val|
		var mval;
		mval = val.linlin(~spreadminval,~spreadmaxval,~mapminstep,~mapmaxstep);
		~timestep = mval;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(2,2,~spread2timestep);
// map spread 2 alpha variable of the serie
~spread2alpha = Task{ loop{
	~mapping_busses_matrix.at(2,3).get{|val|
		var mval;
		mval = val.explin(~spreadminval,~spreadmaxval,~mapminalpha,~mapmaxalpha);
		~alpha = mval;
	};
	0.02.wait
}};
~mapping_tasks_matrix.put(2,3,~spread2alpha);
// map spread 2 beta variable of the serie
~spread2beta = Task{ loop{
	~mapping_busses_matrix.at(2,4).get{|val|
		var mval;
		mval = val.explin(~spreadminval,~spreadmaxval,~mapminbeta,~mapmaxbeta);
		~beta = mval;
	};
	0.02.wait
}};
~mapping_tasks_matrix.put(2,4,~spread2beta);

// Tasks give sp
/*
d = Synth(\fileSpecSpread,[\buffer, ~ss_filebuf,\outCbus, ~featurebus[3]]);
d.free

f = Synth(\soundinSpecSpread); f.set(\amp,0);
f.free;
g = { LFNoise2.ar(10800) }.play;
g = { SinOsc.ar(440) }.play;
g.free
*/