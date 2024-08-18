data {
    // Number of observations
    int<lower=0> N;
    // Number of latent explanatory features
    int<lower=0> P;
    // Number of groups
    int<lower=0> G;
    // Size of fuzz
    real<lower=0> fuzz;
}
generated quantities {
    vector[N] y;
    matrix[N, P] Latent;
    matrix[N, P] X;
    real beta_0;
    vector[P] beta_latent;
    beta_0 = normal_rng(10, 1);
    for (p in 1:P) {
        beta_latent[p] = normal_rng(0, 1);
    }
    for (n in 1:N) {
        for (p in 1:P) {
            Latent[n, p] = normal_rng(0, 1);
            X[n, p] = Latent[n, p] + normal_rng(0, fuzz);
        }
        y[n] = normal_rng(beta_0 + Latent[n]*beta_latent, 1);
    }
}
