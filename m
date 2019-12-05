Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9B11475E
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfLES4e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 13:56:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:18412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbfLES4e (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Dec 2019 13:56:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 10:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="386274423"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2019 10:56:32 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1icwIi-000422-AC; Thu, 05 Dec 2019 20:56:32 +0200
Date:   Thu, 5 Dec 2019 20:56:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH v4] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191205185632.GA32742@smile.fi.intel.com>
References: <20191205164248.14511-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205164248.14511-1-ardb@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 05, 2019 at 04:42:48PM +0000, Ard Biesheuvel wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> When commit 69c1f396f25b
> 
>   "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"
> 
> moved the x86 specific EFI earlyprintk implementation to a shared location,
> it also tweaked the behaviour. In particular, it dropped a trick with full
> framebuffer remapping after page initialization, leading to two regressions:
> 1) very slow scrolling after page initialization,
> 2) kernel hang when the 'keep_bootcon' command line argument is passed.
> 
> Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
> behavior to the early boot stages, presumably due to eliminating heavy
> map()/unmap() operations per each pixel line on the screen.
> 
> Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> [ardb: ensure efifb is unmapped again unless keep_bootcon is in effect]
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/earlycon.c | 40 +++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index c9a0efca17b0..0bc4fe741415 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -13,18 +13,57 @@
>  
>  #include <asm/early_ioremap.h>
>  
> +static const struct console *earlycon_console __initdata;
>  static const struct font_desc *font;
>  static u32 efi_x, efi_y;
>  static u64 fb_base;
>  static pgprot_t fb_prot;
> +static void *efi_fb;
> +
> +/*
> + * efi earlycon needs to use early_memremap() to map the framebuffer.
> + * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
> + * memremap() should be used instead. memremap() will be available after
> + * paging_init() which is earlier than initcall callbacks. Thus adding this
> + * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
> + */
> +static int __init efi_earlycon_remap_fb(void)
> +{
> +	/* bail if there is no bootconsole or it has been disabled already */
> +	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> +		return 0;
> +
> +	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> +		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> +	else
> +		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> +
> +	return efi_fb ? 0 : -ENOMEM;
> +}
> +early_initcall(efi_earlycon_remap_fb);
> +
> +static int __init efi_earlycon_unmap_fb(void)
> +{
> +	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */

> +	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))

Isn't efi_fb test superfluous here?

> +		memunmap(efi_fb);

> +	return 0;
> +}
> +late_initcall(efi_earlycon_unmap_fb);

I still think we need __exitcall() to clean up the stuff in any case.

>  
>  static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
>  {
> +	if (efi_fb)
> +		return efi_fb + start;
> +
>  	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
>  }
>  
>  static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
>  {
> +	if (efi_fb)
> +		return;
> +
>  	early_memunmap(addr, len);
>  }
>  
> @@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
>  		efi_earlycon_scroll_up();
>  
>  	device->con->write = efi_earlycon_write;
> +	earlycon_console = device->con;
>  	return 0;
>  }
>  EARLYCON_DECLARE(efifb, efi_earlycon_setup);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


