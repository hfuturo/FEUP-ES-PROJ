## **Architecture and Design**

### Logical Architecture

The logical architecture of our app only features 2 different systems. The HabitHero system where the user interacts with the application and where the logic resides. The other system is the External System which englobes all the API's that our app interacts with, such as Notifications API, Calendar API and Email API.

![here](/images/logical_architecture.png)

### Physical Architecture

In out physical architecture we have the client smartphone where it interacts with the Habit Hero server, which deals with all the logic. This server, on the other hand, interacts with all the API's. 

![DeploymentView](/images/physical_architecture.png)

### Domain Model

Here we can see how the different domains interacts with eachother in the application. We have a user that can have multiple themes. This user can also have multiple habits and challenges. Each habit can have multiple reminders, but only one insight.

![DomainModel](/images/domain-model.png)
