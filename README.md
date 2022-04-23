# University of the West Indies - St. Augustine
# Course - INFO 3604 - Project
## Group Name: JJ and Friends
## Group Members:
- Dharian Malchan
- Jean-Paul Lezama
- Jevon Greenidge
## Project: HealthWise
## Problem Scope
In Trinidad and Tobago, citizens often neglect their health for one reason or the other. The
way in which persons take control of their wellbeing can be changed with the use of an
intelligent health prediction system which allows for reliable information and convenience,
all while also being directed to the nearest health care providers for additional resources and
assurance. Often, for some reason or another, for instance high cost of care, lack of
availability of services or no insurance coverage, patients are unable to access healthcare
services. The HealthWise system seeks to solve this issue by allowing patients to get instant
and trustworthy healthcare advice and guidance online that is backed by licensed medical
practitioners.

# How to Set Up
# Install Before Set Up
1. Wampsever64
2. Nodejs
3. Vue cli
4. Vs code

# Get Application on to your machine
Locate wamp64 folder and open it. Now, locate www folder and open it.
Then, create a folder named health-wise and open it.

Download the code from main branch into the health-wise folder 

Now ensure that wampserver is on 
Open command prompt and enter 

```
cd \
```

```
cd \wamp64\www\health-wise\app
```

Then enter 
```
code .
```
To open the application on vs code

Open the terminal on vs code and enter
```
npm install vue2-google-maps@0.10.7
```

```
npm i date-fns --save
```

```
npm run serve
```
Wait for the application to build.
After the application successfully build open up a web browser and paste the localhost url.

# Set up database
Open phpmyadmin using wampserver.

When prompted to enter username and password

Username: root and leave the password blank

Click GO. 

Create a database called health_wise

Now, download the sql file "health_wise (1).sql" in branch v1.0 and import it in the health-wise database.
