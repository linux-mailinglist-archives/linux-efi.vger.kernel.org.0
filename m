Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5E141670
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 09:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgARIAN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 03:00:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38909 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgARIAN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 03:00:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so24760845wrh.5
        for <linux-efi@vger.kernel.org>; Sat, 18 Jan 2020 00:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFOEOXqnCDTTcDQn4El+71G/5ufyH8CwcIjRAHLYoAg=;
        b=vG/c8xAMLKnw35yMwUcyERh82mgpWduiosJkl6ePJZx//bVHz6K/t81pdkparT0iXQ
         UqRivSuHguBripc8g2qmPENm7gWkXLsYSBGSWtqOINGdVHlVui62Dz1xLoKvU4LEXRAw
         +ONISHBcLa/DtBEWffemkC/VGWnm7AqBratbxOL2qerng8irHqsFLKyHWo0rUVepd1Et
         QVFmp4MVkmO+AE6gu0qswMtkByStwcQnyWA73tOnrEKr67BABarPpUVFlLIE5ubwnicX
         ZHUDe+nSnjQAHdsqkcIibgc0oXD5FltiBNKRvhUGxNtPyPs6bhcRH3gNA8K/FFBGF899
         BdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFOEOXqnCDTTcDQn4El+71G/5ufyH8CwcIjRAHLYoAg=;
        b=cOBilfKaXqRS7b+yCHla8445sM5QlWtMkQnEJY7NUsA4xvWSEclNhxRPEIT5Lj7ZDD
         19rVxLyXYlU4OUX70y8z8bJx3fvP8fWx97Ovao6iHS/V0UdGGj8LaHmM67TjoB8IfR1c
         YlhcBdM+FWpc7nZqPHvUW1yoYecuXT+wdE4lZVrUX0UOl5RrIiYvAS5LBBrd2MQEYX2l
         qGZvhTtDyUM1WWOJgM3AqH0Hm3RiYuSq3DK74nvgiQNa3EjRJpetU49OXAG2XcHEcq7n
         bzB72ekEw5vJz7J+WuWTseMczMOqlIQg170bOIwvzjchw+kqpNBDMpm+gCbgFBBu5inD
         T+xA==
X-Gm-Message-State: APjAAAVYOjj8oBAtVTQvviI4L+iqbmwBQrWc+FsVNc4AsMEPjaH7bcFX
        CPzhmAkAYGybzs5+fKxo9r7Mk9I+ZyvYNc+rBHLKEg==
X-Google-Smtp-Source: APXvYqxAnrbSBO9XoqExZSQU6rzKOVMX5hrWLQTmZJfR0JgUPSpTLbnaLmkmSiraht3cZ64g2pxjZYjbInNmVVkHL6U=
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr7276173wrm.151.1579334411045;
 Sat, 18 Jan 2020 00:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20200118063022.21743-1-cai@lca.pw>
In-Reply-To: <20200118063022.21743-1-cai@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 Jan 2020 09:00:04 +0100
Message-ID: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 18 Jan 2020 at 07:30, Qian Cai <cai@lca.pw> wrote:
>
> The commit 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers
> into 32 and 64 bit versions") introduced a KASAN error during boot,
>
>  BUG: KASAN: user-memory-access in efi_set_virtual_address_map+0x4d3/0x574
>  Read of size 8 at addr 00000000788fee50 by task swapper/0/0
>
>  Hardware name: HP ProLiant XL450 Gen9 Server/ProLiant XL450 Gen9
>  Server, BIOS U21 05/05/2016
>  Call Trace:
>   dump_stack+0xa0/0xea
>   __kasan_report.cold.8+0xb0/0xc0
>   kasan_report+0x12/0x20
>   __asan_load8+0x71/0xa0
>   efi_set_virtual_address_map+0x4d3/0x574
>   efi_enter_virtual_mode+0x5f3/0x64e
>   start_kernel+0x53a/0x5dc
>   x86_64_start_reservations+0x24/0x26
>   x86_64_start_kernel+0xf4/0xfb
>   secondary_startup_64+0xb6/0xc0
>
> It points to this line,
>
> status = efi_call(efi.systab->runtime->set_virtual_address_map,
>
> efi.systab->runtime's address is 00000000788fee18 which is an address in
> EFI runtime service and does not have a KASAN shadow page. Fix it by
> doing a copy_from_user() first instead.
>

Can't we just use READ_ONCE_NOCHECK() instead?

> Fixes: 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers into 32 and 64 bit versions")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/platform/efi/efi_64.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 515eab388b56..d6712c9cb9d8 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -1023,6 +1023,7 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
>                                                 u32 descriptor_version,
>                                                 efi_memory_desc_t *virtual_map)
>  {
> +       efi_runtime_services_t runtime;
>         efi_status_t status;
>         unsigned long flags;
>         pgd_t *save_pgd = NULL;
> @@ -1041,13 +1042,15 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
>                 efi_switch_mm(&efi_mm);
>         }
>
> +       if (copy_from_user(&runtime, efi.systab->runtime, sizeof(runtime)))
> +               return EFI_ABORTED;
> +
>         kernel_fpu_begin();
>
>         /* Disable interrupts around EFI calls: */
>         local_irq_save(flags);
> -       status = efi_call(efi.systab->runtime->set_virtual_address_map,
> -                         memory_map_size, descriptor_size,
> -                         descriptor_version, virtual_map);
> +       status = efi_call(runtime.set_virtual_address_map, memory_map_size,
> +                         descriptor_size, descriptor_version, virtual_map);
>         local_irq_restore(flags);
>
>         kernel_fpu_end();
> --
> 2.21.0 (Apple Git-122.2)
>
