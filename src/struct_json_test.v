module problemdetail

import net.urllib { URL, parse }
import os { Result }

fn test_omit() {
	prob := Problem{
		dereferencer: fn (_ string) Result {
			return Result{}
		}
	}
	_, out := prob.to_json()
	assert out == '{}'
}

fn test_type_empty() {
	prob := new(none, 0, '', '', none)
	assert prob.type == parse('about:blank')!
	ctype, text := prob.to_json()
	assert ctype == type_json
	assert text == '{"type":"about:blank"}'
}

fn test_status_ok() {
	status := 200
	_, out := new(none, status, '', '', none).to_json()
	assert out == '{"type":"about:blank","status":${status}}'
}

fn test_title_nonempty() {
	title := 'my-title'
	_, out := new(none, 0, title, '', none).to_json()
	assert out == '{"type":"about:blank","title":"${title}"}'
}

fn test_instance_empty() {
	prob := new(none, 0, '', '', none)
	assert prob.instance.str() == ''
	ctype, text := prob.to_json()
	assert ctype == type_json
	assert text == '{"type":"about:blank"}'
}

fn test_instance_nonempty() {
	prob := new(none, 0, '', '', URL{ scheme: 'abc', opaque: 'def' })
	assert prob.instance.str() == 'abc:def'
	ctype, text := prob.to_json()
	assert ctype == type_json
	assert text == '{"type":"about:blank","instance":"abc:def"}'
}
