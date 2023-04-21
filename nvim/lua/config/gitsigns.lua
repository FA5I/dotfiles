local git_status_ok, gitsigns = pcall(require, "gitsigns")

if not git_status_ok then
    print('gitsigns not loaded!')
    return
end

gitsigns.setup()
