function histo = pichist(p)
histo = zeros(1,256);
sizep = size(p);
pixels = sizep(1) * sizep(2);
for index = 1:pixels
   histo(p(index)+1) = histo(p(index)+1) +1;
end

bar((0:255),histo)