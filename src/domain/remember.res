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

module Update = {
    let addCard = (t, card): t => {
        ...t,
        stack: t.stack->Stack.Update.addCard(card),
    }

    let startReview = t => {
        ...t,
        view: 
            t.stack
            ->Stack.Selectors.getCards(t.iteration)
            ->View.make,
    }

    let next = (t, known: bool) => switch t.view {
        | View.Review(review) => switch View.Update.next(review, known) {
            | Some(review) => { ...t, view: View.Review(review) }
            | None => {
                iteration: t.iteration + 1,
                stack: t.stack->Stack.Update.updateCards(
                    Belt.List.concat(review.remember, review.forget),
                ),
                view: View.Overview,
            }
        }
        | View.Overview => t
    }
}

