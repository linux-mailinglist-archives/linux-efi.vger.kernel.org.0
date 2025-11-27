Return-Path: <linux-efi+bounces-5708-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D9C8C8B3
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 02:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 286DC34352C
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5C25F7A9;
	Thu, 27 Nov 2025 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5c4EQgr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D70248F51
	for <linux-efi@vger.kernel.org>; Thu, 27 Nov 2025 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206613; cv=none; b=KmZhMJT3PXul6fKeP2mUCvbWTWpa34Om6SMkZxU2uRKkC8bdMhTjaVm2qIFItRTxPak/vTGJhL6OG9cuCJILjIqM/gAnQvE2oZvwxRwR1eDhz7qRu0+BdCdvPwQ8JBk8p85OO6OS4vFZTadvbyYH5/5o86IlQaDfxA7E/FyGccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206613; c=relaxed/simple;
	bh=x63UrZvzdWbO9vytQh63ZUXavJaWtH1zFiYQrB8deU8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOoCa7ccQY9yJvhUDr5YYVTpbnPuvOiW9N8JdMZsHFD3Jut+segPLv2bqho/71mg85/ojXRm9RTnsbiKTfwW9a8epuQBXvkPV4c5jeliao14IKoC4WYQH0dx/z14m1fxjuNMMfOiD3qLHQU9PnFjoEvSMuqoewal25G52fWU+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5c4EQgr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779a637712so1611345e9.1
        for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764206609; x=1764811409; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNuNk1yaizw865Qq2SQ1TPwZonHkT+uQRcwOIFsLCps=;
        b=S5c4EQgrKbVALYuvq1n+15dvc2PLS2tqmUgKOfTJyiOk77BFbc+z/38kThaU4fb++/
         qu4v3kJPjJu7En/z1Vu1JCVDAVPPShy6uVioQ0vr0YDJF8x6jhLxwds0jzW5xapOkCUr
         +P88DY7klPVkkTHq1R4wQm6yt1snRX3WWitO1ch7bTLBENMGyS3rp/V67MiAFCwI6fQG
         KLQnVSkwRMViuVTDNsSCQHF3X+kRRKfz0uKUMZDjLX31J5upVaJ7qhtCKCYlOP7m/bjR
         yrVnoSF+Er6l8120HvMtV4oXD0xy5HKRJ7SFTyDdLBZYAhKLm57JGDMiY9IlTBcroM5y
         YiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206609; x=1764811409;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNuNk1yaizw865Qq2SQ1TPwZonHkT+uQRcwOIFsLCps=;
        b=VAIj4XzXG/jdknMx3MUTfx1qgfZrvOtMutzN3CWwr4wJS6Tr4xUUIl+kWygpQfHzKq
         lPuIf6oy7Psos0Cn7b8han5HR2L0UAmJMEGdnkjzVDqCJzKslBHBO3Q4wnESN7E4VvWD
         zC1XfTyxQsLcJaZb1Vlv+iirGdZ2ajqVm7fnpW++T4l0mQLX3QVWI3o57NFhRM+vifmv
         B7S3Z2D4Xn9RlobM2wZAs+3vhbI0+aO5Z/c3kDku6IHlgW5XMxjLla/IxSxktgboFgYU
         fNfnM+RjF2bMkIHP2Q8OXSRnORH4YOWaskOQiwdFDCxtyL5XuHuM/BR3xWJdhUAJKd2X
         Ia1g==
X-Forwarded-Encrypted: i=1; AJvYcCXcPzHM6T7Vf+/Fbz3Qk1nYcqLjQt948gIE7mVs0HBB3atWTWquArOrtJFO03AKg04etJ0YWMPi7kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUNTZ4rb/q3/SdLrKP0y4Z2aYBx2pGYIatN2Wr19iSeQydB8x
	sp1L4Ju0c3C2nyNae8p9FSh2ql9n6v2mGz1z6LDIht7067YzMby2ubiOsvNw36ngtz8=
