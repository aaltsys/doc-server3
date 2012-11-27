##################################
 Basic Workstation User Management
##################################

The **AAltSys Server** provides user security, which requires that all users
authenticate their login information when accessing the server. User names and
passwords which are stored in individual workstations must be entered in the
server's **Zentyal** administration system before users can access the server.
Therefore part of server installation is collecting, and correcting, user
account information from the workstations.

.. _identifier-standards:

Identifier Standards
====================

The following standards apply to user names, full names, and passwords:

+ User names may contain only alphanumeric characters or the symbols :kbd:` . ? & + : - @`
+ Spaces are not permitted in user names.
+ Administrative users, *"Administrator"* and *"Owner"*, should not be used for logins.
+ *"Guest"* should be disabled.
+ All administrative and user logins must have passwords.

Windows User Management Issues
==============================

The following user account management problems are commonly found on Windows workstations:

+ Administrative user *"Administrator"* or *"Owner"* has a user's full name and is used as the primary login account.
+ User *"Guest"* is being used as a login account.
+ A user's name contains spaces or prohibited characters.
+ Several separate machines in a network list the same user name, with differing full names and/or passwords.
+ A user name, full name, and home folder name are all three different.
+ A home folder name, which cannot be changed by any entry process, does not match the user to whom it is assigned.
+ :menuselection:`Start --> Control Panel --> User Accounts` displays the full name, but not the user name, for login authorization.

Windows XP User Management
==========================

The following procedure allows user names, full names, and passwords to be viewed and changed:

+ On the :menuselection:`Start` menu, right-click :menuselection:`My Computer --> Manage`.
+ In the :guilabel:`Computer Management` windows, click the :guilabel:`\+` at the left of :guilabel:`Local Users and Groups`.
+ Double-click the :guilabel:`Users` folder.
+ To add a new user, select menu item :menuselection:`Action --> New User...` .
+ To delete a user, right-click the user name, choose :menuselection:`Delete`, follow the directions.

.. warning:: *This permanently deletes all data and records for the user, including email.*

+ To change a user name, click on the name, press :kbd:`[F2]`, edit the name, and press :kbd:`<Enter>`
+ To set or change a full name, double-click a user name, change the full name in the :guilabel:`Properties` windows, click :guilabel:`OK`.
+ To set or change a password, right-click a user name, choose :menuselection:`Set password`.

.. warning:: *This is not recommended for active users.*

Windows XP Passwords
====================

+ Login as the user whose password will be reset
+ On the menu, choose :menuselection:`Start --> Control Panel`
+ If the :guilabel:`Control Panel` left side says :guilabel:`Switch to Classic View`, then select that option.
+ Double-click :guilabel:`User Accounts`.
+ Double-click the logged in user's full name.
+ Click on :guilabel:`Change my password`, follow the on-screen directions.

.. warning:: *If the chosen user is not logged in the link will say* :guilabel:`Change the password` *instead, but please do not.*

Mac OS X User Management
========================

The following procedure allows user names, full names, and passwords to be viewed and changed:

+ Open :menuselection:`Apple Menu --> System Preferences...`
+ In :guilabel:`System Preferences` open the :guilabel:`Accounts` preference pane.

  - If the pane is locked, click the lock icon in the lower left corener to authenticate your administrative credentials.

+ To add a user, click the :guilabel:`+` below the user account list.

  - Specify the user account type. *Note: Standard account type is recommended for users as all administrative tasks request an administrator's username and password for security.*
  - Specify the user's full name.
  - Specify the user's account name, also known as the username, following the guidelines found in :ref:`identifier-standards`.
  - Specify the user's password.
  - Click :guilabel:`Create Account`.
  
+ To view the account name, also known as the username, of an existing user right-click on the user in the account list and select :menuselection:`Advanded Options...`

  - The account name listed is the username used for network communications.
  
+ To change the password for an existing account, login as the account in question.

  - Select the user account from the account list.
  - Click :guilabel:`Change password...`
  
.. warning:: *If the chosen user is not logged in the button will say* :guilabel:`Reset password...` *instead, but please do not.*

