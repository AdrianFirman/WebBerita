<%@ page contentType="text/html;charset=UTF-8" %>
    <html>

    <head>
        <title>Berita Indonesia</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f3f4f6;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #1f2937;
                margin-bottom: 10px;
            }

            form {
                text-align: center;
                margin-bottom: 30px;
            }

            label {
                font-size: 1.1em;
                margin-right: 10px;
            }

            select {
                font-size: 1em;
                padding: 6px 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                outline: none;
                transition: border-color 0.3s;
            }

            select:hover,
            select:focus {
                border-color: #6366f1;
            }

            .berita {
                display: flex;
                align-items: flex-start;
                background: #ffffff;
                padding: 15px;
                margin: 10px auto;
                max-width: 900px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .berita:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.12);
            }

            .berita img {
                width: 200px;
                height: auto;
                border-radius: 8px;
                margin-right: 20px;
                object-fit: cover;
            }

            .berita-content {
                flex: 1;
            }

            .berita-content h3 {
                margin: 0 0 5px 0;
                font-size: 1.3em;
            }

            .berita-content h3 a {
                text-decoration: none;
                color: #1d4ed8;
            }

            .berita-content h3 a:hover {
                text-decoration: underline;
            }

            .berita-content small {
                color: #6b7280;
                font-size: 0.9em;
            }

            .berita-content p {
                margin-top: 8px;
                color: #374151;
                font-size: 1em;
            }
        </style>
    </head>

    <body>
        <h1>Berita Indonesia</h1>

        <form method="get" action="berita">
            <label for="kategori">Pilih Kategori:</label>
            <select name="kategori" id="kategori" onchange="this.form.submit()">
                <% String[] paths={ "terbaru" , "politik" , "hukum" , "ekonomi" , "bola" , "olahraga" , "humaniora"
                    , "lifestyle" , "hiburan" , "dunia" , "tekno" , "otomotif" }; String kategoriAktif=(String)
                    request.getAttribute("kategoriAktif"); for (String path : paths) { %>
                    <option value="<%= path %>" <%=path.equals(kategoriAktif) ? "selected" : "" %>>
                        <%= path.substring(0, 1).toUpperCase() + path.substring(1) %>
                    </option>
                    <% } %>
            </select>
        </form>

        <% java.util.List<com.example.NewsItem> beritaList =
            (java.util.List<com.example.NewsItem>) request.getAttribute("beritaList");
                if (beritaList != null && !beritaList.isEmpty()) {
                for (com.example.NewsItem berita : beritaList) {
                %>
                <div class="berita">
                    <img src="<%= berita.thumbnail %>" alt="thumbnail" />
                    <div class="berita-content">
                        <h3><a href="<%= berita.link %>" target="_blank">
                                <%= berita.title %>
                            </a></h3>
                        <small>
                            <%= berita.pubDate %>
                        </small>
                        <p>
                            <%= berita.description %>
                        </p>
                    </div>
                </div>
                <% } } else { %>
                    <p style="text-align:center; color: gray;">Tidak ada berita untuk kategori ini.</p>
                    <% } %>
    </body>

    </html>