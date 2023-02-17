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
      app-id=@t
      client-id=@t
      client-secret=@t
      sign-secret=@t
      access-token=json
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
  ==
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
::  +webs: handles handle-http-requests
::
++  webs
  |_  $:  eid=@ta
          caz=(list card)
          inb=inbound-request:eyre
          pay=(unit simple-payload:http)
      ==
  +*  we  .
  ++  we-emit  |=(c=card we(caz [c caz]))
  ++  we-fail  we(pay `[500+~ `(we-page 'u done gooft' ~)])
  ++  we-emil  |=(lac=(list card) we(caz (welp lac caz)))
  ++  we-abed
    |=([id=@ta ib=inbound-request:eyre] we(eid id, inb ib))
  ::
  ++  we-abet
    ^-  (quip card _state)
    :_  state
    %-  flop  %+  welp  caz
    (give-simple-payload:app:ser eid (need pay))
  ::
  ++  we-auth
    ;:  welp
      "https://slack.com/oauth/v2/authorize?"
      "scope=incoming-webhooks,channels:history,channels:read&"
      "client_id={(trip client-id)}&"
      "redirect_uri={(trip url)}/apps/"
    ==
  ::
  ++  we-work
    ^+  we
    =*  headers  header-list.request.inb
    =/  reqline  (parse-request-line:ser url.request.inb)
    ~&  >>  [%inb-request inb]
    =+  pol=`(pole knot)`site.reqline
    ?>  ?=([%apps %zlack rest=*] pol)
    ?+    method.request.inb  we-fail
      ::  XX: remove this later probably?
      %'GET'   we(pay `[[200^~ `(we-page ~)]])
      :: %'POST'  (we-take cont itum)
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
              ?~  access-token
                ;a(href we-auth):"connect"
              ;a(href we-auth, disabled ""):"connect"
            ;form
              ;label(for "url"):"url:"
              ;input
                =type         "text"
                =id           "url"
                =name         "url"
                =required     ""
                =placeholder  "https://{(scow %p our.bol)}.arvo.network";
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
    '''
  --
--