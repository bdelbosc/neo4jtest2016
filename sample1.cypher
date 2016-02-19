// ---------------------------------------------------------------
// Search "within basis data"
//
//   We want to find Companies.
//   These Companies are assessed by a company which “Name” starts with “R”.
//   The "assessed by" connection between companies is established via “Orders”.
//   The client of the order must be a Company which has “Mr_Lampe” as “CEO”.

// ---------------------------------------------------------------
// Schema
// (:Order)-[:ASSESSING]->(:Company)
// (:Order)-[:HAS_ASSESSOR]->(:Company)
// (:Order)-[:HAS_CLIENT]->(:Company)
// (:Person)-[:WORK_IN {role}]->(:Company)

// ---------------------------------------------------------------
// DATA from graph
CREATE (abc:Company {name:'ABC'})
CREATE (def:Company {name:'DEF'})
CREATE (ghi:Company {name:'GHI'})
CREATE (jkl:Company {name:'JKL'})
CREATE (cu1:Company {name:'Cu 1'})
CREATE (cu4:Company {name:'Cu 4'})
CREATE (re:Company {name:'Risk E'})
CREATE (rc:Company {name:'Risk C'})

CREATE (o12:Order {name:'No 12'})
CREATE (o27:Order {name:'No 27'})
CREATE (o33:Order {name:'No 33'})
CREATE (o84:Order {name:'No 84'})

CREATE (lampe:Person {name:'Mr_Lampe'})

CREATE
  (o12)-[:ASSESSING]->(def),
  (o27)-[:ASSESSING]->(abc),
  (o33)-[:ASSESSING]->(ghi),
  (o84)-[:ASSESSING]->(jkl),
  (o12)-[:HAS_CLIENT]->(cu4),
  (o27)-[:HAS_CLIENT]->(cu1),
  (o33)-[:HAS_CLIENT]->(cu4),
  (o84)-[:HAS_CLIENT]->(cu1),
  (o12)-[:HAS_ASSESSOR]->(rc),
  (o27)-[:HAS_ASSESSOR]->(rc),
  (o33)-[:HAS_ASSESSOR]->(re),
  (o84)-[:HAS_ASSESSOR]->(rc),
  (lampe)-[:WORK_IN {role:'CEO'}]->(cu1),
  (lampe)-[:WORK_IN {role:'CEO'}]->(cu4)

// Additional data to test search
CREATE (nrc:Company {name:'No Risk Com'})
CREATE (xyz:Company {name:'XYZ'})
CREATE (cu9:Company {name:'Cu 9'})
CREATE (o00:Order {name:'No 00'})
CREATE (o01:Order {name:'No 01'})
CREATE (john:Person {name:'Mr_John'})
CREATE 
  (o00)-[:ASSESSING]->(xyz),
  (o00)-[:HAS_CLIENT]->(cu9),
  (john)-[:WORK_IN {role:'CEO'}]->(cu9),
  (lampe)-[:WORK_IN {role:'Staff'}]->(cu9),
  (o00)-[:HAS_ASSESSOR]->(nrc)

// ---------------------------------------------------------------
// Seach Query that return companies
MATCH (:Person {name: 'Mr_Lampe'})-[:WORK_IN {role:'CEO'}]->(:Company)<-[:HAS_CLIENT]-(o:Order)
MATCH (o)-[:HAS_ASSESSOR]->(ca:Company) WHERE (ca.name STARTS WITH 'R')
MATCH (o)-[:ASSESSING]->(c:Company)
RETURN c

// Same but return the complete graph (companies, order and person)
MATCH (p:Person {name: 'Mr_Lampe'})-[:WORK_IN {role:'CEO'}]->(cc:Company)<-[:HAS_CLIENT]-(o:Order)
MATCH (o)-[:HAS_ASSESSOR]->(ca:Company) WHERE (ca.name STARTS WITH 'R')
MATCH (o)-[:ASSESSING]->(c:Company)
RETURN *


