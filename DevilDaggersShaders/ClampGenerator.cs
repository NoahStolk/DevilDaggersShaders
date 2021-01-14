using System.IO;
using System.Text;

namespace DevilDaggersShaders
{
	public static class ClampGenerator
	{
		public static void Run(string rootPath, float clampValue)
		{
			const string identifier = "floor(world_position *";
			foreach (string path in Directory.GetFiles(rootPath, "*.glsl", SearchOption.AllDirectories))
			{
				string[] glslLines = File.ReadAllLines(path);

				for (int i = 0; i < glslLines.Length; i++)
				{
					string line = glslLines[i];
					if (line.Contains(identifier))
					{
						if (clampValue == 0)
						{
							glslLines[i] = string.Empty;
							continue;
						}

						int start1 = line.IndexOf(identifier) + identifier.Length;
						int end1 = line.IndexOf(')') - 1;

						int start2 = line.LastIndexOf(' ');
						int end2 = line.LastIndexOf(';') - 1;

						StringBuilder newLine = new StringBuilder();
						int j = 0;
						while (j < line.Length)
						{
							if (j > start1 && j <= end1)
							{
								newLine.Append(clampValue.ToString());
								j += end1 - start1;
							}
							else if (j > start2 && j <= end2)
							{
								newLine.Append(clampValue.ToString());
								j += end2 - start2;
							}
							else
							{
								newLine.Append(line[j]);
								j++;
							}
						}
						glslLines[i] = newLine.ToString();
					}
				}

				File.WriteAllLines(path, glslLines);
			}
		}
	}
}
