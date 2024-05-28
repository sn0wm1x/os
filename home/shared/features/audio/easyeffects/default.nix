{
  # EasyEffects
  services.easyeffects.enable = true;
  services.easyeffects.preset = "Truthear x Crinacle Zero";

  xdg.configFile = {
    # https://github.com/jaakkopasanen/AutoEq/blob/master/results/crinacle/711%20in-ear/Truthear%20x%20Crinacle%20Zero/Truthear%20x%20Crinacle%20Zero%20ParametricEQ.txt
    "easyeffects/output/Truthear x Crinacle Zero.json".source = ./truthear-x-crinacle-zero.json;
  };
  # ".config/easyeffects"
}
