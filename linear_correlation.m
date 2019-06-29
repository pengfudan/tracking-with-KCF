function kf = linear_correlation(xf, yf)
%LINEAR_CORRELATION Linear Kernel at all shifts, i.e. correlation.

	%cross-correlation term in Fourier domain
	kf = sum(xf .* conj(yf), 3) / numel(xf);

end

