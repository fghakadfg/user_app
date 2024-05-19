using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace user_app
{
    /// <summary>
    /// Interaction logic for TechleadWindow.xaml
    /// </summary>
    public partial class TechleadWindow : Window
    {
        public TechleadWindow()
        {
            InitializeComponent();

            using (var context = new PostgresContext())
            {

                
                dataBlueprints.ItemsSource = context.Blueprints.ToList();
                dataComponents.ItemsSource = context.Components.ToList();
                dataComponentsProduction.ItemsSource = context.ComponentsProductions.ToList();
                dataProducts.ItemsSource = context.Productions.ToList();
                dataProjects.ItemsSource = context.Projects.ToList();
                dataProjectsProgress.ItemsSource = context.ProjectProgresses.ToList();
                dataManufacturedProducts.ItemsSource = context.ManufacturedProducts.ToList();
            }


        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {


            String userText = userTextBox.Text;

            EmployeeFeedback ef = new EmployeeFeedback();

            ef.AddNote(userText);




        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {

            MainWindow main = new MainWindow();
            main.Show();
            this.Close();

        }
    }
}
