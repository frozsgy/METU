N=4145; % size of Monte Carlo Simulation with alpha = 0.01 and error = 0.02
TotalWeight=zeros(N,1); % vector to keep the total weight of vehicles for each monte carlo run
for k=1:N;
	weight = 0; % the total weight for this monte carlo run

	% motorcycles
	lambda = 40;
	U = rand; i = 0;
	F = exp(-lambda);
	while (U>=F);
		i=i+1;
		F = F+exp(-lambda)*lambda^i/gamma(i+1);
	end;
	Y = i; % total number of motorcycles
	for f=1:Y; % summing total weight of motorcycles
		F = sum(-1/0.15 * log(rand(16,1)));
		weight = weight + F;
	end;

	% automobiles
	lambda = 30;
	U = rand; i = 0;
	F = exp(-lambda);
	while (U>=F);
		i=i+1;
		F = F+exp(-lambda)*lambda^i/gamma(i+1);
	end;
	Y = i; % total number of automobiles
	for f=1:Y;  % summing total weight of automobiles
		F = sum(-1/0.05 * log(rand(60,1)));
		weight = weight + F;
	end;

	% trucks
	lambda = 20;
	U = rand; i = 0;
	F = exp(-lambda);
	while (U>=F);
		i=i+1;
		F = F+exp(-lambda)*lambda^i/gamma(i+1);
	end;
	Y = i; % total number of trucks
	for f=1:Y; % summing total weight of trucks
		F = sum(-1/0.01 * log(rand(84,1)));
		weight = weight + F;
	end;

	TotalWeight(k) = weight;

end;
p_est = mean(TotalWeight>220000);
expectedWeight = mean(TotalWeight);
stdWeight = std(TotalWeight);
fprintf('Estimated probability = %f\n',p_est);
fprintf('Expected weight = %f\n',expectedWeight);
fprintf('Standard deviation = %f\n',stdWeight);