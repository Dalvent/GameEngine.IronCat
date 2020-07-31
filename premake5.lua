workspace "GoblinEngine"
    architecture "x86_64"
    startproject "SandBox"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "GoblinEngine/vendor/GLFW/include"
IncludeDir["GLAD"] = "GoblinEngine/vendor/GLAD/include"
IncludeDir["ImGUI"] = "GoblinEngine/vendor/ImGUI"

include "GoblinEngine/vendor/GLFW"
include "GoblinEngine/vendor/GLAD"
include "GoblinEngine/vendor/ImGUI"

project "GoblinEngine"
    location "GoblinEngine"
    kind "SharedLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "pch.h"
    pchsource "GoblinEngine/src/pch.cpp"
    
    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    defines
    {
        "GE_PLATFORM_WINDOWS",
        "GE_BUILD_DLL",
        "GLFW_INCLUDE_NONE"
    }

    includedirs
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.GLAD}",
        "%{IncludeDir.ImGUI}"
    }

    links
    {
        "GLFW",
        "GLAD",
        "ImGui",
        "opengl32.lib"
	}

    filter "system:windows"
        systemversion "latest"

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }
    
    filter "configurations:Debug"
        defines "GE_DEBUG"
        buildoptions "/MDd"
        symbols "On"
    
    filter "configurations:Relese"
        defines "GE_RELEASE"
        buildoptions "/MD"
        symbols "On" 
    
    filter "configurations:Dis"
        defines "GE_DIST"
        buildoptions "/MD"
        symbols "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    
    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }
    
    defines
    {
        "GE_PLATFORM_WINDOWS"
    }

    includedirs
    {
        "GoblinEngine/src",
        "GoblinEngine/vendor/spdlog/include"
    }

    links
    {
        "GoblinEngine"
    }
    
    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"
    
    
        defines
        {
            "GE_PLATFORM_WINDOWS"
        }

        
    filter "configurations:Debug"
        defines "GE_DEBUG"
        buildoptions "/MDd"
        symbols "On"
    
    filter "configurations:Relese"
        defines "GE_RELEASE"
        buildoptions "/MD"
        symbols "On" 
    
    filter "configurations:Dis"
        defines "GE_DIST"
        buildoptions "/MD"
        symbols "On"