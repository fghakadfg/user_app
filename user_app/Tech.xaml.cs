using System;
using System.Collections.Generic;
using System.ComponentModel;
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
    /// Interaction logic for Tech.xaml
    /// </summary>
    public partial class Tech : Window
    {
        public Tech()
        {
            InitializeComponent();


            using (var context = new PostgresContext())
            {

                dataBlueprints.ItemsSource = context.Blueprints.ToList();
                dataComponents.ItemsSource = context.Components.ToList();
                dataComponentsProduction.ItemsSource = context.ComponentsProductions.ToList();
                dataProducts.ItemsSource = context.Productions.ToList();
                dataManufacturedProducts.ItemsSource = context.ManufacturedProducts.ToList();
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {


            String userText = userTextBox.Text;


            EmployeeFeedback ef = new EmployeeFeedback();

            ef.AddNote(userText);






        }
    }
}
