using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using Python.Runtime;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Diagnostics;
using System.IO;

namespace user_app
{
    /// <summary>
    /// Interaction logic for AccountantWindow.xaml
    /// </summary>
    public partial class AccountantWindow : Window
    {
        public AccountantWindow()
        {
            InitializeComponent();

            using (var context = new PostgresContext())
            {

                dataClients.ItemsSource = context.Clients.ToList();
                dataContracts.ItemsSource = context.Contracts.ToList();
                dataEmployees.ItemsSource = context.Employees.ToList();
                dataOrders.ItemsSource = context.Orders.ToList();
                dataReqs.ItemsSource = context.Requisitions.ToList();

                var ids = context.ManufacturedProducts.Select(p => p.IdProduct).Distinct().ToList();
                comboBoxProduct.Items.Clear(); // Очистить текущие элементы, если необходимо

                foreach (var id in ids)
                {
                    comboBoxProduct.Items.Add(id);
                }

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

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {

            int id = int.Parse(comboBoxProduct.Text);
            string exePath = "dist\\analizer.exe";

            string filePath = "producttype.txt";

            using (StreamWriter writer = new StreamWriter(filePath))
            {

                String str = id.ToString();



                writer.WriteLine(str);

            }




            // Создание процесса
            ProcessStartInfo startInfo = new ProcessStartInfo();
            startInfo.FileName = exePath;
            startInfo.UseShellExecute = false; // Используем прямое выполнение, а не оболочку
            startInfo.CreateNoWindow = true;   // Не создавать окно консоли
            // Запуск процесса
            using (Process process = Process.Start(startInfo))
            {
                // Дождитесь завершения процесса, если это необходимо
                process.WaitForExit();
            }
        }
    }
}
