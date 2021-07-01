#include <Endor.h>

class Sandbox : public Endor::Application
{
public:
	Sandbox()
	{
	}

	~Sandbox()
	{
	}
};

void main()
{
	// Endor::Print();

	Sandbox* sandbox = new Sandbox;
	sandbox->Run();
	delete sandbox;
}