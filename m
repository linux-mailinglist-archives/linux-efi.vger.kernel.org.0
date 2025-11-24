Return-Path: <linux-efi+bounces-5660-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8BC7FA45
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24D244E47A7
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58652F533E;
	Mon, 24 Nov 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NghiHQ1X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6622F5A33
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976541; cv=none; b=HcnlZCChmSXdGmLeZMzfeULmFToYW7XQgmFezhBXp0wY8Au+ayEmTbOneuhFvWyplcrrqwuB8DXiWDdbLFjMV6Uy9JqQeMkFEcNLcLap1OZnlJILKPSWZxxpoulJTrOhe+wU/Ybeemra8NGpsH8uPh/N1H+qW2HwNNBareBXLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976541; c=relaxed/simple;
	bh=PUxuEYfHaMXKyRQa8nksQ38OVmVCrv/2GMdnL6jPYFU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GySAlG101kaDmV44t669gtcRRWWj7iKbequHpkuGH93jZKfsHiH5dtG9j8sOGRMQZZmZiJNliNA8vhDsk8YwIOO7tffEibKJSzuq4I/cFF5A1KutAbNVFFiLfzuS+5B4lJy6ggaKn3PugSV+ubVd72Bvi+gIgwBKEDAMV7gxDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NghiHQ1X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so35944145e9.2
        for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763976536; x=1764581336; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSUd6Iu5swY1yI3rOZ1kFsJAdObQXxI7F4AS/dEiKfI=;
        b=NghiHQ1XnuVAxJDYO9j5gFue3oxXZobpMnaAc0O0j+bvafBSaYiBWYoA8JSBTz/Fe7
         ru1UeThmjk0uBr0A8Cv47ChE1AcEqOdOafnSq7D8rLKnbXcEahyM8/Rib+sLwp9XB06n
         beePpTwd/p6pNhHiDDAShLzH6NjAisRkRKqQU7K8qjgRuqMYoCKnYsGyRm0x+AdvRSOu
         07JPh0E246JgrOqgkevqiOgE3wiQ8cevZCECmMZeVV+MNzWeZbXACSvm7LZXn6M4n90E
         vO0xdNpo/J2aFrwTJc0YwnKXiNfEbHTEuUC5Z6K/OUuykMKdW5VkCYcxmTBVl1w3ztNF
         XSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763976536; x=1764581336;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSUd6Iu5swY1yI3rOZ1kFsJAdObQXxI7F4AS/dEiKfI=;
        b=Zf9H7y5pkCJSmn+NJPGlFG0SdF3BX541jV3qpZSRTZ/qW3mllhZ5wqP8ykjSMmGeuK
         AI0daqRRDPqM6RAE5t1b2ArdirIzCWsaLvxGcd2PegMHnxIwylAfJZYHXW6MftRzcVsq
         EUPzsX7zmGGaeuTUk5KR69dM1HYnsaPmVvSI1bsbhjiN1HLBjCUUB6VeCgkJVUwSmxcj
         p3Gx+GU8/KZ3m4ZNOt9u0NJcjXca+WwyfhOY5vsmCMHOBdba/QaKAga15FZMhNqV9Cyn
         hslGopNgiEwtaxmqW4kkgdR0YM3tcRT8JpOtWObn8J8+K7uJ2uLgBvNB+pXlUOKT5KoA
         R4yA==
X-Forwarded-Encrypted: i=1; AJvYcCUgoecD8wkomF/2KMflqcTbViuApIrU3sHgLWOQZW5Ejx89fG7VdiOENIHyZOCgJlBBroP2z4c703A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9A7tRwWRpDJnF7vbL7Rc4/ODied9af5fg+/uA/9RpZiGAyVv
	qbi0VFBZo5q958z0FCz56/NNqe1Y6Bk0vLx1fI0NPIWuMTS63FcTJZQHgURb3jghhGg=
X-Gm-Gg: ASbGnct7kATS8hMnMHyhlRpRa/RK/MfwimKiNqvkQqvR5/sZpEZCaHzkNgGorHeP3Tb
	rWflyEah87y6ngEy5ylkPDHN42toaLD664on01o/o3E57X2TcB42ubexxTVyxGxudRMCWsglZcf
	WufAxVp+RjiqqTgMo0kSN+ajBjrmU0z7mMgrTIk6NsA0NL0BIRyW94Hl2MwZpqthJxmH2IyrVOe
	P/M4qs5O4wMA3khDKQdw07BXcMWb/zozBcsugY0olhomKrWps1T/YVIqMRW358cHxSjHTtsHenN
	C8MdxNR6uw7+y3XB+TMEaqtvGgZDOWoFnIXpNuQJy/QsCBttWczYHuLUYDrM/ILgjccx8Mqwxtf
	L1wyt4fip/WopoQqrRlhpxQGzjXQ+PHNCEzDrfSP2Qy2Yv9AlwcoxWPNhy/m4Vt8RhbgJdRhDPw
	krkWr10kuZfOnFUgBWUOqfzQaI5SwVr/rCLVCtI9V5
X-Google-Smtp-Source: AGHT+IGqX87Liusvu8VA+P6vAK2NQvQqKGFS75x4fPSdpk7QAnEFO6Q86alRxbuZVhECcom6UWrp6g==
X-Received: by 2002:a05:600c:1c0c:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-477c018a099mr145588045e9.15.1763976536416;
        Mon, 24 Nov 2025 01:28:56 -0800 (PST)
