module problemdetail

import net.urllib
import os { Result }

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

fn test_type_empty_deref() {
	mut deref_err := IError(none)
	prob := new(none)
	prob.dereference() or { deref_err = err }
	assert deref_err !is none
}

fn mock_dereferencer(cmd string) Result {
	return Result{
		output: cmd
	}
}

fn test_type_proper_deref() {
	mut prob := new(urllib.parse('https://vlang.io')!)
	prob.dereferencer = mock_dereferencer
	mut deref_err := IError(none)
	out := prob.dereference()!
	assert deref_err is none
	assert out.output == 'xdg-open ${prob.type.str()}'
}
