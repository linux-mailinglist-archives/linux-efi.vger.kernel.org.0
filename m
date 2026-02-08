Return-Path: <linux-efi+bounces-6098-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM3AB2xpiGkzpQQAu9opvQ
	(envelope-from <linux-efi+bounces-6098-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 08 Feb 2026 11:46:04 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DA6108689
	for <lists+linux-efi@lfdr.de>; Sun, 08 Feb 2026 11:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77ADA300B059
	for <lists+linux-efi@lfdr.de>; Sun,  8 Feb 2026 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA905311C3B;
	Sun,  8 Feb 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szMovIaU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681427AC28;
	Sun,  8 Feb 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770547559; cv=none; b=ogcZMDq0BrE0xhnQsU3XcVC6O/KFFdHrJtyVSe39mkVPSKzTSqfN/U8XEobTq803JUKD3Mb922efg9n361JdJVMVDDEPBhz3DvytnA+/loyzGPGYsPJPablwflp2gyjwLaZFtYoN8V2wxEh74xdo1951opkvq19OYI9CCcfqs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770547559; c=relaxed/simple;
	bh=oCOks4Zu7lnr+Dn0QAI7n4eMmSuai+UyfMfboMsdGlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swt4ddwBwqQXW5WZTUvt8dI8hBnNqkZ8rogyiAXzTrtEpgPHJSIMw57RXOiLCAPdshwob2tIPainSJPczdz73CsrnSNcKKZ7yWsuPosjn8SttYDl8oxUH+C6wRtApiTkXNH/TUKNoYYIFxKMXnpUWz1jAW1vQ+zMVdjMBIfg/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szMovIaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F83C4CEF7;
	Sun,  8 Feb 2026 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770547559;
	bh=oCOks4Zu7lnr+Dn0QAI7n4eMmSuai+UyfMfboMsdGlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=szMovIaUZmX2u8cIlV4PbkpacHnR3bebZelZbbP1/i+8/7hUYK0VcJ+HEceivEVyt
	 /VWx0Z+UaxQEI1PwKgNzCUGcf4J80cmIpa9c0Didmx7hqhYrxY+JIIedxH29TAcMGO
	 jhRIqM/FNPC+BhpTfNi7RFgoNaCDbnCPuwK3LW8JvXrN0fuoNAQ8zt/2CTibJCo7a3
	 72yXIOpAdz1hkMEH2gzlJ3yVsjXpFWOJYOVcgwwtE7p0fQ/WInFiw4ZiOnmLdjXV7U
	 iPWXhyM6Ubuucjxf1s7hZ6w+9109n1MeoCGenz6knXhkqVutK3aghrQJR0s0DtTKh0
	 enFrlJ1Jdj7KA==
Message-ID: <c2d14818-1c34-47c7-a210-1f7c737f0bc9@kernel.org>
Date: Sun, 8 Feb 2026 11:45:55 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi: Save Brightness using EFI on Macs
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20260206125641.12983-1-atharvatiwarilinuxdev@gmail.com>
 <20260206125641.12983-2-atharvatiwarilinuxdev@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260206125641.12983-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6098-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wunner.de:email]
X-Rspamd-Queue-Id: 74DA6108689
X-Rspamd-Action: no action

Hi,

