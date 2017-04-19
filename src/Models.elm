module Models exposing (..)

type alias Model =
  { showMenu : Bool
  }

initialModel : Model
initialModel =
  { showMenu = True
  }
