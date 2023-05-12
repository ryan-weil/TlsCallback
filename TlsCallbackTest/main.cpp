#include <windows.h>

extern "C" void tls_callback();

void tls_callback()
{
	MessageBoxW(0, L"In TLS callback", L"In TLS callback", 0);
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
{
	MessageBox(0, L"Main", L"Main", 0);
	
	return 0;
}