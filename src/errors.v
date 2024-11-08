module problemdetail

pub struct DereferenceError {
	Error
	url string
}

fn (err DereferenceError) msg() string {
	return 'Cannot dereference non-http/https types (${err.url}).'
}
