namespace ApplicationCore.Contracts;

public interface IRepository<T> where T:class
{
    int Insert(T entity);
    int Update(T entity, int id);
    int Delete(int id);
    IEnumerable<T> GetAll();
    T GetById(int id);
    IEnumerable<T> Search(Func<T, bool> predicate);
}