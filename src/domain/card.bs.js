// Generated by ReScript, PLEASE EDIT WITH CARE


function make(front, back, level) {
  return {
          front: front,
          back: back,
          level: level
        };
}

function next(t) {
  var match = t.level;
  switch (match) {
    case /* New */0 :
        return {
                front: t.front,
                back: t.back,
                level: /* Familiar */1
              };
    case /* Familiar */1 :
        return {
                front: t.front,
                back: t.back,
                level: /* Remember */2
              };
    case /* Remember */2 :
        return {
                front: t.front,
                back: t.back,
                level: /* Know */3
              };
    case /* Know */3 :
        return {
                front: t.front,
                back: t.back,
                level: /* Done */4
              };
    case /* Done */4 :
        return t;
    
  }
}

function back(t) {
  var match = t.level;
  switch (match) {
    case /* New */0 :
        return t;
    case /* Familiar */1 :
        return {
                front: t.front,
                back: t.back,
                level: /* New */0
              };
    case /* Remember */2 :
        return {
                front: t.front,
                back: t.back,
                level: /* Familiar */1
              };
    case /* Know */3 :
        return {
                front: t.front,
                back: t.back,
                level: /* Remember */2
              };
    case /* Done */4 :
        return {
                front: t.front,
                back: t.back,
                level: /* Know */3
              };
    
  }
}

var Update = {
  next: next,
  back: back
};

var empty = {
  front: "",
  back: "",
  level: /* New */0
};

export {
  empty ,
  make ,
  Update ,
  
}
/* No side effect */
