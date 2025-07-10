package com.example;

import com.google.gson.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.*;
import java.util.*;

public class BeritaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String kategori = request.getParameter("kategori");
        if (kategori == null || kategori.isEmpty()) {
            kategori = "politik";
        }

        String apiUrl = "https://api-berita-indonesia.vercel.app/antara/" + kategori;
        List<NewsItem> beritaList = new ArrayList<>();

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            JsonObject json = JsonParser.parseReader(reader).getAsJsonObject();
            JsonArray items = json.getAsJsonObject("data").getAsJsonArray("posts");

            for (JsonElement item : items) {
                JsonObject obj = item.getAsJsonObject();
                NewsItem berita = new NewsItem();
                berita.title = obj.get("title").getAsString();
                berita.link = obj.get("link").getAsString();
                berita.pubDate = obj.get("pubDate").getAsString();
                berita.description = obj.get("description").getAsString();
                berita.thumbnail = obj.get("thumbnail").getAsString();
                beritaList.add(berita);
            }

            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("beritaList", beritaList);
        request.setAttribute("kategoriAktif", kategori);
        request.getRequestDispatcher("/berita.jsp").forward(request, response);
    }
}
