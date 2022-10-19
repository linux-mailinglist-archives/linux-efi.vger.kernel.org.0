Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC1603A60
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJSHLY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJSHLX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:11:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7E976564;
        Wed, 19 Oct 2022 00:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 776C561796;
        Wed, 19 Oct 2022 07:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1256C433B5;
        Wed, 19 Oct 2022 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666163480;
        bh=O5F5FesobYNwryewrLkS0y9nbGIUKDKjSbFzCMWrYCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K3CpHF8+g6iZ0oEXzTBhbEIpTCLksiWfr3I4fRoRuhg5qCMetuzjAPmPrSsZnSvf6
         l0+38tjSnDVuXtzKLOmc52d5b291fbcjdIwjpMk8xn3DZToVJytiIkaApk0OpZ9jCP
         Ujy6QMcF44nSxwQVgtWMnETe82QvvysrFYUHbHiA95VkNbKqPkEDXoHJ5TAMpsnaN3
         fHXOyJs70vSnck3zmTYYovB3uVaZLhitZLtQyizSpxTUjOHANzlO8jV1WHCWv3Uqd1
         uItGNKQiNqkYFdsvMj34A1Ap1nbgjURBjePSovF6UkvBox3//lBCiYKFqYKP1LCcEv
         W98246qV4tmFw==
Received: by mail-lf1-f42.google.com with SMTP id g7so21512348lfv.5;
        Wed, 19 Oct 2022 00:11:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ksnAbgXTnutfebmeeNIxNgaVq1yKlZ1SRlk6cj58CbcHR0pAJ
        hmdipYzES84sLGEQsxSzEOQ055MNkQDXi04XMVs=
X-Google-Smtp-Source: AMsMyM6iW2W915J+ugjO1mbyqFOKqxL6qJNsaHw+q57rQiwIaVr+zbSb3Da+qs80TXUNHbQ0cxlSCup01xpozrWDc6g=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr2218986lfb.583.1666163478811; Wed, 19
 Oct 2022 00:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <30135b246edca4185b3943d62e40dfc7f3740f71.1662459668.git.baskov@ispras.ru>
In-Reply-To: <30135b246edca4185b3943d62e40dfc7f3740f71.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:11:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFe+Z0-4EzPxykiasQT6WjGr78+cQh1Rx14OVwG+BBtNg@mail.gmail.com>
Message-ID: <CAMj1kXFe+Z0-4EzPxykiasQT6WjGr78+cQh1Rx14OVwG+BBtNg@mail.gmail.com>
Subject: Re: [PATCH 05/16] x86/boot: Support 4KB pages for identity mapping
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Current identity mapping code only supports 2M and 1G pages.
> 4KB pages are desirable for better memory protection granularity
> in compressed kernel code.
>
> Change identity mapping code to support 4KB pages and
> memory remapping with different attributes.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

This looks reasonable to me but someone on team-x86 will need to review this.

One nit below

