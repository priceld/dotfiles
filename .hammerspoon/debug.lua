-- Useful functions for debugging. I should probably bind them to shortcuts
-- but for now I've just been running them in the console.
function print_table(t, f)
	for i, v in ipairs(t) do
		print(i, f(v))
	end
end

function w_info(w)
	return string.format("title [%s] [%s] [%s]", w:title(), w:application():name(), w:application():bundleID())
end
print_table(hs.window.visibleWindows(), w_info)

for i, v in ipairs(hs.application.runningApplications()) do
	print_table(v:allWindows(), w_info)
end
