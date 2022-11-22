Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1B634972
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 22:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiKVVh1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiKVVh0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 16:37:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A1C4C32;
        Tue, 22 Nov 2022 13:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 399CC61909;
        Tue, 22 Nov 2022 21:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9175BC433D6;
        Tue, 22 Nov 2022 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669153043;
        bh=1tf5WQ8jjJc/1tVH+idoTgSZqcUY/VzWpKq7OHf+UVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W/zjYA6ctlCZacKeeiMijc8lEFQno24fkg3uKbpdqCLZMsJgfV8I1gEnLCIRgmWWz
         61IGWzGMdBW0EFqXonFb2xzpzYDoNLppYMC4W0ForveqE57rWzdmYuI7f6F/4zxH8P
         LDaiTQfQYfvVEfGTeOQSqNFxBheKW2yzCdRYSTGm0Ybb7Pdbzujez6m7JQbuSoQvPS
         e3xvk9ZwBXXIJCFFeVCgoQnpCeLf4OO8Sg0DvnNwfe3fvYxFHjZzBgu2fQys8bQMWx
         GxPB+4c7vZWcgrHuu4unvEYQKF3gYajda4mmLW6+1DXHgmS/WyxGhZcPG6u+Y8UVJI
         Udq+2M8htNkJw==
Received: by mail-lj1-f182.google.com with SMTP id x21so19347388ljg.10;
        Tue, 22 Nov 2022 13:37:23 -0800 (PST)
X-Gm-Message-State: ANoB5pnCBi38gqLMA21ChCFP3/+QtbJcKSteRT8/2GIx3bVl51Ee/cgW
        5DjZx/vPZZxbBD3/e7ao+3u16i/jNR1TdL9UMsE=
X-Google-Smtp-Source: AA0mqf5QiUFfs/m5Jb/zJbO2yxQPD/EJoJyNcGVpMJEMAJRGLkBcqIk99aCRzGtyqITSqhKe0lm60eMQeJWLpDyM878=
X-Received: by 2002:a05:651c:1603:b0:26d:d603:8df2 with SMTP id
 f3-20020a05651c160300b0026dd6038df2mr7460852ljq.189.1669153041465; Tue, 22
 Nov 2022 13:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20221122161017.2426828-1-ardb@kernel.org> <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
In-Reply-To: <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Nov 2022 22:37:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
Message-ID: <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Nov 2022 at 21:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/22/22 10:10, Ard Biesheuvel wrote:
> > After doing some cleanup work on the EFI code in head_64.S, the mixed
> > mode code in particular, I noticed that the memory encryption pieces
> > could use some attention as well, so I cleaned that up too.
> >
> > Changes since v2:
> > - add some clarifying comments to the EFI mixed mode changes
> > - include patch to make the EFI handover protocol optional that was sent
> >    out separately before
> > - rebase onto tip/master
> >
> > Changes since v1:
> > - at Boris's request, split the patches into smaller ones that are
> >    easier to review
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Michael Roth <michael.roth@amd.com>
>
> This causes an SEV guest to blow up on boot in the early boot code. It
> looks like the stack pointer is not valid and it triple faults on a pushq
> instruction (pushq $__KERNEL_CS in arch/x86/boot/compressed/head_64.S of
> startup_64).
>

Thanks for the report.

So the mystery here (at least to me) is that all the changes are to
the 32-bit code, and startup_64 reloads the stack pointer from the
symbol

Does your config have CONFIG_EFI_MIXED enabled?

Can I reproduce this fully emulated with QEMU? Or do I need a SEV host?

> Here is the Qemu register dump:
> RAX=00000000029cc260 RBX=ffffffffdd98c000 RCX=0000000000000010 RDX=0000000000000002
> RSI=000000003dec1000 RDI=0000000000000000 RBP=ffffffffdb000000 RSP=ffffffffde36e000
> R8 =000000003dec1410 R9 =000000003dec13fc R10=000000000000006c R11=0000000000000000
> R12=0000000000000000 R13=0000000000000001 R14=0000000000000004 R15=000000003eacdf44
> RIP=0000000002000263 RFL=00200002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 00000000 00000000
> CS =0038 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> SS =0000 0000000000000000 00000000 00000000
> DS =0000 0000000000000000 00000000 00000000
> FS =0000 0000000000000000 00000000 00000000
> GS =0000 0000000000000000 00000000 00000000
> LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
> TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
> GDT=     00000000029cc270 0000002f
> IDT=     000000003f55e018 00000fff
> CR0=80010033 CR2=ffffffffde36dff8 CR3=000000003fc01000 CR4=00000668
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000d00
>
> Thanks,
> Tom
>
> >
> > Ard Biesheuvel (17):
> >    x86/compressed: efi-mixed: rename efi_thunk_64.S to efi-mixed.S
> >    x86/compressed: efi-mixed: move 32-bit entrypoint code into .text
> >      section
> >    x86/compressed: efi-mixed: move bootargs parsing out of 32-bit startup
> >      code
> >    x86/compressed: efi-mixed: move efi32_pe_entry into .text section
> >    x86/compressed: efi-mixed: move efi32_entry out of head_64.S
> >    x86/compressed: efi-mixed: move efi32_pe_entry() out of head_64.S
> >    x86/compressed: efi: merge multiple definitions of image_offset into
> >      one
> >    x86/compressed: efi-mixed: simplify IDT/GDT preserve/restore
> >    x86/compressed: avoid touching ECX in startup32_set_idt_entry()
> >    x86/compressed: pull global variable ref up into startup32_load_idt()
> >    x86/compressed: move startup32_load_idt() into .text section
> >    x86/compressed: move startup32_load_idt() out of head_64.S
> >    x86/compressed: move startup32_check_sev_cbit() into .text
> >    x86/compressed: move startup32_check_sev_cbit() out of head_64.S
> >    x86/compressed: adhere to calling convention in
> >      get_sev_encryption_bit()
> >    x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
> >    efi: x86: Make the deprecated EFI handover protocol optional
> >
> >   arch/x86/Kconfig                        |  17 +
> >   arch/x86/boot/compressed/Makefile       |   8 +-
> >   arch/x86/boot/compressed/efi_mixed.S    | 351 ++++++++++++++++++++
> >   arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
> >   arch/x86/boot/compressed/head_32.S      |   4 -
> >   arch/x86/boot/compressed/head_64.S      | 303 +----------------
> >   arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
> >   arch/x86/boot/header.S                  |   2 +-
> >   arch/x86/boot/tools/build.c             |   2 +
> >   drivers/firmware/efi/libstub/x86-stub.c |   2 +-
> >   10 files changed, 533 insertions(+), 503 deletions(-)
> >   create mode 100644 arch/x86/boot/compressed/efi_mixed.S
> >   delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S
> >
