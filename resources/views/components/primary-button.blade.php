<button {{ $attributes->merge(['type' => 'submit', 'class' => 'inline-flex items-center px-4 py-2 bg-green-200 text-black border border-transparent rounded-md font-semibold text-xs uppercase tracking-widest hover:bg-green-300 focus:bg-green-300 active:bg-green-400 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition ease-in-out duration-150']) }}>
    {{ $slot }}
</button>
