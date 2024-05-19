using System.Configuration;
using System.IO;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace user_app
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }


      

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            int userId = int.Parse(userIdBox.Text);

            String userPassword = userPasswordBox.Text;

            String userRole = userRoleBox.Text;

            switch (userRole)
            {
                case "Старший инженер":


                    using(var context = new PostgresContext())
                    {

                        var entity = context.TechAccesses.FirstOrDefault(e => e.Idemployee == userId);

                        if (entity != null && entity.EmployeePassword == userPassword)
                        {

                            passLabel.Content = "Passed";
                          
                            passLabel.Visibility = Visibility.Visible;

                            

                            TechleadWindow tech = new TechleadWindow();



                            string filePath = "example.txt";

                            using (StreamWriter writer = new StreamWriter(filePath))
                            {

                                String str = userId.ToString();
                                
                               

                                writer.WriteLine(str);
                                
                            }


                            tech.Show();
                            MainWindow main = new MainWindow();
                            this.Close();
                        }
                        else
                        {
                            
                            
                            passLabel.Foreground = new SolidColorBrush(Colors.Red);
                            
                            passLabel.Content = "Didn' passed";
                            passLabel.Visibility = Visibility.Visible;
                        }

                    }



                    break;
                case "Инженер":

                    using (var context = new PostgresContext())
                    {

                        var entity = context.TechAccesses.FirstOrDefault(e => e.Idemployee == userId);

                        if (entity != null && entity.EmployeePassword == userPassword)
                        {

                            passLabel.Content = "Passed";

                            passLabel.Visibility = Visibility.Visible;

                            string filePath = "example.txt";

                            using (StreamWriter writer = new StreamWriter(filePath))
                            {

                                String str = userId.ToString();



                                writer.WriteLine(str);

                            }
                            Tech tech = new Tech();

                            tech.Show();
                            MainWindow main = new MainWindow();
                            this.Close();
                        }
                        else
                        {


                            passLabel.Foreground = new SolidColorBrush(Colors.Red);

                            passLabel.Content = "Didn' passed";
                            passLabel.Visibility = Visibility.Visible;
                        }

                    }


                    break;

                case "Бухгалтер":

                    using (var context = new PostgresContext())
                    {

                        var entity = context.LawyerAcces.FirstOrDefault(e => e.Idemployee == userId);

                        if (entity != null && entity.EmployeePassword == userPassword)
                        {

                            passLabel.Content = "Passed";

                            passLabel.Visibility = Visibility.Visible;
                            string filePath = "example.txt";

                            using (StreamWriter writer = new StreamWriter(filePath))
                            {

                                String str = userId.ToString();



                                writer.WriteLine(str);

                            }
                            AccountantWindow accountant = new AccountantWindow();

                            accountant.Show();
                            MainWindow main = new MainWindow();
                            this.Close();
                        }
                        else
                        {


                            passLabel.Foreground = new SolidColorBrush(Colors.Red);

                            passLabel.Content = "Didn' passed";
                            passLabel.Visibility = Visibility.Visible;
                        }

                    }



                    break;

                case "Юрист":

                    using (var context = new PostgresContext())
                    {

                        var entity = context.LawyerAcces.FirstOrDefault(e => e.Idemployee == userId);

                        if (entity != null && entity.EmployeePassword == userPassword)
                        {

                            passLabel.Content = "Passed";

                            passLabel.Visibility = Visibility.Visible;
                            string filePath = "example.txt";

                            using (StreamWriter writer = new StreamWriter(filePath))
                            {

                                String str = userId.ToString();



                                writer.WriteLine(str);

                            }
                            LawyerWindow lawyer = new LawyerWindow();

                            lawyer.Show();
                            MainWindow main = new MainWindow();
                            this.Close();
                        }
                        else
                        {


                            passLabel.Foreground = new SolidColorBrush(Colors.Red);

                            passLabel.Content = "Didn' passed";
                            passLabel.Visibility = Visibility.Visible;
                        }

                    }
                    break;


               

                default:
                    break;

            }

            

        }
    }
}