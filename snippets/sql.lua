local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("SQL Snippets", { clear = true })
local file_pattern = "*.sql"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --



local same_word = function(index)
               return f(function(arg)
                        return arg[1]
                        end, {index})
             end
local first_word = function(index)
               return f(function(arg)
                        local parts = vim.split(arg[1][1], " ", true)
                        return "|| " .. parts[1] or ""
                        end, {index})
             end



local log = s("log", fmt ( [[
log('{}' {} ,l_module);
]],{i(1,"")
   , c(2, {  t("")
           , first_word(1)
           , t("|| sqlerrm")

              })
} 
 ))
table.insert(snippets, log)


local exception = s("exception", fmt ( [[
EXCEPTION
  WHEN OTHERS THEN
  log('unexpected error: ' || sqlerrm, l_module );
  {}
]],{i(1,"")} 

 ))
table.insert(snippets, exception)


local procedure = s("procedure", fmt( [[
PROCEDURE {} (
)
IS
  l_module CONSTANT VARCHAR2(100) := '{}';
BEGIN
  {}
END {};
]], {
        i(1, "")
      , rep(1)
      , i(3,"")
      , rep(1)

      }
))
table.insert(snippets, procedure)

local get_cursor_result = function (position)
  return d(position, function ()
            local nodes = {}
            -- table.insert(nodes, t(" "))
            -- table.insert(nodes, t("max was here "))
            local lines = vim.api.nvim_buf_get_lines(0,0,-1, false)
            for _, line in ipairs(lines) do 
              if line:match("ROWTYPE") then
                print(nodes)
                print(line)
                table.insert(nodes, t (line))
              end 
            end
            return sn(nil, nodes)
        end, {} )
  end

local get_rowtype_result = function (index)
  return f(function (arg)
            local lines = vim.api.nvim_buf_get_lines(0,0,-1, false)
            local a = "" 
            print(vim.inspect(arg))
            local str = arg[1][1] .. "%%ROWTYPE"
            print(str)
  
            for _, line in ipairs(lines) do 
              if line:match(arg[1][1] .. "%%ROWTYPE") then

                a = string.gsub(line, "^%s+", "") -- strip trailing spaces
                break
              end 
            end
            
            local parts = vim.split(a, " ", true)
            return parts[1]
        end, {index} )
  end

local opencursor = s({ trig = "open([%w_]+)", regTrig = true, hidden = false}, fmt( [[
open {};
loop
  fetch {} into {};
  exit when {}%notfound;
end loop;
close {};
]], {
       d(1, function(_, snip)
          return sn(1, i(1, snip.captures[1]))
        end)
     , rep(1)
     -- , get_cursor_result(2)
     -- , i(2, "")
     , c(2, {   get_rowtype_result(1
                                             -- d(1, function(_, snip)
                                             --    return sn(1, i(1, snip.captures[1]))
                                             --  end)
     )})
     , rep(1)
     , rep(1)
      }
))
table.insert(snippets, opencursor)

local trig =  s("trig", fmt ([[
trig {} param 2: {}
]],
{ 
   i(1)
 , same_word(1)
 }
))
table.insert(snippets, trig)
--
--
--
--
--
--
--
--
--
--
--''
--
--
--
-- 
--
-- End Refactoring --

return snippets, autosnippets

