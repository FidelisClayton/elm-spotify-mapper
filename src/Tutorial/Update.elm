module Tutorial.Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)

import Tutorial.Msgs as Tutorial exposing (TutorialMsg, Step, TutorialModel)

updateTutorial : TutorialMsg -> Model -> (Model, Cmd Msg)
updateTutorial msg model =
  case msg of
    Tutorial.AddSteps steps ->
      let
        newTutorial =
          model.tutorial
            |> addSteps steps
      in
        { model | tutorial = newTutorial } ! []

    Tutorial.Cancel ->
      let
        newTutorial =
          model.tutorial
            |> setActive False
      in
        { model | tutorial = newTutorial } ! []

setTutorial : TutorialModel -> Model -> Model
setTutorial tutorial model =
  { model | tutorial = tutorial }

setActive : Bool -> TutorialModel -> TutorialModel
setActive value tutorial =
  { tutorial | active = value }

addSteps : (List Step) -> TutorialModel -> TutorialModel
addSteps steps tutorial =
  { tutorial | steps = List.append tutorial.steps steps }
