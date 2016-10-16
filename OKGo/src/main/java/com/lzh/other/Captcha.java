package com.lzh.other;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Captcha
 */
public class Captcha extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Captcha() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		
		//����image���趨���ߡ�ͼƬ����
		int width = 150;
		int height = 50;	
		BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);	
		
		//��ȡGraphic���󣬲���ͼƬ
		Graphics2D g2 = bi.createGraphics();	
		//���ñ�����ɫ
		g2.setColor(Color.white);	
		g2.fillRect(0, 0, width, height);
		//���ú�ɫ�߿�
		g2.setColor(Color.BLACK);	
		g2.drawRect(0, 0, width-1, height-1);
		//�����������
		String str = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String[] source = str.split("");
		Random random = new Random();
		char[] group = new char[4];
		for (int i = 0; i < group.length; i++) {
			group[i] = source[random.nextInt(62)].charAt(0);
		}
		//������ַ�д��ͼƬ��
		g2.setColor(Color.blue);
		g2.setFont(new Font(str, 2, 30));
		g2.drawChars(group, 0, 4, 40, 40);
		//�������ŵ�
		for (int i = 0; i < 500; i++) {
			g2.drawRoundRect(random.nextInt(150), random.nextInt(50), 0, 0, 0, 0);
		}
		
		ImageIO.write(bi, "jpeg", response.getOutputStream());	//ImageIOר���������ͼƬ
		
		//������֤���ַ�����session
		String checkKey = String.valueOf(group);
		session.setAttribute("checkKey", checkKey);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
