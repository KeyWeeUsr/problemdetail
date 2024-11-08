module problemdetail

import net.urllib

fn test_type_empty() {
	prob := new(none)
	assert prob.type.scheme == 'about'
	assert prob.type.opaque == 'blank'
	assert prob.type == urllib.parse('about:blank')!
}

fn test_type_specified() {
	prob := new(urllib.URL{})
	assert prob.type.scheme != 'about'
	assert prob.type.opaque != 'blank'
	assert prob.type == urllib.URL{}
}

fn test_type_specified_sane() {
	what := urllib.parse('https://vlang.io')!
	prob := new(what)
	assert prob.type.scheme != 'about'
	assert prob.type.opaque != 'blank'
	assert prob.type == what
	// Java-esque URL != URL problem?
	assert prob.type != urllib.parse('https://vlang.io')!
	assert prob.type.debug() == urllib.parse('https://vlang.io')!.debug()
}
