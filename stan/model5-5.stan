data {
   int N;
   int<lower=0, upper=1> A[N];
   real<lower=0, upper=1> Score[N];
   real<lower=0,upper=1> Weather[N];
   int<lower=0, upper=1> Y[N];
}

parameters {
	real b1;
	real b2;
	real b3;
	real b4;
}

transformed parameters {
	real q[N];
	for(k in 1:N) {
		q[k] = inv_logit(b1 + b2 * A[k] + b3 * Score[k] + b4 * Weather[k]);
	}
}

model {
	for(k in 1:N) {
		Y[k] ~ bernoulli(q[k]);
	}
}

generated quantities {
	real y_pred[N];
	for (k in 1:N) {
		y_pred[k] = bernoulli_rng(q[k]);
	}
}
