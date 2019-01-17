
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function Get-Creds ($title,$user, $password, $domain1) {

###################Load Assembly for creating form & button######

 

[void][System.Reflection.Assembly]::LoadWithPartialName( “System.Windows.Forms”)

[void][System.Reflection.Assembly]::LoadWithPartialName( “Microsoft.VisualBasic”)

 

#####Define the form size & placement

 

$form = New-Object “System.Windows.Forms.Form”;

$form.Width = 500;

$form.Height = 160;

$form.Text = $title;

$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;

 

##############Define text label1

$textLabel1 = New-Object “System.Windows.Forms.Label”;

$textLabel1.Left = 25;

$textLabel1.Top = 15;

 

$textLabel1.Text = $user;

 

##############Define text label2

 

$textLabel2 = New-Object “System.Windows.Forms.Label”;

$textLabel2.Left = 25;

$textLabel2.Top = 50;

 

$textLabel2.Text = $password;

 

##############Define text label3

 

$textLabel3 = New-Object “System.Windows.Forms.Label”;

$textLabel3.Left = 25;

$textLabel3.Top = 85;

 

$textLabel3.Text = $domain1;

 

############Define text box1 for input

$textBox1 = New-Object “System.Windows.Forms.TextBox”;

$textBox1.Left = 150;

$textBox1.Top = 10;

$textBox1.width = 200;

 

############Define text box2 for input

 

$textBox2 = New-Object “System.Windows.Forms.TextBox”;

$textBox2.Left = 150;

$textBox2.Top = 50;

$textBox2.width = 200;

 

############Define text box3 for input

 

$textBox3 = New-Object “System.Windows.Forms.TextBox”;

$textBox3.Left = 150;

$textBox3.Top = 90;

$textBox3.width = 200;

 

#############Define default values for the input boxes

$defaultValue1 = “jakub.syrek”
$defaultValue2 = “”
$defaultValue3 = “GEO”

$textBox1.Text = $defaultValue1;

$textBox2.Text = $defaultValue2;

$textBox3.Text = $defaultValue3;

 

#############define OK button

$button = New-Object “System.Windows.Forms.Button”;

$button.Left = 360;

$button.Top = 85;

$button.Width = 100;

$button.Text = “Ok”;

 

############# This is when you have to close the form after getting values

$eventHandler = [System.EventHandler]{

$textBox1.Text;

$textBox2.Text;

$textBox3.Text;

$form.Close();};

 

$button.Add_Click($eventHandler) ;

 

#############Add controls to all the above objects defined

$form.Controls.Add($button);

$form.Controls.Add($textLabel1);

$form.Controls.Add($textLabel2);

$form.Controls.Add($textLabel3);

$form.Controls.Add($textBox1);

$form.Controls.Add($textBox2);

$form.Controls.Add($textBox3);

$ret = $form.ShowDialog();

 

#################return values

 

return $textBox1.Text, $textBox2.Text, $textBox3.Text

 

}

$return = Get-Creds “Please provide login info:” “User credentials:” “Password:” “Domain:”

$userS = $return[0]

$passS = $return[1]

$domainS = $return[2]

function Read-MultiLineInputBoxDialog([string]$Message, [string]$WindowTitle, [string]$DefaultText)
    {
        Add-Type -AssemblyName System.Drawing
        Add-Type -AssemblyName System.Windows.Forms
     
        # Create the Label.
        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Size(10,10) 
        $label.Size = New-Object System.Drawing.Size(280,20)
        $label.AutoSize = $true
        $label.Text = $Message
     
        # Create the TextBox used to capture the user's text.
        $textBox = New-Object System.Windows.Forms.TextBox 
        $textBox.Location = New-Object System.Drawing.Size(10,40) 
        $textBox.Size = New-Object System.Drawing.Size(575,200)
        $textBox.AcceptsReturn = $true
        $textBox.AcceptsTab = $false
        $textBox.Multiline = $true
        $textBox.ScrollBars = 'Both'
        $textBox.Text = $DefaultText
     
        # Create the OK button.
        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Size(415,250)
        $okButton.Size = New-Object System.Drawing.Size(75,25)
        $okButton.Text = "OK"
        $okButton.Add_Click({ [array]$arr = $textBox.Text; $form.Tag = $textBox.Text; $form.Close() })  #$form.Tag
     
        # Create the Cancel button.
        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Size(510,250)
        $cancelButton.Size = New-Object System.Drawing.Size(75,25)
        $cancelButton.Text = "Cancel"
        $cancelButton.Add_Click({ [arr]$arr = $null;$form.Tag = $null ; $form.Close() })
     
        # Create the form.
        $form = New-Object System.Windows.Forms.Form 
        $form.Text = $WindowTitle
        $form.Size = New-Object System.Drawing.Size(610,320)
        $form.FormBorderStyle = 'FixedSingle'
        $form.StartPosition = "CenterScreen"
        $form.AutoSizeMode = 'GrowAndShrink'
        $form.Topmost = $True
        $form.AcceptButton = $okButton
        $form.CancelButton = $cancelButton
        $form.ShowInTaskbar = $true
     
        # Add all of the controls to the form.
        $form.Controls.Add($label)
        $form.Controls.Add($textBox)
        $form.Controls.Add($okButton)
        $form.Controls.Add($cancelButton)
     
        # Initialize and show the form.
        $form.Add_Shown({$form.Activate()})
        $form.ShowDialog() > $null   # Trash the text of the button that was clicked.
     
        # Return the text that the user entered.
        [string]$str = $form.Tag
        return $str

    }

     
  
    

    [string]$string  = "";
    $string = Read-MultiLineInputBoxDialog -Message "Please Provide list of hosts to be deleted" -WindowTitle "List of hosts" -DefaultText "Enter some text here..." ;
    
    $array = $string.split([Environment]::NewLine)
    
 
    

    if ($strinG -eq $null) { Write-Host "You clicked Cancel" }
    else { Write-Host "You entered the following text: $strinG" }  
      
     [array]$Result = @() ;
       
        foreach ($a in $array)
     {
      if ($a -ne "") {  $Result += $a ; }
      
     }
       
     if ($Result -eq $null) { Write-Host "No result" }
     else { Write-Host $Result } 
    







