PFont UITextField_TextFont; 

void doCommand(String command) {
  command = command.toUpperCase();
  if (command.startsWith("SCREEN.")) {  //SCREEN Segue functions
    command = command.substring("SCREEN.".length());
    try{
    String[] screenSpecification = split(command, '.');  // :-> SCREEN.CURRENT_SCREEN.CURRENT_VIEW
    CURRENT_SCREEN = screenSpecification[0].replace('_', ' ');
    CURRENT_VIEW = screenSpecification[1].replace('_', ' ');
    }
    catch (Exception e) {
      println("Encountered an unusual exception");
      println("Invalid command - " + command);
    }
  }
  if (command.equals("exit".toUpperCase()) || command.equals("quit".toUpperCase())) {
    exit();
  }
}