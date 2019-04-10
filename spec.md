# Specifications for the Sinatra Assessment

Specs:
- [x] Used Sinatra to build the app
- [x] Used ActiveRecord for storing information in a database
- [x] Included one User model and one Exercise model
- [x] Included one has_many relationship on my User model (User has_many exercises)
- [x] Included one belongs_to relationship on my Exercise model (Exercise belongs_to User)
- [x] Included user accounts with unique login attribute (username). Used ActiveRecord validation helper 'uniqueness' to ensure that the username has not been used before
- [x] Ensured that the belongs_to resource (exercise) has routes for Creating, Reading, Updating and Destroying
- [x] Ensured that users can't modify content created by other users by checking the user id of the currently logged in user with the user id of the record they are trying to modify
- [x] Included user input validations for creating a new user and exercise record to make sure no fields are left blank
- [x] BONUS - not required - Displayed validation failures to user with error message using Rack Flash
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] I have a large number of small Git commits
- [x] My commit messages are meaningful
- [x] I made the changes in a commit that relate to the commit message
- [x] I didn't include changes in a commit that weren't related to the commit message
