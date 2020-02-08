using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class EditProfile : System.Web.UI.Page
{
    string conn = System.Configuration.ConfigurationManager.ConnectionStrings["HelplineConnectionString"].ConnectionString;
    protected int uid
    {
        get
        {
            if (Request.QueryString["uid"] != null)
            {
                return Convert.ToInt32(Request.QueryString["uid"]);
            }
            else
            {
                return 0;
            }
        }
    }
    protected string homeUrl
    {
        get
        {
            return "~/Home.aspx?uid=" + uid.ToString();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();

            #region Dropdown binding
            for (int i = 1; i <= 31; i++)
            {
                ddlDay.Items.Add(i.ToString());
            }
            for (int i = 1; i <= 12; i++)
            {
                ddlMonth.Items.Add(i.ToString());
            }
            for (int i = 2010; i >= 1900; i--)
            {
                ddlYear.Items.Add(i.ToString());
            }
            #endregion

            #region get value for user
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Select * from users where uid=@uid", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtUsername.Text = dr["username"].ToString();
                        txtName.Text = dr["name"].ToString();
                        txtEmail.Text = dr["email"].ToString();
                        txtCollege.Text = dr["college"].ToString();
                        ddlBranch.Text = dr["branch"].ToString();
                        ddlGender.Text = dr["gender"].ToString();
                        string dob = dr["dob"].ToString();
                        string[] dobSplit=new string[3];
                        dobSplit=dob.Split('-');
                        ddlDay.Text = dobSplit[0];
                        ddlMonth.Text = dobSplit[1];
                        ddlYear.Text = dobSplit[2];
                    }
                }
                con.Close();
            }
            catch (Exception e1)
            {
                ScriptManager.RegisterStartupScript(this,GetType(),"alert","alert('Error:"+e1.Message+"')",true);
            }
            #endregion
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        SqlConnection con = null;
        string existingImg="";
        
        #region Get existing image
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd2 = new SqlCommand("Select uimage from users where uid=@uid", con);
            cmd2.Parameters.AddWithValue("@uid", uid);
            con.Open();
            SqlDataReader dr = cmd2.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    existingImg = dr["uimage"].ToString();
                }
            }
            con.Close();
        }
        catch (Exception e2)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e2.Message + "')", true);
        }
        #endregion

        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Update users set name=@name,email=@email,dob=@dob,college=@college,branch=@branch,gender=@gender,uimage=@uimage where uid=@uid",con);
            cmd.Parameters.AddWithValue("@uid",uid);
            cmd.Parameters.AddWithValue("@name",txtName.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@dob", ddlDay.Text + "-" + ddlMonth.Text + "-" + ddlYear.Text);
            cmd.Parameters.AddWithValue("@college", txtCollege.Text);
            cmd.Parameters.AddWithValue("@branch", ddlBranch.Text);
            cmd.Parameters.AddWithValue("@gender", ddlGender.Text);
            if (fuImage.HasFile)
            {
                cmd.Parameters.AddWithValue("@uimage", fuImage.FileName);
            }
            else
            {
                cmd.Parameters.AddWithValue("@uimage", existingImg);
            }
            con.Open();
            cmd.ExecuteNonQuery();
            if (fuImage.HasFile)
            {
                fuImage.SaveAs(Server.MapPath("~/images/user_images/") + fuImage.FileName);
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Your profile has been updated.')", true);
            con.Close();
        }
        catch (Exception e1)
        {
            ScriptManager.RegisterStartupScript(this,GetType(),"alert","alert('Error:"+e1.Message+"')",true);
        }
    }
}