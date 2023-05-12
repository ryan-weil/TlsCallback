#include <Windows.h>

// Credit to namazso for this

#pragma comment (linker, "/INCLUDE:_tls_used")

extern "C" ULONG64 _tls_index;
ULONG64 _tls_index;

VOID NTAPI tls_callback(
    PVOID DllHandle,
    DWORD Reason,
    PVOID Reserved
) 
{
    MessageBoxW(nullptr, L"TLS Callback", L"TLS Callback", MB_OK);
}

extern "C" const PIMAGE_TLS_CALLBACK tls_callbacks[] = {
        &tls_callback,
        nullptr
};

extern "C" const IMAGE_TLS_DIRECTORY _tls_used{
        .AddressOfIndex = (ULONG64)&_tls_index,
        .AddressOfCallBacks = (ULONG64)tls_callbacks
};

extern "C" int EntryPoint() {
    MessageBoxW(nullptr, L"Entry Point", L"Entry Point", MB_OK);
    ExitProcess(0);
}