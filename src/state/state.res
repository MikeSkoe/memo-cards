type action =
    | AddCard(Card.t)
    | StartReview
    | Review(Card.familiarity)

let reducer = (t, action) => switch action {
    | AddCard(card) => t->Remember.addCard(card)
    | StartReview => t->Remember.startReview
    | Review(familiarity) => t->Remember.next(familiarity)
}

let store = Remporium.makeStore(Remember.empty, reducer);

module AppState = Remporium.CreateModule({
    type action = action;
    type state = Remember.t;
});

