# js-toxcore-c [![Build Status](https://img.shields.io/travis/TokTok/js-toxcore-c.svg?style=flat-square)](http://travis-ci.org/TokTok/js-toxcore-c) [![NPM Version](https://img.shields.io/npm/v/js-toxcore-c.svg?style=flat-square)](https://www.npmjs.org/package/js-toxcore-c)

[![NPM](https://nodei.co/npm/js-toxcore-c.png?mini=true)](https://nodei.co/npm/js-toxcore-c/)

Node.js bindings for [libtoxcore], built off of [node-ffi].

Note: Installing this package does not install [libtoxcore]. It is expected that
[libtoxcore] is installed prior to using **js-toxcore-c**.

If you see compiler errors while trying to npm install js-toxcore-c, you
[may](https://github.com/node-ffi/node-ffi/issues/451) need to install node-ffi
manually using npm:

```sh
$ npm install https://github.com/node-ffi/node-ffi
```

### New API Progress

-   [x] toxcore (missing conferences)
-   [ ] toxav
-   [x] toxencryptsave
-   [ ] Higher level API

### Synchronous Example

```js
var toxcore = require('js-toxcore-c');

// Create a default Tox instance
var tox = new toxcore.Tox();

// ... or, create a Tox instance using specific paths for toxcore libraries
var toxAtPath = new toxcore.Tox({
  path: '/path/to/libtoxcore.so',
  crypto: '/path/to/libtoxencryptsave.so'
});

// ... or, give Tox some data to load
var toxWithData = new toxcore.Tox({
  data: '/path/to/toxfile'
});

// ... if that data is encrypted, include a passphrase
var toxWithEncData = new toxcore.Tox({
  data: '/path/to/encrypted/toxfile',
  pass: 'myPassphrase'
});

// Bootstrap from nodes (see a list at: https://wiki.tox.chat/users/nodes)
tox.bootstrapSync('23.226.230.47', 33445, 'A09162D68618E742FFBCA1C2C70385E6679604B2D80EA6E84AD0996A1AC8A074'); // stal
tox.bootstrapSync('104.219.184.206', 443, '8CD087E31C67568103E8C2A28653337E90E6B8EDA0D765D57C6B5172B4F1F04C'); // Jfreegman

// Set your name and status message
tox.setNameSync('My username');
tox.setStatusMessageSync('Hello world!');

// Listen for friend requests
tox.on('friendRequest', function(e) {
  console.log('Friend request from: ' + e.publicKeyHex());
});

// Print received friend messages to console
tox.on('friendMessage', function(e) {
  var friendName = tox.getFriendNameSync(e.friend());
  console.log(friendName + ': ' + e.message());
});

// Print out your tox address so others can add it
console.log('Address: ' + tox.getAddressHexSync());

// Start!
tox.start();
```

For more examples, see the `examples/` directory.

### Documentation

Generating the documentation should be as easy as `grunt jsdoc`.

[libtoxcore]:https://github.com/TokTok/c-toxcore
[node-ffi]:https://github.com/node-ffi/node-ffi
