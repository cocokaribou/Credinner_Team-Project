package com.dc.Credinner.Service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

public class CommonService extends SqlSessionDaoSupport {	

	protected Log log = LogFactory.getLog(CommonService.class);
    
	//디버깅용 쿼리 아이디 출력
    protected String printQueryId(String queryId) {
        if(log.isDebugEnabled()){
            log.debug("\t QueryId  \t:  " + queryId);
        }
        
        return queryId;
    }
    
    //디버깅용 파라메터 출력
    protected HashMap printParam(HashMap params) {
        if(log.isDebugEnabled()){
        	log.debug("\t params Start  \t:  ");
        	for(int k =0 ; k < params.keySet().size(); k++)
        	{
        		String key = params.keySet().toArray()[k].toString();
        		String value = params.values().toArray()[k].toString();
        		log.debug("\t " + key + " \t:  " + value);
        	}
        	log.debug("\t params End  \t:  ");
        }
        
        return params;
    }
     
    //insert 공통 함수
    protected int insert(String queryId, HashMap params) {
        printQueryId(queryId);        
        printParam(params);
        return getSqlSession().insert(queryId, params);
    }
     
    //update 공통 함수
    protected int update(String queryId, HashMap params){
        printQueryId(queryId);
        printParam(params);
        return getSqlSession().update(queryId, params);
    }
     
    //delete 공통 함수
    protected int delete(String queryId, HashMap params){
        printQueryId(queryId);
        printParam(params);
        return getSqlSession().delete(queryId, params);
    }
     
    //select 1 row 공통 함수
    protected HashMap selectOne(String queryId, HashMap params){
        printQueryId(queryId);
        printParam(params);
        return getSqlSession().selectOne(queryId, params);
    }
    
    //select 1 row 공통 함수
    protected HashMap selectOne(String queryId){
        printQueryId(queryId);
        return getSqlSession().selectOne(queryId);
    }   
     
    //select 공통 함수
    @SuppressWarnings("rawtypes")
    protected List<HashMap> selectList(String queryId, HashMap params){
        printQueryId(queryId);
        printParam(params);
        return getSqlSession().selectList(queryId,params);
    }
    
    //select 공통 함수
    @SuppressWarnings("rawtypes")
    protected List<HashMap> selectList(String queryId){
        printQueryId(queryId);
        return getSqlSession().selectList(queryId);
    }   
   
}
