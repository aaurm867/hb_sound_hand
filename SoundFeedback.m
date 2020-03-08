addpath('./lib/mjhaptix/');
hx_connect('');

while mj_connected() == 1
   pause(2)
   fprintf("Connected\n")
end
fprintf("Disconnected\n")