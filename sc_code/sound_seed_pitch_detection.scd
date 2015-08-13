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
////// V A R I A B L E S   F O R   P I T C H   D E T E C T I O N ///////
~ss_extractors = Array.fill(5,0); // array for synts
~featurebus = Array.fill(5,Bus.control(s,1)); // array for control busses
// feature range
~featminfreq = 20;
~featmaxfreq = 20000;

// base freq range
~mapminfreq = 20;
~mapmaxfreq = 20000;
// grain dur range
~mapmindur = 0.04;
~mapmaxdur = 1.01;
// density range
~mapminstep = 0.04;
~mapmaxstep = 20.0;
// alpha range
~mapminalpha = 0;
~mapmaxalpha = 2;
// beta range
~mapminbeta = 0;
~mapmaxbeta = 2;

~ss_load_range = {|bound,param|
	var min,max,out;
	case
	{param==0} { min = ~mapminfreq; max = ~mapmaxfreq}
	{param==1} { min = ~mapmindur; max = ~mapmaxdur}
	{param==2} { min = ~mapminstep; max = ~mapminstep}
	{param==3} { min = ~mapminalpha; max = ~mapmaxalpha}
	{param==4} { min = ~mapminbeta; max = ~mapmaxbeta};
	if (bound==0) { out = min } { out = max };
	out
};
~ss_set_range = {|bound,param,val|
	case
	{param==0} { if (bound==0) {~mapminfreq=val} {~mapmaxfreq=val}; }
	{param==1} { if (bound==0) {~mapmindur=val} {~mapmaxdur=val}; }
	{param==2} { if (bound==0) {~mapminstep=val} {~mapminstep=val}; }
	{param==3} { if (bound==0) {~mapminalpha=val} {~mapmaxalpha=val}; }
	{param==4} { if (bound==0) {~mapminbeta=val} {~mapmaxbeta=val}; };
};


///// P I T C H   M A P P I N G ///////
// 0.02.wait -> fissato così per tutti i parametri in quanto questi vengono letti al massimo ogni timestep che può essere minimo 0.04
~mapping_matrix = Array2D.new(4,5);
//~mapping_matrix.at(0,0).start;
//~mapping_matrix.at(0,0).stop;
~mapping_matrix.put(0,0,~pitch2seriebasefreq);
// map pitch 2 the fundamental of the serie
~pitch2seriebasefreq = Task{ loop{
	~currentbus.get{|val|
		~bsfreq = val.linlin(~featminfreq,~featmaxfreq,~mapminfreq,~mapmaxfreq);
	};
	0.02.wait;
}};

// map pitch 2 grain duration
~pitch2grain_dur = Task{ loop{
	~currentbus.get{|val|
		var mval;
//		mval = val.linlin(200,800,~mapmaxdur,~mapmindur) * 1000;
		mval = val.linlin(~featminfreq,~featmaxfreq,~mapmaxdur,~mapmindur) * 1000;
		~grain_dur = mval;
	};
	0.02.wait;
}};

// map pitch 2 timestep (density of granular synthesis)
~pitch2timestep = Task{ loop{
	~currentbus.get{|val|
		var mval;
//		mval = val.linlin(200,800,~mapminstep,~mapmaxstep) * 1000;
		mval = val.linlin(~featminfreq,~featmaxfreq,~mapminstep,~mapmaxstep) * 1000;
		~overlap = mval / 4;
		~timestep = ~timestep_calc.value(mval,~overlap);
	};
	0.02.wait;
}};

// map pitch 2 alpha variable of the serie
~ptch2alpha = Task{ loop{
	~currentbus.get{|val|
		var mval;
		mval = val.explin(~featminfreq,~featmaxfreq,~mapminalpha,~mapmaxalpha);
		~alpha = mval;
	};
	0.02.wait
}};

// map pitch 2 beta variable of the serie
~pitch2beta = Task{ loop{
	~currentbus.get{|val|
		var mval;
		mval = val.explin(~featminfreq,~featmaxfreq,~mapminbeta,~mapmaxbeta);
		~beta = mval;
	};
	0.02.wait
}};



~mapping_matrix.put(0,0,~pitch2seriebasefreq);
~mapping_matrix.put(0,1,~pitch2grain_dur);
~mapping_matrix.put(0,2,~pitch2timestep);
~mapping_matrix.put(0,3,~ptch2alpha);
~mapping_matrix.put(0,4,~pitch2beta);
// Tasks give sp

/*
//// M A N U A L   E X E C U T I O N /////////
// set the volume of the input file
~extractor1.set(\amp, 0.1);
// Start input file pitch detection
~file_pitch.value();
// Start input sound pitch detection
~soundin_pitch.value();
// Stop the pitch detection synth
~extractor1.set(\gate, 0);
// map pitch to base freq
~pitch2seriebasefreq.play;
~pitch2seriebasefreq.stop;
// pitch range values: linear (20,20000) -> (~mapminfreq,~mapmaxfreq)
~mapminfreq=80;
~mapmaxfreq=320;
// map pitch to grain dur: linear (20,20000) -> (~mapminfreq,~mapmaxfreq)
~pitch2grain_dur.start;
~pitch2grain_dur.stop;
// grain dur range values: linear (20,20000) -> (~mapmaxdur,~mapmindur)
// low pitch longer values, higest pitch shorter values
~mapmindur = 0.04;
~mapmaxdur = 1.30;
~mapmindur = 1.30;
~mapmaxdur = 0.00001;
// map pitch to timestep (density)
~pitch2timestep.start;
~pitch2timestep.stop
// timestep range values: linear (20,20000) -> (~mapminstep,~mapmaxstep)
// low pitch shorter values, higest pitch longer values
~mapminstep = 0.04;
~mapmaxstep = 0.90;
// map pitch 2 alpha variable of the serie
~ptch2alpha.start;
~ptch2alpha.stop;
// alpha range values: (20,20000) -> (~mapminalpha,~mapmaxalpha)
~mapminalpha = 0;
~mapmaxalpha = 2;
// beta range values: (20,20000) -> (~mapminalpha,~mapmaxalpha)
~pitch2beta.start;
~pitch2beta.stop;
// beta range values: (20,20000) -> (~mapminbeta,~mapmaxbeta)
~mapminbeta = 0;
~mapmaxbeta = 2;
*/