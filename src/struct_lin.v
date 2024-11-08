module problemdetail

import os { Result }

pub fn (prob Problem) visit_type() !Result {
	dest := prob.type
	if !prob.visit_allowed(dest.scheme) {
		return DereferenceError{
			url: prob.type.str()
		}
	}
	return prob.dereferencer('xdg-open ${dest}')
}

pub fn (prob Problem) visit_instance() !Result {
	dest := prob.instance
	if dest.str() == '' {
		return DereferenceError{
			url: dest.str()
		}
	}

	if !prob.visit_allowed(dest.scheme) {
		return DereferenceError{
			url: prob.type.str()
		}
	}
	return prob.dereferencer('xdg-open ${dest}')
}
