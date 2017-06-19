module HelpersSpec exposing (tests)

import Expect exposing (..)
import Fuzz exposing (..)
import Test exposing (..)

import Models exposing (ImageObject, Artist, VisEdge, VisNode)
import Spotify.Models exposing (Track)
import Helpers exposing (..)

tests : Test
tests =
  describe "Helpers"
    [ describe "firstImageUrl"
      [ test "Should return an empty string" <|
        \_ ->
          Expect.equal (firstImageUrl []) ""

      , test "Should return 'image1.jpg'" <|
        \_ ->
          let
            image1 = ImageObject 0 "image1.jpg" 0
            image2 = ImageObject 0 "image2.jpg" 0
            images = [ image1, image2 ]
            expected = "image1.jpg"
          in
            expected
              |> Expect.equal (firstImageUrl images)
      ]

    , describe "firstArtistName"
      [ test "Should return an empty string" <|
        \_ ->
          ""
            |> Expect.equal (firstArtistName [])

      , test "Should return 'Artist 1'" <|
        \_ ->
          let
            artist1 = Artist [] "" "" "Artist 1" 0 "" [] False
            artist2 = Artist [] "" "" "Artist 2" 0 "" [] False

            artists = [ artist1, artist2 ]
            expected = "Artist 1"
          in
            expected
              |> Expect.equal (firstArtistName artists)
      ]

    , describe "paddValue"
      [ test "Should return '01'" <|
        \_ ->
          "01"
            |> Expect.equal (paddValue 1)

      , test "Should return '10'" <|
        \_ ->
          "10"
            |> Expect.equal (paddValue 10)
      ]

    , describe "getPct"
      [ test "Should return 50" <|
        \_ ->
          50
            |> Expect.equal (getPct 50 100)
      ]

    , describe "pctToValue"
      [ test "Should return 50" <|
        \_ ->
          50
            |> Expect.equal (pctToValue 50 100)
      ]

    , describe "getByIndex"
      [ test "Should return 'Darkness'" <|
        \_ ->
          let
            items = [ "Hello", "Darkness", "My", "Old", "Friend" ]
            expected = Just "Darkness"
          in
            expected
              |> Expect.equal (getByIndex 1 items)

      , test "Should return Nothing" <|
        \_ ->
          Nothing
            |> Expect.equal (getByIndex 2 [])
      ]

    , describe "getLastItem"
      [ test "Should return 'Friend'" <|
        \_ ->
          let
            items = [ "Hello", "Darkness", "My", "Old", "Friend" ]
            expected = Just "Friend"
          in
            expected
              |> Expect.equal (getLastItem items)

      , test "Should return Nothing" <|
        \_ ->
          Nothing
            |> Expect.equal (getLastItem [])
      ]

    , describe "artistToNode"
      [ test "Should convert an artist to a node" <|
        \_ ->
          let
            artist = Artist [] "href" "id" "Artist 1" 0 "uri" [] False
            expected =
              { id = "id"
              , label = "Artist 1"
              , value = 0
              , shape = "circularImage"
              , image = ""
              }
          in
            expected
              |> Expect.equal (artistToNode artist)
      ]

    , describe "artistsToEdge"
      [ test "Should convert a list of string to edges" <|
        \_ ->
          let
            artists = [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False ]
            expected =
              [ VisEdge "123" "id" ]
          in
            expected
              |> Expect.equal (artistsToEdge "123" artists)
      ]

    , describe "filterNewArtists"
      [ test "should filter the artist that doesn't have a node" <|
        \_ ->
          let
            artists =
              [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False
              , Artist [] "href2" "id2" "Artist 2" 0 "uri" [] False
              ]

            nodes =
              [ VisNode "id" "Artist 1" 0 "" "uri" ]

            expected =
              [ Artist [] "href2" "id2" "Artist 2" 0 "uri" [] False ]
          in
            expected
              |> Expect.equal (filterNewArtists artists nodes)
      ]

    , describe "filterNewArtistsWithRelated"
      [ test "should filter an artist by id and verify if he have others related artists" <|
        \_ ->
          let
            artists =
              [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False
              , Artist [] "href2" "id2" "Artist 2" 0 "uri" [] True
              ]

            expected =
              [ Artist [] "href2" "id2" "Artist 2" 0 "uri" [] True ]
          in
            expected
              |> Expect.equal (filterArtistsWithRelated "id2" artists)
      ]

    , describe "filterArtistById"
      [ test "should filter an artist by id" <|
        \_ ->
          let
            artists =
              [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False
              , Artist [] "href2" "id2" "Artist 2" 0 "uri" [] True
              ]

            expected =
              [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False ]
          in
            expected
              |> Expect.equal (filterArtistById "id" artists)
      ]

    , describe "filterTrackById"
      [ test "should filter a track by id" <|
        \_ ->
          let
            tracks =
              [ Track "1" "track1" "" ""
              , Track "2" "track2" "" ""
              ]

            expected =
              [ Track "1" "track1" "" "" ]
          in
            expected
              |> Expect.equal (filterTrackById "1" tracks)
      ]

    , describe "filterNewTracks"
      [ test "should filter new tracks" <|
        \_ ->
          let
            oldTracks =
              [ Track "1" "track1" "" ""
              , Track "2" "track2" "" ""
              ]

            newTracks =
              [ Track "1" "track1" "" ""
              , Track "3" "track3" "" ""
              ]

            expected =
              [ Track "3" "track3" "" "" ]
          in
            expected
              |> Expect.equal (filterNewTracks oldTracks newTracks)
      ]

    , describe "toSpotifyTrack"
      [ test "should convert a Models.Track to Spotify.Models.Track" <|
        \_ ->
          let
            album =
              Models.Album "" [] [] ""

            track =
              Models.Track album [] "1" "track1" "" ""

            expected =
              Track "1" "track1" "" ""
          in
            expected
              |> Expect.equal (toSpotifyTrack track)
      ]

      , describe "firstArtist"
        [ test "should return the first artist selected by the user before explore" <|
          \_ ->
            let
              artists =
                [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False
                , Artist [] "href2" "id2" "Artist 2" 0 "uri" [] True
                , Artist [] "href3" "id3" "Artist 3" 0 "uri" [] True
                ]

              expected =
                Just (Artist [] "href3" "id3" "Artist 3" 0 "uri" [] True)

            in
              expected
                |> Expect.equal (firstArtist artists)
        ]

      , describe "joinWithComma"
        [ test "should join two string with comma" <|
          \_ ->
            "a, b"
              |> Expect.equal (joinWithComma "a" "b")

        , test "should add a '.' after the first string" <|
          \_ ->
            "a."
              |> Expect.equal (joinWithComma "a" "")
        ]

      , describe "generatePlaylistDescription"
        [ test "should generate the playlist description using the artists that have related artists" <|
          \_ ->
            let
              artists =
                [ Artist [] "href" "id" "Artist 1" 0 "uri" [] False
                , Artist [] "href2" "id2" "Artist 2" 0 "uri" [] True
                , Artist [] "href3" "id3" "Artist 3" 0 "uri" [] True
                ]

              expected = "Artist 2, Artist 3."
            in
              expected
                |> Expect.equal (generatePlaylistDescription artists)
        ]
    ]
