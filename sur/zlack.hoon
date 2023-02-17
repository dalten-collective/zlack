::
::  app credentials:
::  - app-id:        A04LQAWP8AC
::  - client-id:     4564013650816.4704370790352
::  - client-secret: ec75435403ab2dd3a863b40617a89717
::  - sign-secret:   c3804c9ada5438620ae226b5cfa41612
::
::  oauth overview:
::  1. ask for scopes
::    - https://slack.com/oauth/v2/authorize?
::      * scope=<comma-delimited-list>&
::      * client_id=<client_id>&
::      * redirect_uri=<https redirect>
::      * state=<secret key>
::  2. user gives ok
::    - dis done by user to some workspace
::  3. get access code
::    - returned to redirect_url as a code field
::    - optional: check state parameter if you sent one
::  4. exchange code for access token
::    - https://slack.com/api/oauth.v2.access
::    - multipart data:
::      - code=<code from 3>
::      - client_id=<client_id>
::      - client_secret=<client_secret>
::  5. receive access token - which looks like a json?
::
::  scopes required (by event/method):
::  - event: message.channels (incoming - delivered via Events API)
::    * channels:history
::  - method: conversations.list (list all slack channels)
::    * channels:read
::  - 
::
/+  ser=server
|%
::
+$  actions
  $%  [%app-credentials aid=@t cid=@t cet=@t ret=@t]    :: app credentials
      [%my-url url=@t]
  ==
--