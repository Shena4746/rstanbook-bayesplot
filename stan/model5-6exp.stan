data {
   int N;
   int<lower=0, upper=1> A[N];
   real<lower=0, upper=1> Score[N];
   int<lower=0> M[N];
}

parameters {
	real b[3];
}

transformed parameters {
	real lambda[N];
	for(k in 1:N) {
		lambda[k] = exp(b[1] + b[2] * A[k] + b[3] * Score[k]);
	}
}

model {
	for(k in 1:N) {
		M[k] ~ poisson(lambda[k]);
	}
}

generated quantities {
	int m_pred[N];
	real Score_AME[10];
	real A_AME;
	for (k in 1:N) {
		m_pred[k] = poisson_rng(lambda[k]);
	}
	for (k in 1:10) {
		Score_AME[k] = exp(b[3]*k/20);
	}
	A_AME = exp(b[2]);
}
