module FlashMessage.Models exposing (..)

type MessageType
  = Success
  | Info
  | Warning
  | Danger

type alias Model =
  { active : Bool
  , messageType : MessageType
  , message : String
  }

initialModel : Model
initialModel =
  { active = True
  , messageType = Info
  , message = ""
  }
