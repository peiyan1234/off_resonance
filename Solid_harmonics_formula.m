function SH_f=Solid_harmonics_formula(N,M)
% clear all; clc

% fprintf('This code will output a formula of regular solid spherical harmonic functions written in Cartesian form in a real basis. \n')
% fprintf('You should input two indices of it to get the formula you want, \n')
% fprintf('including an order n and a degree m for which |m| < n. \n');

% Created by Pei-Yan, Li.
% National Taiwan University.

syms n m x y z k
fn(n, m, k)=factorial(n-m)*((-1)^(k+m))*((x+1i*y)^(k+m))*((x-1i*y)^k)*(z^(n-m-2*k))/((2^(2*k+m))*factorial(k+m)*factorial(k)*factorial(n-m-2*k));
fp(n, m, k)=factorial(n+m)*((-1)^k)*((x+1i*y)^(k+m))*((x-1i*y)^k)*(z^(n-m-2*k))/((2^(2*k+m))*factorial(k+m)*factorial(k)*factorial(n-m-2*k));

% N=input('What is the order of your regular solid spherical harmonic function?     ');
% M=input('What is the degree of your regular solid spherical harmonic function?    ');
c=0:1:((N-M)/2);

if M>0
    Kp=c;
    Kn=M:1:((N+M)/2);
    a=fn(N,-M,Kn(1)) + fp(N,M,Kp(1));
    if length(Kp)>=2
        for h=2:length(Kp)
            a=a+ fn(N,-M,Kn(h)) + fp(N,M,Kp(h));
        end
    end
    SH_f=simplify(expand(a/2));
end

if M==0
    Kz=c;
    a=fn(N,0,Kz(1));
    if length(Kz)>=2
        for h=2:length(Kz)
            a=a+fn(N,0,Kz(h));
        end
    end
    SH_f=simplify(expand(a));
end

if M<0
    Kp=0:1:((N+M)/2);
    Kn=c(c>=(-M));
    a=fn(N,M,Kn(1)) - fp(N,-M,Kp(1));
    if length(Kn)>=2
        for h=2:length(Kn)
            a=a+ fn(N,M,Kn(h)) - fp(N,-M,Kp(h));
        end
    end
    SH_f=simplify(expand(1i*(a)/2));
end

end