<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td colspan="2">
                <h2>Register</h2>
            </td>
        </tr>
        <tr>
            <td>
                Name
            </td>
            <td>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtName" Display="Dynamic" ErrorMessage="Name is required" 
                    ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Email
            </td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email is required" 
                    ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="txtEmail" Display="Dynamic" 
                    ErrorMessage="Invalid Email Format" ForeColor="Red" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Invalid Email Format</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                DOB (DD/MM/YYYY)
            </td>
            <td>
                <asp:DropDownList ID="ddlDay" runat="server" Width="40px"></asp:DropDownList>
                <asp:DropDownList ID="ddlMonth" runat="server" Width="40px"></asp:DropDownList>
                <asp:DropDownList ID="ddlYear" runat="server" Width="55px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                College
            </td>
            <td>
                <asp:TextBox ID="txtCollege" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Branch
            </td>
            <td>
                <asp:DropDownList ID="ddlBranch" runat="server">
                    <asp:ListItem>BE IT</asp:ListItem>
                    <asp:ListItem>BE EXTC</asp:ListItem>
                    <asp:ListItem>Diploma IT</asp:ListItem>
                    <asp:ListItem>Diploma EXTC</asp:ListItem>
                    <asp:ListItem>Bsc IT</asp:ListItem>
                    <asp:ListItem>Msc IT</asp:ListItem>
                    <asp:ListItem>MCA</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Sex
            </td>
            <td>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Username
            </td>
            <td class="style1">
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtUsername" ErrorMessage="Username is required" 
                    ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Password
            </td>
            <td>
                <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="txtPass" Display="Dynamic" 
                    ErrorMessage="Password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Confirm Password
            </td>
            <td class="style2">
                <asp:TextBox ID="txtConfPass" runat="server" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="txtConfPass" ControlToValidate="txtPass" Display="Dynamic" 
                    ErrorMessage="Passwords must match" ForeColor="Red">Passwords do not match</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Upload Image
            </td>
            <td class="style2">
                <asp:FileUpload ID="fuImage" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnRegister" runat="server" Text="Register" 
                    onclick="btnRegister_Click" />
                <br />
                <a href="Login.aspx">Back to Login</a>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
            </td>
        </tr>
</table>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .style1
        {
            height: 29px;
            margin-left: 160px;
        }
        .style2
        {
            height: 29px;
        }
    </style>
</asp:Content>
