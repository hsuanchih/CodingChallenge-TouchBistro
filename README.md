# CodingChallenge-TouchBistro

The objective of this coding challenge is to tranform CoreData objects, their attributes and relationships into dictionary representation. 

This repository offers __two__ solutions to the same challenge - both walking & documenting the object graph using breadth-first-search:
* Branch [`code-challenge-implementation`](https://github.com/hsuanchih/CodingChallenge-TouchBistro/tree/code-challenge-implementation) implements one solution leveraging the `Encodable` protocol to encode the object graph using `JSONEncoder`.
* Branch [`code-challenge-alternative`](https://github.com/hsuanchih/CodingChallenge-TouchBistro/tree/code-challenge-alternative) takes an alternative approach by constructing the dictionary output via introspection.
