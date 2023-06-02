Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE767720AF9
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFBVaO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 17:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjFBVaN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 17:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B31E48;
        Fri,  2 Jun 2023 14:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4426155F;
        Fri,  2 Jun 2023 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1D8C4339B;
        Fri,  2 Jun 2023 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685741411;
        bh=qgRiHTAzGUiYqHvcAAXtF7ge8RD50s1R2CPGTYzuChA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbVeR33sPyMFVf2I0h+tmuIwCOmYlX9WHiQ9oUHP4JxWwfNNn5smqsIJx53eei63s
         K+qa7q2gr/WJj0Y9Jb+pjKCCIp+Yo/5h8NEYcT4nT0Tfe9n9haVjd9NKuPL0KbBSOL
         VY702GKQCIJb0eRsc4g/gfxlnFY/BF8hjXE4ABtnxpp7edQSmgD+5tdiHRmwYkgGmy
         d3nK1GBD7xUeDiSDF/1G3lUf0gXRKjUPhNndNs7nTKaT42P10qysbbitkORfUXTxUt
         sw9vI7Lcs/Je97UU8h3J8UUIeQ94Yu6Z9EHYQ5OlRw+91QenQ1bu+DzwwC0YFQtl3o
         xuIZ7uIUBe6qA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso539581fa.1;
        Fri, 02 Jun 2023 14:30:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDzA1WpprlvE3f1loyhlEIBWsatks444Oq4TjlSBHDErS5U8Y8j+
        MHfPfS8zmx2g8SpI9+GFNiVaJzX/H4D5ZnKFNJQ=
X-Google-Smtp-Source: ACHHUZ6l7EbkoWbe8mDIAVHHsbEkJ0pdMY/Gs4YwNZ0eTfPFW/eIAbmJwg4ozd7WjtmLM0iyudYuBarUQSRM8pYY9Ns=
X-Received: by 2002:a2e:b60c:0:b0:2af:1c15:e7c8 with SMTP id
 r12-20020a2eb60c000000b002af1c15e7c8mr775414ljn.44.1685741409104; Fri, 02 Jun
 2023 14:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230602101313.3557775-1-ardb@kernel.org> <20230602101313.3557775-21-ardb@kernel.org>
 <bfe5bbac-37e2-6728-606a-c652bafad6b6@amd.com> <849a65c8-a320-a8a8-8784-0ee3737eee9e@amd.com>
In-Reply-To: <849a65c8-a320-a8a8-8784-0ee3737eee9e@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Jun 2023 23:29:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGwKfbX+tvch0OiyN69jhOOi_zcUdkzXf2ipQ4Gd++3FQ@mail.gmail.com>
Message-ID: <CAMj1kXGwKfbX+tvch0OiyN69jhOOi_zcUdkzXf2ipQ4Gd++3FQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] x86/efistub: Perform SNP feature test while
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Jun 2023 at 22:39, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 6/2/23 15:38, Tom Lendacky wrote:
> > On 6/2/23 05:13, Ard Biesheuvel wrote:
> >> Before refactoring the EFI stub boot flow to avoid the legacy bare metal
> >> decompressor, duplicate the SNP feature check in the EFI stub before
> >> handing over to the kernel proper.
> >>
> >> The SNP feature check can be performed while running under the EFI boot
> >> services, which means we can fail gracefully and return an error to the
> >> bootloader if the loaded kernel does not implement support for all the
> >> features that the hypervisor enabled.
> >>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >>   arch/x86/boot/compressed/sev.c          | 74 ++++++++++++--------
> >>   arch/x86/include/asm/sev.h              |  4 ++
> >>   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
> >>   3 files changed, 67 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/arch/x86/boot/compressed/sev.c
> >> b/arch/x86/boot/compressed/sev.c
> >> index 014b89c890887b9a..be021e24f1ece421 100644
> >> --- a/arch/x86/boot/compressed/sev.c
> >> +++ b/arch/x86/boot/compressed/sev.c
> >
> >
> >> +void sev_enable(struct boot_params *bp)
> >> +{
> >> +    unsigned int eax, ebx, ecx, edx;
> >>       bool snp;
> >>       /*
> >> @@ -358,37 +391,14 @@ void sev_enable(struct boot_params *bp)
> >>        */
> >>       snp = snp_init(bp);
> >> -    /* Check for the SME/SEV support leaf */
> >> -    eax = 0x80000000;
> >> -    ecx = 0;
> >> -    native_cpuid(&eax, &ebx, &ecx, &edx);
> >> -    if (eax < 0x8000001f)
> >> -        return;
> >> -
> >> -    /*
> >> -     * Check for the SME/SEV feature:
> >> -     *   CPUID Fn8000_001F[EAX]
> >> -     *   - Bit 0 - Secure Memory Encryption support
> >> -     *   - Bit 1 - Secure Encrypted Virtualization support
> >> -     *   CPUID Fn8000_001F[EBX]
> >> -     *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> >> -     */
> >> -    eax = 0x8000001f;
> >> -    ecx = 0;
> >> -    native_cpuid(&eax, &ebx, &ecx, &edx);
> >> -    /* Check whether SEV is supported */
> >> -    if (!(eax & BIT(1))) {
> >> +    /* Set the SME mask if this is an SEV guest. */
> >> +    sev_status = sev_get_status();
> >> +    if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
> >>           if (snp)
> >>               error("SEV-SNP support indicated by CC blob, but not
> >> CPUID.");
> >>           return;
> >>       }
> >> -    /* Set the SME mask if this is an SEV guest. */
> >> -    boot_rdmsr(MSR_AMD64_SEV, &m);
> >> -    sev_status = m.q;
> >> -    if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> >> -        return;
> >> -
> >>       /* Negotiate the GHCB protocol version. */
> >>       if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
> >>           if (!sev_es_negotiate_protocol())
> >> @@ -409,6 +419,14 @@ void sev_enable(struct boot_params *bp)
> >>       if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> >>           error("SEV-SNP supported indicated by CC blob, but not SEV
> >> status MSR.");
> >> +    /*
> >> +     * Check for the SME/SEV feature:
> >> +     *   CPUID Fn8000_001F[EBX]
> >> +     *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> >> +     */
> >> +    eax = 0x8000001f;
> >> +    ecx = 0;
> >> +    native_cpuid(&eax, &ebx, &ecx, &edx);
> >
> > This causes SEV-ES / SEV-SNP to crash.
> >
> > This goes back to a previous comment where calling either
> > sev_es_negotiate_protocol() or get_hv_features() blows away the GHCB value
> > in the GHCB MSR and as soon as the CPUID instruction is executed the boot
> > blows up.
> >
> > Even if we move this up to be done earlier, we can complete this function
> > successfully but then blow up further on.
> >
> > So you probably have to modify the routines in question to save and
> > restore the GHCB MSR value.
>
> I should clarify that it doesn't in fact cause a problem until the final
> patch is applied and this path is taken.
>

Could we just move the CPUID call to the start of the function?
