Return-Path: <linux-efi+bounces-5641-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1AC7AB0D
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742573A11FA
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E134029E;
	Fri, 21 Nov 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cpn9e30c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V7eEY3nw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cpn9e30c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V7eEY3nw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170321771C
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740592; cv=none; b=Ds4pQpnEKDGPZar9gr4cFM3eBi/dFqkXmhtfFKKZPU9JQyyCfFpf97Nti6+7yMBFj/9LRJ4pBWgWaUiN+vNB9sp+DzROl5Kd1/ZOF1bJUGRvGUDqNAYHX2jAM+hECv65PqcU7OOE93mAa/rpRg6N2mpQz96tAso/KmzdVkOU0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740592; c=relaxed/simple;
	bh=7FOz8a6ZY9ig5iWblOuHDBF2kHsV/ePymDmZxz9Mu9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7ZpCz9aQFbY1gFgTYL/1tf7M1WYkJAwQpDkS0OWIK/liM9U5hyor5g9Xp8k7wWar7aWkj0Vy9exVQTfyEfpvweW4TWk7iBrybHIjoiaxkHExpV4bQDp7G8U4TM3+V+XvhrDWCeCWhY8p4gGxgrgrahOR5EopsjY0im6hdKl+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cpn9e30c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V7eEY3nw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cpn9e30c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V7eEY3nw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 772CA219AA;
	Fri, 21 Nov 2025 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763740588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8UVo7cob4soj/N2gDxSROf5m+F/1WrkBeTpLRgjEZPA=;
	b=Cpn9e30c71kagpa6+tt6QXHNvdUiEbthf9oyVP8d+CWsnl31PqNhgef/XN9ODv0l9GnKML
	M0veQuE1+FY/Er6W8gUn+oOlbEEjKfTNUE0PhYmzyKe+YiplzFyJF9adTT4XOVCdNP5w3f
	6fckIxjAzIKTanAkEb0TNrUGJR/LP3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763740588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8UVo7cob4soj/N2gDxSROf5m+F/1WrkBeTpLRgjEZPA=;
	b=V7eEY3nw1P0oVicif98pciUGQqUPEwet7D2XRMowPRTehuAeWPr+81xFuDvpnAlAt5Fc2B
	jz+1OcGPGmiPKUDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763740588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8UVo7cob4soj/N2gDxSROf5m+F/1WrkBeTpLRgjEZPA=;
	b=Cpn9e30c71kagpa6+tt6QXHNvdUiEbthf9oyVP8d+CWsnl31PqNhgef/XN9ODv0l9GnKML
	M0veQuE1+FY/Er6W8gUn+oOlbEEjKfTNUE0PhYmzyKe+YiplzFyJF9adTT4XOVCdNP5w3f
	6fckIxjAzIKTanAkEb0TNrUGJR/LP3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763740588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8UVo7cob4soj/N2gDxSROf5m+F/1WrkBeTpLRgjEZPA=;
	b=V7eEY3nw1P0oVicif98pciUGQqUPEwet7D2XRMowPRTehuAeWPr+81xFuDvpnAlAt5Fc2B
	jz+1OcGPGmiPKUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 244A83EA61;
	Fri, 21 Nov 2025 15:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pSOsB6yLIGkPawAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 15:56:28 +0000
Message-ID: <b626f958-36e6-4dc3-a82b-9656275c3bb0@suse.de>
Date: Fri, 21 Nov 2025 16:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] sysfb: Move edid_info into sysfb_primary_display
To: ardb@kernel.org, javierm@redhat.com, arnd@arndb.de
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20251121135624.494768-1-tzimmermann@suse.de>
 <20251121135624.494768-7-tzimmermann@suse.de>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20251121135624.494768-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 



Am 21.11.25 um 14:36 schrieb Thomas Zimmermann:
> Move x86's edid_info into sysfb_primary_display as a new field named
> edid. Adapt all users.
>
> An instance of edid_info has only been defined on x86. With the move
> into sysfb_primary_display, it becomes available on all architectures.
> Therefore remove this contraint from CONFIG_FIRMWARE_EDID.

s/contraint/constraint/

