User = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "alacritty",
    floating_terminal = "alacritty",
    browser = "firefox-developer-edition",
    file_manager = "thunar",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME").."/.config/awesome/config/profile.png",
    battery_threshold_critical = 15,
    battery_threshold_low = 30,
    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/pictures/screenshots",
    },

    -- >> Sidebar <<
    sidebar = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },
}
return User;
