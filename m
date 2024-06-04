Return-Path: <linux-efi+bounces-1149-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEA8FBD9D
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E94B21C1A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AFB14BF91;
	Tue,  4 Jun 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHj/eJs6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713D14B974;
	Tue,  4 Jun 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534493; cv=none; b=RRooQlrOzLsIPza6riZShGbP/2Syd+X1YYvCbUuTZaZv6J/0bqshOM6eyrZv8Vt5Y6pFssWXWkk55H5WqE9EibOyJdvDLsE+xtrAEqe1rdyDNvq767eT+Dyxb1tvZ3jeVflCFJzavj+9OIEdgcjqQVNHaAbg7D06xaAvciqPvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534493; c=relaxed/simple;
	bh=jOW+1OdDSCmwWCebegpjQkPqvOoqBmesdA2lp4CRyvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpTuqXg0VeWFgOCZux3vin6wwRMLFYfBDoGuu3NStkJxb2TFcnTovXpyLQm6HmCwZ9+n+pn94NYffF8/f6Xy627+rRG2qSHlkkIbBan9Uicr/njELX7jev1f0265kpSJKC+w1cTJUdxAN+Gc2Ic/1ocZ6Og43yzbbRltTRlxQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHj/eJs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3787C4AF0F;
	Tue,  4 Jun 2024 20:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534492;
	bh=jOW+1OdDSCmwWCebegpjQkPqvOoqBmesdA2lp4CRyvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rHj/eJs6FDv+FP8Pp+EwPfjeHNiYP6KKDBJAPsvRfBDXawsFtjsLQDvVGbc96Rjcb
	 GR1d0d0orzMjAq+uk/3hWZkJxOeHMUBFxmyrD/u23Y4SUor4lC64HH2ErRSBpKyQzC
	 mQ1+WvazSBhmn6AL1cLr8gnHHZPVPksRplG8/8E8s2bgf21W8Tq6AUZ8B+xH5aYytz
	 QkaHnOrQbx3q87D6AJtJfDoOnZAU7T8Qc2XbqNu0I8rzVKBXpjyI9LQrcOuEvdpoUu
	 VIV4Ka7CtYk66kVcm7x32YUGa5dnhurvI73M0VDYZEDxWS1rWgrWA6E3dnQGa/ScJA
	 vTDmVdalAYgoQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ea9386cde0so61424911fa.2;
        Tue, 04 Jun 2024 13:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0xiLw82jGxVlAfSGYUy6aC6uiTI/q6T6f1CMs92flIptC2lcrma2xD+GbJXzzb31RFHdZxybW7kd7oT88MX2dLoOm3dcqx8GRDKIwUVjeq3DIhf9Nl6619KsJ9RMJ0JRzoyQbtnSQBOJo9oiS4pCetZyd/ZwclYKrBXYnUElzrgRksDKXoo0lyVCBUiOOY81ak9Gu2tca+rLnB3MYAmP35YX3
X-Gm-Message-State: AOJu0Yw2Zwu4/mqx1TOR48B9tqQxGwf7S60+B/OvchZVShyGnhDME+II
	bk9TK0AmCkEfZOPbXEWVV05Z/9WWIDEQWeHLKg7YYnjlBAXEc97PoWHEqG6cQLtIOFv0TNQfYVI
	qkirsnR5to6wZiIfDuYsOeuipZ48=
X-Google-Smtp-Source: AGHT+IHJDS7RbesWDkwWk7Ew2fQrx3H0XBYwx+Z4jx1MSnR1LYyQbaYNK9w0BYZBfeO823xz4XgpKZDKbAn9kgetWNo=
X-Received: by 2002:a2e:a7c9:0:b0:2e9:756f:cde0 with SMTP id
 38308e7fff4ca-2eac79ed71fmr2534751fa.23.1717534490810; Tue, 04 Jun 2024
 13:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com> <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
 <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
 <5bffa507-75e8-4cce-ac0c-fe13d6efd3bb@oracle.com> <CAMj1kXHLaqyPAw5Jjg91pqFbHoMT2jDqui4rosyerHVudRsq-w@mail.gmail.com>
 <5b32106b-bb7b-463d-8b0b-589e3d466bf3@oracle.com>
