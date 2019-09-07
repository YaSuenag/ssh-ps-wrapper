Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Set-Variable APPNAME "SSH PS Wrapper" -Option Constant -Scope Script


function OnKeyCheckChanged{
    $Script:file_btn.Enabled = $Script:key_check.Checked
    $Script:key_text.Enabled = $Script:key_check.Checked
}

function OnKeyFileButtonClicked{
    $file_dialog = New-Object System.Windows.Forms.OpenFileDialog
    $file_dialog.Title = "Choose SSH private key file"

    if($file_dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){
        $Script:key_text.Text = $file_dialog.FileName
    }

}

function Init{
    $form = New-Object System.Windows.Forms.Form
    $form.Text = $APPNAME
    $form.Size = New-Object System.Drawing.Size(260, 180)
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow

    $user_label = New-Object System.Windows.Forms.Label
    $user_label.Location = New-Object System.Drawing.Point(10, 7)
    $user_label.Size = New-Object System.Drawing.Size(35, 20)
    $user_label.Text = "User"
    $Script:user_text = New-Object System.Windows.Forms.TextBox
    $Script:user_text.Location = New-Object System.Drawing.Point(45, 5)
    $Script:user_text.Size = New-Object System.Drawing.Size(100, 50)

    $host_label = New-Object System.Windows.Forms.Label
    $host_label.Location = New-Object System.Drawing.Point(10, 32)
    $host_label.Size = New-Object System.Drawing.Size(35, 20)
    $host_label.Text = "Host"
    $Script:host_text = New-Object System.Windows.Forms.TextBox
    $Script:host_text.Location = New-Object System.Drawing.Point(45, 30)
    $Script:host_text.Size = New-Object System.Drawing.Size(100, 50)

    $port_label = New-Object System.Windows.Forms.Label
    $port_label.Location = New-Object System.Drawing.Point(160, 32)
    $port_label.Size = New-Object System.Drawing.Size(35, 20)
    $port_label.Text = "Port"
    $Script:port_text = New-Object System.Windows.Forms.TextBox
    $Script:port_text.Location = New-Object System.Drawing.Point(195, 30)
    $Script:port_text.Size = New-Object System.Drawing.Size(40, 50)
    $Script:port_text.Text = "22"
    $Script:port_text.ImeMode = [System.Windows.Forms.ImeMode]::Disable

    $Script:key_check = New-Object System.Windows.Forms.CheckBox;
    $Script:key_check.Location = New-Object System.Drawing.Point(10, 55)
    $Script:key_check.Size = New-Object System.Drawing.Size(70, 30)
    $Script:key_check.Text = "SSH key"
    $Script:key_check.Add_CheckedChanged({OnKeyCheckChanged})

    $Script:file_btn = New-Object System.Windows.Forms.Button
    $Script:file_btn.Location = New-Object System.Drawing.Point(90, 60)
    $Script:file_btn.Size = New-Object System.Drawing.Size(70, 20)
    $Script:file_btn.Text = "key file"
    $Script:file_btn.Enabled = $false
    $Script:file_btn.Add_Click({OnKeyFileButtonClicked})

    $Script:key_text = New-Object System.Windows.Forms.TextBox
    $Script:key_text.Location = New-Object System.Drawing.Point(10, 85)
    $Script:key_text.Size = New-Object System.Drawing.Size(225, 50)
    $Script:key_text.Enabled = $false

    $connect_btn = New-Object System.Windows.Forms.Button
    $connect_btn.Location = New-Object System.Drawing.Point(65, 115)
    $connect_btn.Size = New-Object System.Drawing.Size(60, 20)
    $connect_btn.Text = "Connect"
    $connect_btn.DialogResult = [System.Windows.Forms.DialogResult]::OK

    $cancel_btn = New-Object System.Windows.Forms.Button
    $cancel_btn.Location = New-Object System.Drawing.Point(130, 115)
    $cancel_btn.Size = New-Object System.Drawing.Size(60, 20)
    $cancel_btn.Text = "Cancel"
    $cancel_btn.DialogResult = [System.Windows.Forms.DialogResult]::Cancel


    $form.AcceptButton = $connect_btn
    $form.CancelButton = $cancel_btn

    $form.Controls.Add($user_label) 
    $form.Controls.Add($Script:user_text)
    $form.Controls.Add($host_label) 
    $form.Controls.Add($Script:host_text)
    $form.Controls.Add($port_label) 
    $form.Controls.Add($Script:port_text)
    $form.Controls.Add($Script:key_check)
    $form.Controls.Add($Script:file_btn)
    $form.Controls.Add($Script:key_text)
    $form.Controls.Add($connect_btn)
    $form.Controls.Add($cancel_btn)

    Write-Output $form
}


$form = Init
$result = $form.ShowDialog()

if($result -ne [System.Windows.Forms.DialogResult]::OK){
    exit 1
}

$username = $Script:user_text.Text.Trim()
$hostname = $Script:host_text.Text.Trim()
$port_number = $Script:port_text.Text.Trim()
$private_key_file = $Script:key_text.Text.Trim()

if($hostname.Length -eq 0){
    [void][System.Windows.Forms.MessageBox]::Show("Host is empty", $APPNAME, [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    exit 2
}
if($Script:key_check.Checked -and ($private_key_file.Length -eq 0)){
    [void][System.Windows.Forms.MessageBox]::Show("Private key file is empty", $APPNAME, [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    exit 3
}

$command = "ssh"
if($username.Length -gt 0){
    $command += " -l " + $username
}
if($port_number.Length -gt 0){
    $command += " -p " + $port_number
}
if($private_key_file.Length -gt 0){
    $command += " -i " + "'" + $private_key_file + "'"
}
$command += " " + $hostname

echo $command
Invoke-Expression $command