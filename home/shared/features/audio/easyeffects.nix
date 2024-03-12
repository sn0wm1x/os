{
  # EasyEffects
  services.easyeffects.enable = true;
  services.easyeffects.preset = "Truthear x Crinacle Zero ParametricEQ";

  xdg.configFile = {
    # https://github.com/jaakkopasanen/AutoEq/blob/master/results/crinacle/711%20in-ear/Truthear%20x%20Crinacle%20Zero/Truthear%20x%20Crinacle%20Zero%20ParametricEQ.txt
    "easyeffects/output/Truthear x Crinacle Zero ParametricEQ.txt".text = ''
      Preamp: -3.8 dB
      Filter 1: ON LSC Fc 105 Hz Gain 4.7 dB Q 0.70
      Filter 2: ON PK Fc 8552 Hz Gain 2.8 dB Q 1.05
      Filter 3: ON PK Fc 59 Hz Gain -4.3 dB Q 0.77
      Filter 4: ON PK Fc 765 Hz Gain 2.1 dB Q 0.78
      Filter 5: ON PK Fc 2204 Hz Gain -2.0 dB Q 0.38
      Filter 6: ON HSC Fc 10000 Hz Gain -1.6 dB Q 0.70
      Filter 7: ON PK Fc 188 Hz Gain 1.5 dB Q 2.26
      Filter 8: ON PK Fc 101 Hz Gain -0.9 dB Q 1.85
      Filter 9: ON PK Fc 61 Hz Gain 0.5 dB Q 2.87
      Filter 10: ON PK Fc 339 Hz Gain -0.4 dB Q 1.89
    '';
    # https://github.com/jaakkopasanen/AutoEq/tree/master/results/crinacle/711%20in-ear/Truthear%20x%20Crinacle%20Zero
    # TODO: minimal phase {44100,48000}Hz.wav
  };
  # ".config/easyeffects"
}