# Problem Detail
[![VPM][vpm-badge]][vpm-link]
[![CI][ci-badge]][ci-workflow]
[![Buy me a coffee][bmc-badge]][bmc-link]
[![Liberapay][lp-badge]][lp-link]
[![PayPal][ppl-badge]][ppl-link]

This is a simple implementation of Problem Details for HTTP APIs RFC providing
a simple struct `Problem` with resolvable members and serialization to JSON.

Please check `examples` folder for a sample or simply run `make run-examples`.

## How to

    v install KeyWeeUsr.problemdetail

or install it from source

    v install --git https://github.com/KeyWeeUsr/problemdetail

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

[vpm-badge]: https://img.shields.io/badge/vpm-1.0.1-027d9c?logo=v&logoColor=white&logoWidth=10
[vpm-link]: https://vpm.vlang.io/packages/KeyWeeUsr.problemdetail
[ci-badge]: https://github.com/KeyWeeUsr/problemdetail/actions/workflows/test.yml/badge.svg
[ci-workflow]: https://github.com/KeyWeeUsr/problemdetail/actions/workflows/test.yml
[bmc-badge]: https://img.shields.io/badge/-buy_me_a%C2%A0coffee-gray?logo=buy-me-a-coffee
[bmc-link]: https://www.buymeacoffee.com/peterbadida
[ppl-badge]: https://img.shields.io/badge/-paypal-grey?logo=paypal
[ppl-link]: https://paypal.me/peterbadida
[lp-badge]: https://img.shields.io/badge/-liberapay-grey?logo=liberapay
[lp-link]: https://liberapay.com/keyweeusr
[gif]: https://i.imgur.com/OpXUUVk.gif
