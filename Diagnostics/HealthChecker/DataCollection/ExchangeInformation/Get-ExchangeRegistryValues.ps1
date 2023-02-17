﻿# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

. $PSScriptRoot\..\..\..\..\Shared\Get-RemoteRegistryValue.ps1
function Get-ExchangeRegistryValues {
    [CmdletBinding()]
    param(
        [string]$MachineName,
        [ScriptBlock]$CatchActionFunction
    )
    Write-Verbose "Calling: $($MyInvocation.MyCommand)"

    $baseParams = @{
        MachineName         = $MachineName
        CatchActionFunction = $CatchActionFunction
    }

    $ctsParams = $baseParams + @{
        SubKey   = "SOFTWARE\Microsoft\ExchangeServer\v15\Search\SystemParameters"
        GetValue = "CtsProcessorAffinityPercentage"
    }

    $fipsParams = $baseParams + @{
        SubKey   = "SYSTEM\CurrentControlSet\Control\Lsa\FipsAlgorithmPolicy"
        GetValue = "Enabled"
    }

    $blockReplParams = $baseParams + @{
        SubKey   = "SOFTWARE\Microsoft\ExchangeServer\v15\Replay\Parameters"
        GetValue = "DisableGranularReplication"
    }

    $disableAsyncParams = $baseParams + @{
        SubKey   = "SOFTWARE\Microsoft\ExchangeServer\v15"
        GetValue = "DisableAsyncNotification"
    }

    $serializedDataSigningParams = $baseParams + @{
        SubKey   = "SOFTWARE\Microsoft\ExchangeServer\v15\Diagnostics"
        GetValue = "EnableSerializationDataSigning"
    }

    $installDirectoryParams = $baseParams + @{
        SubKey   = "SOFTWARE\Microsoft\ExchangeServer\v15\Setup"
        GetValue = "MsiInstallPath"
    }

    return [PSCustomObject]@{
        CtsProcessorAffinityPercentage = [int](Get-RemoteRegistryValue @ctsParams)
        FipsAlgorithmPolicyEnabled     = [int](Get-RemoteRegistryValue @fipsParams)
        DisableGranularReplication     = [int](Get-RemoteRegistryValue @blockReplParams)
        DisableAsyncNotification       = [int](Get-RemoteRegistryValue @disableAsyncParams)
        SerializedDataSigning          = [int](Get-RemoteRegistryValue @serializedDataSigningParams)
        MsiInstallPath                 = [string](Get-RemoteRegistryValue @installDirectoryParams)
    }
}
