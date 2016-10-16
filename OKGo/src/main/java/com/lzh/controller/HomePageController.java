package com.lzh.controller;


import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lzh.entity.Address;
import com.lzh.entity.Goods;
import com.lzh.entity.Inventory;
import com.lzh.entity.PurchaseUnit;
import com.lzh.entity.UpperTag;
import com.lzh.entity.User;
import com.lzh.service.AddressService;
import com.lzh.service.GoodsService;
import com.lzh.service.HomePageService;
import com.lzh.service.InventoryService;
import com.lzh.service.PurchaseUnitService;



@Controller
@RequestMapping("/main")
public class HomePageController {
	
	private List<UpperTag> upperTags = null;
	
	@Resource
	HomePageService homePageService;
	@Resource
	GoodsService goodsService;
	@Resource
	InventoryService inventoryService;
	@Resource
	PurchaseUnitService purchaseUnitService;
	@Resource
	AddressService addressService;
	
	@RequestMapping("/homePage.do")
	public void buidHomePage(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		upperTags = homePageService.getAllTags();
		request.setAttribute("upperTags", upperTags);
		List<Integer> history =  (List<Integer>) session.getAttribute("history");
		List<Goods> hotGoods = goodsService.getHotGoodsByNameRandomly("");
		List<Goods> specialGoods = goodsService.getSpecialGoodsRandomly();
		request.setAttribute("specialGoods", specialGoods);
		request.setAttribute("hotGoods", hotGoods);
		if (history != null) {
			List<Goods> historyList = new ArrayList<>();
			for (Integer id : history) {
				Goods goods = goodsService.getGoodsById(id);
				historyList.add(goods);
			}
			request.setAttribute("historyList", historyList);
		}
		try {
			request.getRequestDispatcher("/jsp/main/homePage.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(path = "/homePage.do", params = "method=getTags")
	public void jump(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=utf-8");
		if (request.getParameter("uppertagid") != null){
			Integer uppertagid = Integer.parseInt(request.getParameter("uppertagid"));
			ObjectMapper mapper = new ObjectMapper();
			mapper.writeValue(response.getWriter(), upperTags.get(uppertagid - 1).getMiddleTags());
		}
	} 
	
	@RequestMapping(path = "/showGoods.do")
	public void showGoods(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=utf-8");
		String lowertag = request.getParameter("lowertag");
		String goodsname = "";
		Integer pageSize = 30;
		Integer currentPage = 1;
		if (request.getParameter("currentPage") != null & !"".equals(request.getParameter("currentPage"))) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		Integer start = (currentPage - 1) * pageSize;
		Integer total = goodsService.getTotalCountInLower(goodsname, lowertag);
		List<Goods> goodsList = goodsService.getGoodsByNameInLower(goodsname, lowertag, start, pageSize);
		List<Goods> hotGoods = goodsService.getHotGoodsByNameRandomly(lowertag);
		Integer pageNum = (int) Math.ceil(Double.valueOf(total)/Double.valueOf(pageSize));
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("currentPage", currentPage);
		resultMap.put("total", total);
		resultMap.put("pageNum", pageNum);
		resultMap.put("goodsList", goodsList);
		resultMap.put("hotGoods", hotGoods);
		request.setAttribute("resultMap", resultMap);
		request.getRequestDispatcher("/jsp/main/goodsPage.jsp").forward(request, response);
	} 
	
	@RequestMapping("/goodsDetail.do")
	public void goodsDetail(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=utf-8");
		if (request.getParameter("id") != null) {
			Integer id = Integer.parseInt(request.getParameter("id"));
			List<Integer> history = (List<Integer>) session.getAttribute("history");
			if (history == null) {
				history = new ArrayList<>();
			}
			if (!history.contains(id)) {
				while (history.size()>= 4) {
					history.remove(0);
				}
				history.add(id);
			}
			session.setAttribute("history", history);
			Goods goods = goodsService.getGoodsById(id);
			request.setAttribute("goods", goods);
			request.getRequestDispatcher("/jsp/main/goodsDetail.jsp").forward(request, response);
		}
	} 
	
	@RequestMapping("/buyNow.do")
	public void buyNow(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String , Object> purchaseConfirm = null;
		purchaseConfirm = new HashMap<>();
		if (request.getParameter("goodsid") != null & request.getParameter("amount") != null) {
			Integer goodsid = Integer.parseInt(request.getParameter("goodsid"));
			Integer amount = Integer.parseInt(request.getParameter("amount"));
			Goods goods = goodsService.getGoodsById(goodsid);
			List<Goods> goodsList = new ArrayList<>();
			goodsList.add(goods);
			purchaseConfirm.put("goodsList", goodsList);
			
			PurchaseUnit purchaseUnit = new PurchaseUnit();
			purchaseUnit.setGoodsid(goodsid);
			purchaseUnit.setAmount(amount);
			purchaseUnit.setTotalprice(goods.getPrice() * amount);
			List<PurchaseUnit> purchaseUnits = new ArrayList<>();
			purchaseUnits.add(purchaseUnit);
			purchaseConfirm.put("purchaseUnits", purchaseUnits);
			
			
			session.setAttribute("purchaseConfirm", purchaseConfirm);
			
			
			User user = (User) session.getAttribute("user");
			if (user == null) {
				request.setAttribute("target", "/OKGo/main/buyNow.do");
				request.getRequestDispatcher("/jsp/user/userLogIn.jsp").forward(request, response);
			}
			else {
				Integer userid = user.getId();
				List<Address> addresses = addressService.getAddressesByUserId(userid);
				request.setAttribute("addresses", addresses);
				request.getRequestDispatcher("/jsp/main/balance.jsp").forward(request, response);
			}
		}
		else if (session.getAttribute("purchaseConfirm") != null) {
			User user = (User)session.getAttribute("user");
			Integer userid = user.getId();
			List<Address> addresses = addressService.getAddressesByUserId(userid);
			request.setAttribute("addresses", addresses);
			request.getRequestDispatcher("/jsp/main/balance.jsp").forward(request, response);
		}
		
	} 
	@RequestMapping("/createOrder.do")
	public void createOrder(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setCharacterEncoding("utf-8");
		if (request.getParameter("totalprice") != null && request.getParameter("addressid") != null) {
			Integer totalPrice = Integer.parseInt(request.getParameter("totalprice"));
			Integer addressid = Integer.parseInt(request.getParameter("addressid"));
			
			User user = (User) session.getAttribute("user");
			Inventory inventory = new Inventory();
			Map<String , Object> purchaseConfirm = (HashMap<String, Object>) session.getAttribute("purchaseConfirm");
			if (purchaseConfirm != null) {
				List<PurchaseUnit> purchaseUnits = (List<PurchaseUnit>) purchaseConfirm.get("purchaseUnits");
				
				DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				java.util.Date date = new java.util.Date();
				String inventoryid = df.format(date);
				
				inventory.setId(inventoryid);
				inventory.setAddressid(addressid);
				inventory.setCreatedTime(Calendar.getInstance().getTime());
				inventory.setUserid(user.getId());
				inventory.setStatus("待审核");
				inventory.setTotalPrice(totalPrice);
				inventoryService.save(inventory);
				
				for (PurchaseUnit purchaseUnit : purchaseUnits) {
					purchaseUnit.setInventoryid(inventoryid);
					purchaseUnitService.save(purchaseUnit);
				}
				session.removeAttribute("purchaseConfirm");
				session.removeAttribute("shoppingCart");
			}
			else {
				response.getWriter().println("重复提交了！点击确认返回主页");
			}
		}
	} 
	@RequestMapping("/addToCart.do")
	public void addToCart(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		if (request.getParameter("goodsid") != null & request.getParameter("amount") != null) {
			Integer goodsid = Integer.parseInt(request.getParameter("goodsid"));
			Integer amount = Integer.parseInt(request.getParameter("amount"));
			PurchaseUnit purchaseUnit = new PurchaseUnit();
			purchaseUnit.setAmount(amount);
			purchaseUnit.setGoodsid(goodsid);
			if (session.getAttribute("shoppingCart") == null) {
				List<PurchaseUnit> purchaseUnits = new ArrayList<>();
				session.setAttribute("shoppingCart", purchaseUnits);
			}
			List<PurchaseUnit> purchaseUnits = (List<PurchaseUnit>) session.getAttribute("shoppingCart");
			List<Goods> hotGoods = goodsService.getHotGoodsRandomly();
			for (PurchaseUnit purchaseUnit2 : purchaseUnits) {
				if (purchaseUnit2.getGoodsid().equals(goodsid)){
					purchaseUnit2.setAmount(purchaseUnit2.getAmount() + amount);
					session.setAttribute("shoppingCart", purchaseUnits);
					request.setAttribute("hotGoods", hotGoods);
					request.getRequestDispatcher("/jsp/main/addToCart.jsp").forward(request, response);
					return;
				}
			}
			purchaseUnits.add(purchaseUnit);
			session.setAttribute("shoppingCart", purchaseUnits);
			request.setAttribute("hotGoods", hotGoods);
			request.getRequestDispatcher("/jsp/main/addToCart.jsp").forward(request, response);
		}
	} 
	@RequestMapping("/delFromCart.do")
	public void delFromCart(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		if (request.getParameter("goodsid") != null) {
			Integer goodsid = Integer.parseInt(request.getParameter("goodsid"));
			List<PurchaseUnit> purchaseUnits = (List<PurchaseUnit>) session.getAttribute("shoppingCart");
			int delIndex = 0;
			for (int i = 0; i < purchaseUnits.size(); i++) {
				if (purchaseUnits.get(i).getGoodsid().equals(goodsid)) {
					delIndex = i;
				}
			}
			purchaseUnits.remove(delIndex);
			session.setAttribute("shoppingCart", purchaseUnits);
		}
	} 
	
	@RequestMapping("/getCartContent.do")
	public void getCartContent(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setCharacterEncoding("utf-8");
		String requestMethod = request.getParameter("method");
		Map<String, Object> showCartMap = new HashMap<>();
		List<PurchaseUnit> purchaseUnits = (List<PurchaseUnit>) session.getAttribute("shoppingCart");
		if (purchaseUnits != null) {
			
			List<Goods> goodsList = new ArrayList<>();
			for (PurchaseUnit purchaseUnit : purchaseUnits) {
				Goods goods = goodsService.getGoodsById(purchaseUnit.getGoodsid());
				goodsList.add(goods);
			}
			if (requestMethod != null && "noajax".equals(requestMethod)) {
				request.setAttribute("goodsList", goodsList);
				request.setAttribute("purchaseUnits", purchaseUnits);
				request.getRequestDispatcher("/jsp/main/showCart.jsp").forward(request, response);
			}
			else {
				showCartMap.put("goodsList", goodsList);
				showCartMap.put("purchaseUnits", purchaseUnits);
				ObjectMapper mapper = new ObjectMapper();
				mapper.writeValue(response.getWriter(), showCartMap);
			}
		}
		else {
			request.getRequestDispatcher("/jsp/main/showCart.jsp").forward(request, response);
		}
	} 
	@RequestMapping("/changeGoodsAmount.do")
	public void changeGoodsAmount(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		if (request.getParameter("goodsid") != null && request.getParameter("amount") != null) {
			Integer goodsid = Integer.parseInt(request.getParameter("goodsid"));
			Integer amount = Integer.parseInt(request.getParameter("amount"));
			List<PurchaseUnit> purchaseUnits = (List<PurchaseUnit>) session.getAttribute("shoppingCart");
			for (PurchaseUnit purchaseUnit : purchaseUnits) {
				if (goodsid.equals(purchaseUnit.getGoodsid())) {
					purchaseUnit.setAmount(amount);
					session.setAttribute("shoppingCart", purchaseUnits);
					return;
				}
			} 
		}
	} 
	@RequestMapping("/cartToBalance.do")
	public void cartToBalance(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		User user = (User) session.getAttribute("user");
		if (user == null) {
			request.setAttribute("target", "/OKGo/main/cartToBalance.do");
			request.getRequestDispatcher("/jsp/user/userLogIn.jsp").forward(request, response);
		}
		else {
			Map<String , Object> purchaseConfirm = null;
			purchaseConfirm = new HashMap<>();
			List<PurchaseUnit> purchaseUnits = (List<PurchaseUnit>) session.getAttribute("shoppingCart");
			List<Goods> goodsList = new ArrayList<>();
			for (PurchaseUnit purchaseUnit : purchaseUnits) {
				Goods goods = goodsService.getGoodsById(purchaseUnit.getGoodsid());
				purchaseUnit.setTotalprice(purchaseUnit.getAmount() * goods.getPrice());
				goodsList.add(goods);
			}
			purchaseConfirm.put("goodsList", goodsList);
			purchaseConfirm.put("purchaseUnits", purchaseUnits);
			
			Integer userid = user.getId();
			List<Address> addresses = addressService.getAddressesByUserId(userid);
			request.setAttribute("addresses", addresses);
			session.setAttribute("purchaseConfirm", purchaseConfirm);
			request.getRequestDispatcher("/jsp/main/balance.jsp").forward(request, response);
		}
	} 
	@RequestMapping("/search.do")
	public void search(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=utf-8");
		String keyword = request.getParameter("keyword");
		Integer pageSize = 30;
		Integer currentPage = 1;
		if (request.getParameter("currentPage") != null & !"".equals(request.getParameter("currentPage"))) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		Integer start = (currentPage - 1) * pageSize;
		Integer total = goodsService.getTotalCount(keyword);
		List<Goods> goodsList = goodsService.getGoodsByName(keyword, start, pageSize);
		
		List<Goods> hotGoods = goodsService.getHotGoodsByNameRandomly(keyword);
		Integer pageNum = (int) Math.ceil(Double.valueOf(total)/Double.valueOf(pageSize));
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("currentPage", currentPage);
		resultMap.put("total", total);
		resultMap.put("pageNum", pageNum);
		resultMap.put("goodsList", goodsList);
		resultMap.put("hotGoods", hotGoods);
		request.setAttribute("resultMap", resultMap);
		request.getRequestDispatcher("/jsp/main/goodsPage.jsp").forward(request, response);
		
	} 
	
}
