package com.lzh.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.GoodsDao;
import com.lzh.dao.UpperTagMapper;
import com.lzh.dao.UserDao;
import com.lzh.entity.Goods;
import com.lzh.entity.UpperTag;
import com.lzh.service.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService {

	@Resource
	UpperTagMapper upperTagMapper;
	@Resource
	GoodsDao goodsDao;
	
	@Override
	public List<UpperTag> getAllUpperTags() {
		// TODO Auto-generated method stub
		return upperTagMapper.getAllTags();
	}

	
	@Override
	public void saveGoods(Goods goods) {
		// TODO Auto-generated method stub
		goodsDao.saveGoods(goods);
	}


	@Override
	public List<Goods> getGoodsByName(String goodsname, Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return goodsDao.getGoodsByName(goodsname, start, pageSize);
	}


	@Override
	public List<Goods> getGoodsByNameInUpper(String goodsname, String uppertag, Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return goodsDao.getGoodsByNameInUpper(goodsname, uppertag, start, pageSize);
	}


	@Override
	public List<Goods> getGoodsByNameInMiddle(String goodsname, String middletag, Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return goodsDao.getGoodsByNameInMiddle(goodsname, middletag, start, pageSize);
	}


	@Override
	public List<Goods> getGoodsByNameInLower(String goodsname, String lowertag, Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return goodsDao.getGoodsByNameInLower(goodsname, lowertag, start, pageSize);
	}


	@Override
	public void updateGoods(Goods goods) {
		// TODO Auto-generated method stub
		goodsDao.updateGoods(goods);
	}


	@Override
	public void delGoodsById(Integer id) {
		// TODO Auto-generated method stub
		goodsDao.delGoodsById(id);
	}


	@Override
	public void setHot(boolean hot, Integer id) {
		// TODO Auto-generated method stub
		goodsDao.setHot(hot, id);
	}


	@Override
	public void setSpecial(boolean special, Integer id) {
		// TODO Auto-generated method stub
		goodsDao.setSpecial(special, id);
	}


	@Override
	public Integer getTotalCount(String goodsname) {
		// TODO Auto-generated method stub
		return goodsDao.getTotalCount(goodsname);
	}


	@Override
	public Integer getTotalCountInUpper(String goodsname, String uppertag) {
		// TODO Auto-generated method stub
		return goodsDao.getTotalCountInUpper(goodsname, uppertag);
	}


	@Override
	public Integer getTotalCountInMiddle(String goodsname, String middletag) {
		// TODO Auto-generated method stub
		return goodsDao.getTotalCountInMiddle(goodsname, middletag);
	}


	@Override
	public Integer getTotalCountInLower(String goodsname, String lowertag) {
		// TODO Auto-generated method stub
		return goodsDao.getTotalCountInLower(goodsname, lowertag);
	}


	@Override
	public List<Goods> getHotGoodsByNameRandomly(String goodsname) {
		// TODO Auto-generated method stub
		return goodsDao.getHotGoodsByNameRandomly(goodsname);
	}


	@Override
	public Goods getGoodsById(Integer id) {
		// TODO Auto-generated method stub
		return goodsDao.getGoodsById(id);
	}


	@Override
	public List<Goods> getHotGoodsRandomly() {
		// TODO Auto-generated method stub
		return goodsDao.getHotGoodsRandomly();
	}


	@Override
	public List<Goods> getSpecialGoodsRandomly() {
		// TODO Auto-generated method stub
		return goodsDao.getSpecialGoodsRandomly();
	}

	
	
}
