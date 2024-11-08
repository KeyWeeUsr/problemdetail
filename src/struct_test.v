module problemdetail

import net.urllib { URL, parse }
import os { Result }

fn test_type_empty() {
	prob := new(none, 0, '', '', none)
	assert prob.type.scheme == 'about'
	assert prob.type.opaque == 'blank'
	assert prob.type == parse('about:blank')!
}

fn test_type_specified() {
	prob := new(URL{}, 0, '', '', none)
	assert prob.type.scheme != 'about'
	assert prob.type.opaque != 'blank'
	assert prob.type == URL{}
}

fn test_type_specified_sane() {
	what := parse('https://vlang.io')!
	prob := new(what, 0, '', '', none)
	assert prob.type.scheme != 'about'
	assert prob.type.opaque != 'blank'
	assert prob.type == what
	// Java-esque URL != URL problem?
	assert prob.type != parse('https://vlang.io')!
	assert prob.type.debug() == parse('https://vlang.io')!.debug()
}

fn test_type_empty_deref() {
	mut deref_err := IError(none)
	prob := new(none, 0, '', '', none)
	prob.visit_type() or { deref_err = err }
	assert deref_err !is none
}

fn mock_dereferencer(cmd string) Result {
	return Result{
		output: cmd
	}
}

fn test_type_proper_deref() {
	mut prob := new(parse('https://vlang.io')!, 0, '', '', none)
	prob.dereferencer = mock_dereferencer
	mut deref_err := IError(none)
	out := prob.visit_type()!
	assert deref_err is none
	assert out.output == 'xdg-open ${prob.type.str()}'
}

fn test_type_absolute_to_absolute_no_base() {
	what := parse('https://vlang.io/abc/def')!
	prob := new(what, 0, '', '', none)
	assert prob.to_absolute(none).str() == what.str()
}

fn test_type_absolute_to_absolute_rewrite_base() {
	what := parse('https://vlang.io/abc/def')!
	rewrite := parse('https:/gnalv.oi')!
	prob := new(what, 0, '', '', none)

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
	prob := new(what, 0, '', '', none)

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
	assert new(what, 0, '', '', none).type.str() == raw
}

fn test_instance_empty() {
	prob := new(none, 0, '', '', none)
	assert prob.instance.scheme == ''
	assert prob.instance.opaque == ''
	assert prob.instance == URL{}
}

fn test_instance_specified() {
	prob := new(none, 0, '', '', URL{})
	assert prob.instance.scheme != 'about'
	assert prob.instance.opaque != 'blank'
	assert prob.instance == URL{}
}

fn test_instance_specified_sane() {
	what := parse('https://vlang.io')!
	prob := new(none, 0, '', '', what)
	assert prob.instance.scheme != 'about'
	assert prob.instance.opaque != 'blank'
	assert prob.instance == what
	// Java-esque URL != URL problem?
	assert prob.instance != parse('https://vlang.io')!
	assert prob.instance.debug() == parse('https://vlang.io')!.debug()
}

fn test_instance_empty_deref() {
	mut deref_err := IError(none)
	prob := new(none, 0, '', '', none)
	prob.visit_instance() or { deref_err = err }
	assert deref_err !is none
}

fn test_instance_proper_deref() {
	mut prob := new(none, 0, '', '', parse('https://vlang.io')!)
	prob.dereferencer = mock_dereferencer
	mut deref_err := IError(none)
	out := prob.visit_instance()!
	assert deref_err is none
	dest := prob.instance.str()
	assert dest != ''
	assert out.output == 'xdg-open ${dest}'
}

fn test_instance_absolute_to_absolute_no_base() {
	what := parse('https://vlang.io/abc/def')!
	prob := new(what, 0, '', '', none)
	assert prob.to_absolute(none).str() == what.str()
}

fn test_instance_absolute_to_absolute_rewrite_base() {
	what := parse('https://vlang.io/abc/def')!
	rewrite := parse('https:/gnalv.oi')!
	prob := new(what, 0, '', '', none)

	mut expected := URL{
		...rewrite
	}
	expected.path = what.path
	expected.raw_query = what.raw_query
	expected.fragment = what.fragment

	assert prob.to_absolute(rewrite).str() == expected.str()
}

fn test_instance_relative_to_absolute() {
	what := parse('/abc/def')!
	rewrite := parse('https://vlang.io')!
	prob := new(what, 0, '', '', none)

	mut expected := URL{
		...rewrite
	}
	expected.path = what.path
	expected.raw_query = what.raw_query
	expected.fragment = what.fragment

	assert prob.to_absolute(rewrite).str() == 'https://vlang.io/abc/def'
}

fn test_instance_unresolvable_tag() {
	raw := 'tag:example@example.org,2021-09-17:OutOfLuck'
	what := parse(raw)!
	prob := new(none, 0, '', '', what)
	assert prob.instance.str() == raw
}
