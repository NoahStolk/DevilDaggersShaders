using System.Windows;

namespace DevilDaggersShaders.Wpf
{
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
		}

		private void ClampGeneratorButton_Click(object sender, RoutedEventArgs e)
		{
			ClampGenerator.Run(PathTextBox.Text, float.Parse(ValueTextBox.Text));
		}
	}
}