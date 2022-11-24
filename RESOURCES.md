
# Resources

## Tutorials

### General Shiny

📖 [Mastering Shiny](https://mastering-shiny.org)
: Comprehensive introduction to how the components of Shiny work, how to build basic applications and dipping your toe into more advanced usage. If you read nothing else, read this!

🌐 [RStudio Shiny documentation](https://shiny.rstudio.com/articles)
: In-depth articles about various aspects of Shiny. Not that some of these articles are a bit out-dated, so are best read in combination with other sources.

🌐 [Shiny Learning Resources](https://shiny.rstudio.com/tutorial/)
: Collected RStudio Shiny documentation. Includes introductory tutorials and links to other documentation.

🌐 [Shiny Gallery](https://shiny.rstudio.com/gallery/)
: Many example applications demonstrating Shiny features and components.

### UI

📖 [Outstanding User Interfaces with Shiny](https://unleash-shiny.rinterface.com/)
: A deep-dive on customising Shiny applications, primarily focused on UI. Provides a great introduction to more advanced customisation features, like developing your own UI components.

📖 [JavaScript for R](https://book.javascript-for-r.com/)
: A very comprehensive overview of how to use JavaScript in R. This is a general treatment, but has a subsection devoted to using JavaScript with Shiny applications.

📖 [Interactive web-based data visualization with R, plotly, and shiny](https://plotly-r.com/)
: Detailed overview of using the plotly library in Shiny applications and R in general.

### Web essentials

🌐 [Mozilla Developer Network: Learn web development](https://developer.mozilla.org/en-US/docs/Learn)
: Fantastic introduction to web development. Not essential to build Shiny applications, but working through this course will make it significantly easier to understand what's going on under the bonnet, debug applications and build more advanced customisations.

🌐 [jQuery selectors](https://api.jquery.com/category/selectors/)
: Several Shiny functions use jQuery selectors to identify UI elements, which are an extension of CSS selectors. The basics of CSS selectors are covered in the CSS parts of the MDN course, but this is a good reference that includes the jQuery extensions.

### General R documentation

🌐 [Databases using R](https://solutions.rstudio.com/db/)
: General overview of database access using DBI. Lots of articles discussing packages, working with connection strings and database best practices.

### Structure and workflow

📖 [Engineering Production-Grade Shiny Apps](https://engineering-shiny.org)
: How to create and deploy Shiny applications using golem. Lots of useful pointers and guidance that isn't specifically golem related.

📽️ [Appsilon: How to Make Production Ready Shiny Applications](https://appsilon.com/how-to-make-production-ready-shiny-applications/)
: Short overview of considerations for preparing Shiny applications for production.

## Tools

🌐 [Awesome Shiny Extensions](https://github.com/nanxstats/awesome-shiny-extensions)
: Almost exhaustive list of Shiny related packages.

### Building blocks

📦 [htmltools](https://rstudio.github.io/htmltools/)
: Tools for building HTML in R.

📦 [htmlwidgets](https://www.htmlwidgets.org/develop_intro.html)
: Helper functions to create your own JavaScript library wrappers. The basis of many UI extension packages.

### Bootstrap

📦 [bslib](https://rstudio.github.io/bslib/)
: Customise Bootstrap themes.

📦 [thematic](https://rstudio.github.io/thematic/)
: Theming of ggplot2, lattice and base R graphics. Automatically apply Bootstrap themes to plots.

🌐 [Bootstrap](https://getbootstrap.com/)
: Frontend framework providing default Shiny theming, styling and UI component behaviour.

🌐 [Bootswatch](https://bootswatch.com/)
: Themes for Bootstrap. Built in to bslib.

### Layout

📦 [shinydashboard](https://rstudio.github.io/shinydashboard/)
: Simple layout for creating dashboards in Shiny.

🌐 [RinteRface](https://rinterface.com/#packages)
: Collection of packages providing HTML templates and alternative styling libraries.

🌐 [Appsilon Shiny Tools](https://shiny.tools/)
: A set of Shiny utility packages, including some styling and layout alternatives.

### Interaction

📦 [shinyjs](https://deanattali.com/shinyjs/)
: Tools for performing JavaScript operations in your app.

📦 [shinyFeedback](https://merlinoa.github.io/shinyFeedback/)
: Display user feedback alongside Shiny inputs using styling and messages.

### Components

🌐 [selectize](https://shiny.rstudio.com/articles/selectize.html)
: Select lists using the [Selectize.js](https://selectize.dev/) library. This is the default for select boxes created in Shiny.

📦 [DT](https://rstudio.github.io/DT/)
: Advanced interactive tables using the [DataTables](https://datatables.net/) jQuery plugin.

📦 [plotly](https://plotly.com/r/)
: Interactive graphs using the [plotly](https://plotly.com/graphing-libraries/) library. Automatically converts ggplot2 plots.

📦 [leaflet](https://rstudio.github.io/leaflet/)
: Interactive maps using the [leaflet](https://leafletjs.com/) mapping library. Lots of further extension packages are available.

### Structure and workflow

📦 [config](https://rstudio.github.io/config/)
: Manage environment specific configuration options.

📦 [roxygen2](https://roxygen2.r-lib.org/)
: Function documentation.

📦 [renv](https://rstudio.github.io/renv/)
: Manage application dependencies

#### Databases

📦 [DBI](https://dbi.r-dbi.org/)
: Core database package. Provides standard interface for querying and performing operations on databases of various kinds.

📦 [ODBC](https://r-dbi.github.io/odbc/)
: DBI interface for ODBC drivers (used to connect MS SQL Server).

📦 [pool](https://rstudio.github.io/pool/)
: Simple connection management for accessing databases in multi-user/multi-process environments.

### Testing and debugging

📦 [reactlog](https://rstudio.github.io/reactlog/)
: Visualise the reactive flow of your Shiny application.

📦 [testthat](https://testthat.r-lib.org/)
: Provides the unit testing framework we use for testing Shiny applications.

📦 [shinytest2](https://rstudio.github.io/shinytest2/)
: Shiny specific testing functionality, including snapshot testing and helper functions for testing Shiny applications.

📦 [shinyloadtest](https://rstudio.github.io/shinyloadtest/)
: Perform load testing on deployed applications.

### golem

📦 [golem](https://thinkr-open.github.io/golem/)
: "An opinionated framework for building production-grade shiny applications".

📦 [shinyValidator](https://opensource.nibr.com/shinyValidator/)
: Automated auditing and validation of Shiny apps built using the golem framework.
