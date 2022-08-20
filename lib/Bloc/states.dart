abstract class NavStates {}

class NavInitialState extends NavStates {}

class NavChangeIndexState extends NavStates {}


class NavLoadingBusinessState extends NavStates {}

class GetBusinessDataSuccessState extends NavStates {}

class GetBusinessDataErrorState extends NavStates {}


class NavLoadingSportsState extends NavStates {}

class GetSportsDataSuccessState extends NavStates {}

class GetSportsDataErrorState extends NavStates {}


class NavLoadingScienceState extends NavStates {}

class GetScienceDataSuccessState extends NavStates {}

class GetScienceDataErrorState extends NavStates {}

class ChangeThemeState extends NavStates {}


class ChangeBarForSearchState extends NavStates {}

class ChangeListForSearchState extends NavStates {}

class ChangeListWhenTyping extends NavStates {}