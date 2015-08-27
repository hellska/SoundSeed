// this function draws GUI objects
~sound_seed_GUI_creator = {
	~soundseed_w = Window.new("Sound Seed").front.setTopLeftBounds(Rect(0, 0, 600, 350));
	~cagrid = BoxGrid.new(~soundseed_w,bounds:Rect(20, 20, 300, 300),columns:~gridside,rows:~gridside);
	~stepgrid = BoxGrid.new(~soundseed_w,Rect(37,322,266,16),16,1);
// sequencer controls
	~caplay = Button(~soundseed_w,Rect(350,20,30,35));
	~carestart_label = StaticText(~soundseed_w,Rect(385,20,60,15))
	.backColor_(Color.white).string_("mode").align_(\center);
	~caloops_label = StaticText(~soundseed_w,Rect(445,20,60,15))
	.backColor_(Color.white).string_("cycle").align_(\center);
	~caloop_current_label = StaticText(~soundseed_w,Rect(505,20,60,15))
	.backColor_(Color.white).string_("loop").align_(\center);
	~carestart = Button(~soundseed_w,Rect(390,35,50,20));
	~caloops = NumberBox(~soundseed_w,Rect(450,35,50,20))
	.value_(~maxloops).clipLo_(0).clipHi_(10000).decimals_(0)
	.action_{|me| ~maxloops = me.value };
	~caloop_current = NumberBox(~soundseed_w,Rect(510,35,50,20))
	.value_(~currloop).clipLo_(0).decimals_(0).enabled_(false);
// granular synthesis controls
	~graintype = Button(~soundseed_w,Rect(350,60,50,30));
	~grainfreqserie = Button(~soundseed_w,Rect(410,60,140,30));
	~seriebasefreq = NumberBox(~soundseed_w,Rect(552,60,40,30));
	~grain_dur_label = StaticText(~soundseed_w,Rect(350,95,50,15))
	.backColor_(Color.white).string_("grain").align_(\center);
	~grain_overlap_label =StaticText(~soundseed_w,Rect(400,95,60,15))
	.backColor_(Color.white).string_(" overlap").align_(\center);
	~grain_random_density_label = StaticText(~soundseed_w,Rect(460,95,60,15))
	.backColor_(Color.white).string_("rnd").align_(\center);
	~serie_alpha_label = StaticText(~soundseed_w,Rect(520,95,30,15))
	.backColor_(Color.white).string_("α").align_(\center);
	~serie_beta_label = StaticText(~soundseed_w,Rect(550,95,30,15))
	.backColor_(Color.white).string_("β").align_(\center);

	~grain_dur_number = NumberBox(~soundseed_w,Rect(350,110,45,20))
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

	~grain_fix_timestep = Button(~soundseed_w,Rect(395,112,15,15))
	.states_([["<>",Color.black,Color.gray],["<>",Color.black,Color.green]])
	.font_("Courier",8);

	~grain_overlap_number = NumberBox(~soundseed_w,Rect(410,110,45,20))
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
	~timestep_viewer = StaticText(~soundseed_w,Rect(350,132,115,15))
	.backColor_(Color.black).string_("dT:"++~timestep++"c:"++(~timestep*16)).stringColor_(Color.green);

	~grain_random_density_number = NumberBox(~soundseed_w,Rect(467,110,46,20))
	.value_(~rnd).clipLo_(0).clipHi_(20).decimals_(3).step_(0.005)
	.action_{|me|
		~rnd = me.value
	};
	~serie_alpha = Knob(~soundseed_w,Rect(520,110,30,30))
	.value_(~alpha).step_(0.001)
	.action_{|me|
		var val;
		val = ((me.value*~alphamul)+~alphadd).round(0.001);
		~serie_alpha_view.string=("α:"++val); ~alpha=val };
	~serie_alpha_view = StaticText(~soundseed_w,Rect(520,142,60,12))
	.backColor_(Color.black).stringColor_(Color.green).align_(\left)
	.font_("Courier").string_("α:"++~alpha);
	~serie_beta = Knob(~soundseed_w,Rect(550,110,30,30))
	.value_(~beta).step_(0.001)
	.action_{|me|
		var val;
		val = ((me.value*~betamul)+~betaadd).round(0.001);
		~serie_beta_view.string=("β:"++val); ~beta=val };
	~serie_beta_view = StaticText(~soundseed_w,Rect(520,154,60,12))
	.backColor_(Color.black).stringColor_(Color.green).align_(\left)
	.font_("Courier").string_("β:"++~beta);

	~overall_amp_control = Slider(~soundseed_w,Rect(530,180,40,130)).value_(~overall_amp)
	.action_{|me| ~overall_amp = me.value; ~overall_amp_value.value = me.value.ampdb };
	~overall_amp_value = NumberBox(~soundseed_w,Rect(530,310,40,20))
	.value_(~overall_amp.ampdb).align_(\center).enabled_(false).backColor_(Color.gray);
// CA Controls
	~golButton = Button(~soundseed_w,Rect(370,170,40,30));
	~wolfButton = Button(~soundseed_w,Rect(440,170,40,30));
	~wolfRuleNumber = NumberBox(~soundseed_w,Rect(482,170,30,30))
	.value_(~wolframRule).clipLo_(1).clipHi_(256).decimals_(0)
	.action_{|me| ~wolframRule = me.value.asInt };
	~carandConfig = Button(~soundseed_w,Rect(370,210,60,30));
	~carandConfigSized = Button(~soundseed_w,Rect(440,210,40,30));
	~carandConfigSizedNbox = NumberBox(~soundseed_w,Rect(482,210,30,30));
// grid controls
	~cleargridButton = Button(~soundseed_w,Rect(332,279,50,20));
	~drawmodeButton = Button(~soundseed_w,Rect(332,301,50,20));
// define GUI objects behaviour
	~stepgrid
	.setFillColor_(Color.red)
	.setBackgrColor_(Color.white);
	~caplay
	.states_([
		[">",Color.black,Color.gray],
		[">",Color.black,Color.green]])
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
	});
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

	// activate deactivate mapping panel
	~ss_mapping_panel_show = Button(~soundseed_w,Rect(0,340,600,10))
	.states_([["v",Color.black,Color.gray],["/\\",Color.black,Color.gray]])
	.action_{|me|
		case
		{me.value==0}{ ~soundseed_w.setTopLeftBounds(Rect(0, 0, 600, 350)) }
		{me.value==1}{ ~soundseed_w.setTopLeftBounds(Rect(0, 0, 600, 600)) };
	};
	////// mapping panel definition
	~ss_mapping_panel_gui = CompositeView(~soundseed_w,Rect(0,350,600,250))
	.backColor_(Color.white);
	~ss_mapping_panel_label = StaticText(~ss_mapping_panel_gui,Rect(0,0,600,20))
	.string_("MAPPING PANEL",Color.black,Color.grey).align_(\center);

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
		{me.value==0} { /* off feature */ ~ss_onoff_map1_func.value(me.value,0) }
		{me.value==1} { /* on feature*/ ~ss_onoff_map1_func.value(me.value,0) }; };
	~ss_from_in1 = Button(~ss_mapping_panel_gui,Rect(60,80,20,20))
	.states_([["In"],["In",Color.black,Color.green]])
	.action_{|me| case
		{me.value==0} { /* off input */ ~ss_from_file1.value_(1) }
		{me.value==1} { /* on input */ ~ss_from_file1.value_(0) }; }
	.value_(1);
	~ss_from_file1 = Button(~ss_mapping_panel_gui,Rect(90,80,20,20))
	.states_([["F"],["F",Color.black,Color.green]])
	.action_{|me| case
		{me.value==0} { /* off file */ ~ss_from_in1.value_(1) }
		{me.value==1} { /* on file */ ~ss_from_in1.value_(0) }; }
	.value_(0);
	~ss_feature_select = ListView(~ss_mapping_panel_gui,Rect(130,80,150,20))
	.items_(["pitch","centroid","spread","energy"])
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
		min = ~ss_load_range.value(0,me.value);
		max = ~ss_load_range.value(1,me.value);
//		~ss_param_select.items[me.value].postln;
		~ss_param_min_range.clipLo_(min).clipHi_(max).value_(min);
		~ss_param_max_range.clipLo_(min).clipHi_(max).value_(max);
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
	feature = ~ss_feature_select.value;
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
					~ss_extractors.put(numer,
						Synth(\filePitchDetectControl,
							[\buffer, ~ss_filebuf,
								\outCbus, ~featurebus[numer]]
						);
					);
					// end check feature
					~currentbus = ~featurebus[numer];
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
			~ss_extractors.put(numer,
				Synth(\inPitchDetectControl,
					[\outCbus, ~featurebus[numer]]
				);
			);
			~currentbus = ~featurebus[numer];
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

