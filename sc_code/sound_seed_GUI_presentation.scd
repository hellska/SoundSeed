// ~sss_master_win.endFullScreen //
// this function draws GUI objects
~sound_seed_GUI_creator = {
	var screenx, screeny, viewx, viewy, viewxpos, viewypos;
	screenx = 1440;
	screeny = 900;
	viewx = 800;
	viewy = 800;
	viewxpos = (screenx/2)-(viewx/2);
	viewypos = (screeny/2)-(viewy/2);
	~sss_master_win = Window.new("SoundSeed").front.setTopLeftBounds(Rect(0, 0, screenx, screeny)).fullScreen;
//	~soundseed_w = Window.new("Sound Seed").front.setTopLeftBounds(Rect(0, 0, 600, 350)).fullScreen;
	~soundseed_w = CompositeView(~sss_master_win, Rect(viewxpos, viewypos, viewx, viewy));

// grid controls
	~soundSeedGridArea = CompositeView(~soundseed_w, Rect(0,0,viewx/2,viewy/2));
	~cagrid = BoxGrid.new(~soundSeedGridArea,bounds:Rect(0, 0, 300, 300),columns:~gridside,rows:~gridside);
	~stepgrid = BoxGrid.new(~soundSeedGridArea,Rect(17,322,266,16),16,1);
	// grid controls --- nel frame della griglia
	~cleargridButton = Button(~soundSeedGridArea,Rect(332,279,50,20));
	~drawmodeButton = Button(~soundSeedGridArea,Rect(332,301,50,20));

// sequencer controls
	~soundSeedControlArea = CompositeView(~soundseed_w, Rect(viewx/2,0,400,350));

	~caplay = Button(~soundSeedControlArea,Rect(0,0,70,70));

	// cycle area
	~soundSeedCycleArea = CompositeView(~soundSeedControlArea,Rect(130,10,245,50));
	~carestart_label = StaticText(~soundSeedCycleArea,Rect(0,0,60,15))
	.backColor_(Color.white).string_("mode").align_(\center);
	~caloops_label = StaticText(~soundSeedCycleArea,Rect(60,0,60,15))
	.backColor_(Color.white).string_("cycle").align_(\center);
	~caloop_current_label = StaticText(~soundSeedCycleArea,Rect(115,0,60,15))
	.backColor_(Color.white).string_("loop").align_(\center);
	~carestart = Button(~soundSeedCycleArea,Rect(5,15,50,20));
	~caloops = NumberBox(~soundSeedCycleArea,Rect(65,15,50,20))
	.value_(~maxloops).clipLo_(0).clipHi_(10000).decimals_(0)
	.action_{|me| ~maxloops = me.value };
	~caloop_current = NumberBox(~soundSeedCycleArea,Rect(120,15,50,20))
	.value_(~currloop).clipLo_(0).decimals_(0).enabled_(false);

	// frequency serie controls area
	~soundSeedSerieArea = CompositeView(~soundSeedControlArea,Rect(0,90,320,50));
	~graintype = Button(~soundSeedSerieArea,Rect(0,0,50,30));
	~grainfreqserie = Button(~soundSeedSerieArea,Rect(60,0,140,30));
	~seriebasefreq = NumberBox(~soundSeedSerieArea,Rect(210,0,40,30));
	~serie_alpha_label = StaticText(~soundSeedSerieArea,Rect(260,0,30,15))
	.backColor_(Color.white).string_("α").align_(\center);
	~serie_beta_label = StaticText(~soundSeedSerieArea,Rect(290,0,30,15))
	.backColor_(Color.white).string_("β").align_(\center);
	~serie_alpha = Knob(~soundSeedSerieArea,Rect(260,15,30,30))
	.value_(~alpha).step_(0.001)
	.action_{|me|
		var val;
		val = ((me.value*~alphamul)+~alphadd).round(0.001);
		~serie_alpha_view.string=("α:"++val); ~alpha=val
	};
	~serie_beta = Knob(~soundSeedSerieArea,Rect(290,15,30,30))
	.value_(~beta).step_(0.001)
	.action_{|me|
		var val;
		val = ((me.value*~betamul)+~betaadd).round(0.001);
		~serie_beta_view.string=("β:"++val); ~beta=val
	};

	// grain control area
	~soundSeedGrainArea = CompositeView(~soundSeedControlArea,Rect(0,150,170,40));
	~grain_dur_label = StaticText(~soundSeedGrainArea,Rect(0,0,50,15))
	.backColor_(Color.white).string_("grain").align_(\center);
	~grain_overlap_label =StaticText(~soundSeedGrainArea,Rect(50,0,60,15))
	.backColor_(Color.white).string_(" overlap").align_(\center);
	~grain_random_density_label = StaticText(~soundSeedGrainArea,Rect(110,0,60,15))
	.backColor_(Color.white).string_("rnd").align_(\center);
	~grain_dur_number = NumberBox(~soundSeedGrainArea,Rect(0,15,45,20))
	.value_(~grain_dur/1000).clipLo_(0.04).clipHi_(20).decimals_(3).step_(0.005)
	.action_{|me|
		var old_dur, delta_dur, bpm;
		old_dur = ~grain_dur;
		~grain_dur = me.value * 1000;
		delta_dur = ~grain_dur - old_dur;
		// fix tempo
		if (~grain_fix_timestep.value==1){
			~overlap = ~overlap + ( delta_dur );
			~grain_overlap_number.value_(~overlap/1000);
		};
		~timestep = ~timestep_calc.value(~grain_dur,~overlap);
		// bpm = 60 / ~timestep;
		bpm = ~timestep * 16;
		~timestep_viewer.string_("dT:"++~timestep++"c:"++bpm);
		~grain_overlap_number.clipHi = (me.value-0.01);
	};
	~grain_fix_timestep = Button(~soundSeedGrainArea,Rect(45,15,15,15))
	.states_([["<>",Color.black,Color.gray],["<>",Color.black,Color.green]])
	.font_("Courier",8);
	~grain_overlap_number = NumberBox(~soundSeedGrainArea,Rect(60,15,45,20))
	.value_(~overlap/1000).clipLo_(0).clipHi_(5).decimals_(3).step_(0.005)
	.action_{|me|
		var old_ove, delta_ove, bpm;
		old_ove = ~overlap;
		~overlap = me.value*1000;
		delta_ove = ~overlap - old_ove;
		if (~grain_fix_timestep.value==1){
			~grain_dur = ~grain_dur + ( delta_ove );
			~grain_dur_number.value_(~grain_dur/1000);
		};
		~timestep = ~timestep_calc.value(~grain_dur,~overlap);
		// bpm = 60 / ~timestep;
		bpm = ~timestep * 16;
		~timestep_viewer.string_("dT:"++~timestep++"c:"++bpm);
	};
	~grain_random_density_number = NumberBox(~soundSeedGrainArea,Rect(117,15,46,20))
	.value_(~rnd).clipLo_(0).clipHi_(20).decimals_(3).step_(0.005)
	.action_{|me|
		~rnd = me.value
	};

	// V O L U M E
	~overall_amp_control = Slider(~soundSeedControlArea,Rect(340,0,40,300)).value_(~overall_amp)
	.action_{|me| ~overall_amp = me.value; ~overall_amp_value.value = me.value.ampdb };
	~overall_amp_value = NumberBox(~soundSeedControlArea,Rect(340,301,40,20))
	.value_(~overall_amp.ampdb).align_(\center).enabled_(false).backColor_(Color.gray);

	// CA Controls area
	~soundSeedCAArea = CompositeView(~soundSeedControlArea,Rect(100,230,150,70));
	~golButton = Button(~soundSeedCAArea,Rect(0,0,40,30));
	~wolfButton = Button(~soundSeedCAArea,Rect(70,0,40,30));
	~wolfRuleNumber = NumberBox(~soundSeedCAArea,Rect(112,0,30,30))
	.value_(~wolframRule).clipLo_(1).clipHi_(256).decimals_(0)
	.action_{|me| ~wolframRule = me.value.asInt };
	~carandConfig = Button(~soundSeedCAArea,Rect(0,40,60,30));
	~carandConfigSized = Button(~soundSeedCAArea,Rect(70,40,40,30));
	~carandConfigSizedNbox = NumberBox(~soundSeedCAArea,Rect(112,40,30,30));

	// viewer area - without CompositeView
	~timestep_viewer = StaticText(~soundSeedControlArea,Rect(0,322,130,15))
	.backColor_(Color.black).string_("dT:"++~timestep+"c:"++(~timestep*16)).stringColor_(Color.green)
	.align_(\left).font_("Courier");
	~serie_alpha_view = StaticText(~soundSeedControlArea,Rect(140,322,60,15))
	.backColor_(Color.black).stringColor_(Color.green).align_(\left)
	.font_("Courier").string_("α:"++~alpha);
	~serie_beta_view = StaticText(~soundSeedControlArea,Rect(210,322,60,15))
	.backColor_(Color.black).stringColor_(Color.green).align_(\left)
	.font_("Courier").string_("β:"++~beta);

	// define GUI objects behaviour
	~stepgrid
	.setFillColor_(Color.red)
	.setBackgrColor_(Color.white);
	~caplay
	.states_([
		["PLAY >",Color.black,Color.gray],
		["PLAY >",Color.black,Color.green]])
	.action_({|me|
		if (me.value==1){
			~tas.play
		} {
			~tas.stop
	}});
	~carestart
	.states_([
		["single",Color.black,Color.gray],
		["loop",Color.black,Color.green]])
	.action_({|me|
		~ss_cyclemode = me.value;
	}).value_(1);
	~graintype
	.states_([
		["Sine",Color.black,Color.white],
		["Saw",Color.black,Color.yellow],
		["Square",Color.black,Color.red]])
	.action_({|me|
		case
		{me.value==0} {~synthez="sinegrain"}
		{me.value==1} {~synthez="sawgrain"}
		{me.value==2} {~synthez="pulsegrain"};
	})
	.enabled_(false);
	~carandConfig
	.states_([["Random",Color.black,Color.gray]])
	.action_({|me|
		if (~currca=="wolf") { ~wolfCurrRow = 1 };
		if (~carandConfigSized.value==0) {
			~randConfig.value(~gridside)
		} {
			~randConfigSized.value(~gridside,~carandConfigSizedNbox.value)
		}
	});
	~carandConfigSized
	.states_([
		["cells",Color.black,Color.gray],
		["cells",Color.black,Color.green]])
	.action_{|me|
		~sized = me.value;
		~sized.postln;
	};
	~carandConfigSizedNbox.value_(45);
	~grainfreqserie
	.states_([
		["harmonic serie",Color.black,Color.cyan],
		["geometric serie",Color.black,Color.green],
		["expanded harmonic",Color.black,Color.white],
		["compressed harmonic",Color.white,Color.black]
	])
	.action_({|me|
		case
		{ me.value==0 } { ~freqserie = 0;
			~alpha = 1.000;
			~alphamul = 0;
			~alphadd = 1.000;
			~beta = 1.000;
			~betamul = 0;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(false);
			~serie_beta.enabled_(false);
		}
		{ me.value==1 } { ~freqserie = 1; // 0,1.456,0
			~alpha = 0.000;
			~alphamul = 0;
			~alphadd = 0;
			~beta = 1.456;
			~betamul = 0.55;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(false);
			~serie_beta.enabled_(true);
		}
		{ me.value==2 } { ~freqserie = 2; // 1.5,1,0
			~alpha = 1.500;
			~alphamul = 5.000;
			~alphadd = 1.000;
			~beta = 1.000;
			~betamul = 0;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(true);
			~serie_beta.enabled_(false);
		}
		{ me.value==3 } { ~freqserie = 3; // 0.5,1,0
			~alpha = 0.500;
			~alphamul = 1;
			~alphadd = 0;
			~beta = 1.000;
			~betamul = 0;
			~betaadd = 1.000;
			~gamma = 0;
			~serie_alpha.enabled_(true);
			~serie_beta.enabled_(false);
		};
		~serie_alpha.value = ~alpha;
		~serie_alpha_view.string = ("α:"++~alpha);
		~serie_beta.value = ~beta;
		~serie_beta_view.string = ("β:"++~beta);
	});
	~seriebasefreq.value_(~bsfreq)
	.action_({|me| ~bsfreq = me.value });
	~golButton
	.states_([["GoL",Color.black,Color.gray]])
	.action_({ ~currca = "gol" });
	~wolfButton
	.states_([["Wolf",Color.black,Color.gray]])
	.action_({|me| ~currca = "wolf"; ~wolfCurrRow = 1 });
	~cleargridButton
	.states_([["clear",Color.black,Color.gray]])
	.action_({|me| ~cagrid.clearGrid });
	~drawmodeButton
	.states_([["delete",Color.black,Color.cyan],["trail",Color.black,Color.magenta]])
	.action_({|me|
		if (me.value==0) { ~cagrid.setTrailDrag_(false) };
		if (me.value==1) { ~cagrid.setTrailDrag_(true) };
	});
	~serie_alpha.enabled_(false);
	~serie_beta.enabled_(false);
	/// Not used In Presentation BEGIN
	// activate deactivate mapping panel
	/*
	~ss_mapping_panel_show = Button(~soundseed_w,Rect(0,340,600,10))
	.states_([["v",Color.black,Color.gray],["/\\",Color.black,Color.gray]])
	.action_{|me|
		case
		{me.value==0}{ ~soundseed_w.setTopLeftBounds(Rect(0, 0, 600, 350)) }
		{me.value==1}{ ~soundseed_w.setTopLeftBounds(Rect(0, 0, 600, 600)) };
	};
	*/
	/// Not used In Presentation END
	////// mapping panel definition
	~ss_mapping_panel_gui = CompositeView(~soundseed_w,Rect(0,350,viewx,250))
	.backColor_(Color.white);
	~ss_mapping_panel_label = StaticText(~ss_mapping_panel_gui,Rect(0,0,600,20))
	.string_("M A P P I N G   P A N E L",Color.black,Color.grey).align_(\center);

	~ss_play_file_button = Button(~ss_mapping_panel_gui,Rect(210,20,90,40))
	.states_([["P L A Y",Color.black,Color.green]])
	.action_{|me| ~ss_filebuf.play; };
	// drag and drop area for files
	~ss_dragFile = DragSink(~ss_mapping_panel_gui,Rect(310,20,280,40))
	.align_(\center).string="Drag a file here";
	~ss_dragFile.receiveDragHandler = {|v|
		var filename;
		~ss_dragFile.background_(Color.red);
		~ss_dragFile.string_("N O T   L O A D E D!");
		filename = View.currentDrag.asString;
		if (File.type(filename)=="regular".asSymbol)
		{ ~ss_filebuf = ~ss_loadDragFileInBuffer.value(filename, ~ss_dragFile) }
		{ ~ss_dragFile.string = "I'm not a regular file!";
			~ss_dragFile.background_(Color.clear);	};
	};

	// mapping single controls set (create one for each feature)
	~ss_onoff_map1 = Button(~ss_mapping_panel_gui,Rect(20,80,20,20))
	.states_([["I/O"],["I/O",Color.black,Color.green]])
	.action_{|me| case
//		{me.value==0} { /* off feature */ ~ss_onoff_map1_func.value(me.value,0) }
//		{me.value==1} { /* on feature*/ ~ss_onoff_map1_func.value(me.value,0) }; };
		{me.value==0} { /* off feature */ ~ss_onoff_map1_func.value(me.value,~ss_feature_select.value) }
		{me.value==1} { /* on feature*/ ~ss_onoff_map1_func.value(me.value,~ss_feature_select.value) }; };
	~ss_from_in1 = Button(~ss_mapping_panel_gui,Rect(60,80,20,20))
	.states_([["In"],["In",Color.black,Color.green]])
	.action_{|me| case
		{me.value==0} { /* off input */ ~ss_from_file1.value_(1) }
		{me.value==1} { /* on input */ ~ss_from_file1.value_(0) }; }
	.value_(0).enabled_(\false);
	~ss_from_file1 = Button(~ss_mapping_panel_gui,Rect(90,80,20,20))
	.states_([["F"],["F",Color.black,Color.green]])
	.action_{|me| case
		{me.value==0} { /* off file */ ~ss_from_in1.value_(1) }
		{me.value==1} { /* on file */ ~ss_from_in1.value_(0) }; }
	.value_(1).enabled_(\false);
	~ss_feature_select = ListView(~ss_mapping_panel_gui,Rect(130,80,150,20))
	.items_(["pitch","centroid","spread","Peakiness"])
	.font_(Font("Courier",16))
	.action_{|me|
		var min, max, offset;
		offset = 5; // this is the number of parameters ranges present
		min = ~ss_load_range.value(0,me.value+5);
		max = ~ss_load_range.value(1,me.value+5);
//		~ss_param_select.items[me.value].postln;
		~ss_feat_min_range.clipLo_(min).clipHi_(max).value_(min);
		~ss_feat_max_range.clipLo_(min).clipHi_(max).value_(max);
	};
	~ss_param_select = ListView(~ss_mapping_panel_gui,Rect(310,80,280,20))
	.items_(["Fundamental frequency","Grain length","Density","Serie Alpha", "Serie Beta"])
	.font_(Font("Courier",16))
	.action_{|me|
		var min, max;
		// load the range of specific parameter
		min = ~ss_load_range.value(0,me.value);
		max = ~ss_load_range.value(1,me.value);
//		~ss_param_select.items[me.value].postln;
		// set the number boxes values
		~ss_param_min_range.clipLo_(min).clipHi_(max).value_(min);
		~ss_param_max_range.clipLo_(min).clipHi_(max).value_(max);
		// set the variables used for mapping
		~ss_set_range.value(0,me.value,~ss_param_min_range.value);
		~ss_set_range.value(1,me.value,~ss_param_max_range.value);
	};

	~ss_feat_min_range = NumberBox(~ss_mapping_panel_gui,Rect(130,105,70,20)).value_(0)
	.decimals_(3).clipLo_(~featminfreq).clipHi_(~featmaxfreq).value_(~featminfreq)
	.action_{|me| ~featminfreq = me.value };
	~ss_feat_max_range = NumberBox(~ss_mapping_panel_gui,Rect(210,105,70,20)).value_(20000)
	.decimals_(3).clipLo_(~featminfreq).clipHi_(~featmaxfreq).value_(~featmaxfreq)
	.action_{|me| ~featmaxfreq = me.value };
	~ss_param_min_range = NumberBox(~ss_mapping_panel_gui,Rect(310,105,70,20))
	.decimals_(3)
	.clipLo_(~ss_load_range.value(0,0))
	.clipHi_(~ss_load_range.value(1,0))
	.value_(~ss_load_range.value(0,0))
	.action_{|me| ~ss_set_range.value(0,~ss_param_select.value,me.value)};
	~ss_param_max_range = NumberBox(~ss_mapping_panel_gui,Rect(390,105,70,20))
	.decimals_(3)
	.clipLo_(~ss_load_range.value(0,0))
	.clipHi_(~ss_load_range.value(1,0))
	.value_(~ss_load_range.value(1,0))
	.action_{|me| ~ss_set_range.value(1,~ss_param_select.value,me.value)};


	// File names list
	~ss_file_list_array = ["Flute", "Harmonium", "Voices", "Drum", "Orchestra"];

	~ss_file_list = ListView(~ss_mapping_panel_gui,Rect(600,20,100,100))
	.items_(~ss_file_list_array)
	.action_{|it| it.value.postln;
		case
		{it.value==0} { ~ss_filebuf = Buffer.read(s,~ss_basepath++"/sounds/flute.aiff") }
		{it.value==1} { ~ss_filebuf = Buffer.read(s,~ss_basepath++"/sounds/harmonium.aiff") }
		{it.value==2} { ~ss_filebuf = Buffer.read(s,~ss_basepath++"/sounds/street-voices.wav") }
		{it.value==3} { ~ss_filebuf = Buffer.read(s,~ss_basepath++"/sounds/slow-drum-loop.wav") }
		{it.value==4} { ~ss_filebuf = Buffer.read(s,~ss_basepath++"/sounds/orchestra-fragment.wav") };
	};
	// mapping single control set END
};
////////// GUI END ///////////
//// G U I   R E L A T E D   F U N C T I O N ////
~ss_loadDragFileInBuffer = {|inputfile, drag_obj|
	var buff, filename;
	filename = inputfile.asString.split($/);
	filename = filename[filename.size-1];
	buff = Buffer.read(s,inputfile.absolutePath,action:{
		{ drag_obj.string_("file "++filename++" loaded!");
			drag_obj.background_(Color.clear);}.defer;
	});
	buff
};
// check the input of the feature
~ss_feature_input = {|action,numer|
	// the function returns -1 if nothing selected, 1 for soundin, 2 for file input
	var return, who, feature, control;
	return = -255;
	who = "~ss_extractor"+numer.asSymbol;
	feature = ~ss_feature_select.value; // this comes in numer variable !!! check this out
	control = ~ss_param_select.value;
	if (~ss_from_in1.value==0) {
		if (~ss_from_file1.value==0) {
			"both file and soundin off - there's some error check implementation".postln;
			return = -1;
		} {
			if (action==0) { // spengo
				~ss_extractors[numer].set(\gate, 0);
				"OFF input from file!".postln;
				return = 2;
			} { // accendo
				// controllo il buffer
				if (~ss_filebuf.class.asString=="Buffer") {
					// check the feature here
					case
					{numer==0}
					{ ~ss_extractors.put(numer,	Synth(\filePitchDetectControl,
						[\buffer, ~ss_filebuf,\outCbus, ~featurebus[numer], \amp, 0.1])); }
					{numer==1}
					{ ~ss_extractors.put(numer, Synth(\fileSpecCentroid,
						[\buffer, ~ss_filebuf,\meanbuffer, ~ss_centroid_meanbuf,\outCbus, ~featurebus[numer], \amp, 0.1])) }
					{numer==2}
					{ ~ss_extractors.put(numer, Synth(\fileSpecSpread,
						[\buffer, ~ss_filebuf,\outCbus, ~featurebus[numer], \amp, 0.1])) }
					{numer==3}
					{ ~ss_extractors.put(numer, Synth(\fileSpecCrest,
						[\buffer, ~ss_filebuf, \outCbus, ~featurebus[numer], \amp, 0.1])) };
					// end check feature
					~currentbus = ~featurebus[numer]; // obsolete
					~mapping_busses_matrix.put(feature,control,~featurebus[numer]);
					"ON input from file!".postln;
					return = 2;
				} {
					"Buffer not set, load an audio file".postln;
					return = -2;
				};
			};

		};
	};
	if (~ss_from_in1.value==1) {
		if (action==0) { // spengo
			("spengo"+who).postln;
			~ss_extractors[numer].set(\gate, 0);
		} { // accendo
			("accendo"+who).postln;
			case
			{numer==0}
			{ ~ss_extractors.put(numer, Synth(\inPitchDetectControl, [\outCbus, ~featurebus[numer]])) }
			{numer==1}
			{ ~ss_extractors.put(numer, Synth(\soundinSpecCentroid, [\outCbus, ~featurebus[numer]])) }
			{numer==2}
			{ ~ss_extractors.put(numer, Synth(\soundinSpecSpread, [\outCbus, ~featurebus[numer]])) }
			{numer==3}
			{ ~ss_extractors.put(numer, Synth(\soundinSpecCrest, [\outCbus, ~featurebus[numer]])) };
			// set current bus in use
			~currentbus = ~featurebus[numer]; // obsolete
			~mapping_busses_matrix.put(feature,control,~featurebus[numer]);
		};
		"input from Soundin!".postln;
		return = 1;
	};
	return
};

// check the feature selected and start the task
~ss_mapping_set = {|action,number|
	var feature,control;
	feature = ~ss_feature_select.value;
	control = ~ss_param_select.value;
	("Feat:"+feature+"Control:"+control).postln;
	// retrieve the function from the two dimension array
	if (action==1) {
		~mapping_tasks_matrix.at(feature,control).start;
	} {
		~mapping_tasks_matrix.at(feature,control).stop;
	};
};

// activate deactivate mapping
~ss_onoff_map1_func = {|action,number|
	var input, feature, param;
	// check and set input
	input = ~ss_feature_input.value(action,number);
	if (input>=0) {
		// check and set output and mapping
		feature = ~ss_mapping_set.value(action,number);

		case
		{ action == 0 } {
			// actions on gui
			~ss_from_in1.enabled_(\true);
			~ss_from_file1.enabled_(\true);
			~ss_feature_select.enabled_(\true);
			~ss_param_select.enabled_(\true);

		}
		{ action == 1 } {
			// actions on gui
			~ss_from_in1.enabled_(\false);
			~ss_from_file1.enabled_(\false);
			~ss_feature_select.enabled_(\false);
			~ss_param_select.enabled_(\false);

		};

	} {
		~ss_onoff_map1.value_(0);
	};
};

