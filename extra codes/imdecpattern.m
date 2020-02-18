function [L, E] = imdecpattern( Y, lambda, tol, nite )
%IMDECPATTERN recovers a degraded image with a pattern artifact
% by decomposing the image into the latent image and the pattern image. 
%
% [L, E] = IMDECPATTERN( Y )
% [L, E] = IMDECPATTERN( Y, lambda, tol, nite )
%
% arguments
% Y : input image
% L : latent image
% E : artifact image
% lambda : decomposition degree (default lambda=3)
% tol    : the tolerance of a constraint Y = L + E (default tolerance=0)
% nite   : the number of iterations to solve the problem.
%
%
%
% This program solves the following equation
%
% min_{l,e}  |Dl|2,1  + lambda |Fe|c,1
% s.t.       | y - (l+e) |2 <= tol,  1'l = 0
%
% where y is an observed image, l is the latent image, e is the artifact image,
% D is differential filtering and F is Fourier transformation.
%
%
% REFERENCE
%
% K. Shirai, S. Ono, and M. Okuda, ``Minimization of mixed norm for frequency
% spectrum of images and its application of pattern noise decomposition,''
% EUSIPCO, 5pages, 2017.
%
%
% parameters
%
if ~exist( 'lambda', 'var' ) || isempty( lambda )
	lambda = 3; % mainly controls decomposition degree
end
if ~exist( 'tol', 'var' ) || isempty( tol )
	tol = 0;    % tolerance of the l2 ball related to noise reduction
end
% for ADMM
if ~exist( 'nite', 'var' ) || isempty( nite )
	nite = 30; % number of iterations
end
rho = 1; % step size
%
% proximity operators
%
% mixed l2,1 norm
% is directly written in the ADMM algorithm
% mixed lc,1 norm
prox_lc1 = @(V,gamma) V.*(1 - gamma./max(gamma,abs(V))); 
% l2 ball projection centered at V with the radius V-Y
prox_l2ball = @(V,V_Y,tol) V + V_Y * (tol/max(tol,norm(V_Y(:)))); % V_Y = V - Y
% which corresponds to ( norm(V_Y(:)) <= tol ) ? ( V ) : ( Y + V_Y*(tol/norm(V_Y(:)) );
[sy,sx,sc] = size( Y );
N = sy*sx; % number of pixels
% % unitary Fourier transform, but the following non-unitary version is faster.
% F = @(X) fft2(X)/sqrt(N);  Ft = @(X) sqrt(N)*ifft2(X);
%
% non-unitary Fourier transform
lambda = sqrt(N) * lambda;
F = @(X) fft2(X);  Ft = @(X) real(ifft2(X));
Zeros = zeros(sy,sx,sc);
Ones = ones(sy,sx,sc);
% initialization of variables
L = Y;  E = Zeros;
% aux variables Z and Lagrangian-multiplier variables U 
Zlh = Zeros;  Ulh = Zeros;
Zlv = Zeros;  Ulv = Zeros;
Ze  = Zeros;  Ue  = Zeros;
Z   = Zeros;  U   = Zeros;
% filters
% circular differential filters
Dh = [0,-1,1];
Dv = [0;-1;1];
% laplacian filter
DhDh_DvDv = [0,-1,0;-1,4,-1;0,-1,0];
% pre-computation of inverse filters
FA11 = 1 + repmat( psf2otf( DhDh_DvDv, [sy,sx] ), [1,1,sc] );
FA22 = 1 + Ones;
FA12 = Ones;
FA21 = Ones;
idetFA = 1./(FA11.*FA22 - FA12.*FA21); % determinant
iFA11 =  FA22 .* idetFA;  iFA12 = -FA12 .* idetFA;
iFA21 = -FA21 .* idetFA;  iFA22 =  FA11 .* idetFA;
% % weighted version
% sigma = 0.5;
% FW = Ones;
% FW = repmat( psf2otf( fspecial( 'gaussian', 2*ceil(3*sigma)+1, sigma ), [sy,sx] ), [1,1,sc] );
% FW = fftshift(FW);
for t = 1:nite
	
	%
	% solve l and e
	%
	IZU = (Z - U);
	Fbl = fft2( IZU...
		+ imfilter( Zlh - Ulh, Dh, 'corr','circular' )...
		+ imfilter( Zlv - Ulv, Dv, 'corr','circular' ) );
	Fbe = fft2( IZU + Ft( Ze - Ue ) );
	L = real( ifft2( iFA11.*Fbl + iFA12.*Fbe ) );
	E = real( ifft2( iFA21.*Fbl + iFA22.*Fbe ) );
	
	%
	% solve z_l and u_l
	%
	Vlh = imfilter( L, Dh, 'conv','circular' ) + Ulh;
	Vlv = imfilter( L, Dv, 'conv','circular' ) + Ulv;
	
	% prox of l2,1 norm
	Vl_norm = sqrt(Vlh.*Vlh + Vlv.*Vlv);
	Scale = 1 - (1/rho) ./ max(1/rho, Vl_norm);
	Zlh = Vlh .* Scale;
	Zlv = Vlv .* Scale;
	
	Ulh = Vlh - Zlh; % update u_l
	Ulv = Vlv - Zlv;	
	
	%
	% solve z_e and u_e
	%
	Ve = F( E ) + Ue;
	gamma = (lambda/rho);
% 	gamma = (lambda/rho) * FW; % weighted version
	Ze = prox_lc1( Ve, gamma );
	
	% the constraint coresponding to mean(e)=0
	Ze(1,1,:) = 0;
	
	Ue  = Ve  - Ze; % update u_e
	
	%
	% solve z and u
	%
	V = (L + E) + U;
	dVY = V - Y;
	for c = 1:sc
		Z(:,:,c) = prox_l2ball( Y(:,:,c), dVY(:,:,c), tol );
% 		% Actually, this version is faster than the above
% 		dVYc = dVY(:,:,c);
% 		norm_dVY = norm( dVYc(:) );
% 		if ( norm_dVY <= tol )
% 			Z(:,:,c) = V(:,:,c);
% 		else
% 			Z(:,:,c) = Y(:,:,c) + dVY(:,:,c) * (tol/norm_dVY);
% 		end
	end
	U = V - Z; % update U
end
end

