param (
    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ExpectedPrivateNetwork,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ExpectedRegion,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$InstanceName,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ProjectId
)

Describe "Google Cloud SQL Instance Configuration Tests" {

    Context "SQL Instance Network and Region Configuration" {

        It "The SQL instance should have the correct private network configuration" {
            $privateNetwork = $(gcloud sql instances describe $InstanceName `
                --project $ProjectId `
                --format="value(settings.ipConfiguration.privateNetwork)")

            $privateNetwork | Should -Be $ExpectedPrivateNetwork
        }

        It "The SQL instance should be in the expected region" {
            $region = $(gcloud sql instances describe $InstanceName `
                --project $ProjectId `
                --format="value(region)")

            $region | Should -Be $ExpectedRegion
        }
    }

    AfterAll {
        Write-Output "Tests completed."
    }
}
