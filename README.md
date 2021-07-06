# Cowboy Technology Introduction

The app is just an introduction and presentation the cowboy library.
It is an HTTP server that handles the connections to two domains:
* test1.prez
* test2.prez

## 1. test1.prez/
The server returns an HTML file with a form. The buttons are used to send the request to the server to calculate an equation inserted in the insert field in RPN form. 
* Button *Pobierz (GET)* uses GET Function
* Button *Pobierz (POST)* uses POST Function

## 2. test1.prez/getTime
The server returns an XML file with the current date and hour.

## 3. test1.prez/sum_numbers/[:numbers]
Endpoint used by *test1.prez/* to calculate RPN form equations. Returns calculated value of the equation.

## 4. test2.prez/getTime
The server returns an XML file with the date and hour. The day returned in the XML file is the current day + 20. The hour returned in the XML file is hour + 20. It is created in that way to show that there is actually a difference if we connect to the server using domain *test2.prez* than *test1.prez*.

## 5. test2.prez/[:sitename]
The server returns text Hello *:sitename*. If *:sitename* is not given, default value is *Janusz*.

Video with the presentation of the project(Polish):
https://www.youtube.com/watch?v=JwhFZFZboKI
