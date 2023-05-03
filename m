Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E16F5DBE
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjECSRp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 14:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECSRo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 14:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE599D;
        Wed,  3 May 2023 11:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FCE62F3D;
        Wed,  3 May 2023 18:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB8C4339E;
        Wed,  3 May 2023 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683137862;
        bh=Gj6JEc2gVWCMBqql0XgZQBxIte8DfSjdof0+6MhArAY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AZTHF1J9UDBOFDf/8S+SpNAajK8IIT5PhwgiY3yVKtCfll7n32Dh59DtC+GN5wJBL
         ELSxqJR7QrSjp+78xD2Pll+Mdyv4UHiFPHC/EOkaXJT4JVlNAAOF9XwyinjmEZa0Ha
         yy2Du8iyFEs2CxQW5ZO9Mi6iTlC75+eXPvgDSTCtQPmDPjQDViLdN2azuILq7NUYcO
         1iV7n5iXoueDLr5RN/hVaHjANHmrdxxqlr1DjpQCe3vWJq+xEhr/wNlVENC/ZdHdMb
         xEButz2vMYjtW2uFB60Bi3jWW/QCw/bpfls40YGrQRV8OjOs+eljt4CmSm5uAuthdW
         2KWlIDRceDfeg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ac75500798so10698541fa.0;
        Wed, 03 May 2023 11:17:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDwQiMyyaiZLPvBsreYViAHAszU376rHFQQig1zSUDYmggmNShgQ
        WxsgaRsLuVsCHY8XajRegpx/vduuM+ibMvv1/TU=
X-Google-Smtp-Source: ACHHUZ6rXUzMWdWGCfIf2IPEXVbd/Va1NLcvNLD8qyKoxLqGxcHDyA8DAw+GhBfSBbsL+SAVejVEb3mUuXFyB77wBIE=
X-Received: by 2002:a2e:8e96:0:b0:2ab:4a0d:7f3a with SMTP id
 z22-20020a2e8e96000000b002ab4a0d7f3amr254321ljk.30.1683137860113; Wed, 03 May
 2023 11:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
 <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
 <a6846282-95c8-274a-accc-ffa54205489c@amd.com> <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
In-Reply-To: <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 May 2023 20:17:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com>
Message-ID: <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 May 2023 at 19:58, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/2/23 11:08, Tom Lendacky wrote:
> > On 5/2/23 08:39, Ard Biesheuvel wrote:
> >> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>
> >>> On 4/24/23 11:57, Ard Biesheuvel wrote:
> >>>> This series is conceptually a combination of Evgeny's series [0] and
> >>>> mine [1], both of which attempt to make the early decompressor code more
> >>>> amenable to executing in the EFI environment with stricter handling of
> >>>> memory permissions.
> >>>>
> >>>> My series [1] implemented zboot for x86, by getting rid of the entire
> >>>> x86 decompressor, and replacing it with existing EFI code that does the
> >>>> same but in a generic way. The downside of this is that only EFI boot is
> >>>> supported, making it unviable for distros, which need to support BIOS
> >>>> boot and hybrid EFI boot modes that omit the EFI stub.
> >>>>
> >>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
> >>>> it to execute in the EFI context as well as the bare metal context, and
> >>>> this involves changes to the 1:1 mapping code and the page fault
> >>>> handlers etc, none of which are really needed when doing EFI boot in the
> >>>> first place.
> >>>>
> >>>> So this series attempts to occupy the middle ground here: it makes
> >>>> minimal changes to the existing decompressor so some of it can be called
> >>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
> >>>> the kernel and boot it directly, without relying on the trampoline code,
> >>>> page table code or page fault handling code. This allows us to get rid
> >>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
> >>>> invocations of the EFI firmware APIs to clear NX restrictions from
> >>>> allocations that have been populated with executable code.
> >>>>
> >>>> The only code that is being reused is the decompression library itself,
> >>>> along with the minimal ELF parsing that is required to copy the ELF
> >>>> segments in place, and the relocation processing that fixes up absolute
> >>>> symbol references to refer to the correct virtual addresses.
> >>>>
> >>>> Note that some of Evgeny's changes to clean up the PE/COFF header
> >>>> generation will still be needed, but I've omitted those here for
> >>>> brevity.
> >>>
> >>> I tried booting an SEV and an SEV-ES guest using this and both failed
> >>> to boot:
> >>>
> >>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
> >>> z_stream
> >>>
> >>> I'll have to take a closer look as to why, but it might be a couple of
> >>> days before I can get to it.
> >>>
> >>
> >> Thanks Tom.
> >>
> >> The internal malloc() seems to be failing, which is often caused by
> >> BSS clearing problems. Could you elaborate a little bit on the boot
> >> environment you are using here?
> >
> > I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
> > host/hypervisor and guest kernel and the current OVMF tree built using
> > OvmfPkgX64.dsc.
> >
> > I was originally using the current merge window Linux, but moved to the
> > release version just to . With the release version SEV and SEV-ES still
> > fail to
> > boot, but SEV actually #GPs now. And some of the register contents look
> > like encrypted data:
> >
> > ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
> > !!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID -
> > 00000000 !!!!
> > ExceptionData - 0000000000000000
> > RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
> > RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
> > RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
> > RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
> > R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
> > R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
> > R14  - 0000000001000000, R15 - 000000007E0A5198
> > DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
> > GS   - 0000000000000030, SS  - 0000000000000030
> > CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
> > CR4  - 0000000000000668, CR8 - 0000000000000000
> > DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
> > DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
> > GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
> > IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
> > FXSAVE_STATE - 000000007FD96F80
> > !!!! Find image based on IP(0x597E71C1)
> > /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
> > RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!
> >
> > So, yes, probably an area of memory that was zeroes when mapped
> > unencrypted, but wasn't cleared after changing the mapping to
> > encrypted.
>
> Yes, looks like a bss clearing issue. If I add __section(".data") to
> free_mem_ptr and free_mem_end_ptr in arch/x86/boot/compressed/misc.c and
> to malloc_ptr and malloc_cnt in include/linux/decompress/mm.h, then I can
> boot an SEV guest.
>
> However, an SEV-ES guest is triple faulting. This looks to be because
> we're still on the EFI CS of 0x38 after switching GDTs in
> arch/x86/kernel/head_64.S by calling startup_64_setup_env(). Before
> switching to the kernel CS, we take a #VC (from CPUID calls in sme_enable)
> and things blow up on the iretq. Moving the block headed by the comment
> "Now switch to __KERNEL_CS so IRET works reliably" to just after calling
> startup_64_setup_env() fixes it and an SEV-ES guest can boot.
>
> This worked before because I believe we switched off the EFI CS as part of
> the kernel decompressor support and so this bug wasn't exposed. But this
> needs to be fixed regardless of this series.
>

Very interesting. I was under the assumption that everything that goes
on in sev_enable() in the decompressor would be rather indispensable
to boot in SEV mode (which I only spotted today) so I am quite
surprised that things just appear to work. (There is some 32-bit SEV
code in the decompressor as well that obviously never gets called when
booting in long mode, but I hadn't quite grasped how much other SEV
code there actually is)
