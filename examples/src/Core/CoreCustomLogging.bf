/*******************************************************************************************
*
*   raylib [core] example - Custom logging
*
*   This example has been created using raylib 2.1 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Example contributed by Pablo Marcos Oltra (@pamarcos) and reviewed by Ramon Santamaria (@raysan5)
*
*   Copyright (c) 2018 Pablo Marcos Oltra (@pamarcos) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

using raylib_beef.Types;
using raylib_beef.Enums;
using System;

namespace raylib_beef.examples.Core
{
	class CustomLogging : Raylib
	{
		// Custom logging function
		public static void LogCustom(TraceLogType msgType, char8* text, void* args)
		{
			var fullLogMessage = scope String();
			var timeStr = scope String();
			System.DateTime.Now.ToShortTimeString(timeStr);
			fullLogMessage.Append(timeStr);

			switch (msgType)
			{
				case .LOG_INFO: fullLogMessage.Append("[INFO] : ");
				case .LOG_ERROR: fullLogMessage.Append("[ERROR]: ");
				case .LOG_WARNING: fullLogMessage.Append("[WARN] : ");
				case .LOG_DEBUG: fullLogMessage.Append("[DEBUG]: ");
				default: break;
			}
			fullLogMessage.AppendF(scope String(text), args);
			System.Console.Out.WriteLine(fullLogMessage);
		}

		public static void Main()
		{
			// Initialization
			let screenWidth = 800;
			let screenHeight = 450;

			// First thing we do is setting our custom logger to ensure everything raylib logs
			// will use our own logger instead of its internal one
			// TraceLogCallback callback = scope => LogCustom;
			TraceLogCallback callback = => LogCustom;
			SetTraceLogCallback(callback);

			InitWindow(screenWidth, screenHeight, "raylib [core] example - custom logging");

			SetTargetFPS(60);               // Set our game to run at 60 frames-per-second

			// Main game loop
			while (!WindowShouldClose())    // Detect window close button or ESC key
			{
				// Update
				// TODO: Update your variables here

				// Draw
				BeginDrawing();

				ClearBackground(.RAYWHITE);

				DrawText("Check out the console output to see the custom logger in action!", 60, 200, 20, .LIGHTGRAY);

				EndDrawing();
			}

			// De-Initialization
			CloseWindow();        // Close window and OpenGL context
		}

	}
}
