Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C66B0345
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCHJnY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 04:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCHJmr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 04:42:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C5B8550;
        Wed,  8 Mar 2023 01:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F556B81C11;
        Wed,  8 Mar 2023 09:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDFC433D2;
        Wed,  8 Mar 2023 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268533;
        bh=oPiHWLua0tLwVAAuAz8F/OPsJiMy/w96nLuLxOb8i+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CUr1yKrwF9dqHU7m/MztLeEoQJkB6IqyMQZqe0cSWjl+/9KvHXo0Kutk6XoD2b4GG
         OqKb2Qg+QKMNr6NZ0UmQM17K9xm6KCqNRxyUJBQ1ou8Ly5oPTBS8ysNRJ0ytGFp+kp
         weoQ/QyERuY8F0HHkEf/iTtmt2vFnieWCfBQjXUj0XAsFe7nVDS2K5W+ohm/bCYPAU
         axjqGe7yXoXaqWhjK8lTrSKafEGgItUdUerHa0TIL9CrGnB8wkY1J4E1kMk1mPvlKj
         nHY8i0VnP6OwWDoE686gkj5pSq+WwQSMJxxqyU0OjbUGKy4hS/eDSMNdPjsuJbXhWA
         RQyhwBzRvKUgg==
Received: by mail-lf1-f49.google.com with SMTP id s22so20513958lfi.9;
        Wed, 08 Mar 2023 01:42:13 -0800 (PST)
X-Gm-Message-State: AO0yUKWPdPXENnEB2tGN8rz5tLPk62XerM/s1lOfwZFffD/En7kioM/S
        1W0CewvfTnbzJwZ7LJFuw9pxWZr3NQD2YuWluI4=
X-Google-Smtp-Source: AK7set8YyKwikmkKejGnkyn7e+Bhl4bXnXnhXyxYoCTSKHXzlSibFChkfI2ruaXmjSJ+CgKf6RPizD0loCUMM7eyv3U=
X-Received: by 2002:ac2:5923:0:b0:4d5:ca42:e43e with SMTP id
 v3-20020ac25923000000b004d5ca42e43emr5517585lfi.7.1678268531843; Wed, 08 Mar
 2023 01:42:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <9e8d2ad89c62016c6cae031a0b8a368e4c94073e.1671098103.git.baskov@ispras.ru>
In-Reply-To: <9e8d2ad89c62016c6cae031a0b8a368e4c94073e.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 10:42:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtyuktQmbhoHctikwyH-eJfE8d2nzs1-2csYy4+and4Q@mail.gmail.com>
Message-ID: <CAMj1kXFtyuktQmbhoHctikwyH-eJfE8d2nzs1-2csYy4+and4Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/26] x86/boot: Support 4KB pages for identity mapping
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Current identity mapping code only supports 2M and 1G pages.
> 4KB pages are desirable for better memory protection granularity
> in compressed kernel code.
>
> Change identity mapping code to support 4KB pages and
> memory remapping with different attributes.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

This patch triggers an error reported by the build bots:

arch/x86/mm/ident_map.c:19:8: warning: no previous prototype for
'ident_split_large_pmd'


> ---
>  arch/x86/include/asm/init.h |   1 +
>  arch/x86/mm/ident_map.c     | 185 +++++++++++++++++++++++++++++-------
>  2 files changed, 154 insertions(+), 32 deletions(-)
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
> index 968d7005f4a7..662e794a325d 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -4,24 +4,127 @@
>   * included by both the compressed kernel and the regular kernel.
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
> +                * The case when we don't can remap 2M page to 2M page
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
> @@ -31,28 +134,39 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
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
> @@ -63,6 +177,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
>  {
>         unsigned long next;
>         int result;
> +       bool new_table = 0;
>
>         for (; addr < end; addr = next) {
>                 p4d_t *p4d = p4d_page + p4d_index(addr);
> @@ -72,15 +187,14 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
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
> @@ -88,19 +202,22 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
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
> @@ -117,20 +234,24 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
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
> 2.37.4
>
