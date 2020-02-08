using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    string conn = System.Configuration.ConfigurationManager.ConnectionStrings["HelplineConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["msg"] == "invalid")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You must login to view this page.')", true);
            }
            if (Request.QueryString["msg"] == "logout")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You are now logged out.')", true);
            }
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Select uid from users where username=@user and pass=@pass",con);
            cmd.Parameters.AddWithValue("@user",txtUsername.Text);
            cmd.Parameters.AddWithValue("@pass", txtPassword.Text);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    Session["uid"] = dr[0].ToString();
                    string uid = dr[0].ToString();
                    con.Close();
                    SqlCommand cmd2 = new SqlCommand("Update users set uonline=@uonline where uid=@uid",con);
                    cmd2.Parameters.AddWithValue("@uonline",1);
                    cmd2.Parameters.AddWithValue("@uid",uid);
                    con.Open();
                    cmd2.ExecuteNonQuery();
                    Response.Redirect("Home.aspx?uid=" + uid);
                }
            }
            else
            {
                txtUsername.Text = txtPassword.Text = "";
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Invalid Username and/or Password')", true);
            }
        }
        catch (Exception e1)
        {
            txtUsername.Text = txtPassword.Text="";
            ScriptManager.RegisterStartupScript(this,GetType(), "alert", "alert('" + e1.Message + "')", true);
        }
    }
}