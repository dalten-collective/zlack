::  zlack, a slack bridge by quartus
::  - for chorus one, with love
::
::  known limitations:
::  - a new slack app must be generated for each install
::    due to the url restrictions slack imposes:
::    > from a twitter conversation w/ slack:
::      "At the moment it isn't possible to configure
::       multiple Request URL endpoints to receive the
::       Events API callbacks (https://api.slack.com/events-api),
::       but what you can do is have the configured
::       endpoint forward the request along to other
::       endpoints."
::  - only one chat<->slack integration per installation
::    > this is due to the complexity of the authorization
::      process and the difficulty with potentially parsing
::      multiplexed incoming messages (and avoiding dupes)
::
::  steps to use:
::  - boot a ship and get it on a static, ssl-enabled
::    domain
::  - create a slack app in your slack workspace that has
::    the following features and functionality:
::      - incoming-webhooks
::      - bots
::      - permissions
::      - event subscriptions at
::        https://<your-domain>.com/apps/zlack/~/events-api
::  - record your apps' credentials, privately
::  - load the zlack interface through your urbit and
::    follow the prompts (you'll need the credentials and url)
::  - in your channel, invite @zlack by mentioning it.
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
::  5. receive access token
::
::  scopes required (by event/method):
::  - event: message.channels (incoming - delivered via Events API)
::    * channels:history
::  - method: conversations.list (list all slack channels)
::    * channels:read
::  - 
::
/-  cha=chat
/+  ser=server
|%
::
+$  flag  (pair ship term)
::
+$  actions
  $%  [%app-credentials aid=@t cid=@t cet=@t ret=@t]    :: app credentials
      [%my-url url=@t]
  ==
::
+$  updates
  $%  [%user-identity p=(unit [id=@t name=@t])]
      [%sent-messages p=(unit @t)]
  ==
::
+$  event
  $:  token=@t
      team-id=@t
      api-app-id=@t
      event=mesg
      type=@t
      event-id=@t
      event-time=@da
      authorizations=(set [ent=(unit @t) team=@t user=@t is-bot=? is-ent-inst=?])
      is-ext-shared-channel=?
      event-context=@t
  ==
+$  mesg
  %-  unit
  %+  each
    [dif=diff:writs:cha tim=[id:cha @t]]
  [usr=@t msg=@t tim=@da]
--