if (Get-Module -ListAvailable -Name Selenium) {
    Write-Host "Module exists"
} 
else {
    Write-Host "Module does not exist"
    Install-Module Selenium
    Import-Module Selenium
     }

$seleniumDir = "C:\Program Files\WindowsPowerShell\Modules\Selenium\1.1\assemblies"

Add-Type -Path "$seleniumDir\WebDriver.dll"
Add-Type -Path "$seleniumDir\WebDriver.Support.dll"

#$seleniumOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
#$seleniumOptions.AddArguments(@('--start-maximized', '--allow-running-insecure-content', '--disable-infobars', '--enable-automation'))


$chrome = New-Object OpenQA.Selenium.Chrome.ChromeDriver "$seleniumDir"
$website1 =  "https://globalit.hcl.com/itbaselinecontrol/logout.aspx"
$chrome.Navigate().GoToUrl($website1);
$Browser = $chrome
$button = $Browser.FindElements([OpenQA.Selenium.By]::Id('BodyContent_A1'))
$button.Click()
Start-Sleep 2

$user = $Browser.FindElements([OpenQA.Selenium.By]::Id('BodyContent_txtUsername'))
$pass = $Browser.FindElements([OpenQA.Selenium.By]::Id('BodyContent_txtPassword'))
$domain = $Browser.FindElements([OpenQA.Selenium.By]::Id('BodyContent_ddlDomain'))
$user[0].SendKeys($userS)
$pass[0].SendKeys($passS)
$domain[0].SendKeys($domainS)
$button_Login = $Browser.FindElements([OpenQA.Selenium.By]::Id('BodyContent_btnSubmit'))
$button_Login.Click()
Start-Sleep 2
$StopWatch =  [system.diagnostics.stopwatch]::StartNew()
$i = 0
foreach ($hostname in $Result)
 {
  $i++
  $button_Reset = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_btnReset'))
  $button_Reset.Click()
  $Host_name = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_txtHostName'))
  $Host_name[0].SendKeys($hostname)
  $button_Search = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_btnSearch'))
  $button_Search.Click()
  $AD_checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_chkAD_0'))
  $AD_checkbox.Click()
  $SCCM_checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_chkSCCM_0'))
  $SCCM_checkbox.Click()
  $Tarmac_checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_chkTarmac_0'))
  $Tarmac_checkbox.Click()
  $SEP__checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_chkSEP_0'))
  $SEP__checkbox.Click()
  $DLP__checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_chkDLP_0'))
  $DLP__checkbox.Click()
  $Encryption__checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_ddlEncryption_0'))
  $Encryption__checkbox.SendKeys('NA')
  $Remarks__checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_ddlRemarks_0'))
  $Remarks__checkbox.SendKeys('Machine in Store')
  $RemedyID__checkbox = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_txtRemedyId_0'))
  $RemedyID__checkbox.SendKeys('13953474')
  $button_Action = $Browser.FindElements([OpenQA.Selenium.By]::Id('MainContent_gvHostDetails_ibtnDelete_0'))
  #$button_Action.Click()
  Start-Sleep -seconds 1
  $elapsedTime =  $StopWatch.Elapsed.ToString()
  Write-Host "Deleted in : $elapsedTime"
 }
 $elapsedTimer = $($StopWatch.Elapsed.TotalSeconds) / $($i )
 Write-Host "Deleted one per :      $($elapsedTimer) seconds."
