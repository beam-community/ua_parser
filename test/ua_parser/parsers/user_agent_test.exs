defmodule UAParser.Parsers.UATest do
  use ExUnit.Case

  alias UAParser.Parsers.UA, as: Parser
  alias UAParser.{UA, Version}

  @user_string "Mozilla/5.0 (Windows; U; en-US) AppleWebKit/531.9 (KHTML, like Gecko) AdobeAIR/2.5.1"
  @pattern %{regex: ~r/\b(MobileIron|Crosswalk|AdobeAIR|FireWeb|Jasmine|ANTGalio|Midori|Fresco|Lobo|PaleMoon|Maxthon|Lynx|OmniWeb|Dillo|Camino|Demeter|Fluid|Fennec|Epiphany|Shiira|Sunrise|Spotify|Flock|Netscape|Lunascape|WebPilot|NetFront|Netfront|Konqueror|SeaMonkey|Kazehakase|Vienna|Iceape|Iceweasel|IceWeasel|Iron|K-Meleon|Sleipnir|Galeon|GranParadiso|Opera Mini|iCab|NetNewsWire|ThunderBrowse|Iris|UP\.Browser|Bunjalloo|Google Earth|Raven for Mac|Openwave|MacOutlook)\/(\d+)\.(\d+)\.(\d+)/}
  @match ["AdobeAIR/2.5.1", "AdobeAIR", "2", "5", "1"]

  test "parses user agent information" do
    result  = Parser.parse({@pattern, @match})
    version = %Version{major: "2", minor: "5", patch: "1"}

    assert %UA{family: "AdobeAIR", version: ^version} = result
  end
end
