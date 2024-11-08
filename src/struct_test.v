module problemdetail

import net.urllib { URL, parse }
import os { Result }

fn test_type_empty() {
	prob := new(none)
	assert prob.type.scheme == 'about'
	assert prob.type.opaque == 'blank'
	assert prob.type == parse('about:blank')!
}

fn test_type_specified() {
	prob := new(URL{})
	assert prob.type.scheme != 'about'
	assert prob.type.opaque != 'blank'
	assert prob.type == URL{}
}

fn test_type_specified_sane() {
	what := parse('https://vlang.io')!
	prob := new(what)
	assert prob.type.scheme != 'about'
	assert prob.type.opaque != 'blank'
	assert prob.type == what
	// Java-esque URL != URL problem?
	assert prob.type != parse('https://vlang.io')!
	assert prob.type.debug() == parse('https://vlang.io')!.debug()
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
	mut prob := new(parse('https://vlang.io')!)
	prob.dereferencer = mock_dereferencer
	mut deref_err := IError(none)
	out := prob.dereference()!
	assert deref_err is none
	assert out.output == 'xdg-open ${prob.type.str()}'
}

fn test_type_absolute_to_absolute_no_base() {
	what := parse('https://vlang.io/abc/def')!
	prob := new(what)
	assert prob.to_absolute(none).str() == what.str()
}

fn test_type_absolute_to_absolute_rewrite_base() {
	what := parse('https://vlang.io/abc/def')!
	rewrite := parse('https:/gnalv.oi')!
	prob := new(what)

	mut expected := URL{
		...rewrite
	}
	expected.path = what.path
	expected.raw_query = what.raw_query
	expected.fragment = what.fragment

	assert prob.to_absolute(rewrite).str() == expected.str()
}

fn test_type_relative_to_absolute() {
	what := parse('/abc/def')!
	rewrite := parse('https://vlang.io')!
	prob := new(what)

	mut expected := URL{
		...rewrite
	}
	expected.path = what.path
	expected.raw_query = what.raw_query
	expected.fragment = what.fragment

	assert prob.to_absolute(rewrite).str() == 'https://vlang.io/abc/def'
}

fn test_type_unresolvable_tag() {
	raw := 'tag:example@example.org,2021-09-17:OutOfLuck'
	what := parse(raw)!
	assert new(what).type.str() == raw
}

fn test_omit() {
	prob := Problem{
		dereferencer: fn (_ string) Result {
			return Result{}
		}
	}
	println('what: ${prob}')
	_, out := prob.to_json()
	assert out == '{}'
}
