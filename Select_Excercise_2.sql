use Ecommerce_DB;
-- 1. Danh sách các khách hàng đã mua hàng (đã có hóa đơn)
select distinct c.ciD, c.cName, c.cAge
from customer c join orders o on c.cId = o.cID;
-- 2. Danh sách các sản phẩm đã được mua
select distinct p.pid, p.pname,p.pprice
from product p join orderDetail od on p.pId = od.pId;
-- 3. Hiển thị danh sách các khách hàng chưa mua hàng
-- Sử dụng câu lệnh truy vấn lồng: kết quả của câu truy vấn này là đầu vào của câu lệnh truy vấn khác
select *
from customer cu
where cu.cid not in(
select distinct c.ciD
from customer c join orders o on c.cId = o.cID);
-- 4. Hiển thị mã hóa đơn, ngày bán và giá tiền của từng loại hóa đơn
select o.oid, o.odate, sum(od.odQTY*p.pprice) as 'totalAmount'
from orders o join orderDetail od on o.oid = od.oid
	join product p on od.pid = p.pid
group by o.oid;
