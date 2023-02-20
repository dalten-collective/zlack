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
    ?~(h=(~(get by p.j) 'access_token') ~ `?>(?=(%s -.u.h) +.u.h))
  ++  ident
    |=  [id=@t toke=@t]
    ^-  request:http
    :^    %'GET'
        %-  crip
        "https://slack.com/api/users.info?user={(trip id)}&pretty=1"
      :~  'Content-Type'^'application/x-www-form-urlencoded'
          'Authorization'^(cat 3 'Bearer ' toke)
      ==
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
=,  u.them
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
?.  =(b/%& u.sat)             fail
=+  user=(~(got by hav) 'user')
?>  ?=(%o -.user)
=+  name=(~(got by p.user) 'name')
?>  ?=(%s -.name)
(pure:m !>(`updates:zal`user-identity+`[id p.name]))