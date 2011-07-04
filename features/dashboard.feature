
Feature: The Dashboard is somewhat useful
   In order to have a useful dashboard
   I need to be able to view information while a mash is underway
   Such as temperatures in each vessel/zone and what stage of the process is active
   
   Scenario Outline: Open Dashboard
    Given I am on the dashboard
    The dashboard should contain a current temperature for the "hlt" zone
    The dashboard should contain a current temperature for the "mashtun" zone
    The dashboard should contain a current temperature for the "ambient" zone
    The dashboard should contain a five reading temperature delta for the "hlt" zone
    The dashboard should contain a five reading temperature delta for the "mashtun" zone
    The dashboard should contain a five reading temperature delta temperature for the "ambient" zone
    The dashboard should contain the current mash stage
      
      
    