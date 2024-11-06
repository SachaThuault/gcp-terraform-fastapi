param (
    [string]$BastionTestNatIP,
    [string]$BastionTestPublicSubnetwork,
    [string]$BastionTestInstanceName,
    [string]$BastionTestZone,

    [string]$BucketTestBucketName,
    [string]$BucketTestTestFileName,
    [string]$BucketTestFile1,
    [string]$BucketTestFile2,
    [string]$BucketTestFile3,

    [string]$CloudSQLTestPrivateNetwork,
    [string]$CloudSQLTestRegion,
    [string]$CloudSQLTestInstanceName,
    [string]$CloudSQLTestProjectId,

    [string]$FastApiTestIpAddress,

    [string]$PrivateVMTestNetworkIP,
    [string]$PrivateVMTestPrivateSubnetwork,
    [string]$PrivateVMTestInstanceName,
    [string]$PrivateVMTestZone
)


Write-Host "Running BastionTest.ps1..."
.\bastionTest.ps1 -ExpectedNatIP $BastionTestNatIP -ExpectedPublicSubnetwork $BastionTestPublicSubnetwork -InstanceName $BastionTestInstanceName -Zone $BastionTestZone

Write-Host "Running bucketDataTest.ps1..."
.\bucketDataTest.ps1 -BucketName $BucketTestBucketName -TestFileName $BucketTestTestFileName -File1 $BucketTestFile1 -File2 $BucketTestFile2 -File3 $BucketTestFile3


Write-Host "Running cloudSQLTest.ps1..."
.\cloudSQLTest.ps1 -ExpectedPrivateNetwork $CloudSQLTestPrivateNetwork -ExpectedRegion $CloudSQLTestRegion -InstanceName $CloudSQLTestInstanceName -ProjectId $CloudSQLTestProjectId


Write-Host "Running fastAPITest.ps1..."
.\fastAPITest.ps1 -IpAddress $FastApiTestIpAddress

Write-Host "Running privateVMTest.ps1..."
.\privateVMTest.ps1 -ExpectedNetworkIP $PrivateVMTestNetworkIP -ExpectedPrivateSubnetwork $PrivateVMTestPrivateSubnetwork -InstanceName $PrivateVMTestInstanceName -Zone $PrivateVMTestZone

Write-Host "All tests completed."
