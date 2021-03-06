﻿using Helpline_MVC_Project.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace Helpline_MVC_Project.BLL
{
    public class BusinessLayer
    {
        string conn = System.Configuration.ConfigurationManager.ConnectionStrings["HelplineConnectionString"].ConnectionString;

        public string LoginMethod(string username, string password, out bool success)
        {
            success = false;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Select uid from users where username=@user and pass=@pass", con);
                cmd.Parameters.AddWithValue("@user", username);
                cmd.Parameters.AddWithValue("@pass", password);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        HttpContext.Current.Session["uid"] = dr[0].ToString();
                        string uid = dr[0].ToString();
                        con.Close();
                        SqlCommand cmd2 = new SqlCommand("Update users set uonline=@uonline where uid=@uid", con);
                        cmd2.Parameters.AddWithValue("@uonline", 1);
                        cmd2.Parameters.AddWithValue("@uid", uid);
                        con.Open();
                        cmd2.ExecuteNonQuery();
                        success = true;
                        return HttpContext.Current.Session["uid"].ToString();
                        //Response.Redirect("Home.aspx?uid=" + uid);
                    }
                    return "0";
                }
                else
                {
                    //txtUsername.Text = txtPassword.Text = "";
                    return "Invalid Username and/or Password";
                    //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Invalid Username and/or Password')", true);
                }
            }
            catch (Exception e1)
            {
                //txtUsername.Text = txtPassword.Text = "";
                return "Error Occured. Please contact admin";
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('" + e1.Message + "')", true);
            }
        }

        public string RegisterMethod(UserDetailsAll user, out bool success)
        {
            success = false;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Select username from users where username=@user", con);
                cmd.Parameters.AddWithValue("@user", user.Username);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    con.Close();
                    return "Username exists..try different one";
                    //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Username exists..try different one')", true);
                }
                else
                {
                    con.Close();
                    if (user.Image.ContentLength > 0)
                    {
                        SqlCommand cmd2 = new SqlCommand("insert into users values(@name,@email,@dob,@college,@branch,@gender,@username,@pass,@image,@status,@statustime,@online)", con);
                        cmd2.Parameters.AddWithValue("@name", user.Name);
                        cmd2.Parameters.AddWithValue("@email", user.Email);
                        //cmd2.Parameters.AddWithValue("@dob", ddlDay.Text + "-" + ddlMonth.Text + "-" + ddlYear.Text);
                        cmd2.Parameters.AddWithValue("@dob", user.DOB);
                        cmd2.Parameters.AddWithValue("@college", user.College);
                        cmd2.Parameters.AddWithValue("@branch", user.Branch);
                        cmd2.Parameters.AddWithValue("@gender", user.Gender);
                        cmd2.Parameters.AddWithValue("@username", user.Username);
                        cmd2.Parameters.AddWithValue("@pass", user.Password);
                        cmd2.Parameters.AddWithValue("@image", user.Image.FileName);
                        cmd2.Parameters.AddWithValue("@status", "");
                        cmd2.Parameters.AddWithValue("@statustime", "");
                        cmd2.Parameters.AddWithValue("@online", false);
                        con.Open();
                        cmd2.ExecuteNonQuery();
                        //string filename = Path.GetFileName(fuImage.FileName);
                        user.Image.SaveAs(HttpContext.Current.Server.MapPath("~/images/user_images/") + user.Image.FileName);
                        //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You have successfully registered')", true);
                        //txtCollege.Text = txtConfPass.Text = txtEmail.Text = txtName.Text = txtPass.Text = txtUsername.Text = "";
                        //ddlBranch.SelectedIndex = ddlDay.SelectedIndex = ddlGender.SelectedIndex = ddlMonth.SelectedIndex = ddlYear.SelectedIndex = 0;
                        con.Close();
                        success = true;
                        return "You have successfully registered!!!";
                    }
                    else
                    {
                        con.Close();
                        return "Upload your image  to register";
                        //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Upload your image  to register')", true);
                    }
                }

            }
            catch (Exception e1)
            {
                return "Some Error Occurred. Please contact Admin";
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
        }

        public UserDetailsAll GetUserDetails(int uid, out bool success)
        {
            success = false;
            UserDetailsAll ud = new UserDetailsAll();
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
                        ud.Username = dr["username"].ToString();
                        ud.Name = dr["name"].ToString();
                        ud.Email = dr["email"].ToString();
                        ud.College = dr["college"].ToString();
                        ud.Branch = dr["branch"].ToString();
                        ud.Gender = dr["gender"].ToString();
                        ud.DOB = dr["dob"].ToString();
                        success = true;
                    }
                }
                con.Close();
            }
            catch (Exception e1)
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
            return ud;
        }

        public string GetUserImage(int uid, out bool success)
        {
            string ImageUrl = string.Empty;
            success = false;
            //UserDetailsAll ud = new UserDetailsAll();
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Select name,uimage from users where uid=@uid", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //ud.Name = dr["name"].ToString();
                        ImageUrl = "~/images/user_images/" + dr["uimage"].ToString();
                        success = true;
                    }
                }
                con.Close();
            }
            catch (Exception e1)
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
            return ImageUrl;
        }

        public string UpdateUserDetails(UserDetailsAll ud, string uid, out bool success)
        {
            success = false;
            SqlConnection con = null;
            string existingImg = "";

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
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e2.Message + "')", true);
            }
            #endregion

            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Update users set name=@name,email=@email,dob=@dob,college=@college,branch=@branch,gender=@gender,uimage=@uimage where uid=@uid", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@name", ud.Name);
                cmd.Parameters.AddWithValue("@email", ud.Email);
                cmd.Parameters.AddWithValue("@dob", ud.DOB);
                cmd.Parameters.AddWithValue("@college", ud.College);
                cmd.Parameters.AddWithValue("@branch", ud.Branch);
                cmd.Parameters.AddWithValue("@gender", ud.Gender);
                if (ud.Image != null)
                {
                    cmd.Parameters.AddWithValue("@uimage", ud.Image.FileName);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@uimage", existingImg);
                }
                con.Open();
                cmd.ExecuteNonQuery();

                if (ud.Image != null)
                {
                    ud.Image.SaveAs(HttpContext.Current.Server.MapPath("~/images/user_images/") + ud.Image.FileName);
                }
                con.Close();
                success = true;
                return "Your profile has been updated.";
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Your profile has been updated.')", true);

            }
            catch (Exception e1)
            {
                return "Error occured.";
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
        }

        public string UnreadList(string uid, out bool success)
        {
            success = false;
            string UnreadMsg = "";
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("select count(content),fromuser from communication where unread=1 and toUser=@uid group by fromuser", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string count = dr[0].ToString();
                        string sentUser = dr[1].ToString();
                        SqlConnection con2 = new SqlConnection(conn);
                        con2.Open();
                        SqlCommand cmd2 = new SqlCommand("Select name from users where uid=@uid", con2);
                        cmd2.Parameters.AddWithValue("@uid", sentUser);
                        SqlDataReader dr2 = cmd2.ExecuteReader();
                        if (dr2.HasRows)
                        {
                            while (dr2.Read())
                            {
                                UnreadMsg += "<span class='notify'><a href='/Home/Message?uid=" + uid + "&touid=" + sentUser + "'>You have " + count + " unread message(s) from " + dr2[0].ToString() + "</a><br/>";
                            }
                        }
                        con2.Close();
                    }
                }
                con.Close();
                success = true;
                return UnreadMsg;
            }
            catch (Exception e1)
            {
                return "Error occured while fecthing unread message.";
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
        }

        public string UpdateStatus(string txtPost, string uid, out bool success)
        {
            success = false;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Update users set ustatus=@status,ustatustime=@time where uid=@uid", con);
                cmd.Parameters.AddWithValue("@status", txtPost);
                cmd.Parameters.AddWithValue("@time", DateTime.Now);
                cmd.Parameters.AddWithValue("@uid", uid);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                success = true;
                return "Your status has been updated successfully.";
            }
            catch (Exception e1)
            {
                con.Close();
                return "Error occured while updating status.";
            }
        }

        public string RefreshStatus(out bool success)
        {
            success = false;
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd2 = new SqlCommand("Select ustatus,ustatustime,uimage,name from users where ustatus not in('') order by ustatustime desc", con);
            con.Open();
            SqlDataReader dr2 = cmd2.ExecuteReader();
            if (dr2.HasRows)
            {
                success = true;
                string result = ToJson(dr2);
                con.Close();
                return result;
            }
            con.Close();
            return "{\"data\":\"No Data Found\"}";
        }

        public string ChatGrid(string uid, out bool success)
        {
            success = false;
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd3 = new SqlCommand("Select uimage,name,uonline,uid from users where uid not in(@uid) order by name", con);
            cmd3.Parameters.AddWithValue("@uid", uid);
            con.Open();
            SqlDataReader dr3 = cmd3.ExecuteReader();
            if (dr3.HasRows)
            {
                success = true;
                string result = ToJson(dr3);
                con.Close();
                return result;
            }
            con.Close();
            return "{\"data\":\"No Data Found\"}";
        }

        private static string ToJson(SqlDataReader rdr)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);

            using (JsonWriter jsonWriter = new JsonTextWriter(sw))
            {
                jsonWriter.WriteStartArray();

                while (rdr.Read())
                {
                    jsonWriter.WriteStartObject();

                    int fields = rdr.FieldCount;

                    for (int i = 0; i < fields; i++)
                    {
                        jsonWriter.WritePropertyName(rdr.GetName(i));
                        jsonWriter.WriteValue(rdr[i]);
                    }

                    jsonWriter.WriteEndObject();
                }

                jsonWriter.WriteEndArray();

                return sw.ToString();
            }
        }

        public void LogOut(string uid, out bool success)
        {
            success = false;
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
                success = true;
            }
            catch (Exception e1)
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
            //Response.Redirect("~/Login.aspx?msg=logout");
        }

        //Message Actions
        public void ReadMsg(int uid, int touid, out bool success)
        {
            success = false;
            string lblPrevMsg = string.Empty;
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Update communication set unread=0 where fromUser=@touid and toUser=@uid", con);
                cmd.Parameters.AddWithValue("@touid", touid);
                cmd.Parameters.AddWithValue("@uid", uid);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                success = true;
            }
            catch (Exception e1)
            {
                con.Close();
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error:" + e1.Message + "')", true);
            }
        }

        public string Send(int uid, int touid, string message, out bool success)
        {
            success = false;
            string lblPrevMsg = "";
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(conn);
                SqlCommand cmd = new SqlCommand("Insert into communication values(@uid,@touid,@content,@unread,@time)", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@touid", touid);
                cmd.Parameters.AddWithValue("@content", message);
                cmd.Parameters.AddWithValue("@unread", 1);
                cmd.Parameters.AddWithValue("@time", DateTime.Now);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                success = true;
            }
            catch (Exception e1)
            {
                con.Close();
                lblPrevMsg = "Error occured on page";
            }
            return lblPrevMsg;
        }

        public string Update(int uid, int touid, out bool success)
        {
            success = false;
            string lblPrevMsg = string.Empty;
            SqlConnection con = null;
            try
            {
                lblPrevMsg = "";
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
                            lblPrevMsg += "<div style='text-align:left;padding-left:20%;color:orange;font-size:large'>(" + dr[3].ToString() + ") " + "You : " + "<span style='color:black'>" + dr[2].ToString() + "</span></div><br/>";
                            //DateTime.ParseExact(dr[3].ToString(), "dd-MM-yyyy tt h:m:s", System.Globalization.CultureInfo.InvariantCulture,System.Globalization.DateTimeStyles.AdjustToUniversal).ToString("MMM. dd yyyy hh:mm tt")
                        }
                        else
                        {
                            lblPrevMsg += "<div style='text-align:right;padding-left:20%;padding-right:20%;color:#808080;font-size:large'>(" + dr[3].ToString() + ") " + dr[4].ToString() + " : <span style='color:black'>" + dr[2].ToString() + "</span></div><br/>";
                            //DateTime.ParseExact(dr[3].ToString(), "dd-MM-yyyy tt h:m:s", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.AdjustToUniversal).ToString("MMM. dd yyyy hh:mm tt")
                        }
                    }
                }
                con.Close();
                success = true;
            }
            catch (Exception e1)
            {
                lblPrevMsg = "Error occured while updating data";
                con.Close();
                //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('" + e1.Message + "')", true);
            }
            return lblPrevMsg;
        }
    }        
}