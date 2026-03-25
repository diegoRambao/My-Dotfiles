local function resumable(source, opts)
  return function()
    local resume = require("snacks.picker.resume")
    if resume.state[source] then
      Snacks.picker.resume({ source = source })
    else
      Snacks.picker.pick(source, opts or {})
    end
  end
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>ff", resumable("files"), desc = "Find files (resume)" },
      { "<leader>fw", resumable("grep"), desc = "Grep (resume)" },
      { "<leader>f/", resumable("grep_buffers"), desc = "Grep open buffers (resume)" },
      { "<leader>fb", resumable("buffers"), desc = "Buffers (resume)" },
      { "<leader>fo", resumable("recent"), desc = "Recent files (resume)" },
      { "<leader>f.", "<cmd>lua Snacks.picker.resume()<cr>", desc = "Resume last picker" },
    },
  },
}
