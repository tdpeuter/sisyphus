hl.on("hyprland.start", function()
  if not (hl.plugin and hl.plugin.hy3) then
    hl.exec_cmd('hyprctl plugin load /nix/store/78mllvcwa0nbqiczjpd8zqsywhy5dllm-hy3-0.55.0/lib/libhy3.so')
  end
end)