X-Gm-Gg: ASbGncuFGDEVSSXHfIcIQiY2M4BmMZQJ4Y4CicHCsAgs6zIbvFAb2Qt+IBcVG6it5Zm
	fvqjg5S0dsuVsmcVxOeYRRs/pYhcOR+EOz6++aHyYHvP1kv2qEBxkCy7KV1vJg9DTmOtugqyBNi
	qra2b3YvMCpMhgCCi4uBhFd2mR7Ft9Eokac/V87B3CmxxO25WT6OoGzL7Jf4UM7uaV8+UhkHjyl
	wbZ2hPuWfxcL32P4nvY3l6JUd6WSzHFbyaqQ8RzEqz0eI3I/gFIyJ3WZJ39PgxPsgXITW7Wqxj5
	o4jEH9gQl1xpJrpgHzxWJ1tagsn/9SuIXD7SMs+vYSXAjz97lg1Mo1Gu5IDNupue6GZFYGupN8G
	wWJVXO8Qui3jSX8bRNlfUA+mk8Ul1/NULohJmRpQH81p5RooE9pGyWJ/PQJIuGjtrTZswKk463c
	Mu7UVczg7rdjEJ99ayZycPi2EPdOQ7vp/m
X-Google-Smtp-Source: AGHT+IFAI6GQD9lcY1JxdhkE8Lv0II4oKq4ojcJkBaGXT4DCZOTPlduoBmiQE99ST1DmviiNV2jnsw==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr241739295e9.31.1764206608732;
        Wed, 26 Nov 2025 17:23:28 -0800 (PST)
