Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F9243713
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMJC5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHMJC4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 05:02:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E257C061383
        for <linux-efi@vger.kernel.org>; Thu, 13 Aug 2020 02:02:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a14so4550734wra.5
        for <linux-efi@vger.kernel.org>; Thu, 13 Aug 2020 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkTNyYRkgbYaz12fQ06lSjHZCH+igEZHF1ZLr68a4Pc=;
        b=St0rjCN4LjocFxkWL2JKEHSwd9frPy+F8cEY6fwOY2zb573Puar+J4dmOX93BYgyr4
         QLGDtaiyyIz0FvAKSb8GN8ZbpWHiGNprjhz1Azjgak+uuZ43kGqUHpeCIc+ovidTTnlR
         iA15WOt0WKozh7jPYU6yMYAHNrrTm6e+C4Dgk6Q9N6W767i1ZsctFf1BPk5xx4ZWDBcu
         siZ9A5zErf8C/BWkoG5NvGhe8XbjPdjkKxPlyWeDxnReShIuryID17YQLM9h+nIDWU35
         9YBsm8mnKeiwZvDsr6kZKWSK1iiFbvZywmlGMjZ7Kql4rbCqTNW8q+V4ixmve26d8ola
         rpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkTNyYRkgbYaz12fQ06lSjHZCH+igEZHF1ZLr68a4Pc=;
        b=n4YCyve9emstiaNStMlOYK2Otw57O3IG2DY98r9BHMcDBquQqoYsPc0+kUat+OqxRp
         +sljbdBD4xapPtTlD7iIMebfBfB/SZUxl6R6U61g7OfTeVdS6epH6Zud7TZVJWIAflMQ
         WwRwz0CC8tFALqz/WD+enwNKX7G7RiwDSRwf7AGfsy13DGZfk3t0/On+eqU3D4YDHPLx
         ASUwlV1fABwD0eBBMhPOhq9EYmDymdcPxhCI82VrkQ3gZLmORonTMKOP12/TqdV4ctIS
         9ecI3ZnWsWwTRfk0HzpNxtP4sKEPsJkeTlOCGoD4xtPC8/QRvYJ5Pq2MwOiMYg+FkqN8
         P8UQ==
X-Gm-Message-State: AOAM530DT+GcCoauS519oLWVCDTATu0cWWWI5cgtjJFECoRdQT9l6InM
        KM+OuqimNOnU25pMb4N9ogy+PJsjcEIk86xtIOES9w==
X-Google-Smtp-Source: ABdhPJy8nUOMaGRe0BURglBOmXleJkANpz2NiBadP7lUJ5kkQU8jl5Xhlbgg7oHKuzRDxciF04E9cwa/9uPwF7neweg=
X-Received: by 2002:adf:f186:: with SMTP id h6mr3187988wro.144.1597309374980;
 Thu, 13 Aug 2020 02:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200812234758.3563-1-atish.patra@wdc.com> <20200812234758.3563-10-atish.patra@wdc.com>
In-Reply-To: <20200812234758.3563-10-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Aug 2020 14:32:43 +0530
Message-ID: <CAAhSdy3WTxXkd87ZjBM=v4zy7VEy5zimpf9cnbssnspYhBgY4A@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] RISC-V: Add page table dump support for uefi
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        fwts-devel@lists.ubuntu.com, Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 13, 2020 at 5:18 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Extend the current page table dump support in RISC-V to include efi
> pages as well.
>
> Here is the output of efi runtime page table mappings.
>
> ---[ UEFI runtime start ]---
> 0x0000000020002000-0x0000000020003000 0x00000000be732000 4K PTE D A . . . W R V
> 0x0000000020018000-0x0000000020019000 0x00000000be738000 4K PTE D A . . . W R V
> 0x000000002002c000-0x000000002002d000 0x00000000be73c000 4K PTE D A . . . W R V
> 0x0000000020031000-0x0000000020032000 0x00000000bff61000 4K PTE D A . . X W R V
> ---[ UEFI runtime end ]---
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/ptdump.c | 48 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 0831c2e61a8f..ace74dec7492 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2019 SiFive
>   */
>
> +#include <linux/efi.h>
>  #include <linux/init.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> @@ -49,6 +50,14 @@ struct addr_marker {
>         const char *name;
>  };
>
> +/* Private information for debugfs */
> +struct ptd_mm_info {
> +       struct mm_struct                *mm;
> +       const struct addr_marker        *markers;
> +       unsigned long base_addr;
> +       unsigned long end;
> +};
> +
>  static struct addr_marker address_markers[] = {
>  #ifdef CONFIG_KASAN
>         {KASAN_SHADOW_START,    "Kasan shadow start"},
> @@ -68,6 +77,28 @@ static struct addr_marker address_markers[] = {
>         {-1, NULL},
>  };
>
> +static struct ptd_mm_info kernel_ptd_info = {
> +       .mm             = &init_mm,
> +       .markers        = address_markers,
> +       .base_addr      = KERN_VIRT_START,
> +       .end            = ULONG_MAX,
> +};
> +
> +#ifdef CONFIG_EFI
> +static struct addr_marker efi_addr_markers[] = {
> +               { 0,            "UEFI runtime start" },
> +               { SZ_1G,        "UEFI runtime end" },
> +               { -1,           NULL }
> +};
> +
> +static struct ptd_mm_info efi_ptd_info = {
> +       .mm             = &efi_mm,
> +       .markers        = efi_addr_markers,
> +       .base_addr      = 0,
> +       .end            = SZ_2G,
> +};
> +#endif
> +
>  /* Page Table Entry */
>  struct prot_bits {
>         u64 mask;
> @@ -245,22 +276,22 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr,
>         }
>  }
>
> -static void ptdump_walk(struct seq_file *s)
> +static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
>  {
>         struct pg_state st = {
>                 .seq = s,
> -               .marker = address_markers,
> +               .marker = pinfo->markers,
>                 .level = -1,
>                 .ptdump = {
>                         .note_page = note_page,
>                         .range = (struct ptdump_range[]) {
> -                               {KERN_VIRT_START, ULONG_MAX},
> +                               {pinfo->base_addr, pinfo->end},
>                                 {0, 0}
>                         }
>                 }
>         };
>
> -       ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
> +       ptdump_walk_pgd(&st.ptdump, pinfo->mm, NULL);
>  }
>
>  void ptdump_check_wx(void)
> @@ -293,7 +324,7 @@ void ptdump_check_wx(void)
>
>  static int ptdump_show(struct seq_file *m, void *v)
>  {
> -       ptdump_walk(m);
> +       ptdump_walk(m, m->private);
>
>         return 0;
>  }
> @@ -308,8 +339,13 @@ static int ptdump_init(void)
>                 for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
>                         pg_level[i].mask |= pte_bits[j].mask;
>
> -       debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
> +       debugfs_create_file("kernel_page_tables", 0400, NULL, &kernel_ptd_info,
>                             &ptdump_fops);
> +#ifdef CONFIG_EFI
> +       if (efi_enabled(EFI_RUNTIME_SERVICES))
> +               debugfs_create_file("efi_page_tables", 0400, NULL, &efi_ptd_info,
> +                                   &ptdump_fops);
> +#endif
>
>         return 0;
>  }
> --
> 2.24.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
