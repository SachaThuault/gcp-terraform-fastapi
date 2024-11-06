param (
    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$IpAddress
)

$Url = "http://$IpAddress/actor/101/movies"

$response = curl -X 'GET' $Url -H 'accept: application/json'

$responseObject = $response | ConvertFrom-Json

$actorMovies = $responseObject.actor_movies

Describe "Verify Actor and Movie Information" {

    It "should have the correct actor first name" {
        $actorMovies[0].actor_first_name | Should -Be "James"
    }

    It "should have the correct actor last name" {
        $actorMovies[0].actor_last_name | Should -Be "Stewart"
    }

    It "should have the correct movie title" {
        $actorMovies[0].movie_title | Should -Be "Vertigo"
    }
}
