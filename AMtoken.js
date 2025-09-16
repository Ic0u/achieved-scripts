(() => {
  const appleMusicRed = "#fc3c44";
  const darkBg = "#2f3136";
  const lightGray = "#aaa";
  
  // Get all relevant Apple Music cookies
  const cookies = document.cookie.split("; ").reduce((acc, cookie) => {
    const [key, ...valueParts] = cookie.split("=");
    const value = valueParts.join("="); // Handle tokens with "=" characters
    if (key && key.includes("media") || key.includes("music") || key.includes("apple")) {
      acc[key] = decodeURIComponent(value);
    }
    return acc;
  }, {});
  
  const mediaUserToken = cookies["media-user-token"];
  
  if (!mediaUserToken) {
    console.log(
      "%cKhông tìm thấy media-user-token cookie!",
      `color: orange; font-weight: bold; font-size: 14px;`
    );
    return;
  }
  
  // Main output
  console.log(
    `%cApple Music Token gaysex`,
    `background: linear-gradient(135deg, ${appleMusicRed} 0%, #ff4757 50%, #c44569 100%); 
     color: white; 
     font-weight: bold; 
     font-size: 18px; 
     padding: 12px 20px; 
     border-radius: 12px; 
     text-shadow: 2px 2px 4px rgba(0,0,0,0.4);
     border: 1px solid rgba(255,255,255,0.2);
     box-shadow: 0 4px 15px rgba(252, 60, 68, 0.3);`
  );
  
  console.group("%cFull Token", `color: ${appleMusicRed}; font-weight: 700; font-size: 14px; text-shadow: 1px 1px 2px rgba(0,0,0,0.3);`);
  console.log(
    `%c${mediaUserToken}`,
    `background: linear-gradient(135deg, #1e1e1e 0%, #2d2d2d 50%, #1a1a1a 100%); 
     color: #00ff88; 
     font-family: 'Consolas', 'Monaco', 'Courier New', monospace; 
     font-size: 12px; 
     font-weight: 500;
     padding: 16px; 
     border: 2px solid ${appleMusicRed}; 
     border-radius: 10px; 
     word-break: break-all;
     line-height: 1.5;
     box-shadow: inset 0 2px 8px rgba(0,0,0,0.4), 0 4px 20px rgba(252, 60, 68, 0.25);
     text-shadow: 0 0 10px rgba(0, 255, 136, 0.3);`
  );
  console.groupEnd();
  
  // Additional cookies if found
  const otherCookies = Object.entries(cookies).filter(([key]) => key !== "media-user-token");
  if (otherCookies.length > 0) {
    console.group("%cOther Apple/Media Cookies", `color: #ff9500; font-size: 13px; font-weight: 600;`);
    otherCookies.forEach(([key, value]) => {
      const preview = value.length > 50 ? value.substring(0, 50) + "..." : value;
      console.log(
        `%c${key}:%c ${preview}`, 
        `color: #ff9500; font-weight: 600; font-family: 'Consolas', monospace; text-shadow: 0 0 5px rgba(255, 149, 0, 0.3);`, 
        `color: #b3b3b3; font-family: 'Consolas', monospace;`
      );
    });
    console.groupEnd();
  }
  
  console.log(
    `%c\n💝 Made with love by Marcus Nguyen | Enhanced Edition ✨`,
    `color: ${lightGray}; 
     font-style: italic; 
     font-size: 12px;
     text-align: center;
     opacity: 0.8;
     text-shadow: 0 1px 2px rgba(0,0,0,0.2);`
  );
  
  // Helper functions
  function getTokenExpiry(token) {
    try {
      // Basic token validation (this is simplified)
      if (token.length < 100) return { status: "Token seems too short" };
      if (!token.includes("eyJ")) return { status: "Valid format" };
      return { status: "Active" };
    } catch {
      return { status: "Invalid" };
    }
  }
  
  // Global utility functions
  window.copyAMToken = () => {
    navigator.clipboard.writeText(mediaUserToken).then(() => {
      console.log("%cToken copied to clipboard!", `color: #00ff88; font-weight: bold;`);
    }).catch(() => {
      console.log("%cFailed to copy to clipboard", `color: red;`);
    });
  };
  
  window.validateAMToken = async () => {
    console.log("%cTesting token...", `color: yellow;`);
    try {
      const response = await fetch("https://api.music.apple.com/v1/me/storefront", {
        headers: {
          "Authorization": `Bearer ${mediaUserToken}`,
          "Music-User-Token": mediaUserToken
        }
      });
      
      if (response.ok) {
        const data = await response.json();
        console.log("%cToken is valid!", `color: #00ff88; font-weight: bold;`);
        console.log("Storefront:", data.data[0].id);
      } else {
        console.log("%cToken validation failed", `color: red; font-weight: bold;`);
      }
    } catch (error) {
      console.log("%cNetwork error during validation", `color: red;`);
    }
  };
  
  window.clearAMCookies = () => {
    Object.keys(cookies).forEach(cookieName => {
      document.cookie = `${cookieName}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;`;
    });
    console.log("%cApple Music cookies cleared!", `color: orange; font-weight: bold;`);
  };
  
})();
