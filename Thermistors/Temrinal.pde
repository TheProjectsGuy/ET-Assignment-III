//PFont UITextField_TextFont; 

void doCommand(String command) {
  //https://en.wikipedia.org/wiki/Thermistor#Basic_operation
  if (!command.startsWith("OPENLINK.")) {
    command = command.toUpperCase();
  }
  if (command.startsWith("SCREEN.")) {  //SCREEN Segue functions
    command = command.substring("SCREEN.".length());
    try {
      String[] screenSpecification = split(command, '.');  // :-> SCREEN.CURRENT_SCREEN.CURRENT_VIEW
      CURRENT_SCREEN = screenSpecification[0].replace('_', ' ');
      CURRENT_VIEW = screenSpecification[1].replace('_', ' ');
      println(CURRENT_SCREEN + ":" + CURRENT_VIEW);
    }
    catch (Exception e) {
      println("Encountered an unusual exception");
      println("Invalid command - " + command);
    }
  } else if (command.startsWith("OPENLINK.")) {  //OPENLINK.<LINK>
    String Link = command.substring("OPENLINK.".length());  
    link(Link);  //Open the link
  }
  if (command.equals("exit".toUpperCase()) || command.equals("quit".toUpperCase())) {
    exit();
  }
}