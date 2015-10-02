///// S P E C   C E N T R O I D ///////
// new variables
~ss_centroid_nu_formean = 5;
~ss_feat_dimension = 1; // mandatory for synthdefs load
~ss_centroid_meanbuf = Buffer.alloc(s, ~ss_centroid_nu_formean, ~ss_feat_dimension + 1);
// synths definition
SynthDef(\fileSpecCentroid, {|
	buffer,
	meanbuffer,
	loop = 1,
	gate = 1,
	amp = 0.5,
	centNum = 5,
	outbus = 0,
	outCbus|
	var source, env, out, chain, trig, centroidData, centroidBuf, centroid;
	source = PlayBuf.ar(1, buffer, loop: loop);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	chain = FFT(LocalBuf(512), out);
	trig = chain > -0.001;
	centroidData = [SpecCentroid.kr(chain)];
	centroidBuf = KMeansRT.kr(meanbuffer, centroidData, centNum, trig);
	centroid = KMeansRT.getCentroid(meanbuffer, centroidBuf, 1).at(0);
//	centroid.poll(10, \cent);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, centroid)
}).send(s);
SynthDef(\soundinSpecCentroid, {|
	inbus = 0,
	meanbuffer,
	loop = 1,
	gate = 1,
	amp = 0.5,
	centNum = 5,
	outbus = 0,
	outCbus|
	var source, env, out, chain, trig, centroidData, centroidBuf, centroid;
	source = SoundIn.ar(inbus);
	env = EnvGen.ar(Env.asr(),gate,doneAction:2);
	out = source * env;
	chain = FFT(LocalBuf(512), out);
	trig = chain > -0.001;
	centroidData = [SpecCentroid.kr(chain)];
	centroidBuf = KMeansRT.kr(meanbuffer, centroidData, centNum, trig);
	centroid = KMeansRT.getCentroid(meanbuffer, centroidBuf, 1).at(0);
//	centroid.poll(10, \cent);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, centroid)
}).send(s);

// map centroid on fundamental
~cent2seriebasefreq = Task{ loop{
	~mapping_busses_matrix.at(1,0).get{|val|
		var mval;
		mval = val.linlin(~centminfreq,~centmaxfreq,~mapminfreq,~mapmaxfreq);
		~bsfreq = mval;
		{ ~seriebasefreq.value_(~bsfreq) }.defer;
	};
	0.2.wait;
}};
~mapping_tasks_matrix.put(1,0,~cent2seriebasefreq);
// map centroid on grain length
~cent2grain_dur = Task{ loop{
	~mapping_busses_matrix.at(1,1).get{|val|
		var mval;
		mval = val.linlin(~centminfreq,~centmaxfreq,~mapmindur,~mapmaxdur) * 1000;
		~grain_dur = mval;
		{ ~grain_dur_number.value_(~grain_dur/1000) }.defer;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(1,1,~cent2grain_dur);
//~mapping_tasks_matrix.put(1,1,~cent2grain_dur);
// map centroid on density
~cent2timestep = Task{ loop{
	~mapping_busses_matrix.at(1,2).get{|val|
		var mval;
		mval = val.linlin(~centminfreq,~centmaxfreq,~mapminstep,~mapmaxstep);
		~timestep = mval;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(1,2,~cent2timestep);
// map centroid on alpha
~cent2alpha = Task{ loop{
	~mapping_busses_matrix.at(1,3).get{|val|
		var mval;
		mval = val.explin(~centminfreq,~centmaxfreq,~mapminalpha,~mapmaxalpha);
		~alpha = mval;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(1,3,~cent2alpha);
// map centroid on beta
~cent2beta = Task{ loop{
	~mapping_busses_matrix.at(1,4).get{|val|
		var mval;
		mval = val.explin(~centminfreq,~centmaxfreq,~mapminbeta,~mapmaxbeta);
		~beta = mval;
	};
	0.02.wait;
}};
~mapping_tasks_matrix.put(1,4,~cent2beta);