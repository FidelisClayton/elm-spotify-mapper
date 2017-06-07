module Tutorial.Msgs exposing (..)

type TutorialMsg
  = AddSteps (List Step)
  | Cancel

type alias Step =
  { id: String
  , title: String
  , text: String
  , attachTo: String
  , advanceOn: Maybe String
  , done: Bool
  }

type alias TutorialModel =
  { active: Bool
  , steps: List Step
  }

initTutorial : TutorialModel
initTutorial =
  { active = False
  , steps = [
      { id = "search"
      , title = "Search page"
      , text = "This is the search section, here you can search for an artist to start to discover new artists."
      , attachTo = "#TutSearch right"
      , advanceOn = Nothing
      , done = False
      }
    , { id = "search-input"
      , title = "Search for an artist"
      , text = "Use this field to search an artist"
      , attachTo = "#TutSearchInput bottom"
      , advanceOn = Nothing
      , done = False
      }
    ]
  }
