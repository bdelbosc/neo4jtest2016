# Testing Neo4j graph query

## Testing

1. install Neo4j latest distrib
2. start the server and connect to http://localhost:7474/browser/
3. past sample section by section


## Possible integration with Nuxeo

Create a graph service that use a contribution to define a mapping to declare Node, properties ans relationship.

The graph db is secondary store (all information are in the repository),
This brings limitations:
  - There will be one doc per node
  - The relationship will have no properties
  - Relationship are directed (one way)
  - The label is the document type or mixintype

This require to store a relation as a target id or target list of ids for (1, n) relation.

The mapping must define which properties need to be propagate to graph node and relationship,
there must be a mapping because ':' is not accepted as node property:

For document type File:
  label=File // the node label
  name=dc:title
  author=dc:creator
  duplicate=RELATION(rel:duplicate)
  recommanded=RELATION(rel:recommanded)

Indexing (or graphing) a doc can ben done with a sync listener becayse neo4j handle transaction.
   
on creation:
   send create node + relationship

on update:
   send merge on create node
   drop all relation from node, then create them

on delete:
   drop relation from node
   drop relation to node
   drop node

Searching

   expose cypher syntax
   add helper to return docs (same as ES)
