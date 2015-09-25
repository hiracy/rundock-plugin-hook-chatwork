# Rundock::Plugin::Hook::Chatwork
[![Gem Version](https://badge.fury.io/rb/rundock-plugin-hook-chatwork.svg)](http://badge.fury.io/rb/rundock-plugin-hook-chatwork)
<!--
[![Circle CI](https://circleci.com/gh/hiracy/rundock-plugin-hook-chatwork/tree/master.png?style=shield)](https://circleci.com/gh/hiracy/rundock-plugin-hook-chatwork/tree/master)
-->

[Rundock](https://github.com/hiracy/rundock) plugin for [ChatWork API](http://developer.chatwork.com/) hook.

## Installation

```
$ gem install rundock
```

```
$ gem install rundock-plugin-hook-chatwork
```

## Usage

Edit your operation scenario to hooks.yml like this sample.

```
send_chatwork_room:                        # hook name
  hook_type: chatwork                      # hook_type(always specify 'chatwork')
  token: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   # sender token(required)
  room_id: xxxxxxxx                        # room id(required)

# another hook(optional)
sub_chatwork_room:
  hook_type: chatwork
  token: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  room_id: xxxxxxxx
```

And edit your operation scenario to "[scenario.yml](https://github.com/hiracy/rundock/blob/master/scenario_sample.yml)" like this sample.

```
- target: anyhost-01
  deploy:
    - src: /path/to/great/middleware/conf_src.rb  # deploy source file from localhost
      dst: /path/to/great/middleware/conf_dst.rb  # deploy destination file to remotehost
  command:
    - /etc/init.d/great_middleware start
  hook:
    - send_chatwork_room                          # enable hook(hooks.yml/send_chatwork_room)
    - sub_chatwork_room
---
anyhost-01:                                       # see rundock options(https://github.com/hiracy/rundock/blob/master/README.md)
  host: 192.168.10.11
  ssh_opts:
    port: 22
    user: anyuser
    key:  ~/.ssh/id_rsa
```

and execute rundock.

    $ rundock do /path/to/your-dir/scenario.yml -k /path/to/your-dir/hooks.yml

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rundock-plugin-hook-chatwork/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

