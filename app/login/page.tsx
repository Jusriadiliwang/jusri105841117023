import AcmeLogo from '@/app/ui/acme-logo';
import LoginForm from '@/app/ui/login-form';
import { Suspense } from 'react';

// Anda bisa membuat fallback yang lebih bagus, tapi tulisan sederhana sudah cukup
function LoginFormFallback() {
  return (
    <>
      <div className="h-8 w-full animate-pulse rounded-md bg-gray-200" />
      <div className="h-8 w-full animate-pulse rounded-md bg-gray-200" />
      <div className="mt-4 h-10 w-full animate-pulse rounded-md bg-gray-200" />
    </>
  );
}

export default function LoginPage() {
  return (
    <main className="flex items-center justify-center md:h-screen">
      <div className="relative mx-auto flex w-full max-w-[400px] flex-col space-y-2.5 p-4 md:-mt-32">
        <div className="flex h-20 w-full items-end rounded-lg bg-blue-500 p-3 md:h-36">
          <div className="w-32 text-white md:w-36">
            <AcmeLogo />
          </div>
        </div>
        
        {/* Tambahkan prop fallback di sini */}
        <Suspense fallback={<LoginFormFallback />}>
          <LoginForm />
        </Suspense>

      </div>
    </main>
  );
}