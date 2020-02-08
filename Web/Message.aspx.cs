using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Message : System.Web.UI.Page
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
            return"~/Home.aspx?uid=" + uid.ToString();
        }
    }
    protected string profileUrl
    {
        get
        {
            return "~/EditProfile.aspx?uid=" + uid.ToString();
        }
    }
    private int touid
    {
        get
        {
            if (Request.QueryString["touid"] != null)
            {
                return Convert.ToInt32(Request.QueryString["touid"]);
            }
            else
            {
                return 0;
            }
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
            Update();
            DataBind();
            //Make messages as read
            ReadMsg();
        }
    }
    protected void btnSend_Click(object sender, EventArgs e)
    {
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Insert into communication values(@uid,@touid,@content,@unread,@time)",con);
            cmd.Parameters.AddWithValue("@uid",uid);
            cmd.Parameters.AddWithValue("@touid", touid);
            cmd.Parameters.AddWithValue("@content", txtSend.Text);
            cmd.Parameters.AddWithValue("@unread", 1);
            cmd.Parameters.AddWithValue("@time", DateTime.Now);
            con.Open();
            cmd.ExecuteNonQuery();
            Update();
            txtSend.Text = "";
            con.Close();
        }
        catch (Exception e1)
        {
            con.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('" + e1.Message + "')", true);
        }
    }

    private void Update()
    {
        SqlConnection con = null;
        try
        {
            lblPrevMsg.Text = "";
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Select fromuser,touser,content,ctime,name from communication c join users u on u.uid=c.fromuser  where (fromuser=@uid and toUser=@touid) or (fromuser=@touid and toUser=@uid) order by ctime desc", con);
            cmd.Parameters.AddWithValue("@uid", uid);
            cmd.Parameters.AddWithValue("@touid", touid);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    if (Convert.ToInt32(dr[0].ToString()) == uid)
                    {
                        lblPrevMsg.Text += "<div style='text-align:left;padding-left:20%;color:orange;font-size:large'>(" + dr[3].ToString() + ") " + "You : " + "<span style='color:black'>" + dr[2].ToString() + "</span></div><br/>";
                        //DateTime.ParseExact(dr[3].ToString(), "dd-MM-yyyy tt h:m:s", System.Globalization.CultureInfo.InvariantCulture,System.Globalization.DateTimeStyles.AdjustToUniversal).ToString("MMM. dd yyyy hh:mm tt")
                    }
                    else
                    {
                        lblPrevMsg.Text += "<div style='text-align:right;padding-left:20%;padding-right:20%;color:#808080;font-size:large'>(" + dr[3].ToString() + ") " + dr[4].ToString() + " : <span style='color:black'>" + dr[2].ToString() + "</span></div><br/>";
                        //DateTime.ParseExact(dr[3].ToString(), "dd-MM-yyyy tt h:m:s", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.AdjustToUniversal).ToString("MMM. dd yyyy hh:mm tt")
                    }
                }
            }
            con.Close();
        }
        catch (Exception e1)
        {
            con.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('" + e1.Message + "')", true);
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        Update();
        ReadMsg();
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
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
        }
        Response.Redirect("~/Login.aspx?msg=logout");
    }

    protected void ReadMsg()
    {
        SqlConnection con = null;
        try
        {
            con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Update communication set unread=0 where fromUser=@touid and toUser=@uid",con);
            cmd.Parameters.AddWithValue("@touid",touid);
            cmd.Parameters.AddWithValue("@uid",uid);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception e1)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
        }
    }
}