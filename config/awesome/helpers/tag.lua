local _tag = {};
-- Function to un-minimize all clients in currently visible tags
function _tag.unminimize_tag_clients()
    for _, c in ipairs(client.get()) do
        c.minimized = false;
    end
	end

return _tag;
