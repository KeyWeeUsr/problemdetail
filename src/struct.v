module problemdetail

import net.urllib { URL, parse }
import json { encode }
import os { Result, execute }

struct Problem {
mut:
	dereferencer fn (string) Result @[required]
pub mut:
	type URL @[omitempty]
}

pub fn new(type ?URL) Problem {
	default_url := parse('about:blank') or { panic(err) }

	return Problem{
		dereferencer: execute
		type:         type or { default_url }
	}
}

struct ProblemJson {
	type string @[omitempty]
}

pub fn (prob Problem) to_json() (ContentType, string) {
	return type_json, encode(ProblemJson{
		type: prob.type.str()
	})
}

pub fn (prob Problem) to_absolute(base ?URL) URL {
	if prob.type.is_abs() {
		if base == none {
			return prob.type
		}
	}
	mut copy := URL{
		...base
	}
	copy.path = prob.type.path
	copy.raw_query = prob.type.raw_query
	copy.fragment = prob.type.fragment
	return copy
}
