/*
	Created by Daniel Cousens
	Created on June 19, 2013
	
	Edited by Nathan Gil
	Edited on September 20, 2013
*/

import std.algorithm : back, swap;
import std.math : isNaN;
import std.random : uniform;
import std.traits : ReturnType;

template isAgent(T) {
	enum bool isAgent = is(typeof(
	(inout int = 0)
	{
		T a = void;
		if (a.evaluate()) {}
		a.crossover(a, a);
		a.mutate(0.5);
	}));
}

// Explicit Genetic Algorithm (Template)
struct Evolution(T, bool asexual, bool keepElite, UniformRandomNumberGenerator, FT = ReturnType!(T.evaluate)) if (isAgent!T) {
	FT[] fitnesses;
	FT[] fsums;

	T[] population;
	T[] replacement;

	UniformRandomNumberGenerator urng;

	this(in size_t n, UniformRandomNumberGenerator urng, in string input, in string output) {
		this.fitnesses.length = n;
		this.fsums.length = n;
		this.population.length = n;
		this.replacement.length = n;
		this.urng = urng;
		
		foreach ( ref p; this.population ) {
			p = T(input, output);
		}
		
		foreach ( ref p; this.replacement ) {
			p = T(input, output);
		}
	}

	void evaluate() pure {
		FT sum = 0;

		foreach (i, ref agent; this.population) {
			this.fitnesses[i] = agent.evaluate();

			sum += this.fitnesses[i];
			this.fsums[i] = sum;
		}
	}

	// Highest fitness is elite
	size_t findElite() pure const {
		size_t elite = 0;
		auto highest = -real.infinity;

		foreach (i, f; this.fitnesses) {
			if (f > highest) {
				highest = f;
				elite = i;
			}
		}

		return elite;
	}
	
	auto selectElite() pure {
		return this.population[this.findElite()];
	}

	// Maximisation strategy
	auto selectParent() {
		const sum = this.fsums.back;
		if (isNaN(sum) || sum == 0) return this.population.back;

		const r = uniform(0, sum, this.urng);
		foreach (i, fsum; this.fsums) {
			if (fsum >= r) {
				return this.population[i];
			}
		}

		assert(false);
	}

	void step(M)(in M mutationProbability, in M mutationAmount) {
		static if (keepElite) {
			const elite = this.findElite();
		}

		foreach (i, ref x; this.replacement) {
			static if (keepElite) {
				if (i == elite) continue;
			}

			static if (asexual) {
				const a = this.selectParent();

				x.crossover(a, a);
			} else {
				const a = this.selectParent();
				const b = this.selectParent();

				x.crossover(a, b);
			}

			if (uniform(0.0, 1.0, this.urng) < mutationProbability) {
				x.mutate(mutationAmount);
			}
		}

		this.population.swap(replacement);
		this.evaluate();
	}
}
