<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <link href="Styles/Default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        window.history.forward();
        function noBack() { window.history.forward(); }
    </script>
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
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
                                    <td><asp:Hyperlink ID="Hyperlink1" runat="server" NavigateUrl="<%#homeUrl %>">Home</asp:Hyperlink></td>
                                    <td>Engineering Notes</td>
                                    <td><asp:Hyperlink ID="Hyperlink2" runat="server" NavigateUrl="<%#profileUrl %>">Edit Profile</asp:Hyperlink></td>
                                    <td><asp:Button ID="btnLogOut" runat="server" Text="Log Out" 
                                            onclick="btnLogOut_Click" CssClass="logout" CausesValidation="false" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Label ID="lblUnreadMsg" runat="server"></asp:Label>
                                    <asp:Timer runat="server" id="Timer3" Interval="3000" OnTick="Timer3_Tick"></asp:Timer>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td width="70%">
                            <table width="98%" style="vertical-align:top;">
                                <tr>
                                    <td style="width:30%" align="center">
                                        <asp:Image ID="imgUser" runat="server" style="width:200px;height:200px;" />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblName" runat="server" style="font-size:20px;"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <center>
                                            <h3>Set Status</h3>
                                            <asp:TextBox ID="txtPost" runat="server" Height="40px" Width="296px" 
                                                TextMode="MultiLine" style="min-width:300px;max-width:300px;min-height:50px;max-height:50px;"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                ErrorMessage="*" ControlToValidate="txtPost" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                                            <asp:Button ID="btnPost" runat="server" Text="Post" Width="92px" 
                                                onclick="btnPost_Click" style="height: 26px" />
                                        </center>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Status Updates..
                                    </td>
                                </tr>
                            </table>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table width="98%" style="vertical-align:top;">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvStatus" runat="server" BackColor="#e0e0e0" BorderWidth="0px" 
                                                    ShowHeader="false" AutoGenerateColumns="false" 
                                                    onrowdatabound="gvStatus_RowDataBound" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Left" ItemStyle-Height="100px" ItemStyle-Width="100px" ItemStyle-BorderWidth="0">
                                                            <ItemTemplate> 
                                                                <asp:Image ID="imgUserStatus" Width="100px" Height="100px" runat="server"/>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="uimage" Visible="false" ItemStyle-BorderWidth="0" />
                                                        <asp:BoundField DataField="name" ItemStyle-HorizontalAlign="Center" ItemStyle-BorderWidth="0" ItemStyle-Width="80px" />
                                                        <asp:BoundField DataField="ustatus" ItemStyle-HorizontalAlign="Center" ItemStyle-ForeColor="DarkGoldenrod" ItemStyle-BorderWidth="0" />
                                                        <asp:BoundField DataField="ustatustime" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:HH:mm dd/MMM/yyyy}" ItemStyle-BorderWidth="0" />
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:Timer runat="server" id="Timer1" Interval="3000" OnTick="Timer1_Tick"></asp:Timer>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView ID="gvChat" runat="server" AutoGenerateColumns="false" 
                                        ShowHeader="false" Width="100%" onrowdatabound="gvChat_RowDataBound" BorderWidth="0px">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Height="40px" ItemStyle-Width="40px" ItemStyle-BorderWidth="0">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgChatUser" Width="40px" Height="40px" runat="server"/>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-BorderWidth="0" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:HyperLink runat="server" ID="hyName">
                                                        <%#Eval("name") %>
                                                    </asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="name" Visible="false" ItemStyle-HorizontalAlign="Center" ItemStyle-BorderWidth="0" />
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-BorderWidth="0">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgUserOnline" Width="10px" Height="10px" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:Timer runat="server" id="Timer2" Interval="3000" OnTick="Timer2_Tick"></asp:Timer>
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
