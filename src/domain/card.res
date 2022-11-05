type text = string;

type level = New | Familiar | Remember | Know | Done;

type familiarity = Back | Skip | Next;

type t = {
    front: text,
    back: text,
    level: level,
};

let empty: t = {
    front: "",
    back: "",
    level: New,
};

let make = (~front, ~back, ~level): t => { front, back, level };

// -- UPDATE --

let familiarityToString = f => switch f {
    | Back => "Back"
    | Skip => "Skip"
    | Next => "Forward"
}

let shiftLevel = (level, familiarity) => switch (level, familiarity) {
    | (New, Back) | (Familiar, Back) | (New, Skip) => New
    | (New, Next) | (Remember, Back) | (Familiar, Skip) => Familiar
    | (Familiar, Next) | (Know, Back) | (Remember, Skip) => Remember
    | (Remember, Next) | (Done, Back) | (Know, Skip) => Know
    | (Know, Next) | (Done, Next) | (Done, Skip) => Done
}

let mapLevel = (t, fn) => { ...t, level: t.level->fn }

