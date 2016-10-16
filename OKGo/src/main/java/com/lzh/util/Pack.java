package com.lzh.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;

import com.lzh.entity.Goods;
import com.lzh.service.PackService;


public class Pack {
	
	private String uppertag;
	private String middletag;
	private String lowertag;
	
	@Resource
	PackService packService;
	private FileItem file;
	private String filename;
	private String filepath;
	
	
	public Goods packGoods(HttpServletRequest request) {
		// TODO Auto-generated method stub
		Goods goods = new Goods();
		
		
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("utf-8");
		List<FileItem> items = new ArrayList<>();
		try {
			
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Iterator<FileItem> it = items.iterator();
		while (it.hasNext()) {
			FileItem fileItem = (FileItem) it.next();
			//文件域
			if (! fileItem.isFormField()) {
				file = fileItem;
				filename = fileItem.getName();
			}
			//表单域
			if (fileItem.isFormField()) {
				try {
					switch (fileItem.getFieldName()) {
					case "fullname":
						//mutipart/form-data会将中文字符转换成ASII HEX值，因此要先转成字节再编码
						goods.setFullname(new String(fileItem.get(), "utf-8")); 
						break;
					case "price":
						goods.setPrice(Integer.parseInt(new String(fileItem.get(), "utf-8")));
						break;
					case "stock":
						goods.setStock(Integer.parseInt(new String(fileItem.get(), "utf-8")));
						break;
					case "uppertag":
						uppertag = new String(fileItem.get(), "utf-8");
						goods.setUpperTag(uppertag);
						break;
					case "middletag":
						middletag = new String(fileItem.get(), "utf-8");
						goods.setMiddlTag(middletag);
						break;
					case "lowertag":
						lowertag = new String(fileItem.get(), "utf-8");
						goods.setLowerTag(lowertag);
						break;
					case "id":
						String id = new String(fileItem.get(), "utf-8");
						goods.setId(Integer.parseInt(id));
						break;
					default:
						break;
					}
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		Integer uppertagid = packService.getUpperTagByName(uppertag).getId();
		Integer middletagid = packService.getMiddleTagByName(middletag).getId();
		Integer lowertagid = packService.getLowerTagByName(lowertag).getId();
		filepath = "C:\\Users\\lzhnice\\Desktop\\WebPro\\OKGo\\src\\main\\webapp\\image\\products\\" + uppertagid + "\\" + middletagid + "\\" +lowertagid + "\\" + filename;
		File saveUpload = new File(filepath);
		try {
			file.write(saveUpload);
		} catch (Exception e) {
			// TODO Auto-generated catch block
		}
		goods.setImage(StringUtils.substringAfter(filepath, "webapp\\"));
		
		return goods;
	}
}
