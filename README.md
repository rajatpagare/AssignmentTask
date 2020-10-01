## Application Architecture

This task is developed using the [Clean Swift](https://clean-swift.com) approach. This is a unidirectional implementation of [Uncle Bob's Clean Architecture](http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

Here is a basic overview of the components in this architecture:

### Scene
A Scene is a high level group of usecases.

#### BusinessLogic / Interactor
The Interactor is where all the coordination of your business logic goes. It may call out to Workers or Services and coordinate responses to send to the Presenter. Ideally the Interactor doesn't send the Presenter strings (unless they're error messages from the server), it uses enums to represent the state and the Presenter would be responsible for determining their presentation (String) value.

#### PresentationLogic / Presenter
The Presenter is responsible for what to display. If any display code requires logic it should go here. The aim is to try to avoid `if` statements in the view controllers. Examples include localisation, string interpolation etc. Generally everything from here that is passed to the Display is String based.

#### DisplayLogic / ViewController
The Display takes what is given to it by the Presenter and displays it. It also uses either the Router or the Iteractor to take actions based on user actions. It is fairly dumb and shouldn't have any _real_ logic.

#### RoutingLogic / Router
The Router manages where to go next and how to configure that Scene.

There are 3 steps to routing:

1.    Creation - Building, and configuring the next Scene. When the view controller is a Scene this shoud be done using the `DefaultControllerFactory`.
1.    DataPassing - This involves populating the new Scene with any data it needs to perform its tasks. In general you would not let the Presenter or Display know about your business objects. Instead the Router would query the DataStore (effectively the Interactor) and get any business objects that the next Scene needs.
1.    Routing - This is the actual navigation, i.e. calling `viewController.present(<VC>, animated: true)`

#### DataStore / Interactor
The DataStore holds data. It is also the contract between Scenes. It dictates what the scene needs to be populated and the data that it provides.

If the DataStore is providing access to multiple items it is preferred to pass an opaque identifier to the Presenter and then onto the Display which then passes it onto the Router which queries the DataStore based on this identifier.

#### Configurator
The Configurator wires all the above components together. It is generally used in the Router, or by the `DefaultControllerFactory`.

