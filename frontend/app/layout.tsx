import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "News Analyzer",
  description: "AI-powered news analysis tool",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ru">
      <body className="antialiased">
        {children}
      </body>
    </html>
  );
}