Received: from r1chard (220-129-146-231.dynamic-ip.hinet.net. [220.129.146.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b03c7515sm9757191a91.5.2025.11.24.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:28:56 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Mon, 24 Nov 2025 17:28:49 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/6] efi: earlycon: Reduce number of references to global
 screen_info
Message-ID: <aSQlUVPfQrEwXPWm@r1chard>
References: <20251121135624.494768-1-tzimmermann@suse.de>
 <20251121135624.494768-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121135624.494768-2-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/21 14:36, Thomas Zimmermann wrote:
> Replace usage of global screen_info with local pointers. This will
> later reduce churn when screen_info is being moved.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/earlycon.c | 40 ++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index d18a1a5de144..fac3a295c57f 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -32,12 +32,13 @@ static void *efi_fb;
>   */
>  static int __init efi_earlycon_remap_fb(void)
>  {
> +	const struct screen_info *si = &screen_info;
> +
>  	/* bail if there is no bootconsole or it was unregistered already */
>  	if (!earlycon_console || !console_is_registered(earlycon_console))
>  		return 0;
>  
> -	efi_fb = memremap(fb_base, screen_info.lfb_size,
> -			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
> +	efi_fb = memremap(fb_base, si->lfb_size, fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
>  
>  	return efi_fb ? 0 : -ENOMEM;
>  }
> @@ -71,12 +72,12 @@ static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
>  	early_memunmap(addr, len);
>  }
>  
> -static void efi_earlycon_clear_scanline(unsigned int y)
> +static void efi_earlycon_clear_scanline(unsigned int y, const struct screen_info *si)
>  {
>  	unsigned long *dst;
>  	u16 len;
>  
> -	len = screen_info.lfb_linelength;
> +	len = si->lfb_linelength;
>  	dst = efi_earlycon_map(y*len, len);
>  	if (!dst)
>  		return;
> @@ -85,7 +86,7 @@ static void efi_earlycon_clear_scanline(unsigned int y)
>  	efi_earlycon_unmap(dst, len);
>  }
>  
> -static void efi_earlycon_scroll_up(void)
> +static void efi_earlycon_scroll_up(const struct screen_info *si)
>  {
>  	unsigned long *dst, *src;
>  	u16 maxlen = 0;
> @@ -99,8 +100,8 @@ static void efi_earlycon_scroll_up(void)
>  	}
>  	maxlen *= 4;
>  
> -	len = screen_info.lfb_linelength;
> -	height = screen_info.lfb_height;
> +	len = si->lfb_linelength;
> +	height = si->lfb_height;
>  
>  	for (i = 0; i < height - font->height; i++) {
>  		dst = efi_earlycon_map(i*len, len);
> @@ -120,7 +121,8 @@ static void efi_earlycon_scroll_up(void)
>  	}
>  }
>  
> -static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
> +static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h,
> +				    const struct screen_info *si)
>  {
>  	const u32 color_black = 0x00000000;
>  	const u32 color_white = 0x00ffffff;
> @@ -145,13 +147,12 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
>  static void
>  efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  {
> -	struct screen_info *si;
> +	const struct screen_info *si = &screen_info;
>  	u32 cur_efi_x = efi_x;
>  	unsigned int len;
>  	const char *s;
>  	void *dst;
>  
> -	si = &screen_info;
>  	len = si->lfb_linelength;
>  
>  	while (num) {
> @@ -174,7 +175,7 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  			x = efi_x;
>  
>  			while (n-- > 0) {
> -				efi_earlycon_write_char(dst + x*4, *s, h);
> +				efi_earlycon_write_char(dst + x*4, *s, h, si);
>  				x += font->width;
>  				s++;
>  			}
> @@ -207,10 +208,10 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  			cur_line_y = (cur_line_y + 1) % max_line_y;
>  
>  			efi_y -= font->height;
> -			efi_earlycon_scroll_up();
> +			efi_earlycon_scroll_up(si);
>  
>  			for (i = 0; i < font->height; i++)
> -				efi_earlycon_clear_scanline(efi_y + i);
> +				efi_earlycon_clear_scanline(efi_y + i, si);
>  		}
>  	}
>  }
> @@ -226,22 +227,21 @@ void __init efi_earlycon_reprobe(void)
>  static int __init efi_earlycon_setup(struct earlycon_device *device,
>  				     const char *opt)
>  {
> -	struct screen_info *si;
> +	const struct screen_info *si = &screen_info;
>  	u16 xres, yres;
>  	u32 i;
>  
>  	fb_wb = opt && !strcmp(opt, "ram");
>  
> -	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI) {
> +	if (si->orig_video_isVGA != VIDEO_TYPE_EFI) {
>  		fb_probed = true;
>  		return -ENODEV;
>  	}
>  
> -	fb_base = screen_info.lfb_base;
> -	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -		fb_base |= (u64)screen_info.ext_lfb_base << 32;
> +	fb_base = si->lfb_base;
> +	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +		fb_base |= (u64)si->ext_lfb_base << 32;
>  
> -	si = &screen_info;
>  	xres = si->lfb_width;
>  	yres = si->lfb_height;
>  
> @@ -266,7 +266,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
>  
>  	efi_y -= font->height;
>  	for (i = 0; i < (yres - efi_y) / font->height; i++)
> -		efi_earlycon_scroll_up();
> +		efi_earlycon_scroll_up(si);
>  
>  	device->con->write = efi_earlycon_write;
>  	earlycon_console = device->con;
> -- 
> 2.51.1
> 
> 

