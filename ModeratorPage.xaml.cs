using System.Windows;
using System.Data;
using Demo_var_6_Lib;
using System.Data.SqlClient;
using System;

namespace Demo_var_6
{
    public partial class ModeratorPage : Window
    {
        private UserManager userManager;

        public ModeratorPage()
        {
            InitializeComponent();
        
            userManager = new UserManager("Data Source=НЕФОР;Initial Catalog=Trade;Integrated Security=True");
           
            LoadUserData();
        }

        private void LoadUserData()
        {
            DataTable dataTable = userManager.GetAllUsers();
            UserGrid.ItemsSource = dataTable.DefaultView;
        }

        private void AddUser_Click(object sender, RoutedEventArgs e)
        {
            // Получите данные из текстовых полей и выпадающих списков
            string userSurname = UserSurnameTextBox.Text;
            string userName = UserNameTextBox.Text;
            string userPatronymic = UserPatronymicTextBox.Text;
            string userLogin = UserLoginTextBox.Text;
            string userPassword = UserPasswordBox.Password;
            int userRole = UserRoleComboBox.SelectedIndex + 1; // Индекс выбранной роли

            // Вызов метода для добавления нового пользователя
            bool result = userManager.AddUser(userSurname, userName, userPatronymic, userLogin, userPassword, userRole);

            if (result)
            {
                MessageBox.Show("Пользователь добавлен успешно.");
                // Перезагрузка данных пользователей после добавления
                LoadUserData();
            }
            else
            {
                MessageBox.Show("Не удалось добавить пользователя.");
            }
        }

        private void SaveUser_Click(object sender, RoutedEventArgs e)
        {
            // Получите данные из выбранной строки DataGrid
            DataRowView selectedRow = UserGrid.SelectedItem as DataRowView;

            if (selectedRow != null)
            {
                int userId = (int)selectedRow["UserID"];
                string userSurname = UserSurnameTextBox.Text;
                string userName = UserNameTextBox.Text;
                string userPatronymic = UserPatronymicTextBox.Text;
                string userLogin = UserLoginTextBox.Text;
                string userPassword = UserPasswordBox.Password;
                int userRole = UserRoleComboBox.SelectedIndex + 1; // Индекс выбранной роли

                // Вызов метода для обновления информации о пользователе
                bool result = userManager.UpdateUser(userId, userSurname, userName, userPatronymic, userLogin, userPassword, userRole);

                if (result)
                {
                    MessageBox.Show("Информация о пользователе обновлена успешно.");
                    // Перезагрузка данных пользователей после обновления
                    LoadUserData();
                }
                else
                {
                    MessageBox.Show("Не удалось обновить информацию о пользователе.");
                }
            }
        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {
            // Получите текст для поиска
            string searchTag = DescriptionTextBox.Text;

            // Вызов метода для поиска пользователей по тегам
            DataTable dataTable = userManager.SearchUsersByTag(searchTag);
            UserGrid.ItemsSource = dataTable.DefaultView;
        }

        private void Exit_Click(object sender, RoutedEventArgs e)
        {
           Application.Current.Shutdown();
        }

        private void UserRoleComboBox_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {

        }
        private void DeleteUser_Click(object sender, RoutedEventArgs e)
        {
            // Получаем выбранный пользователь из DataGrid
            DataRowView selectedUser = (DataRowView)UserGrid.SelectedItem;

            // Проверяем, что пользователь выбран
            if (selectedUser != null)
            {
                // Получаем UserID выбранного пользователя
                int userId = Convert.ToInt32(selectedUser["UserID"]);

                // Создаем строку подключения к базе данных
                string connectionString = "Data Source=НЕФОР;Initial Catalog=Trade;Integrated Security=True";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Создаем SQL-запрос для удаления пользователя по его UserID
                    string query = "DELETE FROM [User] WHERE UserID = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        try
                        {
                            // Выполняем запрос на удаление
                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                // Успешно удалено
                                MessageBox.Show("Пользователь успешно удален.");
                            }
                            else
                            {
                                MessageBox.Show("Ошибка при удалении пользователя.");
                            }
                        }
                        catch (SqlException ex)
                        {
                            MessageBox.Show($"Ошибка SQL: {ex.Message}");
                        }
                    }
                }

                
                LoadUserData();
            }
            else
            {
                MessageBox.Show("Выберите пользователя для удаления.");
            }
        }
    }
}
