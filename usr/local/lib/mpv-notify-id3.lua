-- send desktop notifications via `notify-send`
-- when tracks change

last_cmd = nil

mp.register_event("file-loaded", function()
	data = mp.get_property_native("metadata")
	if not data then
		return
	end

	local artist = (data["ARTIST"] or data["artist"] or "")
	local title =  (data["TITLE"]  or data["title"]  or "")
	if artist..title == "" then
		return
	end

	artist = "'"..string.gsub(artist, "'", "'\"'\"'").."'"
	title  = "'"..string.gsub(title,  "'", "'\"'\"'").."'"

	local cmd = "notify-send --app-name=mpv --expire-time=2000 -- "..artist.." "..title
	if cmd == last_cmd then
		return
	end

	os.execute(cmd)

	last_cmd = cmd
end)
