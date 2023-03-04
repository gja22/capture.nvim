local M = {}

-- Trim leading and trailing spaces
local function trim(s)
    return s:match "^%s*(.-)%s*$"
end

-- Generate the Zettel id
local function get_id()
    return os.date("%Y%m%d%H%M")
end

-- Generate the id for the next Friday (including today)
local function get_id_next_friday()
    -- %w is day of week [0-6 = Sunday - Saturday]
    local day_of_week = os.date("%w")
    -- How many days away is Friday
    local offset = 0
    if day_of_week == 6 then
        offset = 6
    else
        offset = 5 - day_of_week
    end
    local seconds_in_day = 24*60*60
    return os.date("%Y%m%d%H%M", os.time()+(offset*seconds_in_day))
end

-- Get date in short format, YYYY-MM-DD
local function get_date()
    return os.date("%Y-%m-%d")
end

-- Get the date of the next Friday (including today)
-- in short format, YYYY-MM-DD
local function get_date_next_friday()
    -- %w is day of week [0-6 = Sunday - Saturday]
    local day_of_week = os.date("%w")
    -- print ("weekday: " .. day_of_week)
    -- How many days away is Friday
    local offset = 0
    if day_of_week == "6" then
        offset = 6
    else
        offset = 5 - day_of_week
    end
    -- print ("offset: " .. offset)
    local seconds_in_day = 24*60*60
    return os.date("%Y-%m-%d", os.time()+(offset*seconds_in_day))
end

-- Get short day, Tue
local function get_day()
    return os.date("%a")
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

-- Create daily journal Zettel
M.daily = function()
    local id = get_id()
    local date = get_date()
    local day = get_day()
    local name = 'Journal Entry ' .. day .. ' ' .. date
    local title = name
    local file = id .. '-daily-journal.md'

    vim.api.nvim_command('e ' .. file)

    vim.api.nvim_buf_set_lines(0, 0, 0, true, {
        '---',
        'id: ' .. id,
        'title: ' .. title,
        'date: ' .. date,
        'tags: #journal #daily',
        '---',
        '# ' .. name,
        ' ',
        '## What commitment do I stand in today?',
        ' ',
        '- ',
        ' ',
        '## Intention for the day (in support of goals)',
        ' ',
        '- ',
        ' ',
        '## Notes',
        ' ',
        '- ',
        ' ',
        '## Comments/Concerns/Issues (review backwards)',
        ' ',
        '- ',
        ' ',


    })
end

-- Create weekly report Zettel
M.weekly = function()
    local id = get_id_next_friday()
    local date = get_date_next_friday()
    local day = "Fri"
    local name = 'Weekly Report ' .. day .. ' ' .. date
    local title = name
    local file = id .. '-weekly-report'

    vim.api.nvim_command('e ' .. file)

    vim.api.nvim_buf_set_lines(0, 0, 0, true, {
        '---',
        'id: ' .. id,
        'title: ' .. title,
        'date: ' .. date,
        'tags: #journal #weekly',
        '---',
        '# ' .. name,
        ' ',
        '## Accomplishments',
        ' ',
        '- ',
      ' ',
        '## Plan for next week',
        ' ',
        '- ',
        ' ',
        '## Plan for next 3 months',
        ' ',
        '- ',
        ' ',
        '## Comments/Concerns/Issues',
        ' ',
        '- ',
        ' ',


    })
end
return M