Received: from r1chard (1-169-246-18.dynamic-ip.hinet.net. [1.169.246.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0243b19sm22661544b3a.37.2025.11.26.17.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:23:27 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Thu, 27 Nov 2025 09:23:19 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de, helgaas@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 5/9] sysfb: Pass sysfb_primary_display to devices
Message-ID: <aSeoB1xf05i4LhCp@r1chard>
References: <20251126160854.553077-1-tzimmermann@suse.de>
 <20251126160854.553077-6-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160854.553077-6-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/26 17:03, Thomas Zimmermann wrote:
> Instead of screen_info, store a copy of sysfb_primary_display as
> device data. Pick it up in drivers. Later changes will add additional
> data to the display info, such as EDID information.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/sysfb.c        |  5 +++--
>  drivers/gpu/drm/sysfb/efidrm.c  |  9 ++++++---
>  drivers/gpu/drm/sysfb/vesadrm.c |  9 ++++++---
>  drivers/video/fbdev/efifb.c     | 10 ++++++----
>  drivers/video/fbdev/vesafb.c    | 10 ++++++----
>  drivers/video/fbdev/vga16fb.c   |  8 +++++---
>  6 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 1f671f9219b0..8833582c1883 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -141,7 +141,8 @@ static struct device *sysfb_parent_dev(const struct screen_info *si)
>  
>  static __init int sysfb_init(void)
>  {
> -	struct screen_info *si = &sysfb_primary_display.screen;
> +	struct sysfb_display_info *dpy = &sysfb_primary_display;
> +	struct screen_info *si = &dpy->screen;
>  	struct device *parent;
>  	unsigned int type;
>  	struct simplefb_platform_data mode;
> @@ -202,7 +203,7 @@ static __init int sysfb_init(void)
>  
>  	sysfb_set_efifb_fwnode(si, pd);
>  
> -	ret = platform_device_add_data(pd, si, sizeof(*si));
> +	ret = platform_device_add_data(pd, dpy, sizeof(*dpy));
>  	if (ret)
>  		goto err;
>  
> diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
> index 1b683d55d6ea..29533ae8fbbf 100644
> --- a/drivers/gpu/drm/sysfb/efidrm.c
> +++ b/drivers/gpu/drm/sysfb/efidrm.c
> @@ -4,7 +4,7 @@
>  #include <linux/efi.h>
>  #include <linux/limits.h>
>  #include <linux/platform_device.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic.h>
> @@ -141,6 +141,7 @@ static const struct drm_mode_config_funcs efidrm_mode_config_funcs = {
>  static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
>  						  struct platform_device *pdev)
>  {
> +	const struct sysfb_display_info *dpy;
>  	const struct screen_info *si;
>  	const struct drm_format_info *format;
>  	int width, height, stride;
> @@ -160,9 +161,11 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
>  	size_t nformats;
>  	int ret;
>  
> -	si = dev_get_platdata(&pdev->dev);
> -	if (!si)
> +	dpy = dev_get_platdata(&pdev->dev);
> +	if (!dpy)
>  		return ERR_PTR(-ENODEV);
> +	si = &dpy->screen;
> +
>  	if (screen_info_video_type(si) != VIDEO_TYPE_EFI)
>  		return ERR_PTR(-ENODEV);
>  
> diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
> index 7b7b5ba26317..16fc223f8c5b 100644
> --- a/drivers/gpu/drm/sysfb/vesadrm.c
> +++ b/drivers/gpu/drm/sysfb/vesadrm.c
> @@ -4,7 +4,7 @@
>  #include <linux/ioport.h>
>  #include <linux/limits.h>
>  #include <linux/platform_device.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic.h>
> @@ -391,6 +391,7 @@ static const struct drm_mode_config_funcs vesadrm_mode_config_funcs = {
>  static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
>  						    struct platform_device *pdev)
>  {
> +	const struct sysfb_display_info *dpy;
>  	const struct screen_info *si;
>  	const struct drm_format_info *format;
>  	int width, height, stride;
> @@ -410,9 +411,11 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
>  	size_t nformats;
>  	int ret;
>  
> -	si = dev_get_platdata(&pdev->dev);
> -	if (!si)
> +	dpy = dev_get_platdata(&pdev->dev);
> +	if (!dpy)
>  		return ERR_PTR(-ENODEV);
> +	si = &dpy->screen;
> +
>  	if (screen_info_video_type(si) != VIDEO_TYPE_VLFB)
>  		return ERR_PTR(-ENODEV);
>  
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 0e1bd3dba255..47ebc0107209 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -15,7 +15,7 @@
>  #include <linux/fb.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <video/vga.h>
>  #include <asm/efi.h>
>  #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
> @@ -345,6 +345,7 @@ ATTRIBUTE_GROUPS(efifb);
>  
>  static int efifb_probe(struct platform_device *dev)
>  {
> +	struct sysfb_display_info *dpy;
>  	struct screen_info *si;
>  	struct fb_info *info;
>  	struct efifb_par *par;
> @@ -360,10 +361,11 @@ static int efifb_probe(struct platform_device *dev)
>  	 * driver. We get a copy of the attached screen_info, so that we can
>  	 * modify its values without affecting later drivers.
>  	 */
> -	si = dev_get_platdata(&dev->dev);
> -	if (!si)
> +	dpy = dev_get_platdata(&dev->dev);
> +	if (!dpy)
>  		return -ENODEV;
> -	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
> +
> +	si = devm_kmemdup(&dev->dev, &dpy->screen, sizeof(*si), GFP_KERNEL);
>  	if (!si)
>  		return -ENOMEM;
>  
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index f135033c22fb..f84f4db244bf 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -20,7 +20,7 @@
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <linux/io.h>
>  
>  #include <video/vga.h>
> @@ -243,6 +243,7 @@ static int vesafb_setup(char *options)
>  
>  static int vesafb_probe(struct platform_device *dev)
>  {
> +	struct sysfb_display_info *dpy;
>  	struct screen_info *si;
>  	struct fb_info *info;
>  	struct vesafb_par *par;
> @@ -257,10 +258,11 @@ static int vesafb_probe(struct platform_device *dev)
>  	 * driver. We get a copy of the attached screen_info, so that we can
>  	 * modify its values without affecting later drivers.
>  	 */
> -	si = dev_get_platdata(&dev->dev);
> -	if (!si)
> +	dpy = dev_get_platdata(&dev->dev);
> +	if (!dpy)
>  		return -ENODEV;
> -	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
> +
> +	si = devm_kmemdup(&dev->dev, &dpy->screen, sizeof(*si), GFP_KERNEL);
>  	if (!si)
>  		return -ENOMEM;
>  
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index 6b81337a4909..22085d3668e8 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -21,7 +21,7 @@
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  
>  #include <asm/io.h>
>  #include <video/vga.h>
> @@ -1305,15 +1305,17 @@ static const struct fb_ops vga16fb_ops = {
>  
>  static int vga16fb_probe(struct platform_device *dev)
>  {
> +	struct sysfb_display_info *dpy;
>  	struct screen_info *si;
>  	struct fb_info *info;
>  	struct vga16fb_par *par;
>  	int i;
>  	int ret = 0;
>  
> -	si = dev_get_platdata(&dev->dev);
> -	if (!si)
> +	dpy = dev_get_platdata(&dev->dev);
> +	if (!dpy)
>  		return -ENODEV;
> +	si = &dpy->screen;
>  
>  	ret = check_mode_supported(si);
>  	if (ret)
> -- 
> 2.51.1
> 

