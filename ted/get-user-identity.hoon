/-  zal=zlack, spider
/+  *strandio
=,  strand=strand:spider
=>
  ::
  |%
  ++  strip
    |=  j=json
    ^-  (unit @t)
    ?>  ?=(%o -.j)
    (~(get by p.j) 'access_token')
  ++  ident
    |=  [id=@t toke=@t]
    ^-  [request:http outbound-config:iris]
    :_  *outbound-config:iris
    :^    %'GET'
        %-  crip
        "https://slack.com/api/users.info?token={(trip toke)}&user={(trip id)}"
      ['Content-Type'^(cat 3 'application/x-www-form-urlencoded')]~
    ~
  --
::
^-  thread:spider
|=  vaz=vase
=/  m  (strand ,vase)
^-  form:m
::
=/  them=(unit [id=@t axs=json])
  !<((unit [@t json]) vaz)
=+  fail=(pure:m !>(`updates:zal`user-identity+~))
?~  them              fail
?~  toke=(strip axs)  fail
::
;<  ~  bind:m  (send-request (ident id u.toke))
;<  cli=(unit client-response:iris)  bind:m  take-maybe-response
?~  cli               fail
;<  res=cord  bind:m  (extract-body u.cli)
::
?~  jun=(de-json:html res)    fail
?.  ?=(%o -.u.jun)            fail
=+  hav=p.u.jun
?~  sat=(~(get by hav) 'ok')  fail
?.  =(s/'true' u.sat)         fail
=+  user=(~(got by hav) 'user')
?>  ?=(%o -.user)
=+  name=(~(got by p.user) 'name')
?>  ?=(%s -.name)
(pure:m !>(`updates:zal`user-identity+[id p.name]))