# minidbg

The minidbg is a monitoring tool for Windows OS to record the application's events.
The startup point is the minidbg's path but suffixed with ".bat" instead of ".exe".
For example, the caller needs to specify the Windows sample path into the batch file named "minidbg.bat".
The minidbg will generate logs under the same folder. For example, the log file name is "minidbg.log".

With base64 encoding:
```
0x006b25cd,9116,10744,process,11184,b64::QzpcV2luZG93c1xTeXN0ZW0zMlxjbWQuZXhl,b64::QzpcV2luZG93c1xzeXN0ZW0zMlxjbWQuZXhlIC9jICJDOlx2bVxtaW5pZGJnLmJhdCI=,00000037D11FC000,0000000000000000
0x006b25cf,9116,10744,module,b64::QzpcV2luZG93c1xTeXN0ZW0zMlxjbWQuZXhl,base:0x00007FF68B5D0000
0x006b25d0,9116,10744,module,b64::QzpcV2luZG93c1xTeXN0ZW0zMlxudGRsbC5kbGw=,base:0x00007FFE49870000
0x006b25d1,9116,10744,api,ntdll.dll!NtProtectVirtualMemory(0xffffffffffffffff,0x7ffe49a0e530,0x8,0x4,0x00000000)=0x00007FFE4990FD60 from 0x00007FFE4989B1F9 (ntdll.dll+0x2b1f9)
0x006b25d2,9116,10744,api,ntdll.dll!NtProtectVirtualMemory(0xffffffffffffffff,0x7ffe49a0e000,0x1000,0x8,0x00000008)=0x00007FFE4990FD60 from 0x00007FFE4989B21D (ntdll.dll+0x2b21d)
0x006b25d3,9116,10744,api,ntdll.dll!NtCreateEvent(0x0,0x1f0003,,0x0,0x0)=0x00007FFE4990FC60 from 0x00007FFE4991D43C (ntdll.dll+0xad43c)
0x006b25d5,9116,10744,api,ntdll.dll!NtCreateEvent(0x0,0x1f0003,,0x0,0x0)=0x00007FFE4990FC60 from 0x00007FFE4993A0B9 (ntdll.dll+0xca0b9)
```

After decoding to the original string:
```
0x006b25cd,9116,10744,process,11184,C:\Windows\System32\cmd.exe,C:\Windows\system32\cmd.exe /c "C:\vm\minidbg.bat",00000037D11FC000,0000000000000000
0x006b25cf,9116,10744,module,C:\Windows\System32\cmd.exe,base:0x00007FF68B5D0000
0x006b25d0,9116,10744,module,C:\Windows\System32\ntdll.dll,base:0x00007FFE49870000
0x006b25d1,9116,10744,api,ntdll.dll!NtProtectVirtualMemory(0xffffffffffffffff,0x7ffe49a0e530,0x8,0x4,0x00000000)=0x00007FFE4990FD60 from 0x00007FFE4989B1F9 (ntdll.dll+0x2b1f9)
0x006b25d2,9116,10744,api,ntdll.dll!NtProtectVirtualMemory(0xffffffffffffffff,0x7ffe49a0e000,0x1000,0x8,0x00000008)=0x00007FFE4990FD60 from 0x00007FFE4989B21D (ntdll.dll+0x2b21d)
0x006b25d3,9116,10744,api,ntdll.dll!NtCreateEvent(0x0,0x1f0003,,0x0,0x0)=0x00007FFE4990FC60 from 0x00007FFE4991D43C (ntdll.dll+0xad43c)
0x006b25d5,9116,10744,api,ntdll.dll!NtCreateEvent(0x0,0x1f0003,,0x0,0x0)=0x00007FFE4990FC60 from 0x00007FFE4993A0B9 (ntdll.dll+0xca0b9)
```

The checksum for the latest [minidbg](https://github.com/ryu0886/minidbg/releases/download/0.9.3.13221/minidbg-build.zip).
```
90abb8e561f6a9fc2efbedfe543517126dff3ed9e33255905e7449f67e8eba90  minidbg.exe
95a4bc52e2df91eb64d84dd72096f270b3196ece381c4af7a73fb874c8d30124  minidbg64.exe
```

If the minidbg has the dependency issue, try to install VC redistributable package.
```
sha256sum vc_redist.x*
015edd4e5d36e053b23a01adb77a2b12444d3fb6eccefe23e3a8cd6388616a16  vc_redist.x64.exe
e830c313aa99656748f9d2ed582c28101eaaf75f5377e3fb104c761bf3f808b2  vc_redist.x86.exe
```
