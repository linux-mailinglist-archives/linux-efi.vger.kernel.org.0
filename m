Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E530708B90
	for <lists+linux-efi@lfdr.de>; Fri, 19 May 2023 00:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjERW2E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 May 2023 18:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjERW2E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 May 2023 18:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A262E50;
        Thu, 18 May 2023 15:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385446143A;
        Thu, 18 May 2023 22:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A4DC4339E;
        Thu, 18 May 2023 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684448881;
        bh=G/8xidsOmToKNzjv/dRHf15ohhDPrZ7ZXRGoLlUk1Nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QnGFW8qohBIqqwoI9BK7dOPO5O6Jvsa+EkXDWIOMcb6V5XZoMBEjrBCSun1vu0I55
         nSj7+cvHTzmFMXyjqP1Uu8KODM5iN1jhLMta7NWJfXMGshfzb55QoBThdCRqXyqSpy
         i4j/K6c/hTGwkF1NurFtZ/vs1ECpoZX1XJ4adkSPJP7gAMJBMKyV6TLDh/J+KzTNKe
         qM00tLS5insogCopzBWp1MFxSMAT/gScEuSk9VFATbjSwsrMsLD9O4P+4oyJx8otY8
         ThbVq9yQP+Zlij/Hng4rbEsLcJsfnRYJeImOrWytY7hDo0+xniriVzVhBczXnut6JL
         wDWPpWfXrGQUw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso3083991e87.2;
        Thu, 18 May 2023 15:28:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDwBLsw/SyEq3toz4OyLWBXp8bAwxglBEWF1IbEubLumRmfk6dBm
        XTAuWQvXhvT0h3uyTMnQ1ApxTTqQHEK3yUXIb7k=
X-Google-Smtp-Source: ACHHUZ5H53EGiUgI/XCVnpYKMUHYnX4I+bx1MxpYz0KfKIeI5LhVs6x7BcVTXM27KGT/X3zYIK9EDZg/F7+iJHjHhqk=
X-Received: by 2002:ac2:539a:0:b0:4ec:9df9:f11a with SMTP id
 g26-20020ac2539a000000b004ec9df9f11amr167318lfh.9.1684448879538; Thu, 18 May
 2023 15:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-18-ardb@kernel.org>
 <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com>
In-Reply-To: <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 00:27:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
Message-ID: <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while
 running in the firmware
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 May 2023 at 22:16, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/8/23 02:03, Ard Biesheuvel wrote:
> > The decompressor executes in an environment with little or no access to
> > a console, and without any ability to return an error back to the caller
> > (the bootloader). So the only recourse we have when the SEV/SNP context
> > is not quite what the kernel expects is to terminate the guest entirely.
> >
> > This is a bit harsh, and also unnecessary when booting via the EFI stub,
> > given that it provides all the support that SEV guests need to probe the
> > underlying platform.
> >
> > So let's do the SEV initialization and SNP feature check before calling
> > ExitBootServices(), and simply return with an error if the SNP feature
> > mask is not as expected.
>
> My SEV-ES / SEV-SNP guests started crashing when I applied this patch.
> Turns out that sev_es_negotiate_protocol() used to be called when no #VC
> exceptions were being generated before a valid GHCB was setup. Because
> of that the current GHCB MSR value was not saved/restored. But now,
> sev_es_negotiate_protocol() is called earlier in the boot process and
> there are still messages being issued by UEFI, e.g.:
>
> SetUefiImageMemoryAttributes - 0x000000007F6D7000 - 0x0000000000006000 (0x0000000000000008)
>
> Similarly, get_hv_features() didn't worry about saving the GHCB MSR value
> and an SNP guest crashed after fixing sev_es_negotiate_protocol().
>

Thanks for the clarification

So the underlying assumption here is that performing these checks
before ExitBootServices() is better because we can still return to the
bootloader, which -like GRUB does- could simply attempt booting the
next kernel in the list.

I was obviously unaware of the complication you are hitting here. So I
wonder what your take is on this: should we defer this check until
after ExitBootServices(), and crash and burn like before if the test
fails? Or is the change below reasonable in your opinion, and we can
incorporate it? Or is there a third option, i.e., is there a SEV
specific EFI protocol that the stub should be using to establish
whether the underlying platform meets the kernel's expectations?


