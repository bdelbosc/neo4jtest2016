// ---------------------------------------------------------------
// Search of unknown depth
//
// We want to find Medium
// That is provided by only one company
// and that are used to produce other Medium
//    That is sold to Company “Baya”.

// ---------------------------------------------------------------
// Schema
// (Process)-[:USE]->(Medium)
// (Process)-[:FOLLOW]->(Process)
// (Process)-[:PRODUCE]->(Medium)
// (Medium)-[:PROVIDED_BY]->(Company)
// (Medium)-[:SOLD_TO]->(Company)
// -- advanced
// (Process)-[:LOCATED]->(Building)
// (Person)-[:HAS_ROLE {role}]->(Building)

// ---------------------------------------------------------------
// Graph data
CREATE (cs:Company {name:'Sehia'}),
       (cb:Company {name:'Baya'})

CREATE (mrt:Medium {name:'Round Timber'}),
       (mbw:Medium {name:'Beards (wet)'}),
       (mb:Medium {name:'Boards'})

CREATE (pb:Process {name:'Barking'}),
       (ps:Process {name:'Sawing'}),
       (pd:Process {name:'Drying'})

CREATE (ba:Building {name:'A'}),
       (bb:Building {name:'B'}),
       (bc:Building {name:'C'}),
       (bx:Building {name:'X'}),
       (bz:Building {name:'Z'})

CREATE (dark:Person {name:'Mr_Dark'})

CREATE
  (mrt)-[:PROVIDED_BY]->(cs),
  (pb)-[:USE]->(mrt),
  (pb)-[:FOLLOW]->(ps),
  (ps)-[:PRODUCE]->(mbw),
  (pd)-[:USE]->(mbw),
  (pd)-[:PRODUCE]->(mb),
  (mb)-[:SOLD_TO]->(cb),
  (pb)-[:LOCATED]->(ba),
  (ps)-[:LOCATED]->(bc),
  (pd)-[:LOCATED]->(bz),
  (dark)-[:HAs_ROLE {role:'manager'}]->(bz)

// ---------------------------------------------------------------
// Additional data


// ---------------------------------------------------------------
// Render full graph
MATCH(n) return n;

// ---------------------------------------------------------------
// Search
MATCH (m:Medium)-[r:PROVIDED_BY]->(:Company)
 WITH m, count(r) AS nbProvider
 WHERE nbProvider=1
MATCH (p:Process)-[USE]->(m:Medium)
MATCH (p:Process)-[*]-(mm:Medium)
MATCH (mm:Medium)-[:SOLD_TO]->(cb)
return m;


// ---------------------------------------------------------------
//  Process that generates medium must happen in building (A, B, C) or site manager = Mr_Dark

MATCH (m:Medium)-[r:PROVIDED_BY]->(:Company)
 WITH m, count(r) AS nbProvider
 WHERE nbProvider=1
MATCH (p:Process)-[USE]->(m:Medium)
MATCH (p:Process)-[*]-(mm:Medium)
MATCH (mm:Medium)-[:SOLD_TO]->(cb)
return m;
