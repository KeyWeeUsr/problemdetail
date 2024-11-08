module problemdetail

import os { Result }

pub fn (prob Problem) dereference() !Result {
	dest := prob.type
	if dest.scheme !in ['http', 'https'] {
		return DereferenceError{
			url: prob.type.str()
		}
	}
	return prob.dereferencer('xdg-open ${dest}')
}
