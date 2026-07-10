/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  // Enable container optimization settings
  poweredByHeader: false,
  images: {
    domains: ['assets.sws.internal'],
    formats: ['image/avif', 'image/webp'],
  },
};

module.exports = nextConfig;
