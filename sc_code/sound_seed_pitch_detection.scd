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
// feature pitch range
~featminfreq = ~featminfreqdef = 20;
~featmaxfreq = ~featmaxfreqdef = 20000;


// base freq range
~mapminfreq = ~mapminfreqdef = 20;
~mapmaxfreq = ~mapmaxfreqdef = 20000;
// grain dur range
~mapmindur = ~mapmindurdef = 0.04;
~mapmaxdur = ~mapmaxdurdef = 1.01;
// density range
~mapminstep = ~mapminstepdef = 0.04;
~mapmaxstep = ~mapmaxstepdef = 1.01;
// alpha range
~mapminalpha = ~mapminalphadef = 0;
~mapmaxalpha = ~mapmaxalphadef = 2;
// beta range
~mapminbeta = ~mapminbetadef = 0;
~mapmaxbeta = ~mapmaxbetadef = 2;

// set the correct range for each param
~ss_load_range = {|bound,param|
	var min,max,out;
	case
	// parameters
	{param==0} { min = ~mapminfreqdef; max = ~mapmaxfreqdef}
	{param==1} { min = ~mapmindurdef; max = ~mapmaxdurdef}
	{param==2} { min = ~mapminstepdef; max = ~mapmaxstepdef}
	{param==3} { min = ~mapminalphadef; max = ~mapmaxalphadef}
	{param==4} { min = ~mapminbetadef; max = ~mapmaxbetadef}
	// features
	{param==5} {min = ~featminfreqdef; max = ~featmaxfreqdef}
	{param==6} {min = ~featminfreqdef; max = ~featmaxfreqdef} // centroid is in Hertz
	{param==7} {min = 1; max = 1}
	{param==8} {min = 1; max = 1};
	if (bound==0) { out = min } { out = max };
	out
};
// set the variable by the number box
~ss_set_range = {|bound,param,val|
	case
	{param==0} { if (bound==0) {~mapminfreq=val} {~mapmaxfreq=val}; }
	{param==1} { if (bound==0) {~mapmindur=val} {~mapmaxdur=val}; }
	{param==2} { if (bound==0) {~mapminstep=val} {~mapmaxstep=val}; }
	{param==3} { if (bound==0) {~mapminalpha=val} {~mapmaxalpha=val}; }
	{param==4} { if (bound==0) {~mapminbeta=val} {~mapmaxbeta=val}; };
};


///// P I T C H   M A P P I N G ///////
// 0.02.wait -> fissato così per tutti i parametri in quanto questi vengono letti al massimo ogni timestep che può essere minimo 0.04
~mapping_tasks_matrix = Array2D.new(4,5);
~mapping_busses_matrix = Array2D.new(4,5);
//~mapping_tasks_matrix.at(0,0).start;
//~mapping_tasks_matrix.at(0,0).stop;

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