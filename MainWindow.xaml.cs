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
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.IO;
using Microsoft.Win32;
using ChoETL;
using System.Text.RegularExpressions;
using System.Xml.Xsl;
using System.Xml;

namespace PositionTransmogrifier
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            UpdateDropdown();
        }

        private void UpdateDropdown()
        {

            //DirectoryInfo dir = new DirectoryInfo(System.IO.Directory.GetCurrentDirectory());
            string[] files = System.IO.Directory.GetFiles(System.IO.Directory.GetCurrentDirectory(), "*.xslt");
            //Directory dir = System.IO.Directory.GetFiles(path, "*.txt", SearchOption.AllDirectories);
            foreach (var item in files)
            { TemplateComboBox.Items.Add(item); }
            TemplateComboBox.SelectedIndex = 0;

        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();

            ofd.CheckFileExists = true;
            ofd.Filter = "Comma Delimited Files (*.csv) | *.csv";
            ofd.Title = "Select the CSV File";
            ofd.Multiselect = false;

            if (ofd.ShowDialog() == true)
                InputFileTextbox.Text = ofd.FileName;
            string OutputXMLFile = Regex.Replace(InputFileTextbox.Text, ".csv$", ".ninaTargetSet");
            if (File.Exists(OutputXMLFile)) { MessageBox.Show("Warning:  " + OutputXMLFile + " exists, converting will overwrite file.");  }

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            string InputText = System.IO.File.ReadAllText(InputFileTextbox.Text);
            Console.WriteLine(InputText);
            InputText = Regex.Replace(InputText, ":", "_");
            InputText = Regex.Replace(InputText, "\"", "");

            string OutputXMLFile = Regex.Replace(InputFileTextbox.Text, ".csv$", ".ninaTargetSet"); 

            StringBuilder sb = new StringBuilder();
            using (var p = ChoCSVReader.LoadText(InputText).WithFirstLineHeader())
//            using (var p =  new ChoCSVReader(InputFileTextbox.Text).WithFirstLineHeader() )
            {
                Console.WriteLine(p);
                using (var w = new ChoXmlWriter(sb)
                .Configure(c => c.RootName = "Mosaic")
                .Configure(c => c.NodeName = "Position")
                )
                 w.Write(p);
            }
            Console.WriteLine(sb.ToString());

            //InputXML = 
            try
            {

                StringReader SR_InputXML = new StringReader(sb.ToString());
                XmlReader xr = XmlReader.Create(SR_InputXML);

                XslCompiledTransform myXSLT;
                myXSLT = new XslCompiledTransform();
                myXSLT.Load(TemplateComboBox.SelectedItem.ToString());
                //myXSLT.Load('C:\Users\3ricj\source\repos\PositionTransmogrifier\bin\Debug\QuickShot.xslt');
                XmlTextWriter myWriter = new XmlTextWriter(OutputXMLFile, null);
                myXSLT.Transform(xr, null, myWriter);
            }
            catch { MessageBox.Show("Error performing conversion"); }

            MessageBox.Show("Converted file: " + OutputXMLFile);

            System.Windows.Application.Current.Shutdown();

        }
    }
}
