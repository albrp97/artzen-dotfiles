-- Helper to get the current directory
local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

return {
	entry = function(_, args)
		local action = args[1]
		local bookmarks_file = os.getenv("HOME") .. "/.config/yazi/bookmarks"

		-- Ensure file exists
		os.execute("touch '" .. bookmarks_file .. "'")

		if action == "save" then
			local cwd = get_cwd()
			-- 1. Ask user for a Key (e.g., "d")
			local key, event = ya.input({
				title = "Save to Key (Type letter + Enter):",
				position = { "top-center", y = 3, w = 40 },
			})
			
			if key and key ~= "" then
				-- 2. Append "key path" to file (simple storage)
				-- We add a space after key to ensure "d" doesn't match "da" later
				os.execute("echo '" .. key .. " " .. cwd .. "' >> '" .. bookmarks_file .. "'")
				ya.notify({ title = "Bookmark Saved", content = "'" .. key .. "' -> " .. cwd, timeout = 2.0 })
			end

		elseif action == "jump" then
			-- 1. Ask user for Key
			local key, event = ya.input({
				title = "Jump to Key (Type letter + Enter):",
				position = { "top-center", y = 3, w = 40 },
			})

			if key and key ~= "" then
				-- 2. Find the LAST matching line for this key using grep/tail
				-- Format in file is: "key /path/to/folder"
				local cmd = "grep '^" .. key .. " ' '" .. bookmarks_file .. "' | tail -n 1 | cut -d' ' -f2-"
				
				local handle = io.popen(cmd)
				local result = handle:read("*a")
				handle:close()

				if result and result ~= "" then
					-- Trim newline characters
					local target = result:gsub("[\r\n]+$", "")
					ya.manager_emit("cd", { target })
				else
					ya.notify({ title = "Error", content = "No bookmark found for '" .. key .. "'", level = "error", timeout = 2.0 })
				end
			end
		end
	end,
}