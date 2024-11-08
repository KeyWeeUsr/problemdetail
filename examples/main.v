module main

import net.urllib { URL, parse }
import net.http { Request, Response, Server, new_header_from_map }
import problemdetail as pd

const addr = '127.0.0.1:8000'
const title = 'My custom problem response'
const detail = 'Request failed to showcase RFC9457 response.'
const status = 599

struct MyHandler {}

fn (_ MyHandler) handle(_ Request) Response {
	parsed_addr := parse('http://${addr}') or { panic(err) }
	mut instance := URL{
		...parsed_addr
	}
	where := '${@FILE_LINE}:${@FN}'
	instance.fragment = where

	prob := pd.new(parsed_addr, status, title, detail, instance)
	mime, text := prob.to_json()

	resp := Response{
		body:        text
		header:      new_header_from_map({
			.content_type: mime
		})
		status_code: status
		status_msg:  title
	}
	return resp
}

fn main() {
	mut svc := Server{
		addr:    addr
		handler: MyHandler{}
	}
	svc.listen_and_serve()
}
