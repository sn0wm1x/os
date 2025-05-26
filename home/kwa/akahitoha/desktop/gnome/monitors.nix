{
  xdg.configFile."monitors.xml".text = ''
      <monitors version="2">
      <configuration>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>2</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>eDP-1</connector>
              <vendor>LEN</vendor>
              <product>0x8ab1</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>3072</width>
              <height>1920</height>
              <rate>120.002</rate>
              <ratemode>variable</ratemode>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';
}
