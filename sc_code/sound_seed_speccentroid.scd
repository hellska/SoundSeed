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
	centroid.poll(10, \cent);
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
	centroid.poll(10, \cent);
	Out.ar(outbus, out * amp);
	Out.kr(outCbus, centroid)
}).send(s);