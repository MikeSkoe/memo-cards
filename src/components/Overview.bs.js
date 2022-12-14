// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Form from "./Form.bs.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as Stack from "../domain/stack.bs.js";
import * as State from "../state/state.bs.js";
import * as React from "react";
import * as BoxComp from "./BoxComp.bs.js";
import * as TitleComp from "./TitleComp.bs.js";

function Overview(Props) {
  var $$new = Curry._1(State.AppState.useSelector, (function (param) {
          return Stack.getByLevel(param.stack, /* New */0);
        }));
  var familiar = Curry._1(State.AppState.useSelector, (function (param) {
          return Stack.getByLevel(param.stack, /* Familiar */1);
        }));
  var remember = Curry._1(State.AppState.useSelector, (function (param) {
          return Stack.getByLevel(param.stack, /* Remember */2);
        }));
  var know = Curry._1(State.AppState.useSelector, (function (param) {
          return Stack.getByLevel(param.stack, /* Know */3);
        }));
  var iteration = Curry._1(State.AppState.useSelector, (function (param) {
          return param.iteration;
        }));
  return React.createElement(React.Fragment, undefined, React.createElement(TitleComp.make, {
                  children: "Iteration: " + String(iteration)
                }), React.createElement(Form.make, {}), React.createElement(BoxComp.make, {
                  stack: $$new,
                  label: "New",
                  cursor: undefined
                }), React.createElement(BoxComp.make, {
                  stack: familiar,
                  label: "Familiar",
                  cursor: undefined
                }), React.createElement(BoxComp.make, {
                  stack: remember,
                  label: "Remember",
                  cursor: undefined
                }), React.createElement(BoxComp.make, {
                  stack: know,
                  label: "Know",
                  cursor: undefined
                }));
}

var make = Overview;

export {
  make ,
  
}
/* Form Not a pure module */
