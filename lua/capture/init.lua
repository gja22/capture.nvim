local M = {}

-- Trim leading and trailing spaces
local function trim(s)
    return s:match "^%s*(.-)%s*$"
end

-- Generate the Zettel id
local function get_id()
    return os.date("%Y%m%d%H%M")
end

-- Generate date in the format I like, YYYY-MM-DD
local function get_date()
    return os.date("%Y-%m-%d")
end

-- Ask for name of 1-1, meeting, or note
local function get_name(type)
    local name
    if type == "1-1" then
        name = vim.fn.input("1-1 with: ")
    elseif type == "meeting" then
        name = vim.fn.input("Meeting about: ")
    elseif type == "note" then
        name = vim.fn.input("Note about: ")
    else
        name = "INVALID TYPE IN get_name()"
    end
    name = trim(name)
    return name
end

local function safe_name(n)
    local name = string.lower(n)
    name = string.gsub(name, " ", "-")
    return name
end

-- Create 1-1 Zettel
M.oneonone = function()
    local id = get_id()
    local date = get_date()
    local name = get_name("1-1")
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

-- Create meeting Zettel
M.meeting = function()
    local id = get_id()
    local date = get_date()
    local name = get_name("meeting")
    local lname = safe_name(name)
    local title = name
    local file = id .. '-' .. lname .. '.md'

    vim.api.nvim_command('e ' .. file)

    vim.api.nvim_buf_set_lines(0, 0, 0, true, { '---',
        'id: ' .. id,
        'title: ' .. title,
        'date: ' .. date,
        'tags: #meeting #',
        '---',
        '# ' .. name,
        ' ', })
end

-- Create note Zettel
M.note = function()
    local id = get_id()
    local date = get_date()
    local name = get_name("note")
    local lname = safe_name(name)
    local title = name
    local file = id .. '-' .. lname .. '.md'

    vim.api.nvim_command('e ' .. file)

    vim.api.nvim_buf_set_lines(0, 0, 0, true, { '---',
        'id: ' .. id,
        'title: ' .. title,
        'date: ' .. date,
        'tags: #note #',
        '---',
        '# ' .. name,
        ' ', })
end

return M