>
> x86 fills the EDID data from boot_params.edid_info. DRM drivers pick
> up the raw data and make it available to DRM clients. Replace the
> drivers' references to edid_info and instead use the sysfb_display_info
> as passed from sysfb.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   arch/x86/kernel/setup.c          | 6 +-----
>   drivers/gpu/drm/sysfb/efidrm.c   | 5 ++---
>   drivers/gpu/drm/sysfb/vesadrm.c  | 5 ++---
>   drivers/video/Kconfig            | 1 -
>   drivers/video/fbdev/core/fbmon.c | 8 +++++---
>   include/linux/sysfb.h            | 6 ++++++
>   include/video/edid.h             | 4 ----
>   7 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 675e4b9deb1f..d9bfe2032cd9 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -215,10 +215,6 @@ arch_initcall(init_x86_sysctl);
>   
>   struct sysfb_display_info sysfb_primary_display;
>   EXPORT_SYMBOL(sysfb_primary_display);
> -#if defined(CONFIG_FIRMWARE_EDID)
> -struct edid_info edid_info;
> -EXPORT_SYMBOL_GPL(edid_info);
> -#endif
>   
>   extern int root_mountflags;
>   
> @@ -530,7 +526,7 @@ static void __init parse_boot_params(void)
>   	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
>   	sysfb_primary_display.screen = boot_params.screen_info;
>   #if defined(CONFIG_FIRMWARE_EDID)
> -	edid_info = boot_params.edid_info;
> +	sysfb_primary_display.edid = boot_params.edid_info;
>   #endif
>   #ifdef CONFIG_X86_32
>   	apm_info.bios = boot_params.apm_bios_info;
> diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
> index 29533ae8fbbf..50e0aeef709c 100644
> --- a/drivers/gpu/drm/sysfb/efidrm.c
> +++ b/drivers/gpu/drm/sysfb/efidrm.c
> @@ -24,7 +24,6 @@
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
>   
> -#include <video/edid.h>
>   #include <video/pixel_format.h>
>   
>   #include "drm_sysfb_helper.h"
> @@ -207,8 +206,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
>   		&format->format, width, height, stride);
>   
>   #if defined(CONFIG_FIRMWARE_EDID)
> -	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
> -		sysfb->edid = edid_info.dummy;
> +	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
> +		sysfb->edid = dpy->edid.dummy;
>   #endif
>   	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
>   	sysfb->fb_format = format;
> diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
> index 16fc223f8c5b..0680638b8131 100644
> --- a/drivers/gpu/drm/sysfb/vesadrm.c
> +++ b/drivers/gpu/drm/sysfb/vesadrm.c
> @@ -25,7 +25,6 @@
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
>   
> -#include <video/edid.h>
>   #include <video/pixel_format.h>
>   #include <video/vga.h>
>   
> @@ -474,8 +473,8 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
>   	}
>   
>   #if defined(CONFIG_FIRMWARE_EDID)
> -	if (drm_edid_header_is_valid(edid_info.dummy) == 8)
> -		sysfb->edid = edid_info.dummy;
> +	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
> +		sysfb->edid = dpy->edid.dummy;
>   #endif
>   	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
>   	sysfb->fb_format = format;
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d51777df12d1..ad55e7d62159 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -63,7 +63,6 @@ endif # HAS_IOMEM
>   
>   config FIRMWARE_EDID
>   	bool "Enable firmware EDID"
> -	depends on X86
>   	help
>   	  This enables access to the EDID transferred from the firmware.
>   	  On x86, this is from the VESA BIOS. DRM display drivers will
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 0a65bef01e3c..07df7e98f8a3 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -32,11 +32,13 @@
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> -#include <video/edid.h>
> +#include <linux/string_choices.h>
> +#include <linux/sysfb.h>
> +
>   #include <video/of_videomode.h>
>   #include <video/videomode.h>
> +
>   #include "../edid.h"
> -#include <linux/string_choices.h>
>   
>   /*
>    * EDID parser
> @@ -1504,7 +1506,7 @@ const unsigned char *fb_firmware_edid(struct device *device)
>   		res = &dev->resource[PCI_ROM_RESOURCE];
>   
>   	if (res && res->flags & IORESOURCE_ROM_SHADOW)
> -		edid = edid_info.dummy;
> +		edid = sysfb_primary_display.edid.dummy;
>   
>   	return edid;
>   }
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index e8bde392c690..5226efde9ad4 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -12,6 +12,8 @@
>   #include <linux/screen_info.h>
>   #include <linux/types.h>
>   
> +#include <video/edid.h>
> +
>   struct device;
>   struct platform_device;
>   struct screen_info;
> @@ -62,6 +64,10 @@ struct efifb_dmi_info {
>   
>   struct sysfb_display_info {
>   	struct screen_info screen;
> +
> +#if defined(CONFIG_FIRMWARE_EDID)
> +	struct edid_info edid;
> +#endif
>   };
>   
>   extern struct sysfb_display_info sysfb_primary_display;
> diff --git a/include/video/edid.h b/include/video/edid.h
> index c2b186b1933a..52aabb706032 100644
> --- a/include/video/edid.h
> +++ b/include/video/edid.h
> @@ -4,8 +4,4 @@
>   
>   #include <uapi/video/edid.h>
>   
> -#if defined(CONFIG_FIRMWARE_EDID)
> -extern struct edid_info edid_info;
> -#endif
> -
>   #endif /* __linux_video_edid_h__ */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



