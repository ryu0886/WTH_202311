# WTH

## Introduction

The WTH POC demonstrated how to implement a system with C++/C/Python.
The WTH is a system to automatically generate events for the Windows sample such as PE file, MS Word, batch files and so on.
Instead of patching the Windows API, the core module "[minidbg.exe](./cloudscan/core/README.md)" simulates the debugger to install break points and monitors certain APIs. The API list can be defined by the configuration.

The example for the configuration:
```

api:ntdll.dll!NtCreateFile,p$$$x$$$o$$$x$$$x$$$x$$$x$$$x$$$x$$$x$$$x$$$,3
api:ntdll.dll!NtOpenFile,p$$$x$$$o$$$x$$$x$$$x$$$,3

api:ntdll.dll!NtDeleteFile,o$$$,3
api:ntdll.dll!NtCreateSection,p$$$x$$$o$$$p$$$x$$$x$$$x$$$,3
api:ntdll.dll!NtOpenSection,p$$$x$$$o$$$,3
api:ntdll.dll!NtCreateEvent,p$$$x$$$o$$$x$$$x$$$,3
api:ntdll.dll!NtOpenEvent,p$$$x$$$o$$$,3
api:ntdll.dll!NtCreateSemaphore,p$$$x$$$o$$$x$$$x$$$,3
api:ntdll.dll!NtOpenSemaphore,p$$$x$$$o$$$,3
api:ntdll.dll!NtCreateMutant,p$$$x$$$o$$$x$$$,3
api:ntdll.dll!NtOpenMutant,p$$$x$$$o$$$,3
api:ntdll.dll!NtCreateKey,p$$$x$$$o$$$x$$$u$$$x$$$p$$$,3
api:ntdll.dll!NtOpenKey,p$$$x$$$o$$$,3
api:ntdll.dll!NtOpenKeyEx,p$$$x$$$o$$$x$$$,3
api:ntdll.dll!NtSetValueKey,x$$$u$$$x$$$x$$$x$$$x$$$,3
api:ntdll.dll!NtProtectVirtualMemory,x$$$p$$$p$$$x$$$p2u$,3
api:ntdll.dll!NtWriteVirtualMemory,x$$$x$$$x$$$x$$$p$$$,3
api:ntdll.dll!NtCreateUserProcess,p$$$p$$$x$$$x$$$o$$$o$$$x$$$x$$$p$$$p$$$p$$$,3
api:ntdll.dll!NtOpenProcess,p$$$x$$$p$$$c$$$,3

api:ntdll.dll!NtAlpcSendWaitReceivePort,x$$$x$$$p$$$p$$$p$$$p$$$p$$$p$$$,3
api:ntdll.dll!NtAlpcSetInformation,x$$$x$$$x$$$x$$$,3
api:ntdll.dll!NtAlpcConnectPort,p$$$u$$$o$$$p$$$x$$$p$$$p$$$p$$$p$$$p$$$p$$$,3
api:ntdll.dll!LdrLoadDll,x$$$x$$$u$$$p$$$,3

```

## Requirements

The WTH needs run under x64 Windows OS. Either create an Windows instance in GCP or create a Debian 12 instance and run a nested [QEMU Windows VM](./qemu/README.md) in GCP.

## POC

