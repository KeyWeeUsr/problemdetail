[![Buy me a coffee][bmc-badge]][bmc-link]
[![Liberapay][lp-badge]][lp-link]
[![PayPal][ppl-badge]][ppl-link]

# problemdetail

This is a simple implementation of Problem Details for HTTP APIs RFC providing
a simple struct `Problem` with resolvable members and serialization to JSON.

Please check `examples` folder for a sample or simply run `make run-examples`.

## How to

VPM package upload is planned but currently blocked by
[`vlang/vpm#126`](https://github.com/vlang/vpm/issues/126). In the meantime you
can use:

    v install --git https://github.com/keyweeusr/problemdetail

or clone and either `make local-install` or build manually within your project.
Then simply:

```v
import problemdetail
problemdetail.new(
    type ?URL,
    status int,
    title string,
    detail string,
    instance ?URL
)
```

[bmc-badge]: https://img.shields.io/badge/-buy_me_a%C2%A0coffee-gray?logo=buy-me-a-coffee
[bmc-link]: https://www.buymeacoffee.com/peterbadida
[ppl-badge]: https://img.shields.io/badge/-paypal-grey?logo=paypal
[ppl-link]: https://paypal.me/peterbadida
[lp-badge]: https://img.shields.io/badge/-liberapay-grey?logo=liberapay
[lp-link]: https://liberapay.com/keyweeusr
[gif]: https://i.imgur.com/OpXUUVk.gif
