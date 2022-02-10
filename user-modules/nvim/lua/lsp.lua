local function on_attach()
  require'completion'.on_attach()
  print "hi"
end

require('lspconfig').rust_analyzer.setup({
    cmd = { vim.fn.stdpath('data') .. "/lspinstall/rust/rust-analyzer" },
    on_attach = on_attach
})

require'lspconfig'.hls.setup{
    on_attach = on_attach
}
