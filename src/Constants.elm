module Constants exposing (..)

import Http


maxRelatedArtists : Int
maxRelatedArtists =
    3


scopes : String
scopes =
    "user-read-private playlist-read-private playlist-modify-private playlist-modify-public"


authUrl : String -> String -> String
authUrl clientId redirectUri =
    "https://accounts.spotify.com/authorize/?client_id="
        ++ clientId
        ++ "&response_type=token&redirect_uri="
        ++ Http.encodeUri redirectUri
        ++ "&scope="
        ++ Http.encodeUri scopes
