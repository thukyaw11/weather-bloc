class Helper {
  static String mapStringToImage(String input){
    var name = '';
    switch(input) {
      case "sn":
        name="snow";
        break;
      case "lc":
        name = "cloud";
        break;
      case "lr":
        name = "rain";
        break;
      case "hc":
        name = "cloud";
        break;
        case "c":
          name = "sunny";
          break;
      case "hr":
        name = "rain";
        break;
        case "t":
          name = "thunder_storm";
          break;

      default:
        name = "sunny";
    }

    return name;
  }
}