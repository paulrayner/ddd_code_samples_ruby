# Sample code for domain-driven design (DDD) in Ruby workshop exercises.

The goal of the coding exercises is to apply targeted refactoring towards a richer domain language and certain tactical domain patterns on a small amount of sample code.

We are going to pretend that we are on the warranty application team for an extended warranty company, and that this repository contains some representative Ruby code for the core business logic handled by this system. You will need to imagine that the rest of the application exists, but is just not included here.

N.b.: This code has a lot of issues. This is deliberate. For example, the majority of the objects are devoid of behavior and there is little documentation. Also, the tests are incomplete, poorly named, duplicated, and intermixed with the production code. Try to accept that we are not going to fix most of the issues. Instead, focus on applying the techniques and patterns taught in the workshop to see the impact they can have.

## Run Unit Tests

Run unit tests via the command line as follows:

    $ ruby contract_test.rb

or

    $ ruby all_tests.rb