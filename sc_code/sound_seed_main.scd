//// global variables setting
~ss_basepath = "".resolveRelative; // project folder
//// time variables
~grain_dur = 140; // duration of single grain
~overlap = 20; // overlap of grains, due to calculation function should be less than ~grain_dur
~rnd = ~overlap / 1000 / 4; // randomic component of tempo (addeed to step length)
~timestep = 0.03; // sequencer's single step length
~overall_amp = 1; // main amp
//// variables for the serie calculation
~freqserie = 0; // Define the default series type (0=armonic serie)
~bsfreq = 40.midicps; // fundamental freq of the serie 82~ Hz
~alpha = 1.0; // see comment in function
~beta = 1.0; // see comment in function
~gamma = 0; // see comment in function
//// CA related variables
~ss_cyclemode = 0; // set if CA restart when reach a quiet state(no oscillatory states)
~gridside = 18; // set the grid side with border for Life to work in a correct way
~wolframRule = 30; // why 30?! http://mathworld.wolfram.com/Rule30.html
~wolfCurrRow = 1; // counter for Wolfram CA progression (one row each pattern read)
~wolfMaxRows = 16; // max number of Wolfram CA rows
~currca = "gol"; // define the current ca executed
~sized = 0; // Affect Random Function and define if it is sized or not
~currloop = 0; // cycle to count pattern loop
~maxloops = 16; // max cycles before next random configuration
~synthez = "sinegrain"; // basename for the synth
//// feature pitch range
~featminfreq = ~featminfreqdef = 20; // pitch detection range
~featmaxfreq = ~featmaxfreqdef = 20000; // pitch detection range
~centminfreq = ~centminfreqdef = 21; // centroid min req
~centmaxfreq = ~centmaxfreqdef = 20001; // centroid max freq
//// granular synthesis control ranges
~mapminfreq = ~mapminfreqdef = 20; // base freq range
~mapmaxfreq = ~mapmaxfreqdef = 20000; // base freq range
~mapmindur = ~mapmindurdef = 0.04; // grain dur range
~mapmaxdur = ~mapmaxdurdef = 1.01; // grain dur range
~mapminstep = ~mapminstepdef = 0.04; // density range
~mapmaxstep = ~mapmaxstepdef = 1.01; // density range
~mapminalpha = ~mapminalphadef = 0; // alpha range
~mapmaxalpha = ~mapmaxalphadef = 2; // alpha range
~mapminbeta = ~mapminbetadef = 0; // beta range
~mapmaxbeta = ~mapmaxbetadef = 2; // beta range
//// Arrays
~ss_extractors = Array.fill(5,0); // array for feature extraction synts
~featurebus = Array.fill(5,Bus.control(s,1)); // array for control busses to store extractedd features
~mapping_tasks_matrix = Array2D.new(4,5);
~mapping_busses_matrix = Array2D.new(4,5);
//// F I L E S   L O A D ////
(~ss_basepath++"sound_seed_sinegrain_synths.scd").standardizePath.load; // load sinegrain synths
(~ss_basepath++"sound_seed_CA.scd").standardizePath.load; // load CA functions
(~ss_basepath++"sound_seed_control_functions.scd").standardizePath.load; // load control functions
(~ss_basepath++"sound_seed_pitch_detection.scd").standardizePath.load; // load pitch detection
(~ss_basepath++"sound_seed_speccentroid.scd").standardizePath.load; // load spec centroid
//// GUI
(~ss_basepath++"sound_seed_GUI.scd").standardizePath.load; // load GUI
// the play button task (start sequencer and synthesis)
~tas = Task{ loop{
	~sequencer.value(~gridside,~timestep,~rnd); // Controls also the time
	~caSelect.value(~currca); // change the CA after a pattern complete read
	}
};
///////////////////////
// E X E C U T I O N //
///////////////////////
// calculate the timetep according to ~grain_dur ~overlap
~timestep = ~timestep_calc.value(~grain_dur,~overlap);
// execute the gui creator to start playing around with the synth
~sound_seed_GUI_creator.value();
// generate the first configuration
~randConfig.value(~gridside);

