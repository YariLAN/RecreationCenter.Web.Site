<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="Cinema.Web.Site.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>База отдыха</title>
        <style>
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

        .news {
            padding: 40px 0;
        }

        .news h2 {
            color: #2d5f2d;
            font-size: 2rem;
            margin-bottom: 30px;
            position: relative;
            display: inline-block;
        }

        .news h2:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background-color: #2d5f2d;
        }

        .news-item {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 10px;
            border-left: 10px solid #2d5f2d;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            text-align: left;
        }

        .news-item h1 {
            color: white;
        }

        .news-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        .news-item h3 {
            color: #2d5f2d;
            margin: 0 0 10px 0;
            font-size: 1.3rem;
        }

        .news-item p {
            font-size: 1rem;
            color: #666;
            margin: 0;
            line-height: 1.6;
        }

        .map {
            padding: 20px 0;
        }

        .map h2 {
            color: #2d5f2d;
            margin-bottom: 30px;
            font-size: 2rem;
        }

        iframe {
            width: 100%;
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 0 10px;
            }

            .hero h1 {
                font-size: 2rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .news-item {
                padding: 15px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="hero container">
        <h1>Добро пожаловать на базу отдыха "Лесное озеро"</h1>
        <p>Идеальное место для отдыха и уединения на природе.</p>
        <img style="border: 4px solid #555;" src="img/pS4xsG6oG9XspMFEzt39KQ.jpg" alt="Фото базы отдыха">
    </div>

    <div class="news container" style="text-align: center;">
        <h2>Новости и события</h2>

        <div class="news-item">
            <h3 style="background: white;">Новогодние скидки на аренду коттеджей!</h3>
            <p style="background: white;">Только до 15 января – скидки до 20% на аренду всех коттеджей.</p>
        </div>

        <div class="news-item">
            <h3 style="background: white;">Открытие нового коттеджа у озера</h3>
            <p style="background: white;">Добавлен новый комфортабельный коттедж с видом на озеро.</p>
        </div>

        <div class="news-item">
            <h3 style="background: white;">Рыбалка теперь доступна круглый год!</h3>
            <p style="background: white;">Мы оборудовали зимнюю зону для комфортной рыбалки.</p>
        </div>
    </div>

    <div class="map container">
        <h2>Как нас найти</h2>
        <iframe style="border: 4px solid #555;" src="https://yandex.ru/map-widget/v1/?um=constructor%3A30b913de03bf06ba336a480aa170db4b55b060be3332a747a82b4d6da0c51c32&amp;source=constructor" width="1087" height="720" frameborder="0"></iframe>
    </div>

</asp:Content>
