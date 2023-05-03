Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31146F6089
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 23:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjECVal (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECVak (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 17:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFB130EF;
        Wed,  3 May 2023 14:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AE3617CF;
        Wed,  3 May 2023 21:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70362C4339B;
        Wed,  3 May 2023 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683149437;
        bh=YNSCEkyv0tG1Xwdagg3lyYmAeJ90gSqpVdZuG8MnLbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mVS+/YVzUJPtTPppfbGvRwIvDK4mYvgjmaQlx2zH9Wsd9GMcXv73kLxvtyBtnR5p0
         KGwmEHmtNqBwxyc8ZPCHWsioPsEBwF6Msx3flIQ/Fc2pe4tgyNXb5rApz9gHv0vSPw
         ECKnaLTPRn2SyC8sadG+TLA5KWgEN7/sSM6q3/2VOEJsOVWU6T1gdb4iqWTwdFXDEs
         /RyKHiboIX3ebKTymv9KAYpCFOnvhFoBMJEvF0QeJ201E+MGmYS7BkAGw2ElVSiSkI
         v3HAd4npBxgmO8jSdlFAXtiaFo5VuPdfQfyvGLdxBH4lEzDFdCiliAZJjHGLT4MLu4
         kBGpUFmfo7crg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2a8dd1489b0so57068391fa.3;
        Wed, 03 May 2023 14:30:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDwJNwXxr/Yijk9QGnZ7eySANxs/DmLDQ9PkdcTOEQTFlFmktFyT
        E8R7Kh2PtcsFWUKEmcnWmzNJe/ZihUL1hgiz9OQ=
X-Google-Smtp-Source: ACHHUZ4wDKmJfuiqjyyPaOQfkdEIRPa0XF6ssWVksEqQDSIuoq1Rre+gpLBy7jXFhIDOBQdC184VoJyNRyCRNcmnjRA=
X-Received: by 2002:a2e:98d0:0:b0:2a8:2122:102f with SMTP id
 s16-20020a2e98d0000000b002a82122102fmr334832ljj.49.1683149435405; Wed, 03 May
 2023 14:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
 <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
 <a6846282-95c8-274a-accc-ffa54205489c@amd.com> <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
 <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com>
 <d06086cf-3bb7-0ed1-b877-c94b5ef89fc2@amd.com> <CAMj1kXGwF39ZjggsZ+fhac8w-LHaa++YbRT+cQM25QRKurg2Rw@mail.gmail.com>
 <6639dd3c-edf4-c4a0-cfd6-9e0a13c7738b@amd.com>
In-Reply-To: <6639dd3c-edf4-c4a0-cfd6-9e0a13c7738b@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 May 2023 23:30:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCK8vOxoyS42F8-DgZKF=CPGSUjOWViL-J9UwqoMx1yg@mail.gmail.com>
Message-ID: <CAMj1kXHCK8vOxoyS42F8-DgZKF=CPGSUjOWViL-J9UwqoMx1yg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 May 2023 at 23:23, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/3/23 13:59, Ard Biesheuvel wrote:
> > On Wed, 3 May 2023 at 20:49, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 5/3/23 13:17, Ard Biesheuvel wrote:
> >>> On Wed, 3 May 2023 at 19:58, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>
> >>>> On 5/2/23 11:08, Tom Lendacky wrote:
> >>>>> On 5/2/23 08:39, Ard Biesheuvel wrote:
> >>>>>> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>>>>
> >>>>>>> On 4/24/23 11:57, Ard Biesheuvel wrote:
> >>>>>>>> This series is conceptually a combination of Evgeny's series [0] and
> >>>>>>>> mine [1], both of which attempt to make the early decompressor code more
> >>>>>>>> amenable to executing in the EFI environment with stricter handling of
> >>>>>>>> memory permissions.
> >>>>>>>>
> >>>>>>>> My series [1] implemented zboot for x86, by getting rid of the entire
> >>>>>>>> x86 decompressor, and replacing it with existing EFI code that does the
> >>>>>>>> same but in a generic way. The downside of this is that only EFI boot is
> >>>>>>>> supported, making it unviable for distros, which need to support BIOS
> >>>>>>>> boot and hybrid EFI boot modes that omit the EFI stub.
> >>>>>>>>
> >>>>>>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
> >>>>>>>> it to execute in the EFI context as well as the bare metal context, and
> >>>>>>>> this involves changes to the 1:1 mapping code and the page fault
> >>>>>>>> handlers etc, none of which are really needed when doing EFI boot in the
> >>>>>>>> first place.
> >>>>>>>>
> >>>>>>>> So this series attempts to occupy the middle ground here: it makes
> >>>>>>>> minimal changes to the existing decompressor so some of it can be called
> >>>>>>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
> >>>>>>>> the kernel and boot it directly, without relying on the trampoline code,
> >>>>>>>> page table code or page fault handling code. This allows us to get rid
> >>>>>>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
> >>>>>>>> invocations of the EFI firmware APIs to clear NX restrictions from
> >>>>>>>> allocations that have been populated with executable code.
> >>>>>>>>
> >>>>>>>> The only code that is being reused is the decompression library itself,
> >>>>>>>> along with the minimal ELF parsing that is required to copy the ELF
> >>>>>>>> segments in place, and the relocation processing that fixes up absolute
> >>>>>>>> symbol references to refer to the correct virtual addresses.
> >>>>>>>>
> >>>>>>>> Note that some of Evgeny's changes to clean up the PE/COFF header
> >>>>>>>> generation will still be needed, but I've omitted those here for
> >>>>>>>> brevity.
> >>>>>>>
> >>>>>>> I tried booting an SEV and an SEV-ES guest using this and both failed
> >>>>>>> to boot:
> >>>>>>>
> >>>>>>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
> >>>>>>> z_stream
> >>>>>>>
> >>>>>>> I'll have to take a closer look as to why, but it might be a couple of
> >>>>>>> days before I can get to it.
> >>>>>>>
> >>>>>>
> >>>>>> Thanks Tom.
> >>>>>>
> >>>>>> The internal malloc() seems to be failing, which is often caused by
> >>>>>> BSS clearing problems. Could you elaborate a little bit on the boot
> >>>>>> environment you are using here?
> >>>>>
> >>>>> I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
> >>>>> host/hypervisor and guest kernel and the current OVMF tree built using
> >>>>> OvmfPkgX64.dsc.
> >>>>>
> >>>>> I was originally using the current merge window Linux, but moved to the
> >>>>> release version just to . With the release version SEV and SEV-ES still
> >>>>> fail to
> >>>>> boot, but SEV actually #GPs now. And some of the register contents look
> >>>>> like encrypted data:
> >>>>>
> >>>>> ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
> >>>>> !!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID -
> >>>>> 00000000 !!!!
> >>>>> ExceptionData - 0000000000000000
> >>>>> RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
> >>>>> RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
> >>>>> RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
> >>>>> RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
> >>>>> R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
> >>>>> R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
> >>>>> R14  - 0000000001000000, R15 - 000000007E0A5198
> >>>>> DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
> >>>>> GS   - 0000000000000030, SS  - 0000000000000030
> >>>>> CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
> >>>>> CR4  - 0000000000000668, CR8 - 0000000000000000
> >>>>> DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
> >>>>> DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
> >>>>> GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
> >>>>> IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
> >>>>> FXSAVE_STATE - 000000007FD96F80
> >>>>> !!!! Find image based on IP(0x597E71C1)
> >>>>> /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
> >>>>> RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!
> >>>>>
> >>>>> So, yes, probably an area of memory that was zeroes when mapped
> >>>>> unencrypted, but wasn't cleared after changing the mapping to
> >>>>> encrypted.
> >>>>
> >>>> Yes, looks like a bss clearing issue. If I add __section(".data") to
> >>>> free_mem_ptr and free_mem_end_ptr in arch/x86/boot/compressed/misc.c and
> >>>> to malloc_ptr and malloc_cnt in include/linux/decompress/mm.h, then I can
> >>>> boot an SEV guest.
> >>>>
> >>>> However, an SEV-ES guest is triple faulting. This looks to be because
> >>>> we're still on the EFI CS of 0x38 after switching GDTs in
> >>>> arch/x86/kernel/head_64.S by calling startup_64_setup_env(). Before
> >>>> switching to the kernel CS, we take a #VC (from CPUID calls in sme_enable)
> >>>> and things blow up on the iretq. Moving the block headed by the comment
> >>>> "Now switch to __KERNEL_CS so IRET works reliably" to just after calling
> >>>> startup_64_setup_env() fixes it and an SEV-ES guest can boot.
> >>>>
> >>>> This worked before because I believe we switched off the EFI CS as part of
> >>>> the kernel decompressor support and so this bug wasn't exposed. But this
> >>>> needs to be fixed regardless of this series.
> >>>>
> >>>
> >>> Very interesting. I was under the assumption that everything that goes
> >>> on in sev_enable() in the decompressor would be rather indispensable
> >>> to boot in SEV mode (which I only spotted today) so I am quite
> >>> surprised that things just appear to work. (There is some 32-bit SEV
> >>> code in the decompressor as well that obviously never gets called when
> >>> booting in long mode, but I hadn't quite grasped how much other SEV
> >>> code there actually is)
> >>
> >> The sev_enable() function for SEV and SEV-ES is more for ensuring a proper
> >> environment (ensuring the proper CPUID bits are present for the guest,
> >> checking the GHCB protocol level, properly preparing pagetables, etc.).
> >> Since we're still in EFI and using the EFI #VC handler and pagetables, we
> >> don't require some of that stuff, but some of the it would need to be
> >> performed at some point (I wasn't trying to be a malicious hypervisor).
> >>
> >
> > OK, good to know.
> >
> >> I haven't tested SEV-SNP yet because the hypervisor support is not
> >> upstream, yet, and I haven't applied your series to an SNP hypervisor
> >> tree, yet. There is a lot of support in sev_enable() for SNP that may
> >> likely cause a problem compared to SEV and SEV-ES.
> >>
> >> SEV-SNP has a lot more checking and validation going on and it ensures it
> >> gets the confidential computing blob from EFI into the boot parameters.
> >> I'm not sure when I'll be able to test SNP, since I'm off next week and
> >> trying to wrap up a bunch of stuff before I leave.
> >>
> >
> > Would it make sense, given the apparent direct dependency on EFI, to
> > move that stuff into the EFI stub instead of doing it from the
> > decompressor?
>
> We tried to make the support for SNP not be reliant on EFI. If EFI is
> present, then get the confidential computing blob from it. Otherwise, the
> cc blob can be supplied as part of the setup data in the Linux boot
> protocol (see find_cc_block() in arch/x86/boot/compressed/sev.c).
>
> So I guess some of it could be moved, but I'm not sure how much.
>

Fair enough.

> >
> > Thanks for giving this a spin - I can wait for more testing until you
> > get back, and hopefully, we'll have converged a bit more by that time
> > and there will be a new revision of the series available for testing.
> >
> > BTW any clue whether your boot path is relying on the EFI handover
> > protocol? I.e., QemuStartLegacyImage() in OVMF? Evgeny mentioned that
>
> I don't believe it is. It's using the Grub EFI bootloader to load and boot
> Linux.
>

Looking at the log you just sent (thanks), it appears you are using
distro shim+grub, which implement their own rough approximation of PE
file loading, and typically use the EFI handover protocol. This is
good news, because we already know how broken shim and GRUB are, and I
was concerned that there might be another issue to track down here.

I'll implement Evgeny's suggestion to clear BSS explicitly in the EFI
handover protocol entrypoints for the next revision of the series.

Thanks,
