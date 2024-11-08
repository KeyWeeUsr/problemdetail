module main

import net.http { CommonHeader, Request }
import problemdetail as pd
import strings { new_builder }

fn test_handler() {
	handler := MyHandler{}
	resp := handler.handle(Request{})
	assert resp.header.get(CommonHeader.content_type)! == pd.type_json
	mut bd := new_builder(0)
	bd.write_string('{')
	bd.write_string('"type":"http://${addr}",')
	bd.write_string('"status":${status},')
	bd.write_string('"title":"${title}",')
	bd.write_string('"detail":"${detail}",')
	bd.write_string('"instance":"http://${addr}#main.v:19:handle"')
	bd.write_string('}')
	assert resp.body == bd.str()
}