> The following changes got me past everything:
>
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 3a5b0c9c4fcc..23450628d41c 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -106,15 +106,19 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
>    */
>   static u64 get_hv_features(void)
>   {
> -       u64 val;
> +       u64 val, save;
>
>         if (ghcb_version < 2)
>                 return 0;
>
> +       save = sev_es_rd_ghcb_msr();
> +
>         sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
>         VMGEXIT();
> -
>         val = sev_es_rd_ghcb_msr();
> +
> +       sev_es_wr_ghcb_msr(save);
> +
>         if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
>                 return 0;
>
> @@ -139,13 +143,17 @@ static void snp_register_ghcb_early(unsigned long paddr)
>
>   static bool sev_es_negotiate_protocol(void)
>   {
> -       u64 val;
> +       u64 val, save;
> +
> +       save = sev_es_rd_ghcb_msr();
>
>         /* Do the GHCB protocol version negotiation */
>         sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
>         VMGEXIT();
>         val = sev_es_rd_ghcb_msr();
>
> +       sev_es_wr_ghcb_msr(save);
> +
>         if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
>                 return false;
>
>
> Thanks,
> Tom
>
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   arch/x86/boot/compressed/sev.c          | 12 ++++++++----
> >   arch/x86/include/asm/sev.h              |  4 ++++
> >   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++++++++++++++
> >   3 files changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> > index 014b89c890887b9a..19c40873fdd209b5 100644
> > --- a/arch/x86/boot/compressed/sev.c
> > +++ b/arch/x86/boot/compressed/sev.c
> > @@ -315,20 +315,24 @@ static void enforce_vmpl0(void)
> >    */
> >   #define SNP_FEATURES_PRESENT (0)
> >
> > +u64 snp_get_unsupported_features(void)
> > +{
> > +     if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> > +             return 0;
> > +     return sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
> > +}
> > +
> >   void snp_check_features(void)
> >   {
> >       u64 unsupported;
> >
> > -     if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> > -             return;
> > -
> >       /*
> >        * Terminate the boot if hypervisor has enabled any feature lacking
> >        * guest side implementation. Pass on the unsupported features mask through
> >        * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
> >        * as part of the guest boot failure.
> >        */
> > -     unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
> > +     unsupported = snp_get_unsupported_features();
> >       if (unsupported) {
> >               if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
> >                       sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 13dc2a9d23c1eb25..bf27b91644d0da5a 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -157,6 +157,7 @@ static __always_inline void sev_es_nmi_complete(void)
> >               __sev_es_nmi_complete();
> >   }
> >   extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> > +extern void sev_enable(struct boot_params *bp);
> >
> >   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
> >   {
> > @@ -202,12 +203,14 @@ void snp_set_wakeup_secondary_cpu(void);
> >   bool snp_init(struct boot_params *bp);
> >   void __init __noreturn snp_abort(void);
> >   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
> > +u64 snp_get_unsupported_features(void);
> >   #else
> >   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
> >   static inline void sev_es_ist_exit(void) { }
> >   static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
> >   static inline void sev_es_nmi_complete(void) { }
> >   static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
> > +static inline void sev_enable(struct boot_params *bp) { }
> >   static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
> >   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
> >   static inline void setup_ghcb(void) { }
> > @@ -225,6 +228,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
> >   {
> >       return -ENOTTY;
> >   }
> > +static inline u64 snp_get_unsupported_features(void) { return 0; }
> >   #endif
> >
> >   #endif
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index ce8434fce0c37982..33d11ba78f1d8c4f 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -15,6 +15,7 @@
> >   #include <asm/setup.h>
> >   #include <asm/desc.h>
> >   #include <asm/boot.h>
> > +#include <asm/sev.h>
> >
> >   #include "efistub.h"
> >
> > @@ -714,6 +715,22 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
> >                         &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
> >       p->efi->efi_memmap_size         = map->map_size;
> >
> > +     /*
> > +      * Call the SEV init code while still running with the firmware's
> > +      * GDT/IDT, so #VC exceptions will be handled by EFI.
> > +      */
> > +     if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> > +             u64 unsupported;
> > +
> > +             sev_enable(p->boot_params);
> > +             unsupported = snp_get_unsupported_features();
> > +             if (unsupported) {
> > +                     efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
> > +                             unsupported);
> > +                     return EFI_UNSUPPORTED;
> > +             }
> > +     }
> > +
> >       return EFI_SUCCESS;
> >   }
> >
