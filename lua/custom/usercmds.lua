local user_cmd = function(cmd, expr, options)
  options = options or {}
  vim.api.nvim_create_user_command(cmd, expr, options)
end

--TODO: make it so this only is enabled in json files or files that could reasonably have json
-- also maybe make it so it could be applied on a range, or visually
user_cmd('PrettyJson', ":%!jq '.'")
user_cmd('OT2MDL', ':%! ~/src/bash/onetab_list_to_md_link.sh')
