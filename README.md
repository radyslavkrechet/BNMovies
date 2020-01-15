<h1><img src="https://github.com/radyslavkrechet/PRBoilerplate/blob/master/App/Resources/Assets.xcassets/AppIcon.appiconset/180.png" width="23" height="23">Movies</h1>

<p float="center">
  <img src="/Screenshots/1.png" width="200px" />
  <img src="/Screenshots/2.png" width="200px" /> 
  <img src="/Screenshots/3.png" width="200px" />
  <img src="/Screenshots/4.png" width="200px" />
</p>

### Architecture ###

* App (aka Presentation) contains modules, utils and analytics
* Domain contains DTOs (Data Transfer Objects), interactors (aka use cases) and protocols of repositories
* Data contains implementations of repositories and protocols of API and DAO
* Net contains adapters, request and response models, routers, utils and implementations of API
* Database contains adapters, entities, utils and implementations of DAO

### Workflow ###

<img src="https://habrastorage.org/web/531/04c/89d/53104c89d9cf44a59c95e351b7485574.png">

**App**
* There are base modules that implemented base logic and inherited from each other. They contain protocols of presenters, implementations of view controllers and protocols of data sources (optional).
* Here is a list of base modules: `Root` logs presentation; `Content` gets content by the presenter and displays different states (loading, empty, content, error); `List` logs item selection from data source; `Pagination` logs pull to refresh and refreshes content by the presenter, logs last item presentation by the data source and gets more content by the presenter.
* All modules should inherit one of the base modules. Communication between the module's components should be by protocols only.
* A view controller should own a presenter, take content from the presenter and/or give data for processing to the presenter. The view controller should own a data source, give content from the presenter to the data source and react on data source's events.
* The presenter should have a weak reference to the view, take data for processing from the view and give content to the view. The presenter should own use cases and use them for creating, reading, updating and deleting data (by protocols only).
* The data source should take content from view, own it, use it for presentation and send events to the view.

**Domain**
* There is an `Executable` protocol that should be implemented by all use cases.
* There is a `AsyncOnMain` property wrapper that should be used for handlers in all use cases.
* A use case should own repositories and use them for creating, reading, updating and deleting data (by protocols only).

**Data**
* A repository should implement one of the protocols from Domain, own API and DAO and use them for creating, reading, updating and deleting data (by protocols only).

**Net**
* Communication between the components should be by protocols only.
* An adapter should transform network response to DTO.
* A router should implement `URLRequestConvertible` protocol.
* An API should implement one of the protocols from Data, own network manager, coder service and adapter and use them to network request, decode response and adapt it.

**Database**
* Communication between the components should be by protocols only.
* An adapter should transform DTO to the database entity and vice versa.
* A DAO should implement one of the protocols from Data, own database manager and adapter and use them to get, set and delete data with pre or post adaptation.

### Dependencies ###

* Alamofire is used to network requests
* Kingfisher is used to downloading and caching images
* CoreStore is used to database CRUD operations
* Firebase/Analytics, Fabric and Crashlytics are used to collect analytics/crashes
* Swinject and SwinjectStoryboard are used to dependency injection
* SwiftLint is used to compliance code style
* FLEX is used to in-app debugging
* Quick and Nimble are used to unit tests

### Setup ###

* Create an account on TMDb https://www.themoviedb.org/
* Create API Key https://www.themoviedb.org/settings/api/
* Modify `App/Resources/Configurations/Common.xcconfig` by adding `BASE_URL = https:/$()/api.themoviedb.org/3` and `API_KEY = <api_key_v3>`
* Install pods, build and run the application, sign in with TMDb accout credentials
