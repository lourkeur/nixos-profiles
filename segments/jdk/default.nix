{ pkgs, ... }:

# Make a JDK available globally.
#
# Also make jars executable just because we can!

{
  programs.java.enable = true;

  boot.binfmt.registrations.jar = {
    interpreter = pkgs.writers.writeDash "launch-jar" ''/run/current-system/sw/bin/java -jar "$@"'';
    recognitionType = "extension";
    magicOrExtension = "jar";
  };
}
