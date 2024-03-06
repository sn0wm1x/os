{ pkgs, ... }: {
  home.packages = with pkgs; [ gradience ];

  # https://github.com/GradienceTeam/Community/blob/next/official/catppuccin-frappe.json
  # home.file."/.config/presets/user/catppuccin-frappe.json".source = ./catppuccin-frappe.json;
}