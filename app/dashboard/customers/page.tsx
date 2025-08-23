import { fetchFilteredCustomers } from "@/app/lib/data";
import Image from "next/image";

export default async function CustomersPage({
  searchParams,
}: {
  searchParams?: {
    search?: string;
  };
}) {
  const search = searchParams?.search || "";
  const customers = await fetchFilteredCustomers(search);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-semibold">Pelanggan</h1>
      <h1 className="text-2xl font-semibold">Customers</h1>
      {/* Form pencarian */}
      <form className="mt-4">
        <input
          type="text"
          name="search"
          defaultValue={search}
          placeholder="🔍 Search customers..."
          className="w-full rounded-md border px-4 py-2 focus:outline-none focus:ring focus:ring-blue-300"
        />
      </form>

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
            {customers.length ? (
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