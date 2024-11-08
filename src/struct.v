module problemdetail

import net.urllib

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
