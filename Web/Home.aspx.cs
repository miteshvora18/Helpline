using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Home : System.Web.UI.Page
{
    string conn = System.Configuration.ConfigurationManager.ConnectionStrings["HelplineConnectionString"].ConnectionString;
    private int uid
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
            return "~/Home.aspx?uid=" + uid;
        }
    }
    protected string profileUrl
    {
        get
        {
            return "~/EditProfile.aspx?uid=" + uid.ToString();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (uid == 0)
        {
            Response.Redirect("Login.aspx?msg=invalid");
        }

        if (!IsPostBack)
        {
            DataBind();
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                #region Set name and image of user
                    SqlCommand cmd = new SqlCommand("Select name,uimage from users where uid=@uid",con);
                    cmd.Parameters.AddWithValue("@uid",uid);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            lblName.Text = dr[0].ToString();
                            imgUser.ImageUrl = "~/images/user_images/" + dr[1].ToString();
                        }
                    }
                #endregion
                con.Close();

                #region Get status of all users
                    SqlCommand cmd2 = new SqlCommand("Select ustatus,ustatustime,uimage,name from users where ustatus not in('') order by ustatustime desc", con);
                    con.Open();
                    SqlDataReader dr2 = cmd2.ExecuteReader();
                    gvStatus.DataSource = dr2;
                    gvStatus.DataBind();
                #endregion
                con.Close();

                #region Chat user grid view
                    Chat();
                #endregion

                #region Unread Message
                    UnreadList();
                #endregion
            }
            catch (Exception e1)
            {
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('"+e1.Message+"')", true);
            }
        }
    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (txtPost.Text != "")
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Update users set ustatus=@status,ustatustime=@time where uid=@uid", con);
                cmd.Parameters.AddWithValue("@status", txtPost.Text);
                cmd.Parameters.AddWithValue("@time", DateTime.Now);
                cmd.Parameters.AddWithValue("@uid", uid);
                con.Open();
                cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Your status has been updated successfully.')", true);
                txtPost.Text = "";
                Update();
                con.Close();
            }
            catch (Exception e1)
            {
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('" + e1.Message + "')", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Status cannot be empty')", true);
        }
    }
    protected void gvStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string name = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "uimage"));
        Image img = (Image)e.Row.FindControl("imgUserStatus");
        if (img == null)
        {
            return;
        }
        else
        {
            img.ImageUrl = "~/images/user_images/"+name;
        }
    }

    protected void gvChat_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string chatImage = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "uimage"));
        Image img = (Image)e.Row.FindControl("imgChatUser");
        if (img == null)
        {
            return;
        }
        else
        {
            img.ImageUrl = "~/images/user_images/" + chatImage;
        }

        int onlineImage = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "uonline"));
        Image img2 = (Image)e.Row.FindControl("imgUserOnline");
        if (onlineImage == 0)
        {
            img2.ImageUrl = "~/images/user-offline.png";
        }
        else
        {
            img2.ImageUrl = "~/images/Online-Icon.png";
        }

        HyperLink hl = (HyperLink)e.Row.FindControl("hyName");
        hl.NavigateUrl = "Message.aspx?uid=" + uid + "&touid=" + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "uid"));

    }

    protected void Update()
    {
        SqlConnection con = new SqlConnection(conn);
        SqlCommand cmd2 = new SqlCommand("Select ustatus,ustatustime,uimage,name from users where ustatus not in('') order by ustatustime desc", con);
        con.Open();
        SqlDataReader dr2 = cmd2.ExecuteReader();
        gvStatus.DataSource = dr2;
        gvStatus.DataBind();
    }

    public void Chat()
    {
        SqlConnection con = new SqlConnection(conn);
        SqlCommand cmd3 = new SqlCommand("Select uimage,name,uonline,uid from users where uid not in(@uid) order by name", con);
        cmd3.Parameters.AddWithValue("@uid", uid);
        con.Open();
        SqlDataReader dr3 = cmd3.ExecuteReader();
        gvChat.DataSource = dr3;
        gvChat.DataBind();
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        Update();
    }
    protected void Timer2_Tick(object sender, EventArgs e)
    {
        Chat();
    }
    protected void Timer3_Tick(object sender, EventArgs e)
    {
        UnreadList();
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Update users set uonline=@uonline where uid=@uid", con);
            cmd.Parameters.AddWithValue("@uonline", 0);
            cmd.Parameters.AddWithValue("@uid", uid);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception e1)
        {
            ScriptManager.RegisterStartupScript(this,GetType(),"alert","alert('Error:"+e1.Message+"')",true);
        }
        Response.Redirect("~/Login.aspx?msg=logout");
    }
    protected void UnreadList()
    {
        lblUnreadMsg.Text = "";
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("select count(content),fromuser from communication where unread=1 and toUser=@uid group by fromuser", con);
            cmd.Parameters.AddWithValue("@uid",uid);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string count=dr[0].ToString();
                    string sentUser=dr[1].ToString();
                    SqlConnection con2 = new SqlConnection(conn);
                    con2.Open();
                    SqlCommand cmd2 = new SqlCommand("Select name from users where uid=@uid",con2);
                    cmd2.Parameters.AddWithValue("@uid",sentUser);
                    SqlDataReader dr2 = cmd2.ExecuteReader();
                    if(dr2.HasRows)
                    {
                        while (dr2.Read())
                        {
                            lblUnreadMsg.Text += "<span class='notify'><a href='Message.aspx?uid=" + uid + "&touid=" + sentUser + "'>You have " + count + " unread message(s) from " + dr2[0].ToString() + "</a><br/>";
                        }
                    }
                }
            }
        }
        catch (Exception e1)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
        }
    }
}