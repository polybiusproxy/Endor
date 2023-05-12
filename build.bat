@echo off
cls
set VSLANG=1033
haxe.exe build.hxml -D ENDOR_GLFW_STATIC
haxe.exe build.hxml -debug -D ENDOR_GLFW_STATIC -D HXCPP_STACK_TRACE -D HXCPP_TELEMETRY