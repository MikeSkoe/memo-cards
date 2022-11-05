/*
 * This module handles high level data manipulations that manage the state consistency and integrity
 */

type t = {
    stack: Stack.t,
    view: View.t,
    iteration: Stack.iteration,
};

let empty: t = {
    stack: Stack.empty,
    view: View.empty,
    iteration: 0,
};

// -- UPDATE --

let addCard = (t, card): t => {
    ...t,
    stack: t.stack->Stack.addCard(card),
}

let startReview = t => {
    ...t,
    view: 
        t.stack
        ->Stack.getCards(t.iteration)
        ->cards => switch cards {
            | list{} => View.empty
            | list{head, ...tail} => View.make(head, tail)
        }
}

let next = (t, familiarity) => switch t.view {
    | View.InProgress(view) => switch View.next(view, familiarity) {
        | View.Done(stack) => {
            iteration: t.iteration + 1,
            stack: t.stack->Stack.updateCards(stack),
            view: View.Overview,
        }
        | View.InProgress(view) => {
            ...t,
            view: View.InProgress(view),
        }
        | View.Overview => {
            ...t,
            view: View.Overview,
        }
    }
    | View.Done(stack) => {
        iteration: t.iteration + 1,
        stack: t.stack->Stack.updateCards(stack),
        view: View.Overview,
    }
    | View.Overview => t
}

