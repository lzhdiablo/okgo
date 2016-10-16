package com.lzh.dao;

import java.util.List;

import com.lzh.entity.Goods;

public interface GoodsDao {

	void saveGoods(Goods goods);

	List<Goods> getGoodsByName(String goodsname, Integer start, Integer pageSize);

	List<Goods> getGoodsByNameInUpper(String goodsname, String uppertag, Integer start, Integer pageSize);

	List<Goods> getGoodsByNameInMiddle(String goodsname, String middletag, Integer start, Integer pageSize);

	List<Goods> getGoodsByNameInLower(String goodsname, String lowertag, Integer start, Integer pageSize);

	void updateGoods(Goods goods);

	void delGoodsById(Integer id);

	void setHot(boolean hot, Integer id);

	void setSpecial(boolean special, Integer id);

	Integer getTotalCount(String goodsname);

	Integer getTotalCountInUpper(String goodsname, String uppertag);

	Integer getTotalCountInMiddle(String goodsname, String middletag);

	Integer getTotalCountInLower(String goodsname, String lowertag);

	List<Goods> getHotGoodsByNameRandomly(String goodsname);

	Goods getGoodsById(Integer id);

	List<Goods> getHotGoodsRandomly();

	List<Goods> getSpecialGoodsRandomly();

}
