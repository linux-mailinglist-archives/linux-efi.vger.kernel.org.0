Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F584114598
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfLERQc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 12:16:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERQc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 12:16:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so4612972wrr.1
        for <linux-efi@vger.kernel.org>; Thu, 05 Dec 2019 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAwiYjCNgciqSPLu6CPv+0QA6yapnSPAP0CMALZ+gDg=;
        b=GBQk40nzgtfXaPuxaG26XqAo0RLki4XUmMpOBtdlRXn5OLsGAG4Ltv7XvP720DBjTK
         8Q2+0R1kD888oPXnBpEOw/g/BTDabkYrKTQiY/SyqLFQcrSo3k/e7LcwnJWslbvsddAe
         P9b9HxQUEaGQUJITZZSrEq5VOAbLp3pxPDlTxbqFfSwUxnGlM4YrixxUapKljPLdTUC3
         zKfD0nCPcwvGtVW3HepYDh02WWmTTA6mfCHUgmexw4NRmT9zkg3I5RmWsSTUsVA7VJAH
         CQalAznWey/Iuir/MYfkJ4/XpFPZ7n+fG01Qk50t53ZnqfjXyJOpL/9iCI+l3UeM8Fx8
         qrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAwiYjCNgciqSPLu6CPv+0QA6yapnSPAP0CMALZ+gDg=;
        b=nxDxti9Og4vCue/Z9YZ9yBGxiZrui/UhJVuw+WnXc12TDGJeUkYZVQnHFwK5ilgYV+
         +8Ep1oQ5M9Aa5VQIMoKpajrgLb+V6yXeCBzuWZMPzMJ+de445l/X2lD1afIAbBMAqJEJ
         LqErARH4NSIt1J70tGreKIJsbTd5GjkQ5hiFQT2VPPGgyBDkNyhClczeTtTA9bRhsrcB
         EDYl+R1fYp8p5Rflci4ahPbR2aI42njxVvh+U173J5p3oa7j4+VXSy089lYZ40jKFSYU
         O1fk3d5nGlcZiOjGKMrXZp6ImoxmfRrLqEGL+Z2jjbgLQ138xEIT3knRnueTzDsw736G
         9DfA==
X-Gm-Message-State: APjAAAVykpYmfrpVeJ3awd2xPfOuay3q1hdTJCX4rx8Y+8hwwniQhln+
        yWxsk3gNNgH4qs3NSogR15DDoa9V7mBVUvglIpzvC7jlY+jdAA==
X-Google-Smtp-Source: APXvYqyAH/sbLzlQoJjQ115pAOAQGrKciep+rLHw6SzVupEVl4WyxNi9grrcfl4K5UUshx+xMAxha7fmEWuyXAU1PpY=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr10690214wrr.32.1575566190803;
 Thu, 05 Dec 2019 09:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20191205164248.14511-1-ardb@kernel.org>
In-Reply-To: <20191205164248.14511-1-ardb@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 17:16:27 +0000
Message-ID: <CAKv+Gu9Q3TULTu9-=BtsCdzQJBb6ta=4=2RWNR-Q-NtqwCBQWg@mail.gmail.com>
Subject: Re: [PATCH v4] efi/earlycon: Remap entire framebuffer after page initialization
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Dec 2019 at 16:42, Ard Biesheuvel <ardb@kernel.org> wrote:
>
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
> +       /* bail if there is no bootconsole or it has been disabled already */
> +       if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> +               return 0;
> +
> +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> +               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> +       else
> +               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> +
> +       return efi_fb ? 0 : -ENOMEM;
> +}
> +early_initcall(efi_earlycon_remap_fb);
> +
> +static int __init efi_earlycon_unmap_fb(void)
> +{
> +       /* unmap the bootconsole fb unless keep_bootcon has left it enabled */
> +       if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
> +               memunmap(efi_fb);
> +       return 0;
> +}
> +late_initcall(efi_earlycon_unmap_fb);
>
>  static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
>  {
> +       if (efi_fb)
> +               return efi_fb + start;
> +
>         return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
>  }
>

Actually, now I'm not so sure we really need the early map/unmap for
every line. If we switch from an early mapping to an ordinary mapping
at early_initcall() time, we can just map it once, and tear it down
when we do the ordinary memremap()


>  static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
>  {
> +       if (efi_fb)
> +               return;
> +
>         early_memunmap(addr, len);
>  }
>
> @@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
>                 efi_earlycon_scroll_up();
>
>         device->con->write = efi_earlycon_write;
> +       earlycon_console = device->con;
>         return 0;
>  }
>  EARLYCON_DECLARE(efifb, efi_earlycon_setup);
> --
> 2.17.1
>
