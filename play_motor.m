% TODO: make it sound like a motor: https://www.youtube.com/watch?v=zTvsOQjNbCc

function play_motor(motor,note_str,duration,amplitude,no_pause)
%     tic
    if nargin<5
        no_pause=false;
    end
    x_motor=motor{1};
    motor_fs=motor{2};
    x_motor=x_motor*amplitude/max(max(x_motor));
    motor_freq=157.1924;
    disp(note_str)
    all_notes={'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};

    note=60+(find(strcmp(all_notes,note_str(1:end-1)))-1)+(note_str(end)-'4')*12;
    freq=440 * 2^((note-69)/12);
    %y = modulate(x_motor,motor_freq-freq,motor_fs,'amssb');
    
    sound(x_motor(1:(duration*motor_fs)),motor_fs)
    
    
    
    
    
    
    
    
    
%     fs=floor(motor_fs*freq/motor_freq);
%     
%     x=x_motor(1:floor(duration*fs));
%     
%     
%     final_fs=8192;
%     final_x=resample(x, final_fs, fs);
%     disp(toc)
%     sound(final_x,final_fs)
    if ~no_pause
        pause(duration);
    end
end



