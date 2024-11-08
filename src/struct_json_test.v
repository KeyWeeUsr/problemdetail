module problemdetail

import net.urllib

fn test_type_empty() {
	prob := new(none)
	assert prob.type == urllib.parse('about:blank')!
	ctype, text := prob.to_json()
	assert ctype == type_json
	assert text == '{"type":"about:blank"}'
}
