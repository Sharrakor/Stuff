/*
	Created by Nathan Gil
	Created on September 17, 2013

	For use with evolution.d
*/


import std.conv : to;
import std.random : uniform;
import std.math;

struct Agent {
	char[] chromosomes;
	string input, output;
	
	this(in string input, in string output) in {
		assert(input.length == output.length);
	} body { 
		this.input = input;
		this.output = output;
		
		this.chromosomes.length = input.length;
	}

	real evaluate() pure const {
		auto fitness = 1.0;
	
		foreach ( i, c; this.chromosomes ) {
			fitness += abs((c ^ input[i]) - output[i]);
		}

		return 1.0 / fitness;
	}

	void mutate(T)(in T mutation_amount) {
		foreach ( ref c; this.chromosomes ) {
			if (mutation_amount < uniform(0.0, 1.0)) continue;

			c = cast(char)uniform(0, 256);
		}
	}

	void crossover(const Agent a, const Agent b) pure {
		this.chromosomes[0 .. $ / 2] = a.chromosomes[0 .. $ / 2];
		this.chromosomes[$ / 2 .. $] = b.chromosomes[$ / 2 .. $];
	}

	auto toString() pure const {
		char[] cpy = this.chromosomes.dup;
		foreach (i, ref c; cpy) {
			c = input[i] ^ c;
		}
		return cpy;
	}
}
