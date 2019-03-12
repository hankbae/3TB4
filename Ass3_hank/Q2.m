% ------- FIXED POINT Q1.7 ---------- 
F = fimath('ProductMode','SpecifyPrecision','ProductWordLength',8,'ProductFractionLength',7); %product is Q1.7

y_fix = sfi(0,8,7); % initial state of 0
gain_fix = sfi(-0.982,8,7);

res_fix = zeros(100,2);
res_fix(:,1) = 1:100;

for i=1:100
    res_fix(i,2) = y_fix;
    y_fix = mpy(F,gain_fix,y_fix)+sfi(1,8,7);
end

figure(1);
plot(res_fix(:,1),res_fix(:,2));
title('fixed point step response');

% -------- FLOATING POINT ---------
y_float = 0.0;
gain_float = -0.982;

res_float = zeros(100,2);
res_float(:,1) = 1:100;

for i=1:100
    res_float(i,2) = y_float;
    y_float = gain_float*y_float+1.0;
end
figure(2);
plot(res_float(:,1),res_float(:,2));
title('floating point step response');


% -------- DIFFERENCE ------------ 

res_diff = zeros(100,2);
res_diff(:,1) = 1:100;

res_diff(:,2) = res_float(:,2) - res_fix(:,2);

figure(3);
plot(res_diff(:,1),res_diff(:,2));
title('difference');



