module problemdetail_struct_pub

import net.urllib { parse }
import problemdetail as pd

fn test_type_empty() {
	prob := pd.new(none, 0, '', '')
	assert prob.type.scheme == 'about'
	assert prob.type.opaque == 'blank'
	assert prob.type == parse('about:blank')!
	assert prob.status == 0
	assert prob.title == ''
	assert prob.detail == ''
}
