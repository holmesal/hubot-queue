earshot-server
===

This server listens to the messaging queue located at `pushQueue` on the root of the firebase, and sends push notifications to devies using the apple push notification server api.

Ah shit this is the tits.

todo
===

* Handle missing device tokens before trying to push to devices
* Un-hardcode the device id (test with multiple devices)
* Check elapsed time since last notification and cancel if too soon
* handle other providers
