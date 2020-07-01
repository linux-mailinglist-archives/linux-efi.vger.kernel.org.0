Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092B1210F44
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbgGAP3I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 11:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbgGAP3G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Jul 2020 11:29:06 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2AF2080D;
        Wed,  1 Jul 2020 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593617345;
        bh=6RpV1PcquvB5KGvhSCCiefj50EJSlVYNbwhMO1x1uCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ygHhpl2SmxB+e5wnrEz/3ytMzGGNVa6l1A1Pbt9+PJObGItQapT47KKhK0sNXpVXd
         4JxktHJuJAxQ3EHVTZ2zm1HBVQxeTFYzBJj5bHagVuQV0jB4oBst4FCe4RIg+IKqoX
         klM8tt/oX7hd9Fx9OBSvXkgEOo6mrmjD7VL2TUwA=
Received: by mail-ot1-f43.google.com with SMTP id w17so13855864otl.4;
        Wed, 01 Jul 2020 08:29:05 -0700 (PDT)
X-Gm-Message-State: AOAM530tzjqRde6k7YLEKKlG69V9GqhfdrMgO0YUM4HcuoFgfpEdLvti
        qcMciQRcX2Gzpx0TPjDegmBZgjWbS/dia7Gl58Y=
X-Google-Smtp-Source: ABdhPJwNNaDzx+H1Y3TYfLidx+Pqudx5QWzNub0n5wZ8PcUy4pg2RLhXJ5Uh5+gNutpFPFtgbNTuCdqGgaRri+NIb7Q=
X-Received: by 2002:a9d:688:: with SMTP id 8mr22965465otx.108.1593617344228;
 Wed, 01 Jul 2020 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200701141731.377252388@hpe.com> <20200701141733.081104906@hpe.com>
In-Reply-To: <20200701141733.081104906@hpe.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Jul 2020 17:28:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEm89QCN5AqVBQ4pM21SFAXWfyj4_T9UDStL6K2FGNDqw@mail.gmail.com>
Message-ID: <CAMj1kXEm89QCN5AqVBQ4pM21SFAXWfyj4_T9UDStL6K2FGNDqw@mail.gmail.com>
Subject: Re: [patch 13/13] Remove (now unused) EFI_UV1_MEMMAP from efi.h
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 1 Jul 2020 at 16:18, <steve.wahl@hpe.com> wrote:
>
> With UV1 support removed, EFI_UV1_MEMMAP is no longer used.
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/include/asm/efi.h |   20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> --- linux.orig/arch/x86/include/asm/efi.h       2020-06-17 14:21:49.798542440 -0500
> +++ linux/arch/x86/include/asm/efi.h    2020-06-17 14:28:55.830071857 -0500
> @@ -22,17 +22,7 @@ extern unsigned long efi_fw_vendor, efi_
>   *
>   * This is the main reason why we're doing stable VA mappings for RT
>   * services.
> - *
> - * SGI UV1 machines are known to be incompatible with this scheme, so we
> - * provide an opt-out for these machines via a DMI quirk that sets the
> - * attribute below.
>   */
> -#define EFI_UV1_MEMMAP         EFI_ARCH_1
> -
> -static inline bool efi_have_uv1_memmap(void)
> -{
> -       return IS_ENABLED(CONFIG_X86_UV) && efi_enabled(EFI_UV1_MEMMAP);
> -}
>
>  #define EFI32_LOADER_SIGNATURE "EL32"
>  #define EFI64_LOADER_SIGNATURE "EL64"
> @@ -122,9 +112,7 @@ struct efi_scratch {
>         efi_sync_low_kernel_mappings();                                 \
>         kernel_fpu_begin();                                             \
>         firmware_restrict_branch_speculation_start();                   \
> -                                                                       \
> -       if (!efi_have_uv1_memmap())                                     \
> -               efi_switch_mm(&efi_mm);                                 \
> +       efi_switch_mm(&efi_mm);                                         \
>  })
>
>  #define arch_efi_call_virt(p, f, args...)                              \
> @@ -132,9 +120,7 @@ struct efi_scratch {
>
>  #define arch_efi_call_virt_teardown()                                  \
>  ({                                                                     \
> -       if (!efi_have_uv1_memmap())                                     \
> -               efi_switch_mm(efi_scratch.prev_mm);                     \
> -                                                                       \
> +       efi_switch_mm(efi_scratch.prev_mm);                             \
>         firmware_restrict_branch_speculation_end();                     \
>         kernel_fpu_end();                                               \
>  })
> @@ -176,8 +162,6 @@ extern void efi_delete_dummy_variable(vo
>  extern void efi_switch_mm(struct mm_struct *mm);
>  extern void efi_recover_from_page_fault(unsigned long phys_addr);
>  extern void efi_free_boot_services(void);
> -extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
> -extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
>
>  /* kexec external ABI */
>  struct efi_setup_data {
>
