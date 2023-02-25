/-  zal=zlack, spider
/+  *strandio
=,  strand=strand:spider
=>
  ::
  |%
  ::  +posts: request-http generator
  ::
  ++  post
    |=  [url=@t tok=@t msg=json]
    ^-  request:http
    :^    %'POST'
        url        
      :~  'Content-Type'^'application/json;charset=utf-8'
          'Authorization'^(cat 3 'Bearer ' tok)
      ==
    `(as-octt:mimes:html (en-json:html msg))
  ::  +marse: memo parser
  ::
  ++  marse
    =,  enjs:format
    |=  [mem=memo:cha:zal cat=@t mom=(unit @t)]
    ^-  json
    ?.  ?=(%story -.content.mem)
      ~
    %-  pairs
    =-  ?~(mom - ['thread_ts'^s/u.mom -])
    :~
      channel+s/cat
    ::
      :-  'blocks'
      :-  %a
      :-  %-  pairs
          :~  type+s/'section'
          ::
              :-  %text
              %-  pairs
              :~  type+s/'mrkdwn'
                  text+s/(rap 3 '>' (scot %p author.mem) ':' ~)
              ==
          ==
      ^-  (list json)
      %+  welp
        ^-  (list json)
        %+  turn  p.p.content.mem
        |=  bol=block:cha:zal
        ?-    -.bol
            %cite
          =-  (pairs type+s/'section' text+- ~)
          %-  pairs
          :~  type+s/'plain_text'
              text+s/'citations: coming soon'
              emoji+b/%&
          ==
        ::
            %image
          %+  frond  'accessory'
          %-  pairs
          :~  type+s/'image'
              'image_url'^s/src.bol
              'alt_text'^s/alt.bol
          ==
        ==
      ^-  (list json)
      %+  turn  q.p.content.mem
      |=  nil=inline:cha:zal
      ?@  nil
        =-  (pairs type+s/'section' text+- ~)
        %-  pairs
        :~  type+s/'plain_text'
            text+s/nil
            emoji+b/%&
        ==
      ?+    -.nil
        =-  (pairs type+s/'section' text+- ~)
        %-  pairs
        :~  type+s/'plain_text'
            text+s/(terminating-parse nil)
            emoji+b/%&
        ==
      ::
        %break  (frond type+s/'divider')
      ::
          %italics
        =-  (pairs type+s/'section' text+- ~)
        %-  pairs
        :~  type+s/'mrkdwn'
            text+s/`@t`(rap 3 '_' (crip (turn p.nil terminating-parse)) '_' ~)
        ==
          %bold
        =-  (pairs type+s/'section' text+- ~)
        %-  pairs
        :~  type+s/'mrkdwn'
            text+s/`@t`(rap 3 '*' (crip (turn p.nil terminating-parse)) '*' ~)
        ==
          %strike
        =-  (pairs type+s/'section' text+- ~)
        %-  pairs
        :~  type+s/'mrkdwn'
            text+s/`@t`(rap 3 '~' (crip (turn p.nil terminating-parse)) '~' ~)
        ==
          %blockquote
        =-  (pairs type+s/'section' text+- ~)
        %-  pairs
        :~  type+s/'mrkdwn'
            text+s/`@t`(rap 3 '```' (crip (turn p.nil terminating-parse)) '```' ~)
        ==
      ==
    ==
  ++  terminating-parse
    |=  nil=inline:cha:zal
    ^-  @t
    ?@  nil  nil
    ?+    -.nil  !!
      %inline-code  (rap 3 '`' p.nil '`' ~)
      %ship         (scot %p p.nil)
      %code         (rap 3 '```' p.nil '```' ~)
      %tag          !!
      %link         (rap 3 '<' p.nil '|' q.nil '>' ~)
        %block
      (cat 3 '<included a block - not supported> - ' q.nil)
    ==
  --
::
^-  thread:spider
|=  vaz=vase
=/  m  (strand ,vase)
^-  form:m
::
=+  ^=  ours
      !<  %-  unit
          $:  url=@t
              tok=@t
              cat=@t
              mom=(unit @t)
              msg=diff:writs:cha:zal
          ==
        vaz
=+  fail=(pure:m !>(`updates:zal`sent-messages+~))
?~  ours  fail
?-    -.q.msg.u.ours
  ::  XX: do deletes
  %del       fail
  ::  XX: do reactions
  %add-feel  fail
  %del-feel  fail
::
    %add
  =+  murse=(marse [p.q.msg cat mom]:u.ours)
  ?:  ?=(~ murse)  fail
  ;<  ~  bind:m  (send-request (post url.u.ours tok.u.ours murse))
  ;<  cli=(unit client-response:iris)  bind:m  take-maybe-response
  ?~  cli  fail
  ;<  res=cord  bind:m  (extract-body u.cli)
  ?~  jun=(de-json:html res)    fail
  ?.  ?=(%o -.u.jun)            fail
  =+  hav=p.u.jun
  ?~  sat=(~(get by hav) 'ok')  fail
  ?.  =(b/%& u.sat)             fail
  =+  stamp=(~(got by hav) 'ts')
  (pure:m !>(`updates:zal`sent-messages+`?>(?=(%s -.stamp) p.stamp)))
==