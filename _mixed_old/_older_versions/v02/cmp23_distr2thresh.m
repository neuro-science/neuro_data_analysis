function [th, H] = cmp23_distr2thresh (H0, p)
% % % written 03/09/2014 by wp
% % % H0 shall be Nxm matrix, when N is number of cases and m is numbers
% % % within cases, thus N > m. First column contains the largest values
% % % p is the demanded p value (e.g. 0.05)

	%% 1. check input
	% % % data dimension	
	sz = size(H0);
	if sz(1) < sz(2)
		H0 = H0';
		sz = size(H0);
		fprintf('The input seemed to be in the wrong dimension, changed!\n');
	end
	% % % default value
	if nargin < 2 || isempty(p)
		p = 0.05;
	end
	
	%% 2. do it
	% % % split data
	H1 = H0(:, 1);
	H2 = H0(:, 2:sz(2));
	% % % sort	
	[H1, I] = sort(H1, 'descend');
	H2 = H2(I, :);
	% % % first round	
	tmp = round(p * sz(1));
	if tmp && (~isempty(H1))
		th1 = H1(tmp);
		H3 = H2(H2 > th1);
		H = sort([H1; H3], 'descend');
		th = H(round(p * length(H)));
	else
		th = [];
		H = [];
	end
	
end