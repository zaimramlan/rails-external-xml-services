# Rails External XML Services
This Rails project is a sample to communicate with 3rd party services that uses XML (RSS type) as their request/response body.

Other XML services (WSDL, SOAP or RDF type) are not covered (or will be added - when necessary) since there are already gems to assist in that area.

## Concept
There are 3 main parts to the concept.
1. Adapter Class
1. Service Class
1. Schema (Helper Class)

### Flow
But first, we go through an example flow:
1. User details are filled in and submitted
1. Once user is successfully created, the controller calls the _adapter_ to submit the request to a 3rd party service's endpoint

### Adapter
The adapter acts like a plug-n-play 3rd party wrapper for communicating with their endpoints (in our case - `CompanyFooAdapter`)
1. The adapter builds the user data into an XML through a _service_ called `BuildUserXmlService` 
1. The XML is then sent to the 3rd party endpoint

### Service
The service builds the user data based on the _schema_ received from the 3rd party

### Schema
1. The 3rd party provides an XML request/response body sample
1. We create a 3rd party schema wrapper (in our case - `CompanyFooWrapper`) that loads the XML request/response body sample file into callable methods

## More Info
To understand more what's happening under the hood, simply run `$ rspec --format documentation` or dive into the codes
