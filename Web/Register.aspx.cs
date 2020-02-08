using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class About : System.Web.UI.Page
{
    string conn = System.Configuration.ConfigurationManager.ConnectionStrings["HelplineConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            for (int i = 1; i <= 31; i++)
            {
                ddlDay.Items.Add(i.ToString());
            }
            for (int i = 1; i <= 12; i++)
            {
                ddlMonth.Items.Add(i.ToString());
            }
            for (int i = 2010; i >=1900 ; i--)
            {
                ddlYear.Items.Add(i.ToString());
            }
        }
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Select username from users where username=@user",con);
            cmd.Parameters.AddWithValue("@user",txtUsername.Text);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Username exists..try different one')", true);
            }
            else
            {
                con.Close();
                if (fuImage.HasFile)
                {
                    SqlCommand cmd2 = new SqlCommand("insert into users values(@name,@email,@dob,@college,@branch,@gender,@username,@pass,@image,@status,@statustime,@online)", con);
                    cmd2.Parameters.AddWithValue("@name", txtName.Text);
                    cmd2.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd2.Parameters.AddWithValue("@dob", ddlDay.Text + "-" + ddlMonth.Text + "-" + ddlYear.Text);
                    cmd2.Parameters.AddWithValue("@college", txtCollege.Text);
                    cmd2.Parameters.AddWithValue("@branch", ddlBranch.Text);
                    cmd2.Parameters.AddWithValue("@gender", ddlGender.Text);
                    cmd2.Parameters.AddWithValue("@username", txtUsername.Text);
                    cmd2.Parameters.AddWithValue("@pass", txtPass.Text);
                    cmd2.Parameters.AddWithValue("@image", fuImage.FileName);
                    cmd2.Parameters.AddWithValue("@status", "");
                    cmd2.Parameters.AddWithValue("@statustime", "");
                    cmd2.Parameters.AddWithValue("@online", false);
                    con.Open();
                    cmd2.ExecuteNonQuery();
                    //string filename = Path.GetFileName(fuImage.FileName);
                    fuImage.SaveAs(Server.MapPath("~/images/user_images/") + fuImage.FileName);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You have successfully registered')", true);
                    txtCollege.Text = txtConfPass.Text = txtEmail.Text = txtName.Text = txtPass.Text = txtUsername.Text = "";
                    ddlBranch.SelectedIndex = ddlDay.SelectedIndex = ddlGender.SelectedIndex = ddlMonth.SelectedIndex = ddlYear.SelectedIndex = 0;
                    con.Close();
                }
                else
                {
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Upload your image  to register')", true);
                }
            }
            
        }
        catch (Exception e1)
        {
            ScriptManager.RegisterStartupScript(this,GetType(),"alert","alert('Error:"+e1.Message+"')",true);
        }
    }
}
