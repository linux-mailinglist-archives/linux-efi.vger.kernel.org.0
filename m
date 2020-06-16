Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF0F1FAA82
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFPHzc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 03:55:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33886 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPHzc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Jun 2020 03:55:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id b8so18492665oic.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 00:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0UZS1344FZMJ9sVFAfBG3IhgSf2KKzqEk05E3yUoqE=;
        b=XSoEIrJFfMJpsVDmEYeN+s7sn8b++OYc0VhGWUknduLRw7AAsN3nUKf0nXoMgqHDxH
         H2REilAds+qP5faePtQrJZ8+G6/DaT2t4lnJurrUZdMx3H1iKZWZ+2OQQyAYrtpsjbk8
         A9/S7oEBaZaeevnfjhwpXEkiMY90ImoLFvmreVjRQrTjLLwCCY5iCTHJPSDhf9NgdCOm
         +meAoww0ISyDONAIZtm4Z5NtqdbHev7zL4xduwrcwpKkWl4ALyJtx//e+dbUfsFGOYDA
         qB/FPvNrMOdgC1F7RUojay5QmDSYJy/Pe2fRr8AEXq+PU/0z1ZkwS7bpOfT2UJd49iik
         GA5Q==
X-Gm-Message-State: AOAM533/NLloEkLdqGHfYXj6IO5qpR2wGbHc33D48K3+F4AwG4ZwLRUq
        Tv444paGWfisTjrco9DlBj1cTU53PlaP0R2EmLWGfens
X-Google-Smtp-Source: ABdhPJwMnh9vOBm1ivYzGguW+ODZxfzPd6QA/5LfGE9ipyABVaPN48l1YV96vpeXAN8+8zfTbP7W4KvdyyhcLDM4QBY=
X-Received: by 2002:aca:849:: with SMTP id 70mr2295786oii.153.1592294130938;
 Tue, 16 Jun 2020 00:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org> <20200422172414.6662-3-ardb@kernel.org>
In-Reply-To: <20200422172414.6662-3-ardb@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Jun 2020 09:55:19 +0200
Message-ID: <CAMuHMdXZM7XYBt=2dJFJi+xxe2HOh43KzSkxGoMqaaC_kc_P-g@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] efi/libstub: Make initrd file loader configurable
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Apr 22, 2020 at 7:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> Loading an initrd passed via the kernel command line is deprecated: it
> is limited to files that reside in the same volume as the one the kernel
> itself was loaded from, and we have more flexible ways to achieve the
> same. So make it configurable so new architectures can decide not to
> enable it.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for your patch, which is now commit cf6b83664895a5c7
("efi/libstub: Make initrd file loader configurable")!

> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -124,6 +124,17 @@ config EFI_ARMSTUB_DTB_LOADER
>           functionality for bootloaders that do not have such support
>           this option is necessary.
>
> +config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> +       bool "Enable the command line initrd loader"
> +       depends on EFI_GENERIC_STUB
> +       default y
> +       help
> +         Select this config option to add support for the initrd= command
> +         line parameter, allowing an initrd that resides on the same volume
> +         as the kernel image to be loaded into memory.
> +
> +         This method is deprecated.

So why the default y?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
