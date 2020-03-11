% Parameters
joystick=true;

frequency=20;
xy_speed=0.2;
z_speed=0.1;
wrist_speed=2;
finger_speed=0.5;
thumb_speed=0.5/1.6;
abd_speed=0.1;
rot_speed=0.2;

% Computed variables
delta_t=1/frequency;


% Initialize haptix
addpath('./lib/mjhaptix/');
hx_close()
hx_connect('');

% Initialize controller
if joystick
    joy=vrjoystick(1);
end

%Initialize ros (for fixed rate loop)
rosshutdown;
rosinit();
rate=rosrate(frequency);

%Loop
while mj_connected() == 1
    
    mocap=mj_get_mocap();
    control=mj_get_control();
    if joystick
        [axes, buttons, povs] = read(joy); % read controller data
        axes(abs(axes)<0.1)=0; %deadband axes close to zero
        axes(end+1)=(povs(1)~=-1)*sind(povs(1)); %treat povx as axis
        axes(end+1)=(povs(1)~=-1)*cosd(povs(1)); %treat povy as axis
        axes(end+1)=buttons(5)-buttons(6); %treat l1/r1 as axis
        axes(end+1)=buttons(3)-buttons(2); %treat x/b as axis


        mocap.pos(1)=mocap.pos(1)+xy_speed*axes(1)*delta_t; % x position
        mocap.pos(2)=mocap.pos(2)-xy_speed*axes(2)*delta_t; % y position
        mocap.pos(3)=mocap.pos(3)+z_speed*axes(7)*delta_t; % z position
        control.ctrl(1)=control.ctrl(1)+wrist_speed*axes(6)*delta_t; % pronation
        mocap.quat(1)=mocap.quat(1)+rot_speed*axes(4)*delta_t; % udev
        control.ctrl(3)=control.ctrl(3)+wrist_speed*axes(5)*delta_t; % flexion


        control.ctrl(4)=control.ctrl(4)+finger_speed*axes(8)*delta_t; % thumb rotation
        control.ctrl(5)=control.ctrl(5)+thumb_speed*axes(3)*delta_t; % thumb
        control.ctrl(9)=control.ctrl(9)+finger_speed*axes(3)*delta_t; % index
        control.ctrl(10)=control.ctrl(10)+finger_speed*axes(3)*delta_t; % middle
        control.ctrl(11)=control.ctrl(11)+finger_speed*axes(3)*delta_t; % ring
        control.ctrl(13)=control.ctrl(13)+finger_speed*axes(3)*delta_t; % pinky

        control.ctrl(8)=control.ctrl(8)+abd_speed*axes(9)*delta_t; % fingers abd
        control.ctrl(12)=control.ctrl(12)+abd_speed*axes(9)*delta_t; % fingers abd




        % reset if back is pressed
        if buttons(7)
            control.ctrl(:)=0;
            control.ctrl(4)=0.53;
            control.ctrl(6)=0.23;
            control.ctrl(7)=0.53;
        end

        % reset wrist if pad is pressed
        if buttons(10)
            control.ctrl(1:3)=0;
        end
    end
    mj_set_mocap(mocap);
    mj_set_control(control);
    
    time = rate.TotalElapsedTime;
    fprintf('Time Elapsed: %f\n',time)
    disp(mocap.pos)
    disp(control.ctrl(1:10).')
    waitfor(rate);
end
fprintf("Disconnected\n")