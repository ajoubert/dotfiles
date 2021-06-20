user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "alacritty",
    floating_terminal = "alacritty",
    browser = "firefox-developer-edition",
    -- file_manager = "kitty -1 --class files -e ranger",
    file_manager = "thunar",
    editor = "kitty -1 --class editor -e vim",
    email_client = "kitty -1 --class email -e neomutt",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    -- web_search_cmd = "xdg-open https://www.google.com/search?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME").."/.config/awesome/config/profile.png",

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
        show_on_mouse_screen_edge = false,
    },

    -- >> Lock screen <<
    -- This password will ONLY be used if you have not installed
    -- https://github.com/RMTT/lua-pam
    -- as described in the README instructions
    -- Leave it empty in order to unlock with just the Enter key.
    lock_screen_custom_password = "",
    -- lock_screen_custom_password = "awesome",

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,

    -- >> Weather <<
    -- Get your key and find your city id at
    -- https://openweathermap.org/
    -- (You will need to make an account!)
    -- openweathermap_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    openweathermap_key = "8035ed4ee38e0c316f99ade8daaf3b93",
    openweathermap_city_id = "2759794",
    -- > Use "metric" for Celcius, "imperial" for Fahrenheit
    weather_units = "metric",

    -- >> Coronavirus <<
    -- Country to check for corona statistics
    -- Uses the https://corona-stats.online API
    coronavirus_country = "netherlands",
}
return user;
