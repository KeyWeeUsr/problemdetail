module problemdetail

import net.urllib { URL, parse }
import json { encode }
import os { Result, execute }

struct Problem {
mut:
	dereferencer fn (string) Result @[required]
pub mut:
	type   URL    @[omitempty]
	status int    @[omitempty]
	title  string @[omitempty]
	detail string @[omitempty]
}

pub fn new(type ?URL, status int, title string, detail string) Problem {
	default_url := parse('about:blank') or { panic(err) }

	return Problem{
		dereferencer: execute
		type:         type or { default_url }
		status:       status
		title:        title
		detail:       detail
	}
}

struct ProblemJson {
	type   string @[omitempty]
	status int    @[omitempty]
	title  string @[omitempty]
	detail string @[omitempty]
}

pub fn (prob Problem) to_json() (ContentType, string) {
	return type_json, encode(ProblemJson{
		type:   prob.type.str()
		status: prob.status
		title:  prob.title
		detail: prob.detail
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
