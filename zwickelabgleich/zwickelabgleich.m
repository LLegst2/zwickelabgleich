function [diffu, diffu2, position] = zwickelabgleich (csvFile,reg1Start=1, reg1End=50, reg2Start=50, reg2End=0, counter=70) 
#, diff1, diff2, x1, x2, reg1, reg2
	#,reg1Start, reg1End, reg2Start, reg2End, start
# load data
M   = csvread(csvFile);
vx  = M([1:end],[1]);
vy  = M([1:end],[2]);
len = length(vy);

# make linear regressions
reg1   = polyfit(vx(reg1Start:reg1End)',vy(reg1Start:reg1End)', 1);
funct1 = @ (x) (reg1(1) * x + reg1(2));

# make linear regression 2
reg2   = polyfit(vx(len-reg2Start:len-reg2End)',vy(len-reg2Start:len-reg2End)', 1);
funct2 = @ (x) (reg2(1) * x + reg2(2));

# seek the point of inversion, where both areas are the same size
areaLeft  = 0;
areaRight = 1;

# Schleife begewegt Grenze der zwei Flächen von links nach rechts
while (areaLeft < areaRight )

	areaLeft  = trapz(vx(1:counter),vy(1:counter)) - quad(funct1,vx(1),vx(counter));
	areaRight = quad(funct2,vx(counter+1),vx(len))        - trapz(vx(counter+1:len),vy(counter+1:len));
	counter++;
endwhile



# calc diff
diffu  = funct2(vx(counter))   - funct1(vx(counter));
diffu2 = funct2(vx(counter-1)) - funct1(vx(counter-1));

position = vx(counter);

senkrechtY = linspace(funct1(vx(counter)),funct2(vx(counter))); 
senkrechtLeng = length(senkrechtY);
senkrechtX = repmat(vx(counter), senkrechtLeng);

# plot it nicely
dataplot = [vx vy]';

plot(
	vx,vy, "-r;Data;", 
	vx(counter), vy(counter), "+m;Point of Inversion;", 
	vx(reg1Start:reg1End)',vy(reg1Start:reg1End)', "*b;1 Regression Values;",
	vx(len-reg2Start:len-reg2End)',vy(len-reg2Start:len-reg2End)', "*r;2 Regression Values;",
	polyval([reg1(1) reg1(2)], 0:vx(len)),"-b;Regression 1;",
	polyval([reg2(1) reg2(2)], 0:vx(len)),"-r;Regression 2;", 
	senkrechtX, senkrechtY
	);


endfunction

