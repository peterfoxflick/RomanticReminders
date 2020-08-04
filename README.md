# RomanticReminders
A SwiftUI iOS application that creates native reminders.  Based on the five love languages you can add reminders to do something romantic each day.



## The Goal
Learning how to send notifications in iOS and create reminders.

## Video

This project is documented here:

[![Watch the video](https://raw.githubusercontent.com/peterfoxflick/RomanticReminders/master/Youtube%20Thumbnails.png)](https://www.youtube.com/watch?v=dzaCMaXOOEM)

## Notifications

Originally I wanted the app to send notifications. However, after some research that would require a server to send the notifications and that was more infrastructure then desired for this simple app.
Later I found a way to create local notifications but with how this app sent out daily notifications it would then need to store all the notification info to delete them in case the user wanted to stop, or changed preferences, etc. It was a mess, and I was quite pleased with using the native reminders.

## Reminders

So to simplify the project it uses the existing native iOS app Reminders to keep track of notifications. The app creates a list and stocks it full of reminders. Now, users can view, edit, and delete reminders instead of me having to do the duplicate building. If it already exists why build it?
