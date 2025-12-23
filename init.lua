local shada_path = vim.fn.expand(vim.fn.stdpath("state") .. "/shada/")
local files = vim.fn.glob(shada_path .. "main.shada.tmp.*", tonumber(1), tonumber(1))

if #files > 0 then
	for _, file in ipairs(files) do
		vim.fn.delete(file)
	end
end

require("config.lazy")

