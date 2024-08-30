export default function HomePage() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100">
      <header className="w-full py-6 bg-blue-600 dark:bg-blue-800">
        <h1 className="text-4xl font-bold text-center">
          Welcome to Your Next.js Boilerplate!
        </h1>
      </header>
      <main className="flex-grow flex flex-col items-center justify-center p-4">
        <h2 className="text-2xl mb-4">
          Get started by editing{" "}
          <code className="bg-gray-200 dark:bg-gray-700 p-1 rounded">
            src/pages/index.js
          </code>
        </h2>
        <p className="text-center">
          This is your starting point for building a Next.js application with
          Tailwind CSS.
        </p>
      </main>
      <footer className="w-full py-4 bg-blue-600 dark:bg-blue-800 text-center">
        <p>Powered by Next.js & Tailwind CSS</p>
      </footer>
    </div>
  );
}