> ---
>  arch/x86/include/asm/init.h |   1 +
>  arch/x86/mm/ident_map.c     | 186 +++++++++++++++++++++++++++++-------
>  2 files changed, 155 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index 5f1d3c421f68..a8277ee82c51 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -8,6 +8,7 @@ struct x86_mapping_info {
>         unsigned long page_flag;         /* page flag for PMD or PUD entry */
>         unsigned long offset;            /* ident mapping offset */
>         bool direct_gbpages;             /* PUD level 1GB page support */
> +       bool allow_4kpages;              /* Allow more granular mappings with 4K pages */
>         unsigned long kernpg_flag;       /* kernel pagetable flag override */
>  };
>
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..ad455d4ef595 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -2,26 +2,130 @@
>  /*
>   * Helper routines for building identity mapping page tables. This is
>   * included by both the compressed kernel and the regular kernel.
> + *

Drop this change

>   */
>
> -static void ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
> -                          unsigned long addr, unsigned long end)
> +static void ident_pte_init(struct x86_mapping_info *info, pte_t *pte_page,
> +                          unsigned long addr, unsigned long end,
> +                          unsigned long flags)
>  {
> -       addr &= PMD_MASK;
> -       for (; addr < end; addr += PMD_SIZE) {
> +       addr &= PAGE_MASK;
> +       for (; addr < end; addr += PAGE_SIZE) {
> +               pte_t *pte = pte_page + pte_index(addr);
> +
> +               set_pte(pte, __pte((addr - info->offset) | flags));
> +       }
> +}
> +
> +pte_t *ident_split_large_pmd(struct x86_mapping_info *info,
> +                            pmd_t *pmdp, unsigned long page_addr)
> +{
> +       unsigned long pmd_addr, page_flags;
> +       pte_t *pte;
> +
> +       pte = (pte_t *)info->alloc_pgt_page(info->context);
> +       if (!pte)
> +               return NULL;
> +
> +       pmd_addr = page_addr & PMD_MASK;
> +
> +       /* Not a large page - clear PSE flag */
> +       page_flags = pmd_flags(*pmdp) & ~_PSE;
> +       ident_pte_init(info, pte, pmd_addr, pmd_addr + PMD_SIZE, page_flags);
> +
> +       return pte;
> +}
> +
> +static int ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
> +                         unsigned long addr, unsigned long end,
> +                         unsigned long flags)
> +{
> +       unsigned long next;
> +       bool new_table = 0;
> +
> +       for (; addr < end; addr = next) {
>                 pmd_t *pmd = pmd_page + pmd_index(addr);
> +               pte_t *pte;
>
> -               if (pmd_present(*pmd))
> +               next = (addr & PMD_MASK) + PMD_SIZE;
> +               if (next > end)
> +                       next = end;
> +
> +               /*
> +                * Use 2M pages if 4k pages are not allowed or
> +                * we are not mapping extra, i.e. address and size are aligned.
> +                */
> +
> +               if (!info->allow_4kpages ||
> +                   (!(addr & ~PMD_MASK) && next == addr + PMD_SIZE)) {
> +
> +                       pmd_t pmdval;
> +
> +                       addr &= PMD_MASK;
> +                       pmdval = __pmd((addr - info->offset) | flags | _PSE);
> +                       set_pmd(pmd, pmdval);
>                         continue;
> +               }
> +
> +               /*
> +                * If currently mapped page is large, we need to split it.
> +                * The case when we can remap 2M page to 2M page
> +                * with different flags is already covered above.
> +                *
> +                * If there's nothing mapped to desired address,
> +                * we need to allocate new page table.
> +                */
>
> -               set_pmd(pmd, __pmd((addr - info->offset) | info->page_flag));
> +               if (pmd_large(*pmd)) {
> +                       pte = ident_split_large_pmd(info, pmd, addr);
> +                       new_table = 1;
> +               } else if (!pmd_present(*pmd)) {
> +                       pte = (pte_t *)info->alloc_pgt_page(info->context);
> +                       new_table = 1;
> +               } else {
> +                       pte = pte_offset_kernel(pmd, 0);
> +                       new_table = 0;
> +               }
> +
> +               if (!pte)
> +                       return -ENOMEM;
> +
> +               ident_pte_init(info, pte, addr, next, flags);
> +
> +               if (new_table)
> +                       set_pmd(pmd, __pmd(__pa(pte) | info->kernpg_flag));
>         }
> +
> +       return 0;
>  }
>
> +
> +pmd_t *ident_split_large_pud(struct x86_mapping_info *info,
> +                            pud_t *pudp, unsigned long page_addr)
> +{
> +       unsigned long pud_addr, page_flags;
> +       pmd_t *pmd;
> +
> +       pmd = (pmd_t *)info->alloc_pgt_page(info->context);
> +       if (!pmd)
> +               return NULL;
> +
> +       pud_addr = page_addr & PUD_MASK;
> +
> +       /* Not a large page - clear PSE flag */
> +       page_flags = pud_flags(*pudp) & ~_PSE;
> +       ident_pmd_init(info, pmd, pud_addr, pud_addr + PUD_SIZE, page_flags);
> +
> +       return pmd;
> +}
> +
> +
>  static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>                           unsigned long addr, unsigned long end)
>  {
>         unsigned long next;
> +       bool new_table = 0;
> +       int result;
>
>         for (; addr < end; addr = next) {
>                 pud_t *pud = pud_page + pud_index(addr);
> @@ -31,28 +135,39 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>                 if (next > end)
>                         next = end;
>
> +               /* Use 1G pages only if forced, even if they are supported. */
>                 if (info->direct_gbpages) {
>                         pud_t pudval;
> -
> -                       if (pud_present(*pud))
> -                               continue;
> +                       unsigned long flags;
>
>                         addr &= PUD_MASK;
> -                       pudval = __pud((addr - info->offset) | info->page_flag);
> +                       flags = info->page_flag | _PSE;
> +                       pudval = __pud((addr - info->offset) | flags);
> +
>                         set_pud(pud, pudval);
>                         continue;
>                 }
>
> -               if (pud_present(*pud)) {
> +               if (pud_large(*pud)) {
> +                       pmd = ident_split_large_pud(info, pud, addr);
> +                       new_table = 1;
> +               } else if (!pud_present(*pud)) {
> +                       pmd = (pmd_t *)info->alloc_pgt_page(info->context);
> +                       new_table = 1;
> +               } else {
>                         pmd = pmd_offset(pud, 0);
> -                       ident_pmd_init(info, pmd, addr, next);
> -                       continue;
> +                       new_table = 0;
>                 }
> -               pmd = (pmd_t *)info->alloc_pgt_page(info->context);
> +
>                 if (!pmd)
>                         return -ENOMEM;
> -               ident_pmd_init(info, pmd, addr, next);
> -               set_pud(pud, __pud(__pa(pmd) | info->kernpg_flag));
> +
> +               result = ident_pmd_init(info, pmd, addr, next, info->page_flag);
> +               if (result)
> +                       return result;
> +
> +               if (new_table)
> +                       set_pud(pud, __pud(__pa(pmd) | info->kernpg_flag));
>         }
>
>         return 0;
> @@ -63,6 +178,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
>  {
>         unsigned long next;
>         int result;
> +       bool new_table = 0;
>
>         for (; addr < end; addr = next) {
>                 p4d_t *p4d = p4d_page + p4d_index(addr);
> @@ -72,15 +188,14 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
>                 if (next > end)
>                         next = end;
>
> -               if (p4d_present(*p4d)) {
> +               if (!p4d_present(*p4d)) {
> +                       pud = (pud_t *)info->alloc_pgt_page(info->context);
> +                       new_table = 1;
> +               } else {
>                         pud = pud_offset(p4d, 0);
> -                       result = ident_pud_init(info, pud, addr, next);
> -                       if (result)
> -                               return result;
> -
> -                       continue;
> +                       new_table = 0;
>                 }
> -               pud = (pud_t *)info->alloc_pgt_page(info->context);
> +
>                 if (!pud)
>                         return -ENOMEM;
>
> @@ -88,19 +203,22 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
>                 if (result)
>                         return result;
>
> -               set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
> +               if (new_table)
> +                       set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
>         }
>
>         return 0;
>  }
>
> -int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
> -                             unsigned long pstart, unsigned long pend)
> +int kernel_ident_mapping_init(struct x86_mapping_info *info,
> +                             pgd_t *pgd_page, unsigned long pstart,
> +                             unsigned long pend)
>  {
>         unsigned long addr = pstart + info->offset;
>         unsigned long end = pend + info->offset;
>         unsigned long next;
>         int result;
> +       bool new_table;
>
>         /* Set the default pagetable flags if not supplied */
>         if (!info->kernpg_flag)
> @@ -117,20 +235,24 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
>                 if (next > end)
>                         next = end;
>
> -               if (pgd_present(*pgd)) {
> +               if (!pgd_present(*pgd)) {
> +                       p4d = (p4d_t *)info->alloc_pgt_page(info->context);
> +                       new_table = 1;
> +               } else {
>                         p4d = p4d_offset(pgd, 0);
> -                       result = ident_p4d_init(info, p4d, addr, next);
> -                       if (result)
> -                               return result;
> -                       continue;
> +                       new_table = 0;
>                 }
>
> -               p4d = (p4d_t *)info->alloc_pgt_page(info->context);
>                 if (!p4d)
>                         return -ENOMEM;
> +
>                 result = ident_p4d_init(info, p4d, addr, next);
>                 if (result)
>                         return result;
> +
> +               if (!new_table)
> +                       continue;
> +
>                 if (pgtable_l5_enabled()) {
>                         set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
>                 } else {
> --
> 2.35.1
>
