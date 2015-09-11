// Mapping of seed pitch - first experimentation of mapping technique
// The mapping is performed using Control Busses
///// P I T C H   D E T E C T I O N ///////
SynthDef(\filePitchDetectControl, {
	|buffer = 0,
	loop = 1,
	gate = 1,
	amp = 0.5,
	outbus = 0,
	outCbus = 0|
	var source, env, pitch, pitchsig, out;
	source = PlayBuf.ar(1, buffer, loop: loop);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	pitch = Pitch.kr(source);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, Gate.kr(pitch[0],if(pitch[1],pitch[0],0)))
}).send(s);
SynthDef(\inPitchDetectControl, {
	|inbus = 0,
	loop = 1,
	gate = 1,
	amp = 0.5,
	outbus = 0,
	outCbus = 0|
	var source, env, pitch, pitchsig, out;
	source = SoundIn.ar(inbus);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	pitch = Pitch.kr(source);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, Gate.kr(pitch[0],if(pitch[1],pitch[0],0)))
}).send(s);
///// P I T C H   M A P P I N G ///////
// 0.02.wait -> fissato così per tutti i parametri in quanto questi vengono letti al massimo ogni timestep che può essere minimo 0.04
// map pitch 2 the fundamental of the serie
~pitch2seriebasefreq = Task{ loop{
	~mapping_busses_matrix.at(0,0).get{|val|
		~bsfreq = val.linlin(~featminfreq,~featmaxfreq,~mapminfreq,~mapmaxfreq);
		{ ~seriebasefreq.value_(~bsfreq) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(0,0,~pitch2seriebasefreq);
// map pitch 2 grain duration
~pitch2grain_dur = Task{ loop{
	~mapping_busses_matrix.at(0,1).get{|val|
		var mval;
//		mval = val.linlin(200,800,~mapmaxdur,~mapmindur) * 1000;
		mval = val.linlin(~featminfreq,~featmaxfreq,~mapmindur,~mapmaxdur) * 1000;
		~grain_dur = mval;
		{ ~grain_dur_number.value_(~grain_dur/1000) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(0,1,~pitch2grain_dur);
// map pitch 2 timestep (density of granular synthesis)
~pitch2timestep = Task{ loop{
	~mapping_busses_matrix.at(0,2).get{|val|
		var mval;
		mval = val.linlin(~featminfreq,~featmaxfreq,~mapminstep,~mapmaxstep);
		~timestep = mval;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(0,2,~pitch2timestep);
// map pitch 2 alpha variable of the serie
~ptch2alpha = Task{ loop{
	~mapping_busses_matrix.at(0,3).get{|val|
		var mval;
		mval = val.explin(~featminfreq,~featmaxfreq,~mapminalpha,~mapmaxalpha);
		~alpha = mval;
	};
	0.02.wait
}};
~mapping_tasks_matrix.put(0,3,~ptch2alpha);
// map pitch 2 beta variable of the serie
~pitch2beta = Task{ loop{
	~mapping_busses_matrix.at(0,4).get{|val|
		var mval;
		mval = val.explin(~featminfreq,~featmaxfreq,~mapminbeta,~mapmaxbeta);
		~beta = mval;
	};
	0.02.wait
}};
~mapping_tasks_matrix.put(0,4,~pitch2beta);
// Tasks give sp