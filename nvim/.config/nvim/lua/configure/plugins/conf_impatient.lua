-- https://github.com/lewis6991/impatient.nvim
-- 由于此插件的功能特性，需要其最早require
-- 根据在plugins.lua 中定义的 berfore部分(packer.startup 中的 plug_options.setup) 不是干这个require的事情，因为此时此插件并没有packadd，并不能(或许)成功
-- 应该在 plugins.lua 中定义的 config部分(packer.startup 中的 plug_options.config) 部分

local M = {}

function M.before() end

function M.load()
    local ok, m = pcall(require, "impatient")
    if not ok then
        return
    end

    M.impatient = m
end

function M.after() end

return M