In-Reply-To: <5b32106b-bb7b-463d-8b0b-589e3d466bf3@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Jun 2024 22:54:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEak-_D=B9qLsvo-M5+qJKSCrBwkoQkmC7_NoPR34+r-w@mail.gmail.com>
Message-ID: <CAMj1kXEak-_D=B9qLsvo-M5+qJKSCrBwkoQkmC7_NoPR34+r-w@mail.gmail.com>
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
To: ross.philipson@oracle.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 19:34, <ross.philipson@oracle.com> wrote:
>
> On 6/4/24 10:27 AM, Ard Biesheuvel wrote:
> > On Tue, 4 Jun 2024 at 19:24, <ross.philipson@oracle.com> wrote:
> >>
> >> On 5/31/24 6:33 AM, Ard Biesheuvel wrote:
> >>> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>
> >>>> Hello Ross,
> >>>>
> >>>> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>>>>
> >>>>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> >>>>> later AMD SKINIT) to vector to during the late launch. The symbol
> >>>>> sl_stub_entry is that entry point and its offset into the kernel is
> >>>>> conveyed to the launching code using the MLE (Measured Launch
> >>>>> Environment) header in the structure named mle_header. The offset of the
> >>>>> MLE header is set in the kernel_info. The routine sl_stub contains the
> >>>>> very early late launch setup code responsible for setting up the basic
> >>>>> environment to allow the normal kernel startup_32 code to proceed. It is
> >>>>> also responsible for properly waking and handling the APs on Intel
> >>>>> platforms. The routine sl_main which runs after entering 64b mode is
> >>>>> responsible for measuring configuration and module information before
> >>>>> it is used like the boot params, the kernel command line, the TXT heap,
> >>>>> an external initramfs, etc.
> >>>>>
> >>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>>>> ---
> >>>>>    Documentation/arch/x86/boot.rst        |  21 +
> >>>>>    arch/x86/boot/compressed/Makefile      |   3 +-
> >>>>>    arch/x86/boot/compressed/head_64.S     |  30 +
> >>>>>    arch/x86/boot/compressed/kernel_info.S |  34 ++
> >>>>>    arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
> >>>>>    arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
> >>>>>    arch/x86/include/asm/msr-index.h       |   5 +
> >>>>>    arch/x86/include/uapi/asm/bootparam.h  |   1 +
> >>>>>    arch/x86/kernel/asm-offsets.c          |  20 +
> >>>>>    9 files changed, 1415 insertions(+), 1 deletion(-)
> >>>>>    create mode 100644 arch/x86/boot/compressed/sl_main.c
> >>>>>    create mode 100644 arch/x86/boot/compressed/sl_stub.S
> >>>>>
> >>>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> >>>>> index 4fd492cb4970..295cdf9bcbdb 100644
> >>>>> --- a/Documentation/arch/x86/boot.rst
> >>>>> +++ b/Documentation/arch/x86/boot.rst
> >>>>> @@ -482,6 +482,14 @@ Protocol:  2.00+
> >>>>>               - If 1, KASLR enabled.
> >>>>>               - If 0, KASLR disabled.
> >>>>>
> >>>>> +  Bit 2 (kernel internal): SLAUNCH_FLAG
> >>>>> +
> >>>>> +       - Used internally by the setup kernel to communicate
> >>>>> +         Secure Launch status to kernel proper.
> >>>>> +
> >>>>> +           - If 1, Secure Launch enabled.
> >>>>> +           - If 0, Secure Launch disabled.
> >>>>> +
> >>>>>      Bit 5 (write): QUIET_FLAG
> >>>>>
> >>>>>           - If 0, print early messages.
> >>>>> @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
> >>>>>
> >>>>>      This field contains maximal allowed type for setup_data and setup_indirect structs.
> >>>>>
> >>>>> +============   =================
> >>>>> +Field name:    mle_header_offset
> >>>>> +Offset/size:   0x0010/4
> >>>>> +============   =================
> >>>>> +
> >>>>> +  This field contains the offset to the Secure Launch Measured Launch Environment
> >>>>> +  (MLE) header. This offset is used to locate information needed during a secure
> >>>>> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
> >>>>> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
> >>>>> +  following a success measured launch. The specific state of the processors is
> >>>>> +  outlined in the TXT Software Development Guide, the latest can be found here:
> >>>>> +  https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf__;!!ACWV5N9M2RV99hQ!Mng0gnPhOYZ8D02t1rYwQfY6U3uWaypJyd1T2rsWz3QNHr9GhIZ9ANB_-cgPExxX0e0KmCpda-3VX8Fj$
> >>>>> +
> >>>>>
> >>>>
> >>>> Could we just repaint this field as the offset relative to the start
> >>>> of kernel_info rather than relative to the start of the image? That
> >>>> way, there is no need for patch #1, and given that the consumer of
> >>>> this field accesses it via kernel_info, I wouldn't expect any issues
> >>>> in applying this offset to obtain the actual address.
> >>>>
> >>>>
> >>>>>    The Image Checksum
> >>>>>    ==================
> >>>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> >>>>> index 9189a0e28686..9076a248d4b4 100644
> >>>>> --- a/arch/x86/boot/compressed/Makefile
> >>>>> +++ b/arch/x86/boot/compressed/Makefile
> >>>>> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >>>>>    vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> >>>>>    vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >>>>>
> >>>>> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> >>>>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
> >>>>> +       $(obj)/sl_main.o $(obj)/sl_stub.o
> >>>>>
> >>>>>    $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> >>>>>           $(call if_changed,ld)
> >>>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> >>>>> index 1dcb794c5479..803c9e2e6d85 100644
> >>>>> --- a/arch/x86/boot/compressed/head_64.S
> >>>>> +++ b/arch/x86/boot/compressed/head_64.S
> >>>>> @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
> >>>>>           pushq   $0
> >>>>>           popfq
> >>>>>
> >>>>> +#ifdef CONFIG_SECURE_LAUNCH
> >>>>> +       /* Ensure the relocation region is coverd by a PMR */
> >>>>
> >>>> covered
> >>>>
> >>>>> +       movq    %rbx, %rdi
> >>>>> +       movl    $(_bss - startup_32), %esi
> >>>>> +       callq   sl_check_region
> >>>>> +#endif
> >>>>> +
> >>>>>    /*
> >>>>>     * Copy the compressed kernel to the end of our buffer
> >>>>>     * where decompression in place becomes safe.
> >>>>> @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> >>>>>           shrq    $3, %rcx
> >>>>>           rep     stosq
> >>>>>
> >>>>> +#ifdef CONFIG_SECURE_LAUNCH
> >>>>> +       /*
> >>>>> +        * Have to do the final early sl stub work in 64b area.
> >>>>> +        *
> >>>>> +        * *********** NOTE ***********
> >>>>> +        *
> >>>>> +        * Several boot params get used before we get a chance to measure
> >>>>> +        * them in this call. This is a known issue and we currently don't
> >>>>> +        * have a solution. The scratch field doesn't matter. There is no
> >>>>> +        * obvious way to do anything about the use of kernel_alignment or
> >>>>> +        * init_size though these seem low risk with all the PMR and overlap
> >>>>> +        * checks in place.
> >>>>> +        */
> >>>>> +       movq    %r15, %rdi
> >>>>> +       callq   sl_main
> >>>>> +
> >>>>> +       /* Ensure the decompression location is covered by a PMR */
> >>>>> +       movq    %rbp, %rdi
> >>>>> +       movq    output_len(%rip), %rsi
> >>>>> +       callq   sl_check_region
> >>>>> +#endif
> >>>>> +
> >>>>> +       pushq   %rsi
> >>>>
> >>>> This looks like a rebase error.
> >>>>
> >>>>>           call    load_stage2_idt
> >>>>>
> >>>>>           /* Pass boot_params to initialize_identity_maps() */
> >>>>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> >>>>> index c18f07181dd5..e199b87764e9 100644
> >>>>> --- a/arch/x86/boot/compressed/kernel_info.S
> >>>>> +++ b/arch/x86/boot/compressed/kernel_info.S
> >>>>> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
> >>>>>           /* Maximal allowed type for setup_data and setup_indirect structs. */
> >>>>>           .long   SETUP_TYPE_MAX
> >>>>>
> >>>>> +       /* Offset to the MLE header structure */
> >>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> >>>>> +       .long   rva(mle_header)
> >>>>
> >>>> ... so this could just be mle_header - kernel_info, and the consumer
> >>>> can do the math instead.
> >>>>
> >>>>> +#else
> >>>>> +       .long   0
> >>>>> +#endif
> >>>>> +
> >>>>>    kernel_info_var_len_data:
> >>>>>           /* Empty for time being... */
> >>>>>    SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> >>>>> +
> >>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> >>>>> +       /*
> >>>>> +        * The MLE Header per the TXT Specification, section 2.1
> >>>>> +        * MLE capabilities, see table 4. Capabilities set:
> >>>>> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> >>>>> +        * bit 1: Support for RLP wakeup using MONITOR address
> >>>>> +        * bit 2: The ECX register will contain the pointer to the MLE page table
> >>>>> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> >>>>> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> >>>>> +        */
> >>>>> +SYM_DATA_START(mle_header)
> >>>>> +       .long   0x9082ac5a  /* UUID0 */
> >>>>> +       .long   0x74a7476f  /* UUID1 */
> >>>>> +       .long   0xa2555c0f  /* UUID2 */
> >>>>> +       .long   0x42b651cb  /* UUID3 */
> >>>>> +       .long   0x00000034  /* MLE header size */
> >>>>> +       .long   0x00020002  /* MLE version 2.2 */
> >>>>> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
> >>>>
> >>>> and these should perhaps be relative to mle_header?
> >>>>
> >>>>> +       .long   0x00000000  /* First valid page of MLE */
> >>>>> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> >>>>> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
> >>>>
> >>>> and here
> >>>>
> >>>
> >>> Ugh never mind - these are specified externally.
> >>
> >> Can you clarify your follow on comment here?
> >>
> >
> > I noticed that -as you pointed out in your previous reply- these
> > fields cannot be repainted at will, as they are defined by an external
> > specification.
> >
> > I'll play a bit more with this code tomorrow - I would *really* like
> > to avoid the need for patch #1, as it adds another constraint on how
> > we construct the boot image, and this is already riddled with legacy
> > and other complications.
>
> Yea I should have read forward through all your replies before
> responding to the first one but I think it clarified things as you point
> out here. We appreciate you help and suggestions.
>

