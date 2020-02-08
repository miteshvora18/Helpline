<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Message.aspx.cs" Inherits="Message" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div>
            <center>
                <table width="80%" cellpadding="0" cellspacing="0" class="centerPage">
                    <tr>
                        <td colspan="2">
                            <table style="background-color:#f5f5f5;border:10px solid #f5f5f5;" width="100%">
                                <tr>
                                    <td><asp:Hyperlink runat="server" NavigateUrl="<%#homeUrl %>">Home</asp:Hyperlink></td>
                                    <td>Engineering Notes</td>
                                    <td><asp:Hyperlink runat="server" NavigateUrl="<%#profileUrl %>">Edit Profile</asp:Hyperlink></td>
                                    <td><asp:Button ID="btnLogOut" runat="server" Text="Log Out" 
                                            onclick="btnLogOut_Click" CssClass="logout" CausesValidation="false" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table style="width:100%;text-align:center">
                                <tr>
                                    <td>
                                        <br /><br />
                                        <asp:TextBox ID="txtSend" runat="server" Height="40px" Width="296px" TextMode="MultiLine" style="min-width:300px;max-width:300px;min-height:50px;max-height:50px;"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ErrorMessage="*" ControlToValidate="txtSend" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                                        <asp:Button ID="btnSend" runat="server" Text="Send" Width="92px" 
                                            style="height: 26px" onclick="btnSend_Click" />
                                                
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="width:100%;text-align:center">
                                        <tr> 
                                            <td>
                                                <br />
                                                <asp:Label ID="lblPrevMsg" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Timer runat="server" id="Timer1" Interval="3000" OnTick="Timer1_Tick"></asp:Timer>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
