module problemdetail

import net.urllib { URL, parse }
import json { encode }
import os { Result, execute }

type ProblemURL = URL

pub fn (url ProblemURL) to_absolute(base ?URL) ProblemURL {
	if url.is_abs() {
		if base == none {
			return url
		}
	}
	mut copy := URL{
		...base
	}
	copy.path = url.path
	copy.raw_query = url.raw_query
	copy.fragment = url.fragment
	return copy
}

struct Problem {
mut:
	dereferencer fn (string) Result @[required]
pub mut:
	type   ProblemURL @[omitempty]
	status int        @[omitempty]
	title  string     @[omitempty]
	detail string     @[omitempty]
	// TODO: ?ProblemURL causes compiler bug on scheme being {0}
	instance ProblemURL @[omitempty]
}

pub fn new(type ?URL, status int, title string, detail string, instance ?URL) Problem {
	default_url := parse('about:blank') or { panic(err) }

	return Problem{
		dereferencer: execute
		type:         type or { default_url }
		status:       status
		title:        title
		detail:       detail
		instance:     instance or { URL{} }
	}
}

struct ProblemJson {
	type     string @[omitempty]
	status   int    @[omitempty]
	title    string @[omitempty]
	detail   string @[omitempty]
	instance string @[omitempty]
}

pub fn (prob Problem) to_json() (ContentType, string) {
	return type_json, encode(ProblemJson{
		type:     prob.type.str()
		status:   prob.status
		title:    prob.title
		detail:   prob.detail
		instance: prob.instance.str()
	})
}

fn (prob Problem) visit_allowed(scheme string) bool {
	return scheme in ['http', 'https']
}
