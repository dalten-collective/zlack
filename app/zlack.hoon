/-  *zlack
/+  verb, dbug, default-agent, server
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0
  $:  %0
      url=@t
      chat=(unit flag)
  ::
      app-id=@t
      client-id=@t
      client-secret=@t
      sign-secret=@t
      access-token=json
  ::
      echo=(set diff:writs:cha)                         :: messages
      :: even=(set cord)                                   :: events
  ::
      :: names=(map @t @t)                                 :: user-id to plain name
  ==
::
::
::  boilerplate
::
+$  card  card:agent:gall
--
::
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
::
^-  agent:gall
::
=<
  |_  =bowl:gall
  +*  this  .
      def  ~(. (default-agent this %|) bowl)
      eng   ~(. +> [bowl ~])
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%zlack +on-init']
    =^  cards  state  abet:init:eng
    [cards this]
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%zlack +on-save']
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    ~>  %bout.[0 '%zlack +on-load']
    ^-  (quip card _this)
    =^  cards  state  abet:(load:eng ole)
    [cards this]
  ::
  ++  on-poke
    |=  cag=cage
    ~>  %bout.[0 '%zlack +on-poke']
    ^-  (quip card _this)
    =^  cards  state  abet:(poke:eng cag)
    [cards this]
  ::
  ++  on-peek
    |=  pat=path
    ~>  %bout.[0 '%zlack +on-peek']
    ^-  (unit (unit cage))
    [~ ~]
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ~>  %bout.[0 '%zlack +on-agent']
    ^-  (quip card _this)
    `this
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ~>  %bout.[0 '%zlack +on-arvo']
    ^-  (quip card _this)
    =^  cards  state  abet:(arvo:eng wir sig)
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ~>  %bout.[0 '%zlack +on-watch']
    ^-  (quip card _this)
    `this
  ::
  ++  on-fail
    ~>  %bout.[0 '%zlack +on-fail']
    on-fail:def
  ::
  ++  on-leave
    ~>  %bout.[0 '%zlack +on-leave']
    on-leave:def
  --
