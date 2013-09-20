#!rdmd

/*
	Created by Nathan Gil
	Created on September 17, 2013
*/
import std.stdio;
import std.random;
import std.conv;
import std.getopt : getopt;

import agent : Agent;
import evolution;

void main(string[] args) {
	string inp = "";
	string outp = "";
	auto pop = 10;
	
	void help() {
		writeln("usage: main.d [--i[nput] <input string>] [--o[utput] <output string>] [--p[op] <population count>]");
		// end the program here?
		// toggle a flag?
	}
	
	getopt(
		args,
		"input|i", &inp,
		"output|o", &outp,
		"pop|p", &pop,
		"help|h", &help
	);

	auto rng = Xorshift128();
	auto ev = Evolution!(Agent, false, false, typeof(rng))(pop, rng, inp, outp);
	
	debug {
		string str3;
		foreach ( i, c; inp ) {
			str3 ~= to!string(c ^ outp[i]) ~ " ";
		}
		writeln(str3);
	}

	foreach ( i; 0 .. 1e6 ) {
		ev.step!(real)(0.17, 0.05);
		auto elite = ev.selectElite();
		
		debug {
			if ( i % 1e5 == 0 ) {
				writeln(elite);
			}
		}
		
		if ( elite.toString() == outp ) {
			writeln(elite);
			writeln("Solution found in ", i, " iterations");
			break;
		}
	}
}