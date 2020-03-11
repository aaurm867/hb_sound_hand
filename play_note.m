% TODO: make it sound like a motor: https://www.youtube.com/watch?v=zTvsOQjNbCc

function play_note(notes,duration,amplitude,no_pause)
    if nargin<4
        no_pause=0;
    else
        no_pause=no_pause=='no_pause';
    end
    disp(notes)
    all_notes={'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
    if ~iscell(notes)
        notes={notes};
    end
    fs=8192;  % sampling frequency
    values=0:1/fs:duration;
    a=zeros(size(values));
    for i=1:length(notes)
        note_str=notes{i};
        note=60+(find(strcmp(all_notes,note_str(1:end-1)))-1)+(note_str(end)-'4')*12;
        freq=440 * 2^((note-69)/12);
        a=a+amplitude*sin(2*pi* freq*values)/length(notes).*(1-1./(exp(200*values))).*(1./(exp(3*values)));
    end
    sound(a,fs)
    if ~no_pause
        pause(duration);
    end
end



