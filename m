Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492DFB1A6B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2019 11:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfIMJF4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Sep 2019 05:05:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54278 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfIMJF4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Sep 2019 05:05:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so1871356wmp.4
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2019 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdxQ/xcZCZL9Fn3RAjYodCBOv5q+4ekjCirRl7jEXJQ=;
        b=uboNT2olkshSweJggmBOL9Lm+TACWo3qfNzVcNKIgwYpySD9qjVbNk5/7wivL2+4ow
         q5VjphDpAtObtjtn/trYWCb0VdsHbOLqQtYvi6Vw6D/kaiJJLz2i3tYNOXg89jf4OUhV
         sZxuDoLRmoCKUq+i2se0xvW65vj2QOHFGJjR34qYmGIxtUILJiE3AFz85VnmLvd8laMY
         hQ7vEO+72bTY/xy22PzPop7vne1pTq83tJFnJ+4feSWD+gK+i3Uhq+sZncCsAyc7qYAY
         ZUjXPNLoTCmFwiok5Bh93KDTM+5JD8SCuRifS59xT+V45K8EgkUKCvqizE89ewqGETLo
         FFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdxQ/xcZCZL9Fn3RAjYodCBOv5q+4ekjCirRl7jEXJQ=;
        b=Vw+W2XwvBpyCcJvDuKwgQ8+X5jxivSwNLkI/XXKrg14e50v2NAJzYc/11Xng/tDAgt
         jU2NxgmpYBmz4tCJiJ/Lb6q4c2Je5t3SlX84VFQqJbAZT/XCopx2iegnYW5V/IlayEYW
         P2vSOGMx1IBN6HmrKd8WohSLBAq1jP2R4MsvrAXM954ipBv26tS/1/wZt/UgJTHUrvMR
         qvdHrLlEsqtSb8b9aI9qTLisculSLsNOrL1UyIWcejzGOFGWJvygOWKNYjkknXVTPfDR
         wZWms1H7WO2ash9rw9qH8JsEkrnSVndb7pMGvXR/4PKw/0lfqLaXc78FcFs5JMwVC1nD
         M7qA==
X-Gm-Message-State: APjAAAVANUf4xmaJszcVIFnch7nTqyFUuh/Db4LuZXSG2h7taLfJdLnH
        W21JhALA72W9pwj8AiK5EcczV1nQ3xv+1NdbiXeImQ==
X-Google-Smtp-Source: APXvYqwmPY9zdnjW6V9M9HwMTGuKiHs0K8K+1HoZhaS5oP36n10nsQVmARDWufLg808Ks8Lf3AFDgVFlQhPVEq3p4no=
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr2348267wma.119.1568365552917;
 Fri, 13 Sep 2019 02:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712995374.1616117.8463747608355533922.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712995374.1616117.8463747608355533922.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 10:05:30 +0100
