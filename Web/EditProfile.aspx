<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="EditProfile" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td colspan="2">
                <h2>Profile</h2>
            </td>
        </tr>
         <tr>
            <td>
                Username
            </td>
            <td>
                <asp:TextBox ID="txtUsername" runat="server" Enabled="false" style="background-color:#e0e0e0;"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Name
            </td>
        <td>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        </td>
        </tr>
        <tr>
            <td>

                Email
            </td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                DOB
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
            <td class="style2">
                Upload Image
            </td>
            <td class="style2">
                <asp:FileUpload ID="fuImage" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" /><br />
                <asp:Hyperlink ID="Hyperlink1" runat="server" NavigateUrl="<%#homeUrl %>">Back to Home</asp:Hyperlink>
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
    <title>Edit Profile</title>
</asp:Content>