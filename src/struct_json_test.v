module problemdetail

import net.urllib
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
	prob := new(none, 0, '', '')
	assert prob.type == urllib.parse('about:blank')!
	ctype, text := prob.to_json()
	assert ctype == type_json
	assert text == '{"type":"about:blank"}'
}

fn test_status_ok() {
	status := 200
	_, out := new(none, status, '', '').to_json()
	assert out == '{"type":"about:blank","status":${status}}'
}

fn test_title_nonempty() {
	title := 'my-title'
	_, out := new(none, 0, title, '').to_json()
	assert out == '{"type":"about:blank","title":"${title}"}'
}
