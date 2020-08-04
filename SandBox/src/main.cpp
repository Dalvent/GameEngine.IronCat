#include <iostream>
#include <GoblinEngine.h>
#include <glm/vec2.hpp>

class SuckLayer : public GoblinEngine::Layer
{
public:
	SuckLayer() 
		: Layer("SuckLayer")
	{
	}

	void OnEvent(GoblinEngine::Event& event) override
	{
	}
};

class SandBox : public GoblinEngine::GameMode
{
public:
	SandBox()
	{

	}
	~SandBox()
	{

	}
private:

};

void GoblinEngine::SetupAppSettings(GoblinEngine::GameApplication& app)
{
	app.SetGameMod(new SandBox());
	app.AddLayer(new SuckLayer());
	app.AddLayer(new ImGUILayer());
}