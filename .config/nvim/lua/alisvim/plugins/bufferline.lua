return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
        options = {
            mode = "tabs",
            separator_style = "thick",
            always_show_bufferline = false,
            indicator = {
                style = "underline",  
            },
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true,
                }
            },
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
        },
    },
}
