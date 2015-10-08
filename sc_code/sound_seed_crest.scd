SynthDef(\fileSpecCrest, {|
	buffer,
	loop = 1,
	gate = 1,
	amp = 0.5,
	centNum = 5,
	outbus = 0,
	rescale = 0.000001,
	outCbus|
	var source, env, out, chain, crest;
	source = PlayBuf.ar(1, buffer, loop: loop);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	chain = FFT(LocalBuf(512), out);
	// calculate spread
	crest = FFTCrest.kr(chain,20,20000);
//	crest.poll(5,\crest);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, crest)
}).send(s);
SynthDef(\soundinSpecCrest, {|
	inbus = 0,
	gate = 1,
	amp = 0.0,
	outbus = 0,
	rescale = 0.000001,
	outCbus|
	var source, env, out, chain, crest;
	source = SoundIn.ar(inbus);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	chain = FFT(LocalBuf(512), out);
	// calculate spread
	crest = FFTCrest.kr(chain,20,20000);
//	crest.poll(5,\crest);
//	crest = crest.log10;
//	crest.poll(5,\crest_log);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, crest)
}).send(s);
// Mapping crest values
~crest2seriebasefreq = Task{ loop{
	~mapping_busses_matrix.at(3,0).get{|val|
		~bsfreq = val.linlin(~crestminval,~crestmaxval,~mapminfreq,~mapmaxfreq);
		{ ~seriebasefreq.value_(~bsfreq) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(3,0,~crest2seriebasefreq);
// map spread 2 grain duration
~crest2grain_dur = Task{ loop{
	~mapping_busses_matrix.at(3,1).get{|val|
		var mval;
//		mval = val.linlin(200,800,~mapmaxdur,~mapmindur) * 1000;
		mval = val.linlin(~crestminval,~crestmaxval,~mapmindur,~mapmaxdur) * 1000;
		~grain_dur = mval;
		{ ~grain_dur_number.value_(~grain_dur/1000) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(3,1,~crest2grain_dur);
// map spread 2 timestep (density of granular synthesis)
~crest2timestep = Task{ loop{
	~mapping_busses_matrix.at(3,2).get{|val|
		var mval;
		mval = val.linlin(~crestminval,~crestmaxval,~mapminstep,~mapmaxstep);
		~timestep = mval;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(3,2,~crest2timestep);
// map spread 2 alpha variable of the serie
~crest2alpha = Task{ loop{
	~mapping_busses_matrix.at(3,3).get{|val|
		var mval;
		mval = val.explin(~crestminval,~crestmaxval,~mapminalpha,~mapmaxalpha);
		~alpha = mval;
	};
	0.02.wait
}};
~mapping_tasks_matrix.put(3,3,~crest2alpha);
// map spread 2 beta variable of the serie
~crest2beta = Task{ loop{
	~mapping_busses_matrix.at(3,4).get{|val|
		var mval;
		mval = val.explin(~crestminval,~crestmaxval,~mapminbeta,~mapmaxbeta);
		~beta = mval;
	};
	0.02.wait
}};
~mapping_tasks_matrix.put(3,4,~crest2beta);

// Tasks give sp
/*
d = Synth(\fileSpecCrest,[\buffer, ~ss_filebuf,\outCbus, ~featurebus[3]]);
d.free
*/
