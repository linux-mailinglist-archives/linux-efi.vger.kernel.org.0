Return-Path: <linux-efi+bounces-1119-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4438D63F3
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2F4288483
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A1815B574;
	Fri, 31 May 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxwiIj7h"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43515B0EB;
	Fri, 31 May 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164267; cv=none; b=HxD+qXJwoEyjRToHKCz0NoiVpW8K7YhNtg2ctFhX5amRkEINgzz3WHLtgEqiZnEXIzg6yl/HM1ocmfEhAXswjVvCFvKQPktjMDt++MT0dYu4ZFyWGmiQyS+WkQfIM0byXtSfZPRZP589rWcrt+cmWpgfnpQfjjaUsWAadQX7YYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164267; c=relaxed/simple;
	bh=9KO90g1YRgzZkliYyKsRBxOej6caKIqECjM2eDwUb/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8MionbgRL8T0WXB23VrRqrf3FrhVGi8RgxEIMcdRBo94e8x168mjzT1KRwiwFV9Y8ela1iuaNKN7d7dgFQMKkBFPAWDX7GTGb/W0GwmCNGQ9NH9FGx8ZHSgh3z7dEcg2X9QhlhQXKebj+rSA484F6N5iyDLmRs2n3gfslDVLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxwiIj7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40E5C4AF0A;
	Fri, 31 May 2024 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164266;
	bh=9KO90g1YRgzZkliYyKsRBxOej6caKIqECjM2eDwUb/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IxwiIj7hn26OUzhc6FSZSB2kxtIGSjsAeW5Zh+sYuxLbAdJ9teU77YZjrsMwWSVvE
	 JskgRFo3bLQo3jL51TCy84Prr9b/mNr37OCjVWeyE/3nsS5VYvXY3d7/CwHtCDilGE
	 ZMohF3b+X9kMilUSHlqYx7SrYWz2TYGEF52Velnk0guLlGlnTKVCrPyJrlbw7ogfy0
	 iowBCq73Sb3dFiierOsA8eHkfh3Zbrj+9Tc7JC5hZm/lDsfhEAFgxuQpC3N6jNEHlR
	 dMocnsvFi9u+S/KfWnm+H0cg4459PTwAlaCiyLYXtUtRxAP/t2IfC1d3FnJBBo4EMJ
	 O2tVK1YYIXzww==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ea80a18094so20677401fa.0;
        Fri, 31 May 2024 07:04:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYIQsQa7is1UQTQ9sgYZdlRHb1qV2FuUqONlFHemkXMHOfqZX9cyoySfnPV7Bt9WXLWms/IwsJunC9642hG42bRiazCTukrHEw0P40OoMnsxrsriHMT2GxCOrhf16RMxg0KJNAvr8s74wH3sxyP8fh1N1Mzx0XHKmNIeiM83qw6IFD0TLVqjp4VfZPOjwcHMPBPEhu4lyiD+WWMgp+MNph+y8g
X-Gm-Message-State: AOJu0YxtLuedKMul/bgoiyXEPLtXKeQ5BXCtyRy/OekMeLuwEBOsA224
	5aaYRon9ZzHWB9apYTy9DtDCQ76ZYxCKO1x/hKv6QeRCdUpDgOfjOzILvDOGn7OJNOVAfYLCZYV
	sMVHoFaeLbDkHYoBsnmCR5NVquXg=
X-Google-Smtp-Source: AGHT+IFbP7OVn0ZNiY1Sts+anVAaa8RDVDPxkSqpiu2vgxx2AvOg9j2jGAYMn0LrlB2WLJt0hsrRkPoyyNw9Qy5thuo=
X-Received: by 2002:a2e:a7c5:0:b0:2e2:6dd9:dd8a with SMTP id
 38308e7fff4ca-2ea84b1a993mr18049101fa.0.1717164265060; Fri, 31 May 2024
 07:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com> <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
 <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
