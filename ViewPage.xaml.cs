using Demo_var_6_Lib;
using System.Windows;
using System.Windows.Controls;

namespace Demo_var_6
{
    public partial class ViewPage : Window
    {
        private UserDataManager userDataManager;

        public ViewPage()
        {
            InitializeComponent();

            userDataManager = new UserDataManager(UserDataGrid, SortComboBox, FilterTextBox, SearchTextBox);
        }

        private void SortButton_Click(object sender, RoutedEventArgs e)
        {
            string columnName = SortComboBox.SelectedItem as string;
            if (!string.IsNullOrEmpty(columnName))
            {
                userDataManager.SortData(columnName);
            }
        }

        private void FilterButton_Click(object sender, RoutedEventArgs e)
        {
            userDataManager.ApplyFilter(FilterTextBox.Text);
        }

        private void ResetFilterButton_Click(object sender, RoutedEventArgs e)
        {
            FilterTextBox.Clear();
        }

        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            // Implement search functionality if needed.
        }

        private void ExitButton_Click(object sender, RoutedEventArgs e)
        {
            userDataManager.ExitApplication();
        }

        private void SaveChangesButton_Click(object sender, RoutedEventArgs e)
        {
            userDataManager.SaveChanges();
        }
    }
}
