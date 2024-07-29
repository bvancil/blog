using Random

using Distributions

function generate_distribution(rng, n = 100)
    # How spiky?
    Spikiness = Uniform(1, 10)
    spikiness = rand(rng, Spikiness)
    unnormalized_weights = rand(rng, Uniform(), n + 1) .^ spikiness
    xs = collect(range(0, 1, n + 1))
    ps = unnormalized_weights ./ sum(unnormalized_weights)
    DiscreteNonParametric(xs, ps)
end

rng = MersenneTwister(20240218)
n = 3
MyDist = generate_distribution(rng)
μ = mean(MyDist)
θ₂ = var(MyDist)
γ₁ = skewness(MyDist)
κ = kurtosis(MyDist)
S = entropy(MyDist)

SampleDist = JointOrderStatistics(MyDist, n)
