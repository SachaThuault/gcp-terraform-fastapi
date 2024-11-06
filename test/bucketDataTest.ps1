param (
    [string]$BucketName, 
    [string]$TestFileName,                          
    [string]$File1,                           
    [string]$File2,                             
    [string]$File3                                 
)

BeforeAll {
    Set-Content -Path "temp\$TestFileName" -Value "This is a test file."
}

Describe "Google Cloud Storage Bucket Tests" {

    It "Verifies that $File1 exists in the bucket" {
        $result = gcloud storage ls "gs://$BucketName/$File1"
        $result | Should -Not -BeNullOrEmpty
    }

    It "Verifies that $File2 exists in the bucket" {
        $result = gcloud storage ls "gs://$BucketName/$File2"
        $result | Should -Not -BeNullOrEmpty
    }

    It "Verifies that $File3 exists in the bucket" {
        $result = gcloud storage ls "gs://$BucketName/$File3"
        $result | Should -Not -BeNullOrEmpty
    }

    It "Upload and Downloads the test file from the bucket" {
        gcloud storage cp "temp/$TestFileName" "gs://$BucketName/$TestFileName"
        $downloadPath = ".\temp\updatedFile.txt"
        gcloud storage cp "gs://$BucketName/$TestFileName" $downloadPath
        (Get-Content -Path $downloadPath) | Should -Be "This is a test file."
        Remove-Item -Path $downloadPath -Force
    }
}

AfterAll {
    gcloud storage rm "gs://$BucketName/$TestFileName"
    Remove-Item -Path "temp\$TestFileName" -Force
}

