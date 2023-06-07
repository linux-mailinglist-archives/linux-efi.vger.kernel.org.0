Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C393072666D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFGQvf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFGQve (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 12:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CA188;
        Wed,  7 Jun 2023 09:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80F161755;
        Wed,  7 Jun 2023 16:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098AFC433AF;
        Wed,  7 Jun 2023 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686156692;
        bh=fTWXqsOdQ+GQlo6s8Oemgm/FqPpMc6cdzA2maiDZLwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e3yd1enkles3shpqF56c5kmWYXNwsi++Vluzgaa2qfIs/WqinoJjE+8iE4Y3CXzAp
         KnFELCiBTxeDYL8pBfE4zPs8pDh/bEXofBv/0jkA8jsdNEwWTuZj3OB81srg0e6IQ/
         /yKAMzVHhmFM9NTu5j6DWxeINky6LRWAZLmfWOa/TympcnfzBADP/XlgWM9amvEbuv
         MjuMyjhZGmPakNpH0/Bor9MIWo7X00rhNyyL/yOvFFK0DKczN8eEhzjet4Snc4vUJF
         WGfmDddjaKS6TKqsabgcxTpK2asaSqjf7ccu+4g+hiPH7FUaZngOif1DJLnKWxpjHV
         ltwN60ymCqzIw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f620583bc2so5502121e87.1;
        Wed, 07 Jun 2023 09:51:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDyKeN9DMC34t4zFELWjWmEOffRaX2VS714iS4PKTvVTwWw3GgDC
        LXG/t2axPKpiutGCRPDZADYpAB08rgHviSGHZDg=
X-Google-Smtp-Source: ACHHUZ6WxFXx0QpjkFMtU2jymXfqnIhG8GigB3cV4+9rAyzzZ02jU5g11X498Vno+ghq/2oi+o6mT4WEHfLvkv237Ps=
X-Received: by 2002:a2e:9cd1:0:b0:2b1:e943:8abe with SMTP id
 g17-20020a2e9cd1000000b002b1e9438abemr2332841ljj.47.1686156689811; Wed, 07
 Jun 2023 09:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-20-ardb@kernel.org>
 <46f93827-630a-32f0-555d-aa51a2fd2a60@amd.com>
In-Reply-To: <46f93827-630a-32f0-555d-aa51a2fd2a60@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Jun 2023 18:51:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpxqvbo_NcgzAAHsE71GohoCcttatMXZsjVvXqPBO33w@mail.gmail.com>
Message-ID: <CAMj1kXHpxqvbo_NcgzAAHsE71GohoCcttatMXZsjVvXqPBO33w@mail.gmail.com>
Subject: Re: [PATCH v5 19/20] x86/efistub: Perform SNP feature test while
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Jun 2023 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 6/7/23 02:23, Ard Biesheuvel wrote:
> > Before refactoring the EFI stub boot flow to avoid the legacy bare metal
> > decompressor, duplicate the SNP feature check in the EFI stub before
> > handing over to the kernel proper.
> >
> > The SNP feature check can be performed while running under the EFI boot
> > services, which means we can fail gracefully and return an error to the
> > bootloader if the loaded kernel does not implement support for all the
> > features that the hypervisor enabled.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   arch/x86/boot/compressed/sev.c          | 71 +++++++++++---------
> >   arch/x86/include/asm/sev.h              |  4 ++
> >   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
> >   3 files changed, 62 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> > index 09dc8c187b3cc752..9593bc80c9c6b89d 100644
> > --- a/arch/x86/boot/compressed/sev.c
> > +++ b/arch/x86/boot/compressed/sev.c
>
> ...
>
> > -void sev_enable(struct boot_params *bp)
> > +u64 sev_get_status(void)
> >   {
> >       unsigned int eax, ebx, ecx, edx;
> >       struct msr m;
> > +
> > +     /* Check for the SME/SEV support leaf */
> > +     eax = 0x80000000;
> > +     ecx = 0;
> > +     native_cpuid(&eax, &ebx, &ecx, &edx);
> > +     if (eax < 0x8000001f)
> > +             return 0;
> > +
> > +     /*
> > +      * Check for the SME/SEV feature:
> > +      *   CPUID Fn8000_001F[EAX]
> > +      *   - Bit 0 - Secure Memory Encryption support
> > +      *   - Bit 1 - Secure Encrypted Virtualization support
> > +      *   CPUID Fn8000_001F[EBX]
> > +      *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> > +      */
> > +     eax = 0x8000001f;
> > +     ecx = 0;
> > +     native_cpuid(&eax, &ebx, &ecx, &edx);
> > +     /* Check whether SEV is supported */
> > +     if (!(eax & BIT(1)))
> > +             return 0;
> > +
> > +     /* Set the SME mask if this is an SEV guest. */
> > +     sme_me_mask = BIT_ULL(ebx & 0x3f);
> > +
> > +     boot_rdmsr(MSR_AMD64_SEV, &m);
> > +     return m.q;
> > +}
> > +
> > +void sev_enable(struct boot_params *bp)
> > +{
> >       bool snp;
> >
> >       /*
> > @@ -410,37 +447,13 @@ void sev_enable(struct boot_params *bp)
> >        */
> >       snp = snp_init(bp);
> >
> > -     /* Check for the SME/SEV support leaf */
> > -     eax = 0x80000000;
> > -     ecx = 0;
> > -     native_cpuid(&eax, &ebx, &ecx, &edx);
> > -     if (eax < 0x8000001f)
> > -             return;
> > -
> > -     /*
> > -      * Check for the SME/SEV feature:
> > -      *   CPUID Fn8000_001F[EAX]
> > -      *   - Bit 0 - Secure Memory Encryption support
> > -      *   - Bit 1 - Secure Encrypted Virtualization support
> > -      *   CPUID Fn8000_001F[EBX]
> > -      *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> > -      */
> > -     eax = 0x8000001f;
> > -     ecx = 0;
> > -     native_cpuid(&eax, &ebx, &ecx, &edx);
> > -     /* Check whether SEV is supported */
> > -     if (!(eax & BIT(1))) {
> > +     sev_status = sev_get_status();
> > +     if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
> >               if (snp)
> >                       error("SEV-SNP support indicated by CC blob, but not CPUID.");
>
> This ends up checking the CPUID path because if SEV isn't advertised in
> CPUID the returned status value is 0. But it also checks the SEV_STATUS
> MSR as well. So I think you can remove the SNP / SEV_STATUS check at the
> end of this function (since that check is identical to this now) and just
> update the message to indicate not CPUID or SEV status MSR.
>

But that one checks for MSR_AMD64_SEV_SNP_ENABLED not
MSR_AMD64_SEV_ENABLED. Does that matter at all?

> The sme_me_mask should probably be cleared at this point before returning,
> too. Or, alternately, in sev_get_status(), you can update the setting of
> sme_me_mask to based on MSR_AMD64_SEV_ENABLED being set in the SEV_STATUS MSR.
>

I'll go for the latter, seems cleaner not to touch it in that case.

--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -422,10 +422,12 @@ u64 sev_get_status(void)
        if (!(eax & BIT(1)))
                return 0;

-       /* Set the SME mask if this is an SEV guest. */
-       sme_me_mask = BIT_ULL(ebx & 0x3f);
-
        boot_rdmsr(MSR_AMD64_SEV, &m);
+
+       /* Set the SME mask if this is an SEV guest. */
+       if (m.q & MSR_AMD64_SEV_ENABLED)
+               sme_me_mask = BIT_ULL(ebx & 0x3f);
+
        return m.q;
 }


> >   /* Search for Confidential Computing blob in the EFI config table. */
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 86e1296e87f513b7..081c39b0e8d0d208 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -207,6 +207,8 @@ bool snp_init(struct boot_params *bp);
> >   void __init __noreturn snp_abort(void);
> >   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
> >   void snp_accept_memory(phys_addr_t start, phys_addr_t end);
> > +u64 snp_get_unsupported_features(u64 status);
> > +u64 sev_get_status(void);
> >   #else
> >   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
> >   static inline void sev_es_ist_exit(void) { }
> > @@ -232,6 +234,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
> >   }
> >
> >   static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
> > +static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
> > +static inline u64 sev_get_status(void) { return 0; }
> >   #endif
> >
> >   #endif
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index abcd5703e9f3f980..1015ef883f5850a4 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -15,6 +15,7 @@
> >   #include <asm/setup.h>
> >   #include <asm/desc.h>
> >   #include <asm/boot.h>
> > +#include <asm/sev.h>
> >
> >   #include "efistub.h"
> >   #include "x86-stub.h"
> > @@ -790,6 +791,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
> >       return EFI_SUCCESS;
> >   }
> >
> > +static bool have_unsupported_snp_features(void)
> > +{
> > +     u64 unsupported;
> > +
> > +     unsupported = snp_get_unsupported_features(sev_get_status());
>
> This will also set sme_me_mask, but I think that is ok, since on error
> things will terminate, otherwise sev_enable() should update appropriately
> later.
>

OK

> > +     if (unsupported) {
> > +             efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
> > +                     unsupported);
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> >   static void __noreturn enter_kernel(unsigned long kernel_addr,
> >                                   struct boot_params *boot_params)
> >   {
> > @@ -820,6 +834,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> >       if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
> >               efi_exit(handle, EFI_INVALID_PARAMETER);
> >
> > +     if (have_unsupported_snp_features())
> > +             efi_exit(handle, EFI_UNSUPPORTED);
> > +
> >       if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
> >               efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
> >               if (efi_dxe_table &&
