module problemdetail_struct_pub

import net.urllib
import problemdetail as pd

fn test_type_empty() {
	prob := pd.new(none, 0)
	assert prob.type.scheme == 'about'
	assert prob.type.opaque == 'blank'
	assert prob.type == urllib.parse('about:blank')!
}
