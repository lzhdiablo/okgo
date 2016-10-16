package com.lzh.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lzh.entity.Goods;
import com.lzh.entity.LowerTag;
import com.lzh.entity.MiddleTag;
import com.lzh.entity.UpperTag;
import com.lzh.entity.User;
import com.lzh.service.GoodsService;
import com.lzh.util.Pack;

@Controller
@RequestMapping("/goodsManage")
public class GoodsManageController {
	
	@Resource
	GoodsService goodsService;
	@Resource
	Pack pack;
	
	private List<UpperTag> upperTags;
	private List<MiddleTag> middleTags;
	private List<LowerTag> lowerTags;
	private ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping("/getUppertags.do")
	public void getUpperTags(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8"); 
		upperTags = goodsService.getAllUpperTags();
		 try {
			mapper.writeValue(response.getWriter(), upperTags);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/getMiddleTags.do")
	public void getMiddleTags(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		String uppertag = request.getParameter("uppertag");
		for (UpperTag upperTag2 : upperTags) {
			if (upperTag2.getTagName().equals(uppertag)) {
				middleTags = upperTag2.getMiddleTags();
			}
		}
		 try {
			mapper.writeValue(response.getWriter(), middleTags);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/getLowerTags.do")
	public void getLowerTags(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		String middletag = request.getParameter("middletag");
		for (MiddleTag middleTag2 : middleTags) {
			if (middleTag2.getTagName().equals(middletag)) {
				lowerTags = middleTag2.getLowerTags();
			}
		}
		 try {
			mapper.writeValue(response.getWriter(), lowerTags);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/addGoods.do")
	public void addGoods(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		
		Goods goods = pack.packGoods(request);
		goodsService.saveGoods(goods);
	}
	
	@RequestMapping("/delGoods.do")
	public void delGoods(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		Integer id = Integer.parseInt(request.getParameter("id"));
		goodsService.delGoodsById(id);
	}
	@RequestMapping("/editGoods.do")
	public void editGoods(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		
		Goods goods = pack.packGoods(request);
		goodsService.updateGoods(goods);
	}
	@RequestMapping("/setHot.do")
	public void setHot(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		boolean hot;
		Integer id = Integer.parseInt(request.getParameter("id"));
		if (request.getParameter("hot").equals("true")) {
			hot = false;
		}
		else {
			hot = true;
		}
		goodsService.setHot(hot, id);
	}
	@RequestMapping("/setSpecial.do")
	public void setSpecial(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		boolean special;
		Integer id = Integer.parseInt(request.getParameter("id"));
		if (request.getParameter("special").equals("true")) {
			special = false;
		}
		else {
			special = true;
		}
		goodsService.setSpecial(special, id);
	}
	@RequestMapping("/selectGoods.do")
	public void selectGoods(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setContentType("text/html; charset=utf-8");
		String goodsname = request.getParameter("goodsname");
		String uppertag = request.getParameter("uppertag");
		String middletag = request.getParameter("middletag");
		String lowertag = request.getParameter("lowertag");
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		Integer pageSize = Integer.parseInt(request.getParameter("rows"));
		Integer start = (currentPage - 1)*pageSize;
		Integer total = null;
		List<Goods> goods = new ArrayList<>();
		
		if (goodsname != null) {
			if ("".equals(lowertag)) {
				if ("".equals(middletag)) {
					if ("".equals(uppertag)) {
						total = goodsService.getTotalCount(goodsname);
						goods = goodsService.getGoodsByName(goodsname, start, pageSize);
					}
					else {
						total = goodsService.getTotalCountInUpper(goodsname, uppertag);
						goods = goodsService.getGoodsByNameInUpper(goodsname, uppertag, start, pageSize);
					}
				}
				else {
					total = goodsService.getTotalCountInMiddle(goodsname, middletag);
					goods = goodsService.getGoodsByNameInMiddle(goodsname, middletag, start, pageSize);
				}
			}
			else {
				total = goodsService.getTotalCountInLower(goodsname, lowertag);
				goods = goodsService.getGoodsByNameInLower(goodsname, lowertag, start, pageSize);
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", goods);
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.writeValue(response.getWriter(), map);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
