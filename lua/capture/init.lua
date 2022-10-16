local M = {}

local function trim(s)
   return s:match "^%s*(.-)%s*$"
end

local function get_id()
    return os.date("%Y%m%d%H%M")
end

local function get_date()
    return os.date("%Y-%m-%d")
end

local function get_name()
    local name = vim.fn.input("1-1 with: ")
    name = trim(name)
    return name
end

local function safe_name(n)
    local name = string.lower(n)
    name = string.gsub(name, " ", "-")
    return name
end

M.oneonone = function()
    local id = get_id()
    local date = get_date()
    local name = get_name()
    local lname = safe_name(name)
    local title = name .. ' 1-1'
    local file = id .. '-' .. lname .. '-1-1.md'

    vim.api.nvim_command('e ' .. file)

    vim.api.nvim_buf_set_lines(0, 0, 0, true, { '---',
        'id: ' .. id,
        'title: ' .. title,
        'date: ' .. date,
        'tags: #1-1 #' .. lname,
        '---',
        '# ' .. name .. ' 1-1',
        '**date:** ' .. date,
        ' ', })
end

return M
