// read column from the CA BoxGrid
~readcol = {|col|
	var my2d,bfreq,freq,length,amp,dur,harmonics,synthez,synthid;
	bfreq = ~bsfreq ; // 80;
	harmonics = ~gridside-2;
	freq = List[];
	length = List[];
	amp = List[];
	my2d = Array2D.fromArray(~gridside,~gridside,~cagrid.getNodeStates.flat);
	// dur = rand(~ss_deltadur) + ~ss_mindur;
	dur = ~grain_dur;
	my2d.colAt(col).do{
		|me,idx|
		if (idx>0) { // avoid initial column border
			if (idx<=harmonics) { // avoid end column border
				if (me==1) {

					freq.add(~generalizedserie.value(bfreq,idx + 1,~alpha,~beta,~gamma));

					// freq.add(idx + 1 * bfreq/2);
					// different length for each sine of the column
					// length.add(rand(200) + 50);
					// same length for each sine of the column
					length.add(dur);
					amp.add(~overall_amp/(idx)); // rescale is done inside the synth
				}
			}
		}
	};
	if (freq.size>0) {
		var freqs, amps;
		freqs = Array.fill(freq.size, {|idx| freq[idx] });
		amps = Array.fill(amp.size, {|idx| amp[idx] });
		synthez = (~synthez++freq.size);
		Synth(synthez,[\freqs, freqs, \length, dur, \amps, amps]);
	};
};
// sequencer - read each column every timestep - skip borders cause not used in Conway gameOfLife
~sequencer = {|cols|
	var step,columns;
	columns = cols - 2;
	columns.do{|i|
		if (~rnd==nil){~rnd=0};
		step = ~timestep + rand(~rnd);
		// show the current step
		~stepgrid.gridNodes[0][i].setState_(true);
		if (i>0) { ~stepgrid.gridNodes[0][i-1].setState_(false) };
		if (i==0) { ~stepgrid.gridNodes[0][columns-1].setState_(false) };
		~stepgrid.refresh;
		~readcol.value(i+1);
		step.wait;
	}
};
// calculate the timestep using grain and ovarlap values
~timestep_calc = {|grain_dur, overlap|
	var step;
	step = (grain_dur / 1000) - (overlap / 1000);
	if (step <= 0){
		step = grain_dur / 1000;
		"Overlap set to 0 due to a value higer than graindur".postln
	};
	step
};
// generation of random configuration
~randConfig = {|side|
	var matrix;
	matrix = Array.fill(side*side, { rrand(0,1) }).clump(side);
	~cagrid.setNodeStates_(matrix);
};
// generate a fixed number of active cells in random positions
~randConfigSized = {|side,size|
	var matrix;
	matrix = Array.fill(side*side, 0).clump(side);
	size.do{
		var x,y;
		x = rand(side);
		y = rand(side);
		matrix[x][y] = 1;
	};
	~cagrid.setNodeStates_(matrix);
};
// generalized serie used for spectral design
~generalizedserie = {|base,n,alpha,beta,gamma|
	var freq;
	freq = base * ( n.pow(alpha) * beta.pow(n) + gamma );
	/*	Theory
	α=1,β=1andγ=0generatestheharmonicseries;
	α=0,β>1andγ=0generatesthegeometricseries;
	α>1,β=1andγ=0generatestheexpanded-harmonicseries;
	α<1,β=1andγ=0generatesthecompressed-harmonicseries;
	*/
};
// determines stale states and the duration of the stale state
~checkgridstatus = {
	var current, last,status, continue;
	current = ~ss_gridcontent;
	// check if it's the first time the CA reached a stationary configuration
	if (~ss_gridcontentlast!=nil){
		// check if in cycle mode
		if (~ss_cyclemode==1) {
			// Check if current configuration is equal to the last config
			if (~ss_gridcontentlast==~ss_gridcontent){
				// check if reached the max poop number
				if (~currloop>=~maxloops) {
					~currloop = 0;
					// check if random is normal or sized
					if (~sized==0) {
						"here".postln;
						~randConfig.value(~gridside);
					} {
						{ ~randConfigSized.value(~gridside,~carandConfigSizedNbox.value) }.defer
					};
				} {
					~currloop = ~currloop + 1
				};
				{ ~caloop_current.value = ~currloop }.defer;
			};
		};
	};
	~ss_gridcontentlast=~ss_gridcontent
};
// select the actice CA to use and calls the ca function
~caSelect = {|ca|
	case
	{ ca == "gol" } { ~ss_gridcontent = ~gameOfLife.value(~cagrid,~gridside,~gridside); }
	{ ca == "wolf" } { ~ss_gridcontent = ~wolfram.value(~wolfCurrRow,~wolframRule,~cagrid,16,16) };
	~checkgridstatus.value();
};
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
