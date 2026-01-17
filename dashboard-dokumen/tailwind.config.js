/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./index.html",
        "./src/**/*.{vue,js,ts,jsx,tsx}",
    ],
    darkMode: 'class',
    theme: {
        extend: {
            colors: {
                primary: {
                    DEFAULT: '#667eea',
                    dark: '#5568d3',
                    light: '#7c8ef5',
                },
                secondary: '#764ba2',
                accent: '#f093fb',
            },
            backgroundImage: {
                'gradient-primary': 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                'gradient-success': 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
                'gradient-warning': 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
                'gradient-info': 'linear-gradient(135deg, #3b82f6 0%, #2563eb 100%)',
                'gradient-purple': 'linear-gradient(135deg, #a78bfa 0%, #7c3aed 100%)',
                'gradient-blue': 'linear-gradient(135deg, #60a5fa 0%, #3b82f6 100%)',
                'gradient-green': 'linear-gradient(135deg, #34d399 0%, #10b981 100%)',
                'gradient-orange': 'linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%)',
            },
            boxShadow: {
                'glow': '0 0 20px rgba(102, 126, 234, 0.3)',
            },
            fontFamily: {
                sans: ['Inter', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'sans-serif'],
            },
            animation: {
                'fade-in': 'fadeIn 0.3s ease-out',
                'slide-in-right': 'slideInRight 0.25s ease-out',
            },
            keyframes: {
                fadeIn: {
                    from: {
                        opacity: '0',
                        transform: 'translateY(10px)',
                    },
                    to: {
                        opacity: '1',
                        transform: 'translateY(0)',
                    },
                },
                slideInRight: {
                    from: {
                        opacity: '0',
                        transform: 'translateX(20px)',
                    },
                    to: {
                        opacity: '1',
                        transform: 'translateX(0)',
                    },
                },
            },
        },
    },
    plugins: [],
}
