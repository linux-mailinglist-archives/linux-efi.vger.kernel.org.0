Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51C8FDE07
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKOMhK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 07:37:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:7244 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfKOMhJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Nov 2019 07:37:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="214772131"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2019 04:37:07 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iVaqZ-0004vT-8A; Fri, 15 Nov 2019 14:37:07 +0200
Date:   Fri, 15 Nov 2019 14:37:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-efi@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v2] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191115123707.GU32742@smile.fi.intel.com>
References: <20191112161240.4734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112161240.4734-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 12, 2019 at 06:12:40PM +0200, Andy Shevchenko wrote:
> When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> into generic earlycon implementation") moved x86 specific EFI earlyprintk
> implementation to shared location it also tweaked the behaviour. In particular
> it dropped a trick with full framebuffer remapping after page initialization.
> This led to two regressions:
> 1) very slow scrolling after page initialization;
> 2) kernel hang when keep_bootcon parameter is being provided.
> 
> Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> operations per each pixel line on the screen.

Please, hold on. I found an issue when no earlycon is not being provided in command line.
I will fix, test and send a v3 soon.

> 
> Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2:
> - add __exitcall()
> - swap type and attribute for __init / __exit functions as most used in the kernel
>  drivers/firmware/efi/earlycon.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index c9a0efca17b0..8c6a3c67b7f2 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -17,14 +17,48 @@ static const struct font_desc *font;
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
> +static int __init early_efi_map_fb(void)
> +{
> +	u32 size;
> +
> +	size = screen_info.lfb_size;
> +	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> +		efi_fb = memremap(fb_base, size, MEMREMAP_WB);
> +	else
> +		efi_fb = memremap(fb_base, size, MEMREMAP_WC);
> +
> +	return efi_fb ? 0 : -ENOMEM;
> +}
> +early_initcall(early_efi_map_fb);
> +
> +static void __exit early_efi_unmap_fb(void)
> +{
> +	memunmap(efi_fb);
> +}
> +__exitcall(early_efi_unmap_fb);
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
> -- 
> 2.24.0
> 

-- 
With Best Regards,
Andy Shevchenko


