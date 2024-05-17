clc;

r = 4; % mismo radio de las figuras    
g = 9.81; 

h0 = 8; % altura inicial

% intervalo de tiempo
t0 = 0;
tf = 100;

% Determinar la altura del agua en cada instante de tiempo
[t,h] = ode45(@cilindro, [t0,tf], h0);
[t2,h2] = ode45(@cono, [t0,tf], h0);

h = real(h);
h2 = real(h2);

%plot(t,h);
%plot(t2,h2);

video = VideoWriter('cilindro_cono_mov');
video.FrameRate = 5;

open(video);

for ht = h'

    if ht < 0.01
        break;
    end

    % Centro del cilindro 
    x = 0;
    y = 0;

    % Centro cono
    x2 = 8;
    y2 = 8;

    % Fijamos ejes
    xlim([-10,15])
    ylim([-10,15])
    zlim([0,8]) 
    view(60,30)

    % esto es para el cilindro
    [X, Y, Z] = cylinder(r);

    hold on;
    surf(X + x, Y + y, Z * ht, 'facecolor', 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none')
    hold off;

    % esto para el cono
    [X2, Y2, Z2] = cylinder([0, r]);

    hold on;
    surf(X2 + x2, Y2 + y2, Z2 * ht, 'facecolor', 'r', 'FaceAlpha', 0.5, 'EdgeColor', 'none')
    hold off;

    secuencia_frame = getframe(gcf);
    writeVideo(video, secuencia_frame);
    cla

end

close(video);
implay('cilindro_cono_mov')


%Ec dif cilindro
function ht = cilindro(t, h)
    ht = -4*sqrt(2*9.81*h)/(pi*4^2);
end

%Ec dif cono
function ht = cono(t, h)
    ht = -4*5*sqrt(2*9.81*h)/(pi*4^2);
end