On 6-Feb-26 13:56, Atharva Tiwari wrote:
> Currently when a Mac reboots, the brightness is not the same
> as the previous boot instead its the same as the last time the
> Mac booted macOS.
> 
> We can fix this issue by saving the brightness level to the efivar
> backlight-level.
> 
> We use delayed work instead of a shutdown callback,
> as it still applies the brightness
> even during forced shutdowns and at 0% battery.
> 
> (tested on iMac20,1)
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/firmware/efi/Kconfig                  | 10 ++
>  drivers/firmware/efi/Makefile                 |  1 +
>  drivers/firmware/efi/apple-brightness.c       | 91 +++++++++++++++++++
>  .../linux/platform_data/apple-brightness.h    | 21 +++++
>  4 files changed, 123 insertions(+)
>  create mode 100644 drivers/firmware/efi/apple-brightness.c
>  create mode 100644 include/linux/platform_data/apple-brightness.h
> 
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 29e0729299f5..dd0a9c9a772a 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -167,6 +167,16 @@ config APPLE_PROPERTIES
>  
>  	  If unsure, say Y if you have a Mac.  Otherwise N.
>  
> +config APPLE_BRIGHTNESS
> +	bool "Apple Backlight control for EFI"
> +	depends on X86
> +	help
> +	  This will save the brightness level to EFI, so brightness
> +	  level is preserved across reboots and shutdows. allowing
> +	  for improved support of Apple hardware.
> +
> +	  If unsure, say Y if you have a Mac, Otherwise N.
> +
>  config RESET_ATTACK_MITIGATION
>  	bool "Reset memory attack mitigation"
>  	depends on EFI_STUB
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 8efbcf699e4f..1f5705cc87a2 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
>  obj-$(CONFIG_EFI_TEST)			+= test/
>  obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
>  obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
> +obj-$(CONFIG_APPLE_BRIGHTNESS)		+= apple-brightness.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
>  obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
> diff --git a/drivers/firmware/efi/apple-brightness.c b/drivers/firmware/efi/apple-brightness.c
> new file mode 100644
> index 000000000000..c32e365dc511
> --- /dev/null
> +++ b/drivers/firmware/efi/apple-brightness.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * apple-brightness.c - EFI brightness saver on Macs
> + * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/backlight.h>
> +#include <linux/cleanup.h>
> +#include <linux/efi.h>
> +#include <linux/mutex.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_data/apple-brightness.h>
> +
> +static DEFINE_MUTEX(apple_brightness_mutex);
> +static struct delayed_work apple_brightness_work;
> +
> +static u32 efi_attr;
> +static u16 last_saved_level;
> +
> +static int (*get_brightness)(struct backlight_device *bl);
> +static struct backlight_device *bl_dev;
> +
> +static void apple_brightness_workfn(struct work_struct *work)
> +{
> +	u16 level;
> +	efi_status_t status;
> +
> +	mutex_lock(&apple_brightness_mutex);
> +
> +	level = (u16)get_brightness(bl_dev);
> +
> +	if (level == last_saved_level)
> +		goto out;
> +
> +	status = efivar_set_variable(APPLE_BRIGHTNESS_NAME, &APPLE_BRIGHTNESS_GUID,
> +				efi_attr, sizeof(level), &level);
> +	if (status != EFI_SUCCESS)
> +		pr_debug("Unable to set brightness: 0x%lx\n", status);
> +	else
> +		last_saved_level = level;
> +
> +out:
> +	mutex_unlock(&apple_brightness_mutex);
> +
> +	mod_delayed_work(system_wq, &apple_brightness_work,
> +			msecs_to_jiffies(APPLE_BRIGHTNESS_POLL));

Wait so this now writes an non-volatile EFI variable every
300ms ?  I don't know how these are backed on Apple hw,
but typically these are backed by some SPI-nor flash or
something similar.

Writing this every 300ms is a sure fire way to wear out
the flash and brick the machine real fast.

So NACK.

I was already worried about the shutdown approach on v1,
but did not say anything since I'm not that familiar
with apple hw and other apple code is already doing
something similar.

But writing a non-volatile EFI variable every 300ms is
just a very very bad idea.

Also I do not understand why this is necessary at all?

Systemd already has a service which saves the value
of all /sys/class/backlight and /sys/class/leds/*kbd_backlight
devices on shutdown/reboot and restores these on boot.

So what is the advantage here? Only advantage I can
see is having the old-brightness value right away
rather then getting it restored during boot?

Regards,

Hans





> +}
> +
> +int apple_brightness_probe(struct backlight_device *bl,
> +	int (*get_brightnessfn)(struct backlight_device *bl))
> +{
> +	efi_status_t status;
> +	unsigned long size = sizeof(last_saved_level);
> +	int ret;
> +
> +	guard(mutex)(&apple_brightness_mutex);
> +
> +	bl_dev = bl;
> +	get_brightness = get_brightnessfn;
> +
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
> +		return -ENODEV;
> +
> +	ret = efivar_lock();
> +	if (ret)
> +		return ret;
> +
> +	status = efivar_get_variable(APPLE_BRIGHTNESS_NAME, &APPLE_BRIGHTNESS_GUID,
> +				&efi_attr, &size, &last_saved_level);
> +
> +	efivar_unlock();
> +
> +	if (status != EFI_SUCCESS)
> +		return -ENODEV;
> +
> +	bl_dev = bl;
> +	get_brightness = get_brightnessfn;
> +
> +	INIT_DELAYED_WORK(&apple_brightness_work, apple_brightness_workfn);
> +	mod_delayed_work(system_wq, &apple_brightness_work,
> +			msecs_to_jiffies(APPLE_BRIGHTNESS_POLL));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(apple_brightness_probe);
> +
> +MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
> +MODULE_DESCRIPTION("EFI Brightness saver for Macs");
> +MODULE_LICENSE("Dual MIT/GPL");
> diff --git a/include/linux/platform_data/apple-brightness.h b/include/linux/platform_data/apple-brightness.h
> new file mode 100644
> index 000000000000..4cf5e2d346cb
> --- /dev/null
> +++ b/include/linux/platform_data/apple-brightness.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * apple-brightness.h - EFI brightness saver for Macs
> + * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> + */
> +
> +#ifndef _APPLE_BL_H_
> +#define _APPLE_BL_H_
> +
> +#include <linux/backlight.h>
> +#include <linux/efi.h>
> +
> +#define APPLE_BRIGHTNESS_NAME           L"backlight-level"
> +#define APPLE_BRIGHTNESS_GUID           EFI_GUID(0x7c436110, 0xab2a, 0x4bbb, 0xa8, 0x80, 0xfe, 0x41, 0x99, 0x5c, 0x9f, 0x82)
> +
> +#define APPLE_BRIGHTNESS_POLL           300
> +
> +int apple_brightness_probe(struct backlight_device *bl,
> +	int (*get_brightnessfn)(struct backlight_device *bl));
> +
> +#endif /* _APPLE_BL_H */


