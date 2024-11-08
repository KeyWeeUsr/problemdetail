module problemdetail

import net.urllib
import json

struct Problem {
pub mut:
	type urllib.URL
}

pub fn new(type ?urllib.URL) Problem {
	default_url := urllib.parse('about:blank') or { panic(err) }

	return Problem{
		type: type or { default_url }
	}
}

struct ProblemJson {
	type string
}

pub fn (prob Problem) to_json() (ContentType, string) {
	return type_json, json.encode(ProblemJson{
		type: prob.type.str()
	})
}
