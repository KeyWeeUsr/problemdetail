module problemdetail_const_pub

import problemdetail as pd

fn test_const_import() {
	assert pd.type_json.contains('problem+json')
	assert pd.type_xml.contains('problem+xml')
}
