enum SearchCondition {
  coincident,
  startingWith,
  endingIn,
  inAnyPosition,
  notStartingWith,
  notEndingIn,
  doesNotContain;

  static const defaultCondition = startingWith;

  String translate() => switch (this) {
        coincident => 'Coincident',
        startingWith => 'Començada per',
        endingIn => 'Acabada en',
        inAnyPosition => 'En qualsevol posició',
        notStartingWith => 'No començada per',
        notEndingIn => 'No acabada en',
        doesNotContain => 'Que no contingui',
      };
}
