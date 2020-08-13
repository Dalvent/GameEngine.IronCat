#pragma once
#include "Engine/Events/Event.h"

namespace GoblinEngine
{
	class GameMode
	{
	public:
		virtual void OnBegin() {}
		virtual void OnUpdate() {}
		virtual void OnEnd() {}
		virtual void OnEvent(Event& e) {}
	};
}