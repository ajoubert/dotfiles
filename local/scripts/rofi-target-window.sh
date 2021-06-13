#/bin/bash

# Jumps to the client which corresponds to the given window ID
awesome_jump_to_client() {
    awesome-client "
    local awful = require('awful')
    local win = function (c)
        return awful.rules.match(c, {window = $1})
    end
    for c in awful.client.iterate(win) do
        c:jump_to()
        break
    end
    "
}

awesome_jump_to_client $1
