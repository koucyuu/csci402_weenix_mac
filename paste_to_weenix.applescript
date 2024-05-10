-- https://stackoverflow.com/questions/15190868/copy-pure-text-from-clipboard-using-applescript
set content to (the clipboard as text)
set content_length to count of characters in content
if content_length > 126 then
	return
end if

-- https://stackoverflow.com/a/68150734
set qemu_process_name to "qemu-system-i386"
tell application "System Events"
	-- https://discussions.apple.com/thread/6715260?sortBy=best
	if (get name of every application process) contains qemu_process_name then
		tell application process qemu_process_name
			set frontmost to true
		end tell
	else
		return
	end if
end tell

-- https://stackoverflow.com/questions/69545661/extract-only-letter-characters-from-a-string-in-applescript
repeat with i from 1 to count of characters in content
	set c to character i of content
	set cid to id of c
	-- https://apple.stackexchange.com/questions/36943/how-do-i-automate-a-key-press-in-applescript
	-- https://apple.stackexchange.com/questions/142986/applescript-keystroke-ignoring-numbers
	-- https://eastmanreference.com/complete-list-of-applescript-key-codes
	if cid = 49 then -- 1
		tell application "System Events" to key code 18
	else if cid = 50 then -- 2
		tell application "System Events" to key code 19
	else if cid = 51 then -- 3
		tell application "System Events" to key code 20
	else if cid = 52 then -- 4
		tell application "System Events" to key code 21
	else if cid = 53 then -- 5
		tell application "System Events" to key code 23
	else if cid = 54 then -- 6
		tell application "System Events" to key code 22
	else if cid = 55 then -- 7
		tell application "System Events" to key code 26
	else if cid = 56 then -- 8
		tell application "System Events" to key code 28
	else if cid = 57 then -- 9
		tell application "System Events" to key code 25
	else if cid = 48 then -- 0
		tell application "System Events" to key code 29
	else if cid = 45 then -- -
		tell application "System Events" to key code 27
	else if cid = 46 then -- .
		tell application "System Events" to key code 47
	else
		tell application "System Events" to keystroke c
	end if
end repeat
