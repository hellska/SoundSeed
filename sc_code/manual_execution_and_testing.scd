//// Spec Centroid testing

// for testing
~filebuf = Buffer.read(s, "/Volumes/ssdData/soundsAndSamples/varie/sound_seed_test_flute.aiff".standardizePath);
~outbuss = Bus.control(s, 1);
// filein
a = Synth.new(\fileSpecCentroid, [\buffer, ~filebuf, \meanbuffer, ~ss_centroid_meanbuf, \outCbus, ~outbuss]);
// soundin
a = Synth.new(\soundinSpecCentroid, [\meanbuffer, ~ss_centroid_meanbuf, \outCbus, ~outbuss]);
// stop
a.set(gate, 0);


// Pitch detection testing
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

// Use this to write the frequency for each row to show in the GUI
~ss_show_serie_freqs = {
	var freq, freqs;
	freqs = Array(16);
	16.do{|idx| freqs.add(~generalizedserie.value(~bsfreq,idx + 1,~alpha,~beta,~gamma)) };
	freqs
};

~ss_show_serie_freqs.value();