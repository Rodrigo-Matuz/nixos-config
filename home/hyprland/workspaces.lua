-- ==============================================================
-- Workspace Rules
-- ==============================================================

-- DP-1
hl.workspace_rule({
    workspace = "1",
    monitor = "DP-1",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "DP-1",
})

-- DP-2
hl.workspace_rule({
    workspace = "3",
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = "4",
    monitor = "DP-2",
})

-- HDMI-A-1
hl.workspace_rule({
    workspace = "5",
    monitor = "HDMI-A-1",
})