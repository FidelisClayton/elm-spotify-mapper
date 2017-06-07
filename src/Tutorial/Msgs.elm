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
  , steps = [ search, searchInput ]
  }

search : Step
search =
  { id = "search"
  , title = "Search page"
  , text = "This is the search section, here you can search for an artist to start to discover new artists."
  , attachTo = "#TutSearch right"
  , advanceOn = Nothing
  , done = False
  }

searchInput : Step
searchInput =
  { id = "search-input"
  , title = "Search for an artist"
  , text = "Use this field to search an artist"
  , attachTo = "#TutSearchInput bottom"
  , advanceOn = Nothing
  , done = False
  }

explore : Step
explore =
  { id = "explore"
  , title = "Explore artists"
  , text = "This is the Explore section, here you can discover new artists from the previously selected"
  , attachTo = "#TutExplore right"
  , done = False
  , advanceOn = Nothing
  }

nodeTree : Step
nodeTree =
  { id = "node-tree"
  , title = "Artist node"
  , text = "You can click on this circle to find similar artists. You also can click twice to start to play the artist top tracks."
  , attachTo = ".Main center"
  , done = False
  , advanceOn = Nothing
  }

sidebarTrack : Step
sidebarTrack =
  { id = "sidebar-track"
  , title = "Tracks"
  , text = "Here is the list of the artist top tracks. Click on the track cover to play it."
  , attachTo = ".SongItem right"
  , done = False
  , advanceOn = Nothing
  }

savePlaylist : Step
savePlaylist =
  { id = "save-playlist"
  , title = "Save playlist"
  , text = "Use this button to save your playlist (you must be logged in)."
  , attachTo = ".SavePlaylist left"
  , done = False
  , advanceOn = Nothing
  }

login : Step
login =
  { id = "login"
  , title = "Login"
  , text = "You also can log in to be able to save your playlist."
  , attachTo = "#TutLogin right"
  , done = False
  , advanceOn = Nothing
  }
