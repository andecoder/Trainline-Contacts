# Trainline Tech Test Solution

This repository contains [**my**](https://www.linkedin.com/in/andecoder/) solution to Trainline's Tech Test.
I have followed the principles of Test-Driven Development, S.O.L.I.D., and Clean Architecture on my implementation.
The final solution contains a mixture of Unit, Integration and Snapshot tests to validate functionality.

## Original Instructions

The marketing team has provided us with a list of contacts (Contacts.csv) they want to reach out to. The file is a CSV with 4 tab-separated columns: full name, address, phone number, email. Address contains the following fields, separated by pipe (‘|'): street, city, state, postcode, country.
There are 3 contact methods: email, post and sms. The preferred contact method is determined based on country person lives in:

- email: ["Czech Republic", "Saint Lucia"]
- post: ["Italy", "Australia", "Finland"]
- sms: [all other countries]

The app should contain 2 screens: the initial screen is a list displaying full name and contact method for each of the contacts. The second screen is accessed by tapping on any row and displays a list of all other contacts with same contact method as the selected person.

## The Task

The goal of this tech test is to update the **ContactsTableViewController** and **DetailsTableViewController** classes to satisfy the requirements provided.
