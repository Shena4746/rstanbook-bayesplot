data {
   int N;
   int<lower=0, upper=1> A[N];
   real<lower=0, upper=1> Score[N];
   int<lower=0> M[N];
   int<lower=0> Y[N];
}

parameters {
	real b1;
	real b2;
	real b3;
}

transformed parameters {
	real q[N];
	for(k in 1:N) {
		q[k] = inv_logit(b1 + b2 * A[k] + b3 * Score[k]);
	}
}

model {
	for(k in 1:N) {
		Y[k] ~ binomial(M[k], q[k]);
	}
}

generated quantities {
	real y_pred[N];
	for (k in 1:N) {
		y_pred[k] = binomial_rng(M[k],q[k]);
	}
}