Message-ID: <CAKv+Gu_6zkq0cfp715sn-boGD=ZVDJ-Xk7venkQb1Gry_hxoeg@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] x86, efi: Push EFI_MEMMAP check into leaf routines
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Aug 2019 at 03:06, Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for adding another EFI_MEMMAP dependent call that needs
> to occur before e820__memblock_setup() fixup the existing efi calls to
> check for EFI_MEMMAP internally. This ends up being cleaner than the
> alternative of checking EFI_MEMMAP multiple times in setup_arch().
>
> Cc: <x86@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'd prefer it if the spurious whitespace changes could be dropped, but
otherwise, this looks fine to me, so I am not going to obsess about
it.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/x86/include/asm/efi.h      |    9 ++++++++-
>  arch/x86/kernel/setup.c         |   19 +++++++++----------
>  arch/x86/platform/efi/efi.c     |    3 +++
>  arch/x86/platform/efi/quirks.c  |    3 +++
>  drivers/firmware/efi/esrt.c     |    3 +++
>  drivers/firmware/efi/fake_mem.c |    2 +-
>  include/linux/efi.h             |    2 --
>  7 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 43a82e59c59d..45f853bce869 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -140,7 +140,6 @@ extern void efi_delete_dummy_variable(void);
>  extern void efi_switch_mm(struct mm_struct *mm);
>  extern void efi_recover_from_page_fault(unsigned long phys_addr);
>  extern void efi_free_boot_services(void);
> -extern void efi_reserve_boot_services(void);
>
>  struct efi_setup_data {
>         u64 fw_vendor;
> @@ -244,6 +243,8 @@ static inline bool efi_is_64bit(void)
>  extern bool efi_reboot_required(void);
>  extern bool efi_is_table_address(unsigned long phys_addr);
>
> +extern void efi_find_mirror(void);
> +extern void efi_reserve_boot_services(void);
>  #else
>  static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
>  static inline bool efi_reboot_required(void)
> @@ -254,6 +255,12 @@ static inline  bool efi_is_table_address(unsigned long phys_addr)
>  {
>         return false;
>  }
> +static inline void efi_find_mirror(void)
> +{
> +}
> +static inline void efi_reserve_boot_services(void)
> +{
> +}
>  #endif /* CONFIG_EFI */
>
>  #endif /* _ASM_X86_EFI_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bbe35bf879f5..9bfecb542440 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1118,21 +1118,20 @@ void __init setup_arch(char **cmdline_p)
>         cleanup_highmap();
>
>         memblock_set_current_limit(ISA_END_ADDRESS);
> +
>         e820__memblock_setup();
>
>         reserve_bios_regions();
>
> -       if (efi_enabled(EFI_MEMMAP)) {
> -               efi_fake_memmap();
> -               efi_find_mirror();
> -               efi_esrt_init();
> +       efi_fake_memmap();
> +       efi_find_mirror();
> +       efi_esrt_init();
>
> -               /*
> -                * The EFI specification says that boot service code won't be
> -                * called after ExitBootServices(). This is, in fact, a lie.
> -                */
> -               efi_reserve_boot_services();
> -       }
> +       /*
> +        * The EFI specification says that boot service code won't be
> +        * called after ExitBootServices(). This is, in fact, a lie.
> +        */
> +       efi_reserve_boot_services();
>
>         /* preallocate 4k for mptable mpc */
>         e820__memblock_alloc_reserved_mpc_new();
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index c202e1b07e29..0bb58eb33ca0 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -128,6 +128,9 @@ void __init efi_find_mirror(void)
>         efi_memory_desc_t *md;
>         u64 mirror_size = 0, total_size = 0;
>
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return;
> +
>         for_each_efi_memory_desc(md) {
>                 unsigned long long start = md->phys_addr;
>                 unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 3b9fd679cea9..7675cf754d90 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -320,6 +320,9 @@ void __init efi_reserve_boot_services(void)
>  {
>         efi_memory_desc_t *md;
>
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return;
> +
>         for_each_efi_memory_desc(md) {
>                 u64 start = md->phys_addr;
>                 u64 size = md->num_pages << EFI_PAGE_SHIFT;
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index d6dd5f503fa2..2762e0662bf4 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -246,6 +246,9 @@ void __init efi_esrt_init(void)
>         int rc;
>         phys_addr_t end;
>
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return;
> +
>         pr_debug("esrt-init: loading.\n");
>         if (!esrt_table_exists())
>                 return;
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index 9501edc0fcfb..526b45331d96 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -44,7 +44,7 @@ void __init efi_fake_memmap(void)
>         void *new_memmap;
>         int i;
>
> -       if (!nr_fake_mem)
> +       if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
>                 return;
>
>         /* count up the number of EFI memory descriptor */
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 5c1dd0221384..acc2b8982ed2 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1045,9 +1045,7 @@ extern void efi_enter_virtual_mode (void);        /* switch EFI to virtual mode, if pos
>  extern efi_status_t efi_query_variable_store(u32 attributes,
>                                              unsigned long size,
>                                              bool nonblocking);
> -extern void efi_find_mirror(void);
>  #else
> -
>  static inline efi_status_t efi_query_variable_store(u32 attributes,
>                                                     unsigned long size,
>                                                     bool nonblocking)
>
