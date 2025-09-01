import { fetchFilteredCustomers } from "@/app/lib/data";
import Image from "next/image";
import { lusitana } from "@/app/ui/fonts";
import Search from "@/app/ui/search"; 

export default async function CustomersPage({
  searchParams,
}: {
  searchParams: Promise<{ query?: string }>;
}) {
  const params = await searchParams;
  const search = params.query || "";
  const customers = await fetchFilteredCustomers(search);

  return (
    <div className="p-6">
      <h1 className={`${lusitana.className} text-2xl`}>Customers</h1>

      {/* Search bar */}
      <div className="mt-4 flex items-center justify-between gap-2">
        <Search placeholder="Search customers..." />
      </div>

      {/* Tabel */}
      <div className="mt-6 overflow-x-auto">
        <table className="min-w-full border-collapse rounded-lg overflow-hidden shadow">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-2 text-left">Name</th>
              <th className="px-4 py-2 text-left">Email</th>
              <th className="px-4 py-2">Total Invoices</th>
              <th className="px-4 py-2">Total Pending</th>
              <th className="px-4 py-2">Total Paid</th>
            </tr>
          </thead>
          <tbody className="divide-y bg-white">
            {customers.length > 0 ? (
              customers.map((cust) => (
                <tr key={cust.id}>
                  <td className="flex items-center gap-2 px-4 py-2">
                    <Image
                      src={cust.image_url}
                      alt={cust.name}
                      width={32}
                      height={32}
                      className="rounded-full"
                    />
                    {cust.name}
                  </td>
                  <td className="px-4 py-2">{cust.email}</td>
                  <td className="px-4 py-2 text-center">
                    {cust.total_invoices}
                  </td>
                  <td className="px-4 py-2 text-red-500">
                    {cust.total_pending}
                  </td>
                  <td className="px-4 py-2 text-green-600">
                    {cust.total_paid}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={5} className="text-center py-6 text-gray-500">
                  No customers found
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
