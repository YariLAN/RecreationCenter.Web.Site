<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Relax.Web.Site.Admin1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style13 {
            text-align: center;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            line-height: 1.6;
        }

        .container {
            width: 90%;
            margin: auto;
            max-width: 1200px;
            padding: 0 20px;
        }

        .hero {
            text-align: center;
            padding: 40px 20px;

            color: white;
            border-radius: 0 0 15px 15px;
        }

        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .hero img {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .hero img:hover {
            transform: scale(1.01);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p class="auto-style13">
        Welcome, Админ.
    </p>
    <div class="hero container">
        <img style="border: 4px solid #555;" src="img/pS4xsG6oG9XspMFEzt39KQ.jpg" alt="Фото базы отдыха">
    </div>
</asp:Content>
