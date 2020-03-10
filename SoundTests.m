% play harry potter main theme

tempo=44*1.5;%bpm
beat=60/tempo;
play_note('B4',beat/2);

play_note('E4',beat*1.5,'no_pause');
play_note('E5',beat*1.5/2);
play_note('G5',beat/4);
play_note('F#5',beat/2);

play_note('E4',beat*1.5,'no_pause');
play_note('E5',beat);
play_note('B5',beat/2);

play_note({'A5','E4'},beat*1.5);

play_note({'F#5','E4'},beat*1.5);

play_note('E4',beat*1.5,'no_pause');
play_note('E5',beat*1.5/2);
play_note('G5',beat/4);
play_note('F#5',beat/2);

play_note({'D#5','A#4'},beat);
play_note({'F5','B3'},beat/2);


play_note('B4',beat*2.5,'no_pause');
play_note('E4',beat);
play_note('G4',beat/2);
play_note('B3',beat);

