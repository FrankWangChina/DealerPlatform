using DealerPlatform.Entity;
using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Repository
{
    //T:BaseEntity  只有继承了 BaseEntity 的类才能被传入 T
    public interface IRepository<T> where T:BaseEntity
    {
        T GetById(int Id);
        IEnumerable<T> GetListAll();
        IEnumerable<T> GetListByCustom(string propName, string propValue, bool isContains = true);
        IEnumerable<T> GetListByCustoms(Dictionary<string, ListByCustomsEntity> keyValuePairs);
        IEnumerable<T> GetListByCustoms(Dictionary<string, string> keyValuePairs);
        IEnumerable<T> GetListByCustomWhereIn(string propsName, params string[] propValues);
        int Insert(T t);
        object InsertBackResult(T t);
        int Update(T t);
        int Delete(int Id);
        int Delete(T t);
        int DeleteByCustomer(string propName, string propVal);

    }
}
