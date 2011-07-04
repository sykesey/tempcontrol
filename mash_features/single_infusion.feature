

Feature: create wort
   Aspirational feature to drive wort mashing via Cucumber :)

   Scenario: Heat water
    Given I have water in the "hlt" at "> 0" degrees
    Then heating the water in the "hlt" should give a temperature of ">= 70" degrees

   Scenario: Simple single infusion mash strike in
    Given I have water in the "hlt" at ">= 72" degrees
    And there is grain in the mashtun
    Then adding the strike water to the mashtun should give a temperature of "67C"
    Then start the stage "mash-in"
    And the dashboard shows the stage as "mash-in"
    
    #optional scenario here - HERMs control?
    
   Scenario: Mashout
     Given I have mashed for "45" minutes
     And I have water in the "hlt" at ">= 80" degrees
     And the "mashtun" is at ">= 65" degrees
     Then adding water to the mashtun should take the temperature to "72C"
     Then start the stage "mash-out"
     And the dashboard shows the stage as "mash-out"
     
   Scenario: Sparge
      Given I have mashed out
      And I have water in the "hlt" at ">= 75" degrees
      Then start the stage "fly-sparge"
      And the dashboard shows the stage as "fly-sparge"
      And the "hlt" should finally have no water
      And the dashboard shows the stage as "inactive"
     
    
    #end of feature - wort should now be in the kettle :)
      