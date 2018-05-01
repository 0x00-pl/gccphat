ang = 0.5 + 0.8660254037844387j;
a = 7;
b = 20;
c = 12;

r = c
r = r*ang
r = r + b
r = r*ang
r = r + a

ang = angle(r)
ch = atan2(imag(r), real(r))/(pi/2)*3


sign_tab = [
     1 -1 -1;
     1  1 -1;
    
    ]

wa = acos(a/21);