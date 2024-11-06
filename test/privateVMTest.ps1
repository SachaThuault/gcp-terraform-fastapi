param (
    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ExpectedNetworkIP,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ExpectedPrivateSubnetwork,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$InstanceName,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$Zone
)


Describe "Google Compute Engine Instance Configuration Tests" {


    Context "Compute Instance Network and IP Configuration" {

        It "The instance should have the correct network IP address" {
            $networkIP = $(gcloud compute instances describe $InstanceName `
                --zone=$Zone `
                --format="json" | ConvertFrom-Json).networkInterfaces[0].networkIP

            $networkIP | Should -Be $ExpectedNetworkIP
        }

        It "The instance should be in the correct private subnetwork" {
            $subnetwork = $(gcloud compute instances describe $InstanceName `
                --zone=$Zone `
                --format="json" | ConvertFrom-Json).networkInterfaces[0].subnetwork

            $subnetwork | Should -Be $ExpectedPrivateSubnetwork
        }
    }

    AfterAll {
        Write-Output "Tests completed."
    }
}