|_  [bol=bowl:gall dek=(list card)]
+*  dat  .
++  emit  |=(=card dat(dek [card dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet
  ^-  (quip card _state)
  [(flop dek) state]
::
++  behn
  |=  [wir=path in=@dr]
  (emit %pass behn+wir %arvo %b %wait (add now.bol in))
++  init
  ^+  dat
  (behn /start ~s1)
::
++  load
  |=  vaz=vase
  ^+  dat
  ?>  ?=([%0 *] q.vaz)
  dat(state !<(state-0 vaz))
::
++  poke
  |=  [mar=mark vaz=vase]
  ?+    mar  ~|(zlack-panic-bad-mark/mar !!)
      %handle-http-request
    =+  !<([id=@ta req=inbound-request:eyre] vaz)
    =+  we=we-work:(we-abed:webs id req)
    =^  cards  state  we-abet:we
    (emil cards)
  ==
::
++  arvo
  |=  [pol=(pole knot) sig=sign-arvo]
  ?+    pol  ~|(zlack-panic-bad-arvo/[pol sig] !!)
      [%behn rest=*]
    ?+    rest.pol  ~|(zlack-panic-bad-timer/rest.pol !!)
        [%start ~]
      =-  (emit %pass /eyre/connect %arvo %e -)
      [%connect [[~ [%apps %zlack ~]] dap.bol]]
    ==
  ::
      [%eyre %connect ~]
    ~_  'ZLACK: strange response on eyre.'
    ?>(?=([%eyre %bound %& *] sig) dat)
  ::
      [%iris %request ~]
    ~_  'ZLACK: strange response from slack.'
    ?>  ?=([%iris %http-response %finished *] sig)
    ?>  ?&  =(%200 status-code.response-header.client-response.sig)
            ?=(^ full-file.client-response.sig)
        ==
    =+  toke=(de-json:html q.data.u.full-file.client-response.sig)
    ?~  toke  dat(state *state-0)
    ?.  ?=(%o -.u.toke)  dat(state *state-0)
    ?:  (~(has by p.u.toke) 'error')  dat(state *state-0)
    dat(access-token (need toke))
  ==
::
++  dude
  |=  [pol=(pole knot) sig=sign:agent:gall]
  ?+    pol  ~|(zlack-panic-bad-dude/[pol sig] !!)
      [%chan %chat host=@ name=@ ~]
    dat
      [%zlack %talk wen=@ ~]
    ?>  ?=(%poke-ack -.sig)
    %.  dat
    ?~(p.sig same (slog u.p.sig))
  ==
::  +talk: handles chat io
::
++  talk
  |_  caz=(list card)
  +*  ta   .
      our  (scot %p our.bol)
      now  (scot %da now.bol)
      doc  [our.bol %chat]
  ++  ta-emit  |=(c=card ta(caz [c caz]))
  ++  ta-emil  |=(lac=(list card) ta(caz (welp lac caz)))
  ++  ta-abet  ^-((quip card _state) [(flop caz) state])
  ++  ta-urbs  ta
  ++  ta-slac
    |=  j=json
    =+  ven=(event-wrapper:ta-parz j)
    ~&  >>>  ven
    ?~  event.ven  ta
    :: =.  echo  (~(put by echo) u.event.ven)
    =-  (ta-emit %pass /zlack/talk/[now] %agent doc %poke -)
    :-   %chat-action-0
    !>(`action:cha`[(need chat) [now.bol %writs u.event.ven]])
  ++  ta-parz
    =,  dejs:format
    |%
    ++  slack-time
      |=  t=@t
      ^-  @ud
      =;  [tim=@ud mor=@ud]
        `@ud`(from-unix:chrono:userlib tim)
      (rash t ;~((glue dot) dem dem))
    ++  message
      ^-  $-(json (unit diff:writs:cha))
      |=  j=json
      ?.  ?=(%o -.j)  ~
      ?~  evn=(~(get by p.j) 'type')  ~
      ?.  =(s/'message' u.evn)          ~
      ?~  ser=(~(get by p.j) 'user')  ~
      ?~  msg=(~(get by p.j) 'text')  ~
      ?~  tim=(~(get by p.j) 'ts')    ~
      =-  :-  ~  :_  -
          [our.bol `@da`(slack-time ?>(?=(%s -.u.tim) p.u.tim))]
      :-  %add
      ^-  memo:cha
      :: :^    ?~  d=(~(get by p.j) 'thread_ts')  ~
      ::       `(slack-time ?>(?=(%s -.u.d) p.u.d))
      :^    ~
          our.bol
        `@da`(slack-time ?>(?=(%s -.u.tim) p.u.tim))
      :+  %story  ~
      :~  'zlack: '
          ?>(?=(%s -.u.ser) p.u.ser)
          ' - '
          ?>(?=(%s -.u.msg) p.u.msg)
      ==
    ++  event-wrapper
      ^-  $-(json event)
      %-  ot
      :~  token+so
          'team_id'^so
          'api_app_id'^so
          event+message
          type+so
          'event_id'^so
          'event_time'^du
          authorizations+(as authorizations)
          'is_ext_shared_channel'^bo
          'event_context'^so
      ==
    ++  authorizations
      %-  ot
      :~  'enterprise_id'^so:dejs-soft:format
          'team_id'^so
          'user_id'^so
          'is_bot'^bo
          'is_enterprise_install'^bo
      ==
    --
  --
::  +webs: handles handle-http-requests
::
++  webs
  |_  $:  eid=@ta
          caz=(list card)
          inb=inbound-request:eyre
          pay=(unit simple-payload:http)
      ==
  +*  we  .
      our  (scot %p our.bol)
      now  (scot %da now.bol)
  ++  frisk  ::  parse url-encoded form args
    |=  body=@t
    %-  ~(gas by *(map @t @t))
    (fall (rush body yquy:de-purl:html) ~)
  ++  we-emit  |=(c=card we(caz [c caz]))
  ++  we-emil  |=(lac=(list card) we(caz (welp lac caz)))
  ++  we-chat  .^((set flag) %gx /[our]/chat/[now]/chat/noun)
  ++  we-help  we(pay `[200^~ `we-toke])
  ++  we-abed
    |=([id=@ta ib=inbound-request:eyre] we(eid id, inb ib))
  ++  we-fail
    |=(and=@t we(pay `[500+~ `(we-page 'u done gooft' and ~)]))
  ++  we-part
    ^-  $-(@t (unit flag))
    |=(a=@t (rush a ;~((glue bar) ;~(pfix sig fed:ag) sym)))
  ::
  ++  we-hear
    |=  =flag
    ^+  we
    =+  pat=/chat/(scot %p p.flag)/[q.flag]
    %-  we-emit
    [%pass chan+pat %agent [our.bol %chat] %watch pat]
  ::
  ++  we-abet
    ^-  (quip card _state)
    :_  state
    %-  flop  %+  welp  caz
    (give-simple-payload:app:ser eid (need pay))
  ::
  ++  we-code
    |=  code=@t
    ^-  [request:http outbound-config:iris]
    =+  shak=(crip (a-co:co (end 6 (sham eny.bol))))
    :_  *outbound-config:iris
    :^    %'POST'
        'https://slack.com/api/oauth.v2.access'
      ['Content-Type'^(cat 3 'multipart/form-data; boundary=--' shak)]~
    =-  `(as-octs:mimes:html (rap 3 -))
    :~  '----'  shak  '\0d\0a'
        'Content-Disposition: form-data; name="code"\0d\0a'
        '\0d\0a'
        code  '\0d\0a'
        '----'  shak  '\0d\0a'
        'Content-Disposition: form-data; name="client_id"\0d\0a'
        '\0d\0a'
        client-id  '\0d\0a'
        '----'  shak  '\0d\0a'
        'Content-Disposition: form-data; name="client_secret"\0d\0a'
        '\0d\0a'
        client-secret  '\0d\0a'
        '----'  shak  '\0d\0a'
        'Content-Disposition: form-data; name="redirect_uri"\0d\0a\0d\0a'
        url  '/apps/zlack/~/return'  '\0d\0a'
        '----'  shak  '--'
    ==  
  ::
  ++  we-auth
    ^-  tape
    ;:  welp
      "https://slack.com/oauth/v2/authorize?"
      "scope=incoming-webhook+channels:history+channels:read&"
      "client_id={(trip client-id)}&"
      "redirect_uri={(trip url)}/apps/zlack/~/return"
    ==
  ::
  ++  we-work
    ^+  we
    =*  headers  header-list.request.inb
    =/  reqline=request-line:ser
      (parse-request-line:ser url.request.inb)
    ~&  >>  [%inb-request inb]
    =+  pol=`(pole knot)`site.reqline
    ?>  ?=([%apps %zlack rest=*] pol)
      ?+    rest.pol  (we-fail 'bad path')
          ~
        ?+    method.request.inb  (we-fail 'bad method')
          ::  XX: remove this later probably?
          %'GET'   we(pay `[200^~ `(we-page ~)])
        ::
            %'POST'
          ?~  body.request.inb
            (we-fail 'empty body')
          =+  figs=(frisk q.u.body.request.inb)
          ?.  ?&  (~(has by figs) 'url')
                  (~(has by figs) 'chat')
                  (~(has by figs) 'app-id')
                  (~(has by figs) 'client-id')
                  (~(has by figs) 'client-secret')
                  (~(has by figs) 'sign-secret')
              ==
            (we-fail 'missing arguments')
          ?~  fug=(we-part (~(got by figs) 'chat'))
            (we-fail 'missing chat')
          =-  we(pay `[[200^~ `(we-page ~)]])
          %=  we
            url            (~(got by figs) 'url')
            chat           fug
            app-id         (~(got by figs) 'app-id')
            client-id      (~(got by figs) 'client-id')
            client-secret  (~(got by figs) 'client-secret')
            sign-secret    (~(got by figs) 'sign-secret')
          ==
        ==
      ::
          [%~.~ %return ~]
        =+  fail=we(pay `[200^~ `(we-have %|)])
        ?+    method.request.inb  fail
        ::
            %'GET'
          ?^  access-token  we(pay `[200^~ `we-toke])
          ?~  args.reqline  fail
          =+  figs=(malt `(list [@t @t])`args.reqline)
          =+  wire=/iris/request
          ?~  cud=(~(get by figs) 'code')  fail
          :: we(pay `[200^~ `we-toke])
          %-  we-emit(pay `[200^~ `we-toke])
          [%pass wire %arvo %i %request (we-code.we u.cud)]
        ==
      ::
          [%~.~ %events ~]
        =+  fail=we(pay `[400^~ ~])
        ?.  ?=(%'POST' method.request.inb)  fail
        ?~  body.request.inb  fail
        =+  jon=(de-json:html q.u.body.request.inb)
        ?~  jon  fail
        ?>  ?=(%o -.u.jon)
        ?~  challenge=(~(get by p.u.jon) 'challenge')
          =^  cards  state  ta-abet:(ta-slac:talk `json`u.jon)
          ~&  >>  cards
          (we-emil(pay `[200^~ ~]) cards)
        =-  we(pay `[200^~ `-])
        %-  as-octt:mimes:html  %-  en-json:html
        (frond:enjs:format challenge+u.challenge)
      ==
  ::
  ++  we-have
    |=  suc=?
    ^-  octs
    %-  as-octt:mimes:html
    %-  en-xml:html
    ^-  manx
    ;html
      ;head
        ;title:"zlack admin"
        ;meta(charset "utf-8");
        ;style:"{(trip we-lqqk)}"
      ==
    ::
      ;body
        ;div(class "container")
          ;header
            ;h1:"zlack, by quartus"
            ;h2:"a slack bridge for urbit"
          ==
        ==
      ::
        ;div(class "container")
          ;+  ?:  suc
                ;h3(class "success-message"):"success"
              ;h3(class "failure-message"):"failure"
        ==
      ==
    ==
  ::
  ++  we-toke
    ^-  octs
    %-  as-octt:mimes:html
    %-  en-xml:html
    ^-  manx
    ;html
      ;head
        ;title:"zlack admin"
        ;meta(charset "utf-8");
        ;style:"{(trip we-lqqk)}"
      ==
    ::
      ;body
        ;div(class "container")
          ;header
            ;h1:"zlack, by quartus"
            ;h2:"a slack bridge for urbit"
          ==
        ==
      ::
        ;div(class "container")
          ;+  ?~  chat
              ;div(class "container")
                ;h3:"something went wrong"
                ;a(class "button", href "../", disabled ""):"retry"
              ==
              ?~  access-token
                ;h3(class "failure-message"):"acquiring token... refresh shortly"
              ;h3(class "success-message"):"token acquired"
        ==
      ==
    ==
  ::
  ++  we-page
    |=  errs=(list @t)
    ^-  octs
    %-  as-octt:mimes:html
    %-  en-xml:html
    ^-  manx
    ;html
      ;head
        ;title:"zlack admin"
        ;meta(charset "utf-8");
        ;style:"{(trip we-lqqk)}"
      ==
    ::
      ;body
        ;div(class "container")
          ;header
            ;h1:"zlack, by quartus"
            ;h2:"a slack bridge for urbit"
            ;+  ?:  =(~ errs)  :/""
                :-  [%p ~]
                %+  join
                  `manx`;br;
                (turn errs |=(m=@t `manx`:/"{(trip m)}"))
          ==
        ==
      ::
        ;+  ?.  =('' client-id)
              ;form(method "get", action "#")
                ;+  ?~  access-token
                      ;a(class "button", href we-auth):"connect"
                    ;a(class "button", href we-auth, disabled ""):"connect"
              ==
            ;form(method "post")
              ;fieldset
                ;legend:"urbit information"
              ::
                ;label(for "url"):"base url:"
                ;input
                  =type         "text"
                  =id           "url"
                  =name         "url"
                  =required     ""
                  =placeholder  "https://{(slag 1 (scow %p our.bol))}.arvo.network";
              ::
                ;select(id "chat", name "chat", required "")
                  ;=  ;option(value ""):"select chat"
                      ;*  ^-  marl
                          %-  ~(rep in we-chat)
                          |=  [f=flag l=(list manx)]
                          ?.  =(our.bol p.f)  l
                          :_  l
                          ;option
                            =value  "{(scow %p p.f)}|{(trip q.f)}"
                            {(scow %p p.f)} {(trip q.f)}
                          ==
                  ==
                ==
              ==
            ::
              ;fieldset
                ;legend:"slack app information"
              ::
                ;label(for "app-id"):"app-id:"
                ;input
                  =type         "text"
                  =id           "app-id"
                  =name         "app-id"
                  =required     ""
                  =placeholder  "A01234ABCDE";
              ::
                ;label(for "client-id"):"client-id:"
                ;input
                  =type         "text"
                  =id           "client-id"
                  =name         "client-id"
                  =required     ""
                  =placeholder  "#############.#############";
              ::
                ;label(for "client-secret"):"client-secret:"
                ;input
                  =type         "text"
                  =id           "client-secret"
                  =name         "client-secret"
                  =required     ""
                  =placeholder  "ab12345678ab1cd2e345f67890g12345";
              ::
                ;label(for "sign-secret"):"sign-secret:"
                ;input
                  =type         "text"
                  =id           "sign-secret"
                  =name         "sign-secret"
                  =required     ""
                  =placeholder  "xy12345678ab1cd2e345f67890g12345";
              ==
            ::
              ;button(class "button", type "submit"):"configure"
            ==
      ==
    ==
  ::
  ++  we-lqqk
    '''
    body {
      background-color: #1b1b1b;
      color: #f5f5f5;
      font-family: Arial, sans-serif;
      margin: 0;
      animation: pulseBackground 5s ease-in-out infinite;
    }

    @keyframes pulseBackground {
      0% {
        background-color: #1b1b1b;
      }
      50% {
        background-color: #222222;
      }
      100% {
        background-color: #1b1b1b;
      }
    }

    .container {
      max-width: 100%;
      padding: 2rem;
      text-align: center;
    }

    header {
      margin-bottom: 2rem;
    }

    h1 {
      font-size: 3rem;
      margin-bottom: 1rem;
    }

    h2 {
      font-size: 1.5rem;
      margin-bottom: 2rem;
    }

    form {
      display: flex;
      flex-direction: column;
      margin-bottom: 2rem;
      align-items: center;
    }

    fieldset {
      display: flex;
      flex-direction: column;
      align-items: center;
      width: 35vw;
    }

    label {
      font-size: 1.25rem;
      margin-bottom: 0.5rem;
    }

    input[type="text"] {
      width: 100%;
      max-width: 30rem;
      padding: 0.75rem;
      border: none;
      border-radius: 0.25rem;
      background-color: #292929;
      color: #f5f5f5;
      margin-bottom: 1rem;
    }

    button, a.button {
      display: inline-block;
      padding: 0.75rem 1.5rem;
      margin: 1rem;
      border: none;
      border-radius: 0.25rem;
      background-color: #555555;
      color: #f5f5f5;
      cursor: pointer;
      font-size: 1.25rem;
      text-align: center;
      transition: background-color 0.2s ease-in-out;
    }

    a.button {
      text-decoration: none;
    }

    button:hover, a.button:hover {
      background-color: #777777;
    }

    button:active, a.button:active {
      background-color: #999999;
    }

    button:focus, a.button:focus {
      outline: none;
      box-shadow: 0 0 0 0.2rem rgba(85, 85, 85, 0.5);
    }

    select {
      width: 100%;
      max-width: 30rem;
      padding: 0.75rem;
      border: none;
      border-radius: 0.25rem;
      background-color: #292929;
      color: #f5f5f5;
      margin-bottom: 1rem;
      font-size: 1rem;
      appearance: none;
      -webkit-appearance: none;
      -moz-appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3E%3Cpath d='M0 2l4 4 4-4H0z'/%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 0.7em top 50%;
      background-size: 8px auto;
    }

    .success-message {
      font-size: 2rem;
      color: #ffffff;
      text-shadow: 0 0 0.5rem #ffffff;
      animation: pulse 2s ease-in-out infinite;
    }

    @keyframes pulse {
      0% {
        text-shadow: 0 0 0.5rem #ffffff;
      }
      50% {
        text-shadow: 0 0 1rem #ffffff;
      }
      100% {
        text-shadow: 0 0 0.5rem #ffffff;
      }
    }

    .failure-message {
      font-size: 2rem;
      color: #ff0000;
      text-shadow: 0 0 0.5rem #ff0000;
      animation: glitch 0.5s ease-in-out infinite;
    }

    @keyframes glitch {
      0% {
        transform: translate(0, 0);
        text-shadow: 0 0 0.5rem #ff0000;
      }
      25% {
        transform: translate(1px, -1px);
        text-shadow: 0 0 0.75rem #ff0000;
      }
      50% {
        transform: translate(-1px, 1px);
        text-shadow: 0 0 1rem #ff0000;
      }
      75% {
        transform: translate(-1px, -1px);
        text-shadow: 0 0 0.75rem #ff0000;
      }
      100% {
        transform: translate(1px, 1px);
        text-shadow: 0 0 0.5rem #ff0000;
      }
    }
    '''
  --
--