Return-Path: <linux-efi+bounces-1331-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF991D733
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 06:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938031F21EC5
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 04:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9210A09;
	Mon,  1 Jul 2024 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Mxd4Ca"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBDE1EB39;
	Mon,  1 Jul 2024 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719809166; cv=none; b=OpVah+XqHoRuW2pNeUVjG2lkzYk34B9avuj+pgwdx0YSmW+bWIsdOxNmmnNcgRRId0naf6kHnu6c/n3soTe+LQ5+ffse+I9nRPTGyIlWOCqKBP1XSFT9o6EQOP8agv2StLC6KB6ifZa5uk+C9akOHoPDp667DvYyyjBYTo1RLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719809166; c=relaxed/simple;
	bh=7s2rcqu7xBQJ8QdhLVAHbASj82JsmopJP5CTqWgZhcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK1/862oJJF/c+ysMwvcr7PxdVLDyRm3D7B1ereGsjYR3jdxkJ66mh5duv/+5049yWTJfvCl7Sadlb8S4J9hFsUJ6DIZieMtbpOaNy62b7QSgrRoydIA9IOWxcVZm1dmhys3nlEIu/z6PowGkJ6inXyHySHyHMBYusNzfCkIiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0Mxd4Ca; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48f8f50e3b2so2019682137.0;
        Sun, 30 Jun 2024 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719809161; x=1720413961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv9Gd02X1+nQfsgs4haBJsYpcDHScnZnVywlw35l2Ak=;
        b=C0Mxd4CakcjmgYB+YBWDOezCIjSWb5yKmfbQjHpYko2z7BT2Pw2sf1APsdZBsaj9k4
         3s3qQb9VimrfWeskBygPNOSRoPyJJ5H7CFAplZ2dvoZ5E6c3p0Na0sDn7qwAhPu4FiJP
         Tg543+MtYQFh9ZpAVhnX7OOV/+dQZsZY71A8eDdZV8Ns/q4bRspQBQDduqMHJGn8voLb
         gJAMODZkkrf6kjSUb9+sha6AMoOdAUimXzmdr6ZC0/KSrJwBg7ucsiuJrVD2wICGonnT
         SV31Oka6cixLEn+TeQBR+C3RArbsYZKbhCSc/EqtEAsOHbCJY4nyvNcpGsOSKqgvBfEN
         i25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719809161; x=1720413961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv9Gd02X1+nQfsgs4haBJsYpcDHScnZnVywlw35l2Ak=;
        b=WxWfmClK63SK6HmHVeUQqLGbJZ7R32XJtFEG6lAPRD3UWMiXmbFB8q0enpLslbBJwn
         fOjLQ+u7FqsnMqlK2vC16WF1bCUXC9mO6Q/2FHNWS41v/hFvP6YCuSYCmWD6LwpW2Eav
         uNfz/z5DjVXE3Mhkz9Ye1uBjKhLIIsLbTvikBiuAapmzGig8NWw06FFR2anPOpD+iu09
         1k4fMuBAvh8QOcNuuBTDzMfRq5N92B5vawRbdgOXae9GFJma9OXtNhEWsuFJh3wK5N5r
         f3BjNJTDBZrJ+xrhKOpXGpZ7UcelhB94vflBm7hu3303Zf+y1jCFJclzjmGHCPhXNBR4
         9IdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcNQkBvL1S5b7szBBFnSneAUbLD4T5WGzLeaAn8siFpwPty+hkGRJc7deD4u0ie3DpSIfigmdheqvgFwKZ/4Ocy8yT2JO8nL0MMdebwn0vl5x0IvWczm3lqTWVlgB9NjMcDKz6vMvx
X-Gm-Message-State: AOJu0YwqhjuqI+v3MTBkY9+or/iI46tW+zHyPBjkJ16PsqoXLK1z37cF
	RO89SrsOglZyq2BZtCTwCwveOGolJdkxsPeQOAVX/LFSzjQq8U+MdIv+CbTOX04g1rdVFu2LBps
	/LPfo7n/OMZOX3tYe/GS/4GTZwQs=
X-Google-Smtp-Source: AGHT+IGxT49KKHkXJncBiPaxAdO1Ofy6deas1AHy2Mfu9KSsEAQLk0LbazzGKCYXXVvgARJXsojE/zqUyQYYFrTNS+4=
X-Received: by 2002:a05:6102:126e:b0:48f:9645:62fd with SMTP id
 ada2fe7eead31-48fae952e2amr2395203137.14.1719809161022; Sun, 30 Jun 2024
 21:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
In-Reply-To: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
Date: Mon, 1 Jul 2024 14:45:49 +1000
Message-ID: <CADfWnbbWDgYe6g_CkEmpwAMfZf2kWLE5khB0GSfhojfvDFu5sA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I've checked that this patch works for me when applied to 6.10-rc6.
I can also use https://github.com/0xbb/gpu-switch to make the boot gpu
the iGPU now.

Tested-By: Orlando Chamberlain <orlandoch.dev@gmail.com> (MacBookPro16,1)


On Mon, 1 Jul 2024 at 05:24, Aditya Garg <gargaditya08@live.com> wrote:
>
> From: Aditya Garg <gargaditya08@live.com>
>
> 0c18184de990 ("platform/x86: apple-gmux: support MMIO gmux on T2 Macs")
> brought support for T2 Macs in apple-gmux. But in order to use dual GPU,
> the integrated GPU has to be enabled. On such dual GPU EFI Macs, the EFI
> stub needs to report that it is booting macOS in order to prevent the
> firmware from disabling the iGPU.
>
> This patch is also applicable for some non T2 Intel Macs.
>
> Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html
>
> Credits also goto Kerem Karabay <kekrby@gmail.com> for helping porting
> the patch to the Linux kernel.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  drivers/firmware/efi/libstub/efistub.h  | 15 +++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c | 33 ++++++++++++++++++++++---
>  include/linux/efi.h                     |  1 +
>  3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 27abb4ce0..4257a8b7c 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -825,6 +825,21 @@ union apple_properties_protocol {
>         } mixed_mode;
>  };
>
> +typedef union apple_set_os_protocol apple_set_os_protocol_t;
> +
> +union apple_set_os_protocol {
> +       struct {
> +               unsigned long version;
> +               efi_status_t (__efiapi *set_os_version) (const char *);
> +               efi_status_t (__efiapi *set_os_vendor) (const char *);
> +       };
> +       struct {
> +               u32 version;
> +               u32 set_os_version;
> +               u32 set_os_vendor;
> +       } mixed_mode;
> +};
> +
>  typedef u32 efi_tcg2_event_log_format;
>
>  #define INITRD_EVENT_TAG_ID 0x8F3B22ECU
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1983fd3bf..1eea4f7ba 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -225,6 +225,30 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
>         }
>  }
>
> +static void apple_set_os(void)
> +{
> +       efi_guid_t guid = APPLE_SET_OS_PROTOCOL_GUID;
> +       apple_set_os_protocol_t *set_os;
> +       efi_status_t status;
> +
> +       status = efi_bs_call(locate_protocol, &guid, NULL, (void **)&set_os);
> +       if (status != EFI_SUCCESS)
> +               return;
> +
> +       if (efi_table_attr(set_os, version) >= 2) {
> +               status = efi_fn_call(set_os, set_os_vendor, "Apple Inc.");
> +               if (status != EFI_SUCCESS)
> +                       efi_err("Failed to set OS vendor via apple_set_os\n");
> +       }
> +
> +       /* The version being set doesn't seem to matter */
> +       if (efi_table_attr(set_os, version) > 0) {
> +               status = efi_fn_call(set_os, set_os_version, "Mac OS X 10.9");
> +               if (status != EFI_SUCCESS)
> +                       efi_err("Failed to set OS version via apple_set_os\n");
> +       }
> +}
> +
>  efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>                                                 unsigned long size)
>  {
> @@ -335,9 +359,12 @@ static const efi_char16_t apple[] = L"Apple";
>
>  static void setup_quirks(struct boot_params *boot_params)
>  {
> -       if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
> -           !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
> -               retrieve_apple_device_properties(boot_params);
> +       if (!memcmp(efistub_fw_vendor(), apple, sizeof(apple))) {
> +               if (IS_ENABLED(CONFIG_APPLE_PROPERTIES)) {
> +                       retrieve_apple_device_properties(boot_params);
> +               }
> +               apple_set_os();
> +       }
>  }
>
>  /*
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 418e55545..e28873eb1 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -385,6 +385,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_MEMORY_ATTRIBUTES_TABLE_GUID       EFI_GUID(0xdcfa911d, 0x26eb, 0x469f,  0xa2, 0x20, 0x38, 0xb7, 0xdc, 0x46, 0x12, 0x20)
>  #define EFI_CONSOLE_OUT_DEVICE_GUID            EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define APPLE_PROPERTIES_PROTOCOL_GUID         EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
> +#define APPLE_SET_OS_PROTOCOL_GUID             EFI_GUID(0xc5c5da95, 0x7d5c, 0x45e6,  0xb2, 0xf1, 0x3f, 0xd5, 0x2b, 0xb1, 0x00, 0x77)
>  #define EFI_TCG2_PROTOCOL_GUID                 EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
>  #define EFI_TCG2_FINAL_EVENTS_TABLE_GUID       EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define EFI_LOAD_FILE_PROTOCOL_GUID            EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> --
> 2.39.3 (Apple Git-146)
>