In-Reply-To: <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 May 2024 16:04:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH3AwSiq8K6VZEp83uF-W6mtODqrCKROQZ6VqAsFGVBbg@mail.gmail.com>
Message-ID: <CAMj1kXH3AwSiq8K6VZEp83uF-W6mtODqrCKROQZ6VqAsFGVBbg@mail.gmail.com>
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
To: Ross Philipson <ross.philipson@oracle.com>
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

On Fri, 31 May 2024 at 15:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Ross,
> >
> > On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> > >
> > > The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> > > later AMD SKINIT) to vector to during the late launch. The symbol
> > > sl_stub_entry is that entry point and its offset into the kernel is
> > > conveyed to the launching code using the MLE (Measured Launch
> > > Environment) header in the structure named mle_header. The offset of the
> > > MLE header is set in the kernel_info. The routine sl_stub contains the
> > > very early late launch setup code responsible for setting up the basic
> > > environment to allow the normal kernel startup_32 code to proceed. It is
> > > also responsible for properly waking and handling the APs on Intel
> > > platforms. The routine sl_main which runs after entering 64b mode is
> > > responsible for measuring configuration and module information before
> > > it is used like the boot params, the kernel command line, the TXT heap,
> > > an external initramfs, etc.
> > >
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > ---
> > >  Documentation/arch/x86/boot.rst        |  21 +
> > >  arch/x86/boot/compressed/Makefile      |   3 +-
> > >  arch/x86/boot/compressed/head_64.S     |  30 +
> > >  arch/x86/boot/compressed/kernel_info.S |  34 ++
> > >  arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
> > >  arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
> > >  arch/x86/include/asm/msr-index.h       |   5 +
> > >  arch/x86/include/uapi/asm/bootparam.h  |   1 +
> > >  arch/x86/kernel/asm-offsets.c          |  20 +
> > >  9 files changed, 1415 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/x86/boot/compressed/sl_main.c
> > >  create mode 100644 arch/x86/boot/compressed/sl_stub.S
> > >
> > > diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> > > index 4fd492cb4970..295cdf9bcbdb 100644
> > > --- a/Documentation/arch/x86/boot.rst
> > > +++ b/Documentation/arch/x86/boot.rst
> > > @@ -482,6 +482,14 @@ Protocol:  2.00+
> > >             - If 1, KASLR enabled.
> > >             - If 0, KASLR disabled.
> > >
> > > +  Bit 2 (kernel internal): SLAUNCH_FLAG
> > > +
> > > +       - Used internally by the setup kernel to communicate
> > > +         Secure Launch status to kernel proper.
> > > +
> > > +           - If 1, Secure Launch enabled.
> > > +           - If 0, Secure Launch disabled.
> > > +
> > >    Bit 5 (write): QUIET_FLAG
> > >
> > >         - If 0, print early messages.
> > > @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
> > >
> > >    This field contains maximal allowed type for setup_data and setup_indirect structs.
> > >
> > > +============   =================
> > > +Field name:    mle_header_offset
> > > +Offset/size:   0x0010/4
> > > +============   =================
> > > +
> > > +  This field contains the offset to the Secure Launch Measured Launch Environment
> > > +  (MLE) header. This offset is used to locate information needed during a secure
> > > +  late launch using Intel TXT. If the offset is zero, the kernel does not have
> > > +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
> > > +  following a success measured launch. The specific state of the processors is
> > > +  outlined in the TXT Software Development Guide, the latest can be found here:
> > > +  https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> > > +
> > >
> >
> > Could we just repaint this field as the offset relative to the start
> > of kernel_info rather than relative to the start of the image? That
> > way, there is no need for patch #1, and given that the consumer of
> > this field accesses it via kernel_info, I wouldn't expect any issues
> > in applying this offset to obtain the actual address.
> >
> >
> > >  The Image Checksum
> > >  ==================
> > > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > > index 9189a0e28686..9076a248d4b4 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> > >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> > >  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> > >
> > > -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> > > +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
> > > +       $(obj)/sl_main.o $(obj)/sl_stub.o
> > >
> > >  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> > >         $(call if_changed,ld)
> > > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > > index 1dcb794c5479..803c9e2e6d85 100644
> > > --- a/arch/x86/boot/compressed/head_64.S
> > > +++ b/arch/x86/boot/compressed/head_64.S
> > > @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
> > >         pushq   $0
> > >         popfq
> > >
> > > +#ifdef CONFIG_SECURE_LAUNCH
> > > +       /* Ensure the relocation region is coverd by a PMR */
> >
> > covered
> >
> > > +       movq    %rbx, %rdi
> > > +       movl    $(_bss - startup_32), %esi
> > > +       callq   sl_check_region
> > > +#endif
> > > +
> > >  /*
> > >   * Copy the compressed kernel to the end of our buffer
> > >   * where decompression in place becomes safe.
> > > @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> > >         shrq    $3, %rcx
> > >         rep     stosq
> > >
> > > +#ifdef CONFIG_SECURE_LAUNCH
> > > +       /*
> > > +        * Have to do the final early sl stub work in 64b area.
> > > +        *
> > > +        * *********** NOTE ***********
> > > +        *
> > > +        * Several boot params get used before we get a chance to measure
> > > +        * them in this call. This is a known issue and we currently don't
> > > +        * have a solution. The scratch field doesn't matter. There is no
> > > +        * obvious way to do anything about the use of kernel_alignment or
> > > +        * init_size though these seem low risk with all the PMR and overlap
> > > +        * checks in place.
> > > +        */
> > > +       movq    %r15, %rdi
> > > +       callq   sl_main
> > > +
> > > +       /* Ensure the decompression location is covered by a PMR */
> > > +       movq    %rbp, %rdi
> > > +       movq    output_len(%rip), %rsi
> > > +       callq   sl_check_region
> > > +#endif
> > > +
> > > +       pushq   %rsi
> >
> > This looks like a rebase error.
> >
> > >         call    load_stage2_idt
> > >
> > >         /* Pass boot_params to initialize_identity_maps() */
> > > diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> > > index c18f07181dd5..e199b87764e9 100644
> > > --- a/arch/x86/boot/compressed/kernel_info.S
> > > +++ b/arch/x86/boot/compressed/kernel_info.S
> > > @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
> > >         /* Maximal allowed type for setup_data and setup_indirect structs. */
> > >         .long   SETUP_TYPE_MAX
> > >
> > > +       /* Offset to the MLE header structure */
> > > +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> > > +       .long   rva(mle_header)
> >
> > ... so this could just be mle_header - kernel_info, and the consumer
> > can do the math instead.
> >
> > > +#else
> > > +       .long   0
> > > +#endif
> > > +
> > >  kernel_info_var_len_data:
> > >         /* Empty for time being... */
> > >  SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> > > +
> > > +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> > > +       /*
> > > +        * The MLE Header per the TXT Specification, section 2.1
> > > +        * MLE capabilities, see table 4. Capabilities set:
> > > +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> > > +        * bit 1: Support for RLP wakeup using MONITOR address
> > > +        * bit 2: The ECX register will contain the pointer to the MLE page table
> > > +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> > > +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> > > +        */
> > > +SYM_DATA_START(mle_header)
> > > +       .long   0x9082ac5a  /* UUID0 */
> > > +       .long   0x74a7476f  /* UUID1 */
> > > +       .long   0xa2555c0f  /* UUID2 */
> > > +       .long   0x42b651cb  /* UUID3 */
> > > +       .long   0x00000034  /* MLE header size */
> > > +       .long   0x00020002  /* MLE version 2.2 */
> > > +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
> >
> > and these should perhaps be relative to mle_header?
> >
> > > +       .long   0x00000000  /* First valid page of MLE */
> > > +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> > > +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
> >
> > and here
> >
>
> Ugh never mind - these are specified externally.

OK, so instead of patch #1, please use the linker script to generate
these constants.

I.e., add this to arch/x86/boot/compressed/vmlinux.lds.S

#ifdef CONFIG_SECURE_LAUNCH
PROVIDE(mle_header_offset       = mle_header - startup_32);
PROVIDE(sl_stub_entry_offset    = sl_stub_entry - startup_32);
PROVIDE(_edata_offset           = _edata - startup_32);
#endif

and use the symbols on the left hand side in the code.

