x = input('Enter a number: ');

binaryStr = realToBinary(x, 20);  
fprintf('Binary (base 2): %s\n', binaryStr);

bits = typecast(double(x),'uint64');
bin64 = dec2bin(bits,64);

signBit     = bin64(1);
exponentBits = bin64(2:12);
fractionBits = bin64(13:64);

fprintf('\nIEEE-754 binary64 format:\n');
fprintf('Sign bit:      %s\n', signBit);
fprintf('Exponent bits: %s\n', exponentBits);
fprintf('Fraction bits: %s\n', fractionBits);

fprintf('\nFull 64-bit representation:\n%s\n', bin64);

function result = realToBinary(x, precision)

    if x < 0
        signStr = '-';
        x = abs(x);
    else
        signStr = '';
    end

    integerPart = floor(x);
    fractionalPart = x - integerPart;

    if integerPart == 0
        intStr = '0';
    else
        intStr = '';
        while integerPart > 0
            remainder = mod(integerPart,2);
            intStr = [num2str(remainder) intStr];
            integerPart = floor(integerPart/2);
        end
    end

    if fractionalPart == 0
        fracStr = '';
    else
        fracStr = '.';
        for i = 1:precision
            fractionalPart = fractionalPart * 2;
            bit = floor(fractionalPart);
            fracStr = [fracStr num2str(bit)];
            fractionalPart = fractionalPart - bit;
            if fractionalPart == 0
                break;
            end
        end
    end

    result = [signStr intStr fracStr];
end