function [ p ] = odd2p( odds_row )
    % Check that that neither end-point is a root
    % and if f(a) and f(b) have the same sign, throw an exception.


    eps_abs = 1e-5;
    eps_step = 1e-5;
    N=10000;
    
    if( mod(length(odds_row), 3)~=0)
        error('Incorrect size of Odds Vector');
    end
    
    p=zeros(size(odds_row));
    
    for i=1:(length(odds_row)/3)
        
        a=0.9;
        b=5;
        coeff=odds_row((i-1)*3+1:(i-1)*3+3);
        
        if ( f(coeff,a) == 0 )
                gamma = a;
                p((i-1)*3+1:(i-1)*3+3)=coeff.^(-a);
            elseif ( f(coeff,b) == 0 )
                gamma = b;
                p((i-1)*3+1:(i-1)*3+3)=coeff.^(-b);
                elseif ( f(coeff,a) * f(coeff,b) > 0 )
                    error( 'f(a) and f(b) do not have opposite signs' );
        end
     
        if (f(coeff,a) ~= 0 && f(coeff,b) ~= 0)
           while (b - a >= eps_step || ( abs( f(coeff,a) ) >= eps_abs && abs( f(coeff,b) )  >= eps_abs ) )
               mean = (a + b)/2;
               if ( f(coeff,mean) == 0 )
                   gamma=mean;
                   p((i-1)*3+1:(i-1)*3+3)=coeff.^(-gamma);
                   break;
                elseif ( f(coeff,a)*f(coeff,mean) < 0 )
                    b = mean;
                else
                    a = mean;
               end
               
            if(abs(f(coeff,a))<=abs(f(coeff,b)))
                gamma=a;
            else
                gamma=b;                  
            end
            p((i-1)*3+1:(i-1)*3+3)=coeff.^(-gamma);
       end
        %gamma
    
    end
    
    
end

