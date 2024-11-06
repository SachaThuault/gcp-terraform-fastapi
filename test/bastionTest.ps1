param (
    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ExpectedNatIP,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$ExpectedPublicSubnetwork,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$InstanceName,

    [parameter(Mandatory=$false, ValueFromPipeline)]
    [string]$Zone
)

Describe "Google Bastion Compute Engine Instance Configuration Tests" {

    Context "Compute Instance Network and IP Configuration" {

        It "The instance should have the correct NAT IP address" {
            $natIP = $(gcloud compute instances describe $InstanceName `
                --zone=$Zone `
                --format="json" | ConvertFrom-Json).networkInterfaces[0].accessConfigs[0].natIP

            $natIP | Should -Be $ExpectedNatIP
        }

        It "The instance should be in the correct public subnetwork" {
            $subnetwork = $(gcloud compute instances describe $InstanceName `
                --zone=$Zone `
                --format="json" | ConvertFrom-Json).networkInterfaces[0].subnetwork

            $subnetwork | Should -Be $ExpectedPublicSubnetwork
        }
    }

    AfterAll {
        Write-Output "Tests completed."
    }
}