The POC [website](https://35.203.182.93/sample) can only last for two months and can support very limited [rules](https://github.com/ryu0886/cloudscan/blob/main/core/analysis.py#L108)
The interface is simple one which supports the file upload.

<br>
<table>
    <td>
<img width="343" alt="image" src="https://github.com/ryu0886/WTH_202311/assets/38020822/a2eed572-fa3b-495e-8991-3b48ccad5e45">
    </td>
</table>
<br>

When submitting a testing [sample](https://www.virustotal.com/gui/file-analysis/ZGYxZDhhNWQ1OWYxYTVjNGNhZDU0N2U1NDA4NzI1ZGI6MTcxMjA3MDY2NA==), we can get the following output.
```
{
    "loader_pid": 5956,
    "sample_pid": 3576,
    "sample_image": "C:\\inetpub\\cloudscan\\upload\\ca6c5867-f144-11ee-98f7-525400123456\\3c31d0d8e381bed853fdc20ca4338614.exe",
    "sample_sha256": "966f7263f5bed6f08e59668b964ab930f425aa035857123523d7d83ffd00874f",
    "all_records": {
        "3576": {
            "ppid": 5956,
            "pid": 3576,
            "image": "C:\\inetpub\\cloudscan\\upload\\ca6c5867-f144-11ee-98f7-525400123456\\3c31d0d8e381bed853fdc20ca4338614.exe",
            "basename": "3c31d0d8e381bed853fdc20ca4338614.exe",
            "sha256": "966f7263f5bed6f08e59668b964ab930f425aa035857123523d7d83ffd00874f",
            "api_count": {
                "ntdll.dll!NtProtectVirtualMemory": 298,
                "ntdll.dll!NtCreateEvent": 19,
                "ntdll.dll!NtOpenKey": 75,
                "ntdll.dll!NtOpenFile": 48,
                "ntdll.dll!NtOpenSection": 42,
                "ntdll.dll!LdrGetProcedureAddressForCaller": 123,
                "ntdll.dll!LdrLoadDll": 19,
                "ntdll.dll!LdrGetProcedureAddress": 34,
                "ntdll.dll!NtOpenKeyEx": 71,
                "ntdll.dll!NtCreateSection": 9,
                "ntdll.dll!NtCreateFile": 12,
                "ntdll.dll!NtOpenProcessToken": 12,
                "ntdll.dll!NtCreateMutant": 2,
                "ntdll.dll!NtOpenSemaphore": 2,
                "ntdll.dll!LdrGetDllHandle": 35,
                "ntdll.dll!NtCreateSemaphore": 10,
                "ntdll.dll!NtOpenProcess": 3,
                "ntdll.dll!NtOpenMutant": 2,
                "ntdll.dll!CsrClientCallServer": 2,
                "ntdll.dll!NtAlpcSendWaitReceivePort": 2,
                "ntdll.dll!NtSetInformationFile": 2,
                "ntdll.dll!NtCreateUserProcess": 2,
                "ntdll.dll!NtWriteVirtualMemory": 4,
                "ntdll.dll!NtCreateThreadEx": 4
            },
            "behavior": [
                "3c31d0d8e381bed853fdc20ca4338614.exe(pid=3576) creates a remote thread onto C:\\Windows\\SysWOW64\\PING.EXE(pid=9088)"
            ]
        },
        "9088": {
            "ppid": "3576",
            "pid": 9088,
            "image": "C:\\Windows\\SysWOW64\\PING.EXE",
            "basename": "PING.EXE",
            "sha256": "d6c98d826f8c7f00d8a47090ff09d4700f191c1beab4dddeb939928f64a227d5",
            "api_count": {
                "ntdll.dll!NtProtectVirtualMemory": 274,
                "ntdll.dll!NtCreateEvent": 45,
                "ntdll.dll!NtOpenKey": 64,
                "ntdll.dll!NtOpenFile": 21,
                "ntdll.dll!NtOpenSection": 32,
                "ntdll.dll!LdrGetProcedureAddressForCaller": 82,
                "ntdll.dll!LdrLoadDll": 7,
                "ntdll.dll!LdrGetProcedureAddress": 68,
                "ntdll.dll!NtOpenKeyEx": 143,
                "ntdll.dll!NtCreateSection": 9,
                "ntdll.dll!NtCreateFile": 14,
                "ntdll.dll!NtOpenProcessToken": 8,
                "ntdll.dll!NtCreateMutant": 2,
                "ntdll.dll!NtOpenSemaphore": 2,
                "ntdll.dll!LdrGetDllHandle": 3,
                "ntdll.dll!NtCreateSemaphore": 2,
                "ntdll.dll!RtlCreateUnicodeStringFromAsciiz": 32,
                "ntdll.dll!NtAlpcConnectPort": 2,
                "ntdll.dll!NtAlpcSetInformation": 4,
                "ntdll.dll!NtAlpcSendWaitReceivePort": 22
            },
            "behavior": []
        }
    }
}
```
