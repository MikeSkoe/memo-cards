// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";

function make(front, back, level) {
  return {
          front: front,
          back: back,
          level: level
        };
}

function familiarityToString(f) {
  switch (f) {
    case /* Back */0 :
        return "Back";
    case /* Skip */1 :
        return "Skip";
    case /* Next */2 :
        return "Forward";
    
  }
}

function shiftLevel(level, familiarity) {
  switch (level) {
    case /* New */0 :
        if (familiarity >= 2) {
          return /* Familiar */1;
        } else {
          return /* New */0;
        }
    case /* Familiar */1 :
        switch (familiarity) {
          case /* Back */0 :
              return /* New */0;
          case /* Skip */1 :
              return /* Familiar */1;
          case /* Next */2 :
              return /* Remember */2;
          
        }
    case /* Remember */2 :
        switch (familiarity) {
          case /* Back */0 :
              return /* Familiar */1;
          case /* Skip */1 :
              return /* Remember */2;
          case /* Next */2 :
              return /* Know */3;
          
        }
    case /* Know */3 :
        switch (familiarity) {
          case /* Back */0 :
              return /* Remember */2;
          case /* Skip */1 :
              return /* Know */3;
          case /* Next */2 :
              return /* Done */4;
          
        }
    case /* Done */4 :
        if (familiarity !== 0) {
          return /* Done */4;
        } else {
          return /* Know */3;
        }
    
  }
}

function mapLevel(t, fn) {
  return {
          front: t.front,
          back: t.back,
          level: Curry._1(fn, t.level)
        };
}

var empty = {
  front: "",
  back: "",
  level: /* New */0
};

export {
  empty ,
  make ,
  familiarityToString ,
  shiftLevel ,
  mapLevel ,
  
}
/* No side effect */