OK, so I have a solution that does not require kernel_info at a fixed offset:

- put this at the end of arch/x86/boot/compressed/vmlinux.lds.S

#ifdef CONFIG_SECURE_LAUNCH
PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
PROVIDE(mle_header_offset       = kernel_info_offset +
ABSOLUTE(mle_header - startup_32));
PROVIDE(sl_stub_entry_offset    = kernel_info_offset +
ABSOLUTE(sl_stub_entry - startup_32));
PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata
- startup_32));
#endif


and use this for the header fields:

        /* Offset to the MLE header structure */
#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
        .long   mle_header_offset - kernel_info
#else
        .long   0
#endif



SYM_DATA_START(mle_header)
        .long   0x9082ac5a  /* UUID0 */
        .long   0x74a7476f  /* UUID1 */
        .long   0xa2555c0f  /* UUID2 */
        .long   0x42b651cb  /* UUID3 */
        .long   0x00000034  /* MLE header size */
        .long   0x00020002  /* MLE version 2.2 */
        .long   sl_stub_entry_offset - kernel_info /* Linear entry
point of MLE (virt. address) */
        .long   0x00000000  /* First valid page of MLE */
        .long   0x00000000  /* Offset within binary of first byte of MLE */
        .long   _edata_offset - kernel_info /* Offset within binary of
last byte + 1 of MLE */
        .long   0x00000227  /* Bit vector of MLE-supported capabilities */
        .long   0x00000000  /* Starting linear address of command line
(unused) */
        .long   0x00000000  /* Ending linear address of command line (unused) */

