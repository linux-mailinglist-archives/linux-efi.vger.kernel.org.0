Return-Path: <linux-efi+bounces-554-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22E855C73
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093791F21384
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27943DDD9;
	Thu, 15 Feb 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpj7sU+8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C3CA4E;
	Thu, 15 Feb 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985759; cv=none; b=eUi3+XIdtci7E7+IhlxA4CtJC9NEufKGMYjm+fouG/hZ1PRJ+nxUTI3KOZN3rvIzZnacpyqnUQa6RyB8wwQOYO18/6vPlGORRq0Wmw0blyxgTuR81p/HPhs0SfBhohMrNwyhrrTVYLrqOde0/Bm0gbIbUHr15Z8kpz5GOwskm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985759; c=relaxed/simple;
	bh=RR9SobNyGaP8aWkEJ5jtJvdu3aPbBelKof6b3n7TpaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbWnexM7JoE51WqpoOYwYlXkN+MM0zMeUtT5rVq9wWRj+Fu7uCzQiiAXs2ErSJjkBas8GVxCKaSXv8pjXfez1sgS0Qes/Bszo/TMIdlNHxox0xccDiLEc6tw1XgO4dS59J8mrYIqHfMAa+bpI1ueWG20+9Y1wPiZJ9Sy/rkE5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpj7sU+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C041C43601;
	Thu, 15 Feb 2024 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707985758;
	bh=RR9SobNyGaP8aWkEJ5jtJvdu3aPbBelKof6b3n7TpaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cpj7sU+8/1/WT4WjSMSwPBiGNkClLUY5pYU8qSx+two4Jbaoni2ap2+erDRizgkU/
	 5GbkLbjs5mAMFyQU7gIXixXNuJl5rZcgzHLySgcotZJdpsUr8DhU/tXQN45Dd5qOML
	 tmBnzfrFUm3uJyvS8vCBdyoKpOoC/B4lydP5Xe1f8/u817Yl2yb4guFv4/OdDWtEza
	 5vMfxOQ9zxBteby5/o+XJYuXuEqhWZMc4KZifrhpbNPFeAPQsLbmtwPq/iO81AVAs0
	 jYfFq2Q4rTItkNEXK4t3M4vTwWUqKtygnpDjj+dRgqPMcCsgAAP7L8eZcLCUNiR6a4
	 td2/qgpHsX5bg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d11c55d7f2so8344881fa.2;
        Thu, 15 Feb 2024 00:29:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFDNVC4qqaHTPCyTX4+iVOhddrTJfrIlbZoMyF8qJW4dan6OUvCe4cV1w4JyS8K6XKSa94eg3Ted0gc/k+soICip+bQP1MLkhgELUCAm2hSfAIxzGQBe1RIyXmhe/7TY28i/rsL7VKYmojjkytDzbmkmaQGW+SmA82stFB2sLy4eZCLsGp2vO6C0CVse9rx2IuFNDAyhBCb/kOnGPHYTqVRUEG
X-Gm-Message-State: AOJu0YwKiFhTkykt/eTJ2B3BeBadeoRGaeOsENvpjxL1drRtD6/64J+6
	YngWLivOcJmNGFtFvQiINQRl8kOu4NQYuR0flkYCvfUKJOAiNu/e0zGBzpS0MBcI16PlplPT2nl
	EOLcsFHIWLzVkTYReIpPsXs1ilAQ=
X-Google-Smtp-Source: AGHT+IEHdPD7qYyG1J0ESLFcQWTt7BkdBWZSWkDwlgOjabpPkM825c8x+d1hO6YTJYppFG6nphhgdSi4tLkv+4zC+lI=
X-Received: by 2002:a19:5e12:0:b0:511:7746:5687 with SMTP id
 s18-20020a195e12000000b0051177465687mr808544lfb.24.1707985755845; Thu, 15 Feb
 2024 00:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-8-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-8-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 09:29:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHAhazZmd3JZyjmNTNgmMGUTFb6LOsviwcmEs+XUxHNhw@mail.gmail.com>
Message-ID: <CAMj1kXHAhazZmd3JZyjmNTNgmMGUTFb6LOsviwcmEs+XUxHNhw@mail.gmail.com>
Subject: Re: [PATCH v8 07/15] x86: Secure Launch kernel early boot stub
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> later AMD SKINIT) to vector to during the late launch. The symbol
> sl_stub_entry is that entry point and its offset into the kernel is
> conveyed to the launching code using the MLE (Measured Launch
> Environment) header in the structure named mle_header. The offset of the
> MLE header is set in the kernel_info. The routine sl_stub contains the
> very early late launch setup code responsible for setting up the basic
> environment to allow the normal kernel startup_32 code to proceed. It is
> also responsible for properly waking and handling the APs on Intel
> platforms. The routine sl_main which runs after entering 64b mode is
> responsible for measuring configuration and module information before
> it is used like the boot params, the kernel command line, the TXT heap,
> an external initramfs, etc.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  Documentation/arch/x86/boot.rst        |  21 +
>  arch/x86/boot/compressed/Makefile      |   3 +-
>  arch/x86/boot/compressed/head_64.S     |  34 ++
>  arch/x86/boot/compressed/kernel_info.S |  34 ++
>  arch/x86/boot/compressed/sl_main.c     | 582 ++++++++++++++++++++
>  arch/x86/boot/compressed/sl_stub.S     | 705 +++++++++++++++++++++++++
>  arch/x86/include/asm/msr-index.h       |   5 +
>  arch/x86/include/uapi/asm/bootparam.h  |   1 +
>  arch/x86/kernel/asm-offsets.c          |  20 +
>  9 files changed, 1404 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/boot/compressed/sl_main.c
>  create mode 100644 arch/x86/boot/compressed/sl_stub.S
>
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index c513855a54bb..ce6a51c6d4e7 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -482,6 +482,14 @@ Protocol:  2.00+
>             - If 1, KASLR enabled.
>             - If 0, KASLR disabled.
>
> +  Bit 2 (kernel internal): SLAUNCH_FLAG
> +
> +       - Used internally by the compressed kernel to communicate

decompressor

> +         Secure Launch status to kernel proper.
> +
> +           - If 1, Secure Launch enabled.
> +           - If 0, Secure Launch disabled.
> +
>    Bit 5 (write): QUIET_FLAG
>
>         - If 0, print early messages.
> @@ -1027,6 +1035,19 @@ Offset/size:     0x000c/4
>
>    This field contains maximal allowed type for setup_data and setup_indirect structs.
>
> +============   =================
> +Field name:    mle_header_offset
> +Offset/size:   0x0010/4
> +============   =================
> +
> +  This field contains the offset to the Secure Launch Measured Launch Environment
> +  (MLE) header. This offset is used to locate information needed during a secure
> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
> +  following a success measured launch. The specific state of the processors is
> +  outlined in the TXT Software Development Guide, the latest can be found here:
> +  https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> +
>
>  The Image Checksum
>  ==================
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index a1b018eb9801..012f7ca780c3 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
> +       $(obj)/sl_main.o $(obj)/sl_stub.o
>
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>         $(call if_changed,ld)
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index bf4a10a5794f..6fa5bb87195b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -415,6 +415,17 @@ SYM_CODE_START(startup_64)
>         pushq   $0
>         popfq
>
> +#ifdef CONFIG_SECURE_LAUNCH
> +       pushq   %rsi
> +

This push and the associated pop are no longer needed.

> +       /* Ensure the relocation region coverd by a PMR */

'is covered'

> +       movq    %rbx, %rdi
> +       movl    $(_bss - startup_32), %esi
> +       callq   sl_check_region
> +
> +       popq    %rsi
> +#endif
> +
>  /*
>   * Copy the compressed kernel to the end of our buffer
>   * where decompression in place becomes safe.
> @@ -457,6 +468,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         shrq    $3, %rcx
>         rep     stosq
>
> +#ifdef CONFIG_SECURE_LAUNCH
> +       /*
> +        * Have to do the final early sl stub work in 64b area.
> +        *
> +        * *********** NOTE ***********
> +        *
> +        * Several boot params get used before we get a chance to measure
> +        * them in this call. This is a known issue and we currently don't
> +        * have a solution. The scratch field doesn't matter. There is no
> +        * obvious way to do anything about the use of kernel_alignment or
> +        * init_size though these seem low risk with all the PMR and overlap
> +        * checks in place.
> +        */
> +       movq    %r15, %rdi
> +       callq   sl_main
> +
> +       /* Ensure the decompression location is coverd by a PMR */

covered

> +       movq    %rbp, %rdi
> +       movq    output_len(%rip), %rsi
> +       callq   sl_check_region
> +#endif
> +
> +       pushq   %rsi
>         call    load_stage2_idt
>
>         /* Pass boot_params to initialize_identity_maps() */
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index c18f07181dd5..e199b87764e9 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
>         /* Maximal allowed type for setup_data and setup_indirect structs. */
>         .long   SETUP_TYPE_MAX
>
> +       /* Offset to the MLE header structure */
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +       .long   rva(mle_header)
> +#else
> +       .long   0
> +#endif
> +
>  kernel_info_var_len_data:
>         /* Empty for time being... */
>  SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> +
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +       /*
> +        * The MLE Header per the TXT Specification, section 2.1
> +        * MLE capabilities, see table 4. Capabilities set:
> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> +        * bit 1: Support for RLP wakeup using MONITOR address
> +        * bit 2: The ECX register will contain the pointer to the MLE page table
> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> +        */
> +SYM_DATA_START(mle_header)
> +       .long   0x9082ac5a  /* UUID0 */
> +       .long   0x74a7476f  /* UUID1 */
> +       .long   0xa2555c0f  /* UUID2 */
> +       .long   0x42b651cb  /* UUID3 */
> +       .long   0x00000034  /* MLE header size */
> +       .long   0x00020002  /* MLE version 2.2 */
> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
> +       .long   0x00000000  /* First valid page of MLE */
> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
> +       .long   0x00000227  /* Bit vector of MLE-supported capabilities */
> +       .long   0x00000000  /* Starting linear address of command line (unused) */
> +       .long   0x00000000  /* Ending linear address of command line (unused) */
> +SYM_DATA_END(mle_header)
> +#endif
> diff --git a/arch/x86/boot/compressed/sl_main.c b/arch/x86/boot/compressed/sl_main.c
> new file mode 100644
> index 000000000000..cd9e5c1f1719
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sl_main.c
> @@ -0,0 +1,582 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch early measurement and validation routines.
> + *
> + * Copyright (c) 2022, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/linkage.h>
> +#include <asm/segment.h>
> +#include <asm/boot.h>
> +#include <asm/msr.h>
> +#include <asm/mtrr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/bootparam.h>
> +#include <asm/bootparam_utils.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +#include <crypto/sha1.h>
> +#include <crypto/sha2.h>
> +
> +#define CAPS_VARIABLE_MTRR_COUNT_MASK  0xff
> +
> +#define SL_TPM12_LOG           1
> +#define SL_TPM20_LOG           2
> +
> +#define SL_TPM20_MAX_ALGS      2
> +
> +#define SL_MAX_EVENT_DATA      64
> +#define SL_TPM12_LOG_SIZE      (sizeof(struct tcg_pcr_event) + \
> +                               SL_MAX_EVENT_DATA)
> +#define SL_TPM20_LOG_SIZE      (sizeof(struct tcg_pcr_event2_head) + \
> +                               SHA1_DIGEST_SIZE + SHA256_DIGEST_SIZE + \
> +                               sizeof(struct tcg_event_field) + \
> +                               SL_MAX_EVENT_DATA)
> +
> +static void *evtlog_base;
> +static u32 evtlog_size;
> +static struct txt_heap_event_log_pointer2_1_element *log20_elem;
> +static u32 tpm_log_ver = SL_TPM12_LOG;
> +static struct tcg_efi_specid_event_algs tpm_algs[SL_TPM20_MAX_ALGS] = {0};
> +
> +extern u32 sl_cpu_type;
> +extern u32 sl_mle_start;
> +
> +static u64 sl_txt_read(u32 reg)
> +{
> +       return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
> +}
> +
> +static void sl_txt_write(u32 reg, u64 val)
> +{
> +       writeq(val, (void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
> +}
> +
> +static void __noreturn sl_txt_reset(u64 error)
> +{
> +       /* Reading the E2STS register acts as a barrier for TXT registers */
> +       sl_txt_write(TXT_CR_ERRORCODE, error);
> +       sl_txt_read(TXT_CR_E2STS);
> +       sl_txt_write(TXT_CR_CMD_UNLOCK_MEM_CONFIG, 1);
> +       sl_txt_read(TXT_CR_E2STS);
> +       sl_txt_write(TXT_CR_CMD_RESET, 1);
> +
> +       for ( ; ; )
> +               asm volatile ("hlt");
> +
> +       unreachable();
> +}
> +
> +static u64 sl_rdmsr(u32 reg)
> +{
> +       u64 lo, hi;
> +
> +       asm volatile ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (reg));
> +

No need for volatile.

> +       return (hi << 32) | lo;
> +}
> +
> +static struct slr_table *sl_locate_and_validate_slrt(void)
> +{
> +       struct txt_os_mle_data *os_mle_data;
> +       struct slr_table *slrt;
> +       void *txt_heap;
> +
> +       txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +       os_mle_data = txt_os_mle_data_start(txt_heap);
> +
> +       if (!os_mle_data->slrt)
> +               sl_txt_reset(SL_ERROR_INVALID_SLRT);
> +
> +       slrt = (struct slr_table *)os_mle_data->slrt;
> +
> +       if (slrt->magic != SLR_TABLE_MAGIC)
> +               sl_txt_reset(SL_ERROR_INVALID_SLRT);
> +
> +       if (slrt->architecture != SLR_INTEL_TXT)
> +               sl_txt_reset(SL_ERROR_INVALID_SLRT);
> +
> +       return slrt;
> +}
> +
> +static void sl_check_pmr_coverage(void *base, u32 size, bool allow_hi)
> +{
> +       struct txt_os_sinit_data *os_sinit_data;
> +       void *end = base + size;
> +       void *txt_heap;
> +
> +       if (!(sl_cpu_type & SL_CPU_INTEL))
> +               return;
> +
> +       txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +       os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +
> +       if ((end >= (void *)0x100000000ULL) && (base < (void *)0x100000000ULL))
> +               sl_txt_reset(SL_ERROR_REGION_STRADDLE_4GB);
> +
> +       /*
> +        * Note that the late stub code validates that the hi PMR covers
> +        * all memory above 4G. At this point the code can only check that
> +        * regions are within the hi PMR but that is sufficient.
> +        */
> +       if ((end > (void *)0x100000000ULL) && (base >= (void *)0x100000000ULL)) {
> +               if (allow_hi) {
> +                       if (end >= (void *)(os_sinit_data->vtd_pmr_hi_base +
> +                                          os_sinit_data->vtd_pmr_hi_size))
> +                               sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
> +               } else {
> +                       sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);
> +               }
> +       }
> +
> +       if (end >= (void *)os_sinit_data->vtd_pmr_lo_size)
> +               sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
> +}
> +
> +/*
> + * Some MSRs are modified by the pre-launch code including the MTRRs.
> + * The early MLE code has to restore these values. This code validates
> + * the values after they are measured.
> + */
> +static void sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
> +{
> +       struct slr_txt_mtrr_state *saved_bsp_mtrrs;
> +       u64 mtrr_caps, mtrr_def_type, mtrr_var;
> +       struct slr_entry_intel_info *txt_info;
> +       u64 misc_en_msr;
> +       u32 vcnt, i;
> +
> +       txt_info = (struct slr_entry_intel_info *)os_mle_data->txt_info;
> +       saved_bsp_mtrrs = &txt_info->saved_bsp_mtrrs;
> +
> +       mtrr_caps = sl_rdmsr(MSR_MTRRcap);
> +       vcnt = (u32)(mtrr_caps & CAPS_VARIABLE_MTRR_COUNT_MASK);
> +
> +       if (saved_bsp_mtrrs->mtrr_vcnt > vcnt)
> +               sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
> +       if (saved_bsp_mtrrs->mtrr_vcnt > TXT_OS_MLE_MAX_VARIABLE_MTRRS)
> +               sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
> +
> +       mtrr_def_type = sl_rdmsr(MSR_MTRRdefType);
> +       if (saved_bsp_mtrrs->default_mem_type != mtrr_def_type)
> +               sl_txt_reset(SL_ERROR_MTRR_INV_DEF_TYPE);
> +
> +       for (i = 0; i < saved_bsp_mtrrs->mtrr_vcnt; i++) {
> +               mtrr_var = sl_rdmsr(MTRRphysBase_MSR(i));
> +               if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physbase != mtrr_var)
> +                       sl_txt_reset(SL_ERROR_MTRR_INV_BASE);
> +               mtrr_var = sl_rdmsr(MTRRphysMask_MSR(i));
> +               if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physmask != mtrr_var)
> +                       sl_txt_reset(SL_ERROR_MTRR_INV_MASK);
> +       }
> +
> +       misc_en_msr = sl_rdmsr(MSR_IA32_MISC_ENABLE);
> +       if (txt_info->saved_misc_enable_msr != misc_en_msr)
> +               sl_txt_reset(SL_ERROR_MSR_INV_MISC_EN);
> +}
> +
> +static void sl_find_drtm_event_log(struct slr_table *slrt)
> +{
> +       struct txt_os_sinit_data *os_sinit_data;
> +       struct slr_entry_log_info *log_info;
> +       void *txt_heap;
> +
> +       log_info = (struct slr_entry_log_info *)
> +                   slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
> +       if (!log_info)
> +               sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +       evtlog_base = (void *)log_info->addr;
> +       evtlog_size = log_info->size;
> +
> +       txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +
> +       /*
> +        * For TPM 2.0, the event log 2.1 extended data structure has to also
> +        * be located and fixed up.
> +        */
> +       os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +
> +       /*
> +        * Only support version 6 and later that properly handle the
> +        * list of ExtDataElements in the OS-SINIT structure.
> +        */
> +       if (os_sinit_data->version < 6)
> +               sl_txt_reset(SL_ERROR_OS_SINIT_BAD_VERSION);
> +
> +       /* Find the TPM2.0 logging extended heap element */
> +       log20_elem = tpm20_find_log2_1_element(os_sinit_data);
> +
> +       /* If found, this implies TPM20 log and family */
> +       if (log20_elem)
> +               tpm_log_ver = SL_TPM20_LOG;
> +}
> +
> +static void sl_validate_event_log_buffer(void)
> +{
> +       struct txt_os_sinit_data *os_sinit_data;
> +       void *txt_heap, *txt_end;
> +       void *mle_base, *mle_end;
> +       void *evtlog_end;
> +
> +       if ((u64)evtlog_size > (LLONG_MAX - (u64)evtlog_base))
> +               sl_txt_reset(SL_ERROR_INTEGER_OVERFLOW);
> +       evtlog_end = evtlog_base + evtlog_size;
> +
> +       txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +       txt_end = txt_heap + sl_txt_read(TXT_CR_HEAP_SIZE);
> +       os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +
> +       mle_base = (void *)(u64)sl_mle_start;
> +       mle_end = mle_base + os_sinit_data->mle_size;
> +
> +       /*
> +        * This check is to ensure the event log buffer does not overlap with
> +        * the MLE image.
> +        */
> +       if (evtlog_base >= mle_end && evtlog_end > mle_end)
> +               goto pmr_check; /* above */
> +
> +       if (evtlog_end <= mle_base && evtlog_base < mle_base)
> +               goto pmr_check; /* below */
> +
> +       sl_txt_reset(SL_ERROR_MLE_BUFFER_OVERLAP);
> +
> +pmr_check:
> +       /*
> +        * The TXT heap is protected by the DPR. If the TPM event log is
> +        * inside the TXT heap, there is no need for a PMR check.
> +        */
> +       if (evtlog_base > txt_heap && evtlog_end < txt_end)
> +               return;
> +
> +       sl_check_pmr_coverage(evtlog_base, evtlog_size, true);
> +}
> +
> +static void sl_find_event_log_algorithms(void)
> +{
> +       struct tcg_efi_specid_event_head *efi_head =
> +               (struct tcg_efi_specid_event_head *)(evtlog_base +
> +                                       log20_elem->first_record_offset +
> +                                       sizeof(struct tcg_pcr_event));
> +
> +       if (efi_head->num_algs == 0 || efi_head->num_algs > 2)
> +               sl_txt_reset(SL_ERROR_TPM_NUMBER_ALGS);
> +
> +       memcpy(&tpm_algs[0], &efi_head->digest_sizes[0],
> +              sizeof(struct tcg_efi_specid_event_algs) * efi_head->num_algs);
> +}
> +
> +static void sl_tpm12_log_event(u32 pcr, u32 event_type,
> +                              const u8 *data, u32 length,
> +                              const u8 *event_data, u32 event_size)
> +{
> +       u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
> +       u8 log_buf[SL_TPM12_LOG_SIZE] = {0};
> +       struct tcg_pcr_event *pcr_event;
> +       u32 total_size;
> +
> +       pcr_event = (struct tcg_pcr_event *)log_buf;
> +       pcr_event->pcr_idx = pcr;
> +       pcr_event->event_type = event_type;
> +       if (length > 0) {
> +               sha1(data, length, &sha1_hash[0]);
> +               memcpy(&pcr_event->digest[0], &sha1_hash[0], SHA1_DIGEST_SIZE);
> +       }
> +       pcr_event->event_size = event_size;
> +       if (event_size > 0)
> +               memcpy((u8 *)pcr_event + sizeof(struct tcg_pcr_event),
> +                      event_data, event_size);
> +
> +       total_size = sizeof(struct tcg_pcr_event) + event_size;
> +
> +       if (tpm12_log_event(evtlog_base, evtlog_size, total_size, pcr_event))
> +               sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
> +}
> +
> +static void sl_tpm20_log_event(u32 pcr, u32 event_type,
> +                              const u8 *data, u32 length,
> +                              const u8 *event_data, u32 event_size)
> +{
> +       u8 sha256_hash[SHA256_DIGEST_SIZE] = {0};
> +       u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
> +       u8 log_buf[SL_TPM20_LOG_SIZE] = {0};
> +       struct sha256_state sctx256 = {0};
> +       struct tcg_pcr_event2_head *head;
> +       struct tcg_event_field *event;
> +       u32 total_size;
> +       u16 *alg_ptr;
> +       u8 *dgst_ptr;
> +
> +       head = (struct tcg_pcr_event2_head *)log_buf;
> +       head->pcr_idx = pcr;
> +       head->event_type = event_type;
> +       total_size = sizeof(struct tcg_pcr_event2_head);
> +       alg_ptr = (u16 *)(log_buf + sizeof(struct tcg_pcr_event2_head));
> +
> +       for ( ; head->count < 2; head->count++) {
> +               if (!tpm_algs[head->count].alg_id)
> +                       break;
> +
> +               *alg_ptr = tpm_algs[head->count].alg_id;
> +               dgst_ptr = (u8 *)alg_ptr + sizeof(u16);
> +
> +               if (tpm_algs[head->count].alg_id == TPM_ALG_SHA256 &&
> +                   length) {
> +                       sha256_init(&sctx256);
> +                       sha256_update(&sctx256, data, length);
> +                       sha256_final(&sctx256, &sha256_hash[0]);
> +               } else if (tpm_algs[head->count].alg_id == TPM_ALG_SHA1 &&
> +                          length) {
> +                       sha1(data, length, &sha1_hash[0]);
> +               }
> +
> +               if (tpm_algs[head->count].alg_id == TPM_ALG_SHA256) {
> +                       memcpy(dgst_ptr, &sha256_hash[0], SHA256_DIGEST_SIZE);
> +                       total_size += SHA256_DIGEST_SIZE + sizeof(u16);
> +                       alg_ptr = (u16 *)((u8 *)alg_ptr + SHA256_DIGEST_SIZE + sizeof(u16));
> +               } else if (tpm_algs[head->count].alg_id == TPM_ALG_SHA1) {
> +                       memcpy(dgst_ptr, &sha1_hash[0], SHA1_DIGEST_SIZE);
> +                       total_size += SHA1_DIGEST_SIZE + sizeof(u16);
> +                       alg_ptr = (u16 *)((u8 *)alg_ptr + SHA1_DIGEST_SIZE + sizeof(u16));
> +               } else {
> +                       sl_txt_reset(SL_ERROR_TPM_UNKNOWN_DIGEST);
> +               }
> +       }
> +
> +       event = (struct tcg_event_field *)(log_buf + total_size);
> +       event->event_size = event_size;
> +       if (event_size > 0)
> +               memcpy((u8 *)event + sizeof(struct tcg_event_field), event_data, event_size);
> +       total_size += sizeof(struct tcg_event_field) + event_size;
> +
> +       if (tpm20_log_event(log20_elem, evtlog_base, evtlog_size, total_size, &log_buf[0]))
> +               sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
> +}
> +
> +static void sl_tpm_extend_evtlog(u32 pcr, u32 type,
> +                                const u8 *data, u32 length, const char *desc)
> +{
> +       if (tpm_log_ver == SL_TPM20_LOG)
> +               sl_tpm20_log_event(pcr, type, data, length,
> +                                  (const u8 *)desc, strlen(desc));
> +       else
> +               sl_tpm12_log_event(pcr, type, data, length,
> +                                  (const u8 *)desc, strlen(desc));
> +}
> +
> +static struct setup_data *sl_handle_setup_data(struct setup_data *curr,
> +                                              struct slr_policy_entry *entry)
> +{
> +       struct setup_indirect *ind;
> +       struct setup_data *next;
> +
> +       if (!curr)
> +               return NULL;
> +
> +       next = (struct setup_data *)(unsigned long)curr->next;
> +
> +       /* SETUP_INDIRECT instances have to be handled differently */
> +       if (curr->type == SETUP_INDIRECT) {
> +               ind = (struct setup_indirect *)((u8 *)curr + offsetof(struct setup_data, data));
> +
> +               sl_check_pmr_coverage((void *)ind->addr, ind->len, true);
> +
> +               sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
> +                                    (void *)ind->addr, ind->len,
> +                                    entry->evt_info);
> +
> +               return next;
> +       }
> +
> +       sl_check_pmr_coverage(((u8 *)curr) + sizeof(struct setup_data),
> +                             curr->len, true);
> +
> +       sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
> +                            ((u8 *)curr) + sizeof(struct setup_data),
> +                            curr->len,
> +                            entry->evt_info);
> +
> +       return next;
> +}
> +
> +static void sl_extend_setup_data(struct slr_policy_entry *entry)
> +{
> +       struct setup_data *data;
> +
> +       /*
> +        * Measuring the boot params measured the fixed e820 memory map.
> +        * Measure any setup_data entries including e820 extended entries.
> +        */
> +       data = (struct setup_data *)(unsigned long)entry->entity;
> +       while (data)
> +               data = sl_handle_setup_data(data, entry);
> +}
> +
> +static void sl_extend_slrt(struct slr_policy_entry *entry)
> +{
> +       struct slr_table *slrt = (struct slr_table *)entry->entity;
> +       struct slr_entry_intel_info *intel_info;
> +
> +       /*
> +        * In revision one of the SLRT, the only table that needs to be
> +        * measured is the Intel info table. Everything else is meta-data,
> +        * addresses and sizes. Note the size of what to measure is not set.
> +        * The flag SLR_POLICY_IMPLICIT_SIZE leaves it to the measuring code
> +        * to sort out.
> +        */
> +       if (slrt->revision == 1) {
> +               intel_info = (struct slr_entry_intel_info *)slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
> +               if (!intel_info)
> +                       sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +               sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
> +                                    (void *)entry->entity, sizeof(struct slr_entry_intel_info),
> +                                    entry->evt_info);
> +       }
> +}
> +
> +static void sl_extend_txt_os2mle(struct slr_policy_entry *entry)
> +{
> +       struct txt_os_mle_data *os_mle_data;
> +       void *txt_heap;
> +
> +       txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +       os_mle_data = txt_os_mle_data_start(txt_heap);
> +
> +       /*
> +        * Version 1 of the OS-MLE heap structure has no fields to measure. It just
> +        * has addresses and sizes and a scratch buffer.
> +        */
> +       if (os_mle_data->version == 1)
> +               return;
> +}
> +
> +static void sl_process_extend_policy(struct slr_table *slrt)
> +{
> +       struct slr_entry_policy *policy;
> +       struct slr_policy_entry *entry;
> +       u16 i;
> +
> +       policy = (struct slr_entry_policy *)slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
> +       if (!policy)
> +               sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +       entry = (struct slr_policy_entry *)((u8 *)policy + sizeof(*policy));
> +
> +       for (i = 0; i < policy->nr_entries; i++, entry++) {
> +               switch (entry->entity_type) {
> +               case SLR_ET_SETUP_DATA:
> +                       sl_extend_setup_data(entry);
> +                       break;
> +               case SLR_ET_SLRT:
> +                       sl_extend_slrt(entry);
> +                       break;
> +               case SLR_ET_TXT_OS2MLE:
> +                       sl_extend_txt_os2mle(entry);
> +                       break;
> +               case SLR_ET_UNUSED:
> +                       continue;
> +               default:
> +                       sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
> +                                            (void *)entry->entity, entry->size,
> +                                            entry->evt_info);
> +               }
> +       }
> +}
> +
> +static void sl_process_extend_uefi_config(struct slr_table *slrt)
> +{
> +       struct slr_entry_uefi_config *uefi_config;
> +       struct slr_uefi_cfg_entry *uefi_entry;
> +       u64 i;
> +
> +       uefi_config =(struct slr_entry_uefi_config *)slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_UEFI_CONFIG);
> +
> +       /* Optionally here depending on how SL kernel was booted */
> +       if (!uefi_config)
> +               return;
> +
> +       uefi_entry = (struct slr_uefi_cfg_entry *)((u8 *)uefi_config + sizeof(*uefi_config));
> +
> +       for (i = 0; i < uefi_config->nr_entries; i++, uefi_entry++) {
> +               sl_tpm_extend_evtlog(uefi_entry->pcr, TXT_EVTYPE_SLAUNCH,
> +                                    (void *)uefi_entry->cfg, uefi_entry->size,
> +                                    uefi_entry->evt_info);
> +       }
> +}
> +
> +asmlinkage __visible void sl_check_region(void *base, u32 size)
> +{
> +       sl_check_pmr_coverage(base, size, false);
> +}
> +
> +asmlinkage __visible void sl_main(void *bootparams)
> +{
> +       struct boot_params *bp  = (struct boot_params *)bootparams;
> +       struct txt_os_mle_data *os_mle_data;
> +       struct slr_table *slrt;
> +       void *txt_heap;
> +
> +       /*
> +        * Ensure loadflags do not indicate a secure launch was done
> +        * unless it really was.
> +        */
> +       bp->hdr.loadflags &= ~SLAUNCH_FLAG;
> +
> +       /*
> +        * Currently only Intel TXT is supported for Secure Launch. Testing
> +        * this value also indicates that the kernel was booted successfully
> +        * through the Secure Launch entry point and is in SMX mode.
> +        */
> +       if (!(sl_cpu_type & SL_CPU_INTEL))
> +               return;
> +
> +       slrt = sl_locate_and_validate_slrt();
> +
> +       /* Locate the TPM event log. */
> +       sl_find_drtm_event_log(slrt);
> +
> +       /* Validate the location of the event log buffer before using it */
> +       sl_validate_event_log_buffer();
> +
> +       /*
> +        * Find the TPM hash algorithms used by the ACM and recorded in the
> +        * event log.
> +        */
> +       if (tpm_log_ver == SL_TPM20_LOG)
> +               sl_find_event_log_algorithms();
> +
> +       /*
> +        * Sanitize them before measuring. Set the SLAUNCH_FLAG early since if
> +        * anything fails, the system will reset anyway.
> +        */
> +       sanitize_boot_params(bp);
> +       bp->hdr.loadflags |= SLAUNCH_FLAG;
> +
> +       sl_check_pmr_coverage(bootparams, PAGE_SIZE, false);
> +
> +       /* Place event log SL specific tags before and after measurements */
> +       sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_START, NULL, 0, "");
> +
> +       /* Process all policy entries and extend the measurements to the evtlog */
> +       sl_process_extend_policy(slrt);
> +
> +       /* Process all EFI config entries and extend the measurements to the evtlog */
> +       sl_process_extend_uefi_config(slrt);
> +
> +       sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_END, NULL, 0, "");
> +
> +       /* No PMR check is needed, the TXT heap is covered by the DPR */
> +       txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +       os_mle_data = txt_os_mle_data_start(txt_heap);
> +
> +       /*
> +        * Now that the OS-MLE data is measured, ensure the MTRR and
> +        * misc enable MSRs are what we expect.
> +        */
> +       sl_txt_validate_msrs(os_mle_data);
> +}
> diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
> new file mode 100644
> index 000000000000..42a7436cf2ee
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sl_stub.S
> @@ -0,0 +1,705 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Secure Launch protected mode entry point.
> + *
> + * Copyright (c) 2022, Oracle and/or its affiliates.
> + */
> +       .code32
> +       .text
> +#include <linux/linkage.h>
> +#include <asm/segment.h>
> +#include <asm/msr.h>
> +#include <asm/apicdef.h>
> +#include <asm/trapnr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/bootparam.h>
> +#include <asm/page_types.h>
> +#include <asm/irq_vectors.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +
> +/* CPUID: leaf 1, ECX, SMX feature bit */
> +#define X86_FEATURE_BIT_SMX    (1 << 6)
> +
> +#define IDT_VECTOR_LO_BITS     0
> +#define IDT_VECTOR_HI_BITS     6
> +
> +/*
> + * See the comment in head_64.S for detailed information on what this macro
> + * and others like it are used for. The comment appears right at the top of
> + * the file.
> + */
> +#define rva(X) ((X) - sl_stub_entry)
> +
> +/*
> + * The GETSEC op code is open coded because older versions of
> + * GCC do not support the getsec mnemonic.
> + */
> +.macro GETSEC leaf
> +       pushl   %ebx
> +       xorl    %ebx, %ebx      /* Must be zero for SMCTRL */
> +       movl    \leaf, %eax     /* Leaf function */
> +       .byte   0x0f, 0x37      /* GETSEC opcode */
> +       popl    %ebx
> +.endm
> +
> +.macro TXT_RESET error
> +       /*
> +        * Set a sticky error value and reset. Note the movs to %eax act as
> +        * TXT register barriers.
> +        */
> +       movl    \error, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
> +       movl    (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
> +       movl    $1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_NO_SECRETS)
> +       movl    (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
> +       movl    $1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_UNLOCK_MEM_CONFIG)
> +       movl    (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
> +       movl    $1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_RESET)
> +1:
> +       hlt
> +       jmp     1b
> +.endm
> +
> +       .code32
> +SYM_FUNC_START(sl_stub_entry)
> +       cli
> +       cld
> +
> +       /*
> +        * On entry, %ebx has the entry abs offset to sl_stub_entry. This
> +        * will be correctly scaled using the rva macro and avoid causing
> +        * relocations. Only %cs and %ds segments are known good.
> +        */
> +
> +       /* Load GDT, set segment regs and lret to __SL32_CS */
> +       leal    rva(sl_gdt_desc)(%ebx), %eax
> +       addl    %eax, 2(%eax)
> +       lgdt    (%eax)
> +
> +       movl    $(__SL32_DS), %eax
> +       movw    %ax, %ds
> +       movw    %ax, %es
> +       movw    %ax, %fs
> +       movw    %ax, %gs
> +       movw    %ax, %ss
> +
> +       /*
> +        * Now that %ss is known good, take the first stack for the BSP. The
> +        * AP stacks are only used on Intel.
> +        */
> +       leal    rva(sl_stacks_end)(%ebx), %esp
> +
> +       leal    rva(.Lsl_cs)(%ebx), %eax
> +       pushl   $(__SL32_CS)
> +       pushl   %eax
> +       lret
> +
> +.Lsl_cs:
> +       /* Save our base pointer reg and page table for MLE */
> +       pushl   %ebx
> +       pushl   %ecx
> +
> +       /* See if SMX feature is supported. */
> +       movl    $1, %eax
> +       cpuid
> +       testl   $(X86_FEATURE_BIT_SMX), %ecx
> +       jz      .Ldo_unknown_cpu
> +
> +       popl    %ecx
> +       popl    %ebx
> +
> +       /* Know it is Intel */
> +       movl    $(SL_CPU_INTEL), rva(sl_cpu_type)(%ebx)
> +
> +       /* Locate the base of the MLE using the page tables in %ecx */
> +       call    sl_find_mle_base
> +
> +       /* Increment CPU count for BSP */
> +       incl    rva(sl_txt_cpu_count)(%ebx)
> +
> +       /*
> +        * Enable SMI with GETSEC[SMCTRL] which were disabled by SENTER.
> +        * NMIs were also disabled by SENTER. Since there is no IDT for the BSP,
> +        * allow the mainline kernel re-enable them in the normal course of
> +        * booting.
> +        */
> +       GETSEC  $(SMX_X86_GETSEC_SMCTRL)
> +
> +       /* Clear the TXT error registers for a clean start of day */
> +       movl    $0, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
> +       movl    $0xffffffff, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ESTS)
> +
> +       /* On Intel, the zero page address is passed in the TXT heap */
> +       /* Read physical base of heap into EAX */
> +       movl    (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
> +       /* Read the size of the BIOS data into ECX (first 8 bytes) */
> +       movl    (%eax), %ecx
> +       /* Skip over BIOS data and size of OS to MLE data section */
> +       leal    8(%eax, %ecx), %eax
> +
> +       /* Need to verify the values in the OS-MLE struct passed in */
> +       call    sl_txt_verify_os_mle_struct
> +
> +       /*
> +        * Get the boot params address from the heap. Note %esi and %ebx MUST
> +        * be preserved across calls and operations.
> +        */
> +       movl    SL_boot_params_addr(%eax), %esi
> +
> +       /* Save %ebx so the APs can find their way home */
> +       movl    %ebx, (SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax)
> +
> +       /* Fetch the AP wake code block address from the heap */
> +       movl    SL_ap_wake_block(%eax), %edi
> +       movl    %edi, rva(sl_txt_ap_wake_block)(%ebx)
> +
> +       /* Store the offset in the AP wake block to the jmp address */
> +       movl    $(sl_ap_jmp_offset - sl_txt_ap_wake_begin), \
> +               (SL_mle_scratch + SL_SCRATCH_AP_JMP_OFFSET)(%eax)
> +
> +       /* Store the offset in the AP wake block to the AP stacks block */
> +       movl    $(sl_stacks - sl_txt_ap_wake_begin), \
> +               (SL_mle_scratch + SL_SCRATCH_AP_STACKS_OFFSET)(%eax)
> +
> +       /* %eax still is the base of the OS-MLE block, save it */
> +       pushl   %eax
> +
> +       /* Relocate the AP wake code to the safe block */
> +       call    sl_txt_reloc_ap_wake
> +
> +       /*
> +        * Wake up all APs that are blocked in the ACM and wait for them to
> +        * halt. This should be done before restoring the MTRRs so the ACM is
> +        * still properly in WB memory.
> +        */
> +       call    sl_txt_wake_aps
> +
> +       /* Restore OS-MLE in %eax */
> +       popl    %eax
> +
> +       /*
> +        * %edi is used by this routine to find the MTRRs which are in the SLRT
> +        * in the Intel info.
> +        */
> +       movl    SL_txt_info(%eax), %edi
> +       call    sl_txt_load_regs
> +
> +       jmp     .Lcpu_setup_done
> +
> +.Ldo_unknown_cpu:
> +       /* Non-Intel CPUs are not yet supported */
> +       ud2
> +
> +.Lcpu_setup_done:
> +       /*
> +        * Don't enable MCE at this point. The kernel will enable
> +        * it on the BSP later when it is ready.
> +        */
> +
> +       /* Done, jump to normal 32b pm entry */
> +       jmp     startup_32
> +SYM_FUNC_END(sl_stub_entry)
> +
> +SYM_FUNC_START(sl_find_mle_base)
> +       /* %ecx has PDPT, get first PD */
> +       movl    (%ecx), %eax
> +       andl    $(PAGE_MASK), %eax
> +       /* Get first PT from first PDE */
> +       movl    (%eax), %eax
> +       andl    $(PAGE_MASK), %eax
> +       /* Get MLE base from first PTE */
> +       movl    (%eax), %eax
> +       andl    $(PAGE_MASK), %eax
> +
> +       movl    %eax, rva(sl_mle_start)(%ebx)
> +       ret
> +SYM_FUNC_END(sl_find_mle_base)
> +
> +SYM_FUNC_START(sl_check_buffer_mle_overlap)
> +       /* %ecx: buffer begin %edx: buffer end */
> +       /* %ebx: MLE begin %edi: MLE end */
> +
> +       cmpl    %edi, %ecx
> +       jb      .Lnext_check
> +       cmpl    %edi, %edx
> +       jbe     .Lnext_check
> +       jmp     .Lvalid /* Buffer above MLE */
> +
> +.Lnext_check:
> +       cmpl    %ebx, %edx
> +       ja      .Linvalid
> +       cmpl    %ebx, %ecx
> +       jae     .Linvalid
> +       jmp     .Lvalid /* Buffer below MLE */
> +
> +.Linvalid:
> +       TXT_RESET $(SL_ERROR_MLE_BUFFER_OVERLAP)
> +
> +.Lvalid:
> +       ret
> +SYM_FUNC_END(sl_check_buffer_mle_overlap)
> +
> +SYM_FUNC_START(sl_txt_verify_os_mle_struct)
> +       pushl   %ebx
> +       /*
> +        * %eax points to the base of the OS-MLE struct. Need to also
> +        * read some values from the OS-SINIT struct too.
> +        */
> +       movl    -8(%eax), %ecx
> +       /* Skip over OS to MLE data section and size of OS-SINIT structure */
> +       leal    (%eax, %ecx), %edx
> +
> +       /* Load MLE image base absolute offset */
> +       movl    rva(sl_mle_start)(%ebx), %ebx
> +
> +       /* Verify the value of the low PMR base. It should always be 0. */
> +       movl    SL_vtd_pmr_lo_base(%edx), %esi
> +       cmpl    $0, %esi
> +       jz      .Lvalid_pmr_base
> +       TXT_RESET $(SL_ERROR_LO_PMR_BASE)
> +
> +.Lvalid_pmr_base:
> +       /* Grab some values from OS-SINIT structure */
> +       movl    SL_mle_size(%edx), %edi
> +       addl    %ebx, %edi
> +       jc      .Loverflow_detected
> +       movl    SL_vtd_pmr_lo_size(%edx), %esi
> +
> +       /* Check the AP wake block */
> +       movl    SL_ap_wake_block(%eax), %ecx
> +       movl    SL_ap_wake_block_size(%eax), %edx
> +       addl    %ecx, %edx
> +       jc      .Loverflow_detected
> +       call    sl_check_buffer_mle_overlap
> +       cmpl    %esi, %edx
> +       ja      .Lbuffer_beyond_pmr
> +
> +       /* Check the boot params */
> +       movl    SL_boot_params_addr(%eax), %ecx
> +       movl    $(PAGE_SIZE), %edx
> +       addl    %ecx, %edx
> +       jc      .Loverflow_detected
> +       call    sl_check_buffer_mle_overlap
> +       cmpl    %esi, %edx
> +       ja      .Lbuffer_beyond_pmr
> +
> +       /* Check that the AP wake block is big enough */
> +       cmpl    $(sl_txt_ap_wake_end - sl_txt_ap_wake_begin), \
> +               SL_ap_wake_block_size(%eax)
> +       jae     .Lwake_block_ok
> +       TXT_RESET $(SL_ERROR_WAKE_BLOCK_TOO_SMALL)
> +
> +.Lwake_block_ok:
> +       popl    %ebx
> +       ret
> +
> +.Loverflow_detected:
> +       TXT_RESET $(SL_ERROR_INTEGER_OVERFLOW)
> +
> +.Lbuffer_beyond_pmr:
> +       TXT_RESET $(SL_ERROR_BUFFER_BEYOND_PMR)
> +SYM_FUNC_END(sl_txt_verify_os_mle_struct)
> +
> +SYM_FUNC_START(sl_txt_ap_entry)
> +       cli
> +       cld
> +       /*
> +        * The %cs and %ds segments are known good after waking the AP.
> +        * First order of business is to find where we are and
> +        * save it in %ebx.
> +        */
> +
> +       /* Read physical base of heap into EAX */
> +       movl    (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
> +       /* Read the size of the BIOS data into ECX (first 8 bytes) */
> +       movl    (%eax), %ecx
> +       /* Skip over BIOS data and size of OS to MLE data section */
> +       leal    8(%eax, %ecx), %eax
> +
> +       /* Saved %ebx from the BSP and stash OS-MLE pointer */
> +       movl    (SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax), %ebx
> +
> +       /* Save TXT info ptr in %edi for call to sl_txt_load_regs */
> +       movl    SL_txt_info(%eax), %edi
> +
> +       /* Lock and get our stack index */
> +       movl    $1, %ecx
> +.Lspin:
> +       xorl    %eax, %eax
> +       lock cmpxchgl   %ecx, rva(sl_txt_spin_lock)(%ebx)
> +       pause
> +       jnz     .Lspin
> +
> +       /* Increment the stack index and use the next value inside lock */
> +       incl    rva(sl_txt_stack_index)(%ebx)
> +       movl    rva(sl_txt_stack_index)(%ebx), %eax
> +
> +       /* Unlock */
> +       movl    $0, rva(sl_txt_spin_lock)(%ebx)
> +
> +       /* Location of the relocated AP wake block */
> +       movl    rva(sl_txt_ap_wake_block)(%ebx), %ecx
> +
> +       /* Load reloc GDT, set segment regs and lret to __SL32_CS */
> +       lgdt    (sl_ap_gdt_desc - sl_txt_ap_wake_begin)(%ecx)
> +
> +       movl    $(__SL32_DS), %edx
> +       movw    %dx, %ds
> +       movw    %dx, %es
> +       movw    %dx, %fs
> +       movw    %dx, %gs
> +       movw    %dx, %ss
> +
> +       /* Load our reloc AP stack */
> +       movl    $(TXT_BOOT_STACK_SIZE), %edx
> +       mull    %edx
> +       leal    (sl_stacks_end - sl_txt_ap_wake_begin)(%ecx), %esp
> +       subl    %eax, %esp
> +
> +       /* Switch to AP code segment */
> +       leal    rva(.Lsl_ap_cs)(%ebx), %eax
> +       pushl   $(__SL32_CS)
> +       pushl   %eax
> +       lret
> +
> +.Lsl_ap_cs:
> +       /* Load the relocated AP IDT */
> +       lidt    (sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
> +
> +       /* Fixup MTRRs and misc enable MSR on APs too */
> +       call    sl_txt_load_regs
> +
> +       /* Enable SMI with GETSEC[SMCTRL] */
> +       GETSEC $(SMX_X86_GETSEC_SMCTRL)
> +
> +       /* IRET-to-self can be used to enable NMIs which SENTER disabled */
> +       leal    rva(.Lnmi_enabled_ap)(%ebx), %eax
> +       pushfl
> +       pushl   $(__SL32_CS)
> +       pushl   %eax
> +       iret
> +
> +.Lnmi_enabled_ap:
> +       /* Put APs in X2APIC mode like the BSP */
> +       movl    $(MSR_IA32_APICBASE), %ecx
> +       rdmsr
> +       orl     $(XAPIC_ENABLE | X2APIC_ENABLE), %eax
> +       wrmsr
> +
> +       /*
> +        * Basically done, increment the CPU count and jump off to the AP
> +        * wake block to wait.
> +        */
> +       lock incl       rva(sl_txt_cpu_count)(%ebx)
> +
> +       movl    rva(sl_txt_ap_wake_block)(%ebx), %eax
> +       jmp     *%eax
> +SYM_FUNC_END(sl_txt_ap_entry)
> +
> +SYM_FUNC_START(sl_txt_reloc_ap_wake)
> +       /* Save boot params register */
> +       pushl   %esi
> +
> +       movl    rva(sl_txt_ap_wake_block)(%ebx), %edi
> +
> +       /* Fixup AP IDT and GDT descriptor before relocating */
> +       leal    rva(sl_ap_idt_desc)(%ebx), %eax
> +       addl    %edi, 2(%eax)
> +       leal    rva(sl_ap_gdt_desc)(%ebx), %eax
> +       addl    %edi, 2(%eax)
> +
> +       /*
> +        * Copy the AP wake code and AP GDT/IDT to the protected wake block
> +        * provided by the loader. Destination already in %edi.
> +        */
> +       movl    $(sl_txt_ap_wake_end - sl_txt_ap_wake_begin), %ecx
> +       leal    rva(sl_txt_ap_wake_begin)(%ebx), %esi
> +       rep movsb
> +
> +       /* Setup the IDT for the APs to use in the relocation block */
> +       movl    rva(sl_txt_ap_wake_block)(%ebx), %ecx
> +       addl    $(sl_ap_idt - sl_txt_ap_wake_begin), %ecx
> +       xorl    %edx, %edx
> +
> +       /* Form the default reset vector relocation address */
> +       movl    rva(sl_txt_ap_wake_block)(%ebx), %esi
> +       addl    $(sl_txt_int_reset - sl_txt_ap_wake_begin), %esi
> +
> +1:
> +       cmpw    $(NR_VECTORS), %dx
> +       jz      .Lap_idt_done
> +
> +       cmpw    $(X86_TRAP_NMI), %dx
> +       jz      2f
> +
> +       /* Load all other fixed vectors with reset handler */
> +       movl    %esi, %eax
> +       movw    %ax, (IDT_VECTOR_LO_BITS)(%ecx)
> +       shrl    $16, %eax
> +       movw    %ax, (IDT_VECTOR_HI_BITS)(%ecx)
> +       jmp     3f
> +
> +2:
> +       /* Load single wake NMI IPI vector at the relocation address */
> +       movl    rva(sl_txt_ap_wake_block)(%ebx), %eax
> +       addl    $(sl_txt_int_nmi - sl_txt_ap_wake_begin), %eax
> +       movw    %ax, (IDT_VECTOR_LO_BITS)(%ecx)
> +       shrl    $16, %eax
> +       movw    %ax, (IDT_VECTOR_HI_BITS)(%ecx)
> +
> +3:
> +       incw    %dx
> +       addl    $8, %ecx
> +       jmp     1b
> +
> +.Lap_idt_done:
> +       popl    %esi
> +       ret
> +SYM_FUNC_END(sl_txt_reloc_ap_wake)
> +
> +SYM_FUNC_START(sl_txt_load_regs)
> +       /* Save base pointer register */
> +       pushl   %ebx
> +
> +       /*
> +        * On Intel, the original variable MTRRs and Misc Enable MSR are
> +        * restored on the BSP at early boot. Each AP will also restore
> +        * its MTRRs and Misc Enable MSR.
> +        */
> +       pushl   %edi
> +       addl    $(SL_saved_bsp_mtrrs), %edi
> +       movl    (%edi), %ebx
> +       pushl   %ebx /* default_mem_type lo */
> +       addl    $4, %edi
> +       movl    (%edi), %ebx
> +       pushl   %ebx /* default_mem_type hi */
> +       addl    $4, %edi
> +       movl    (%edi), %ebx /* mtrr_vcnt lo, don't care about hi part */
> +       addl    $8, %edi /* now at MTRR pair array */
> +       /* Write the variable MTRRs */
> +       movl    $(MSR_MTRRphysBase0), %ecx
> +1:
> +       cmpl    $0, %ebx
> +       jz      2f
> +
> +       movl    (%edi), %eax /* MTRRphysBaseX lo */
> +       addl    $4, %edi
> +       movl    (%edi), %edx /* MTRRphysBaseX hi */
> +       wrmsr
> +       addl    $4, %edi
> +       incl    %ecx
> +       movl    (%edi), %eax /* MTRRphysMaskX lo */
> +       addl    $4, %edi
> +       movl    (%edi), %edx /* MTRRphysMaskX hi */
> +       wrmsr
> +       addl    $4, %edi
> +       incl    %ecx
> +
> +       decl    %ebx
> +       jmp     1b
> +2:
> +       /* Write the default MTRR register */
> +       popl    %edx
> +       popl    %eax
> +       movl    $(MSR_MTRRdefType), %ecx
> +       wrmsr
> +
> +       /* Return to beginning and write the misc enable msr */
> +       popl    %edi
> +       addl    $(SL_saved_misc_enable_msr), %edi
> +       movl    (%edi), %eax /* saved_misc_enable_msr lo */
> +       addl    $4, %edi
> +       movl    (%edi), %edx /* saved_misc_enable_msr hi */
> +       movl    $(MSR_IA32_MISC_ENABLE), %ecx
> +       wrmsr
> +
> +       popl    %ebx
> +       ret
> +SYM_FUNC_END(sl_txt_load_regs)
> +
> +SYM_FUNC_START(sl_txt_wake_aps)
> +       /* Save boot params register */
> +       pushl   %esi
> +
> +       /* First setup the MLE join structure and load it into TXT reg */
> +       leal    rva(sl_gdt)(%ebx), %eax
> +       leal    rva(sl_txt_ap_entry)(%ebx), %ecx
> +       leal    rva(sl_smx_rlp_mle_join)(%ebx), %edx
> +       movl    %eax, SL_rlp_gdt_base(%edx)
> +       movl    %ecx, SL_rlp_entry_point(%edx)
> +       movl    %edx, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_MLE_JOIN)
> +
> +       /* Another TXT heap walk to find various values needed to wake APs */
> +       movl    (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
> +       /* At BIOS data size, find the number of logical processors */
> +       movl    (SL_num_logical_procs + 8)(%eax), %edx
> +       /* Skip over BIOS data */
> +       movl    (%eax), %ecx
> +       addl    %ecx, %eax
> +       /* Skip over OS to MLE */
> +       movl    (%eax), %ecx
> +       addl    %ecx, %eax
> +       /* At OS-SNIT size, get capabilities to know how to wake up the APs */
> +       movl    (SL_capabilities + 8)(%eax), %esi
> +       /* Skip over OS to SNIT */
> +       movl    (%eax), %ecx
> +       addl    %ecx, %eax
> +       /* At SINIT-MLE size, get the AP wake MONITOR address */
> +       movl    (SL_rlp_wakeup_addr + 8)(%eax), %edi
> +
> +       /* Determine how to wake up the APs */
> +       testl   $(1 << TXT_SINIT_MLE_CAP_WAKE_MONITOR), %esi
> +       jz      .Lwake_getsec
> +
> +       /* Wake using MWAIT MONITOR */
> +       movl    $1, (%edi)
> +       jmp     .Laps_awake
> +
> +.Lwake_getsec:
> +       /* Wake using GETSEC(WAKEUP) */
> +       GETSEC  $(SMX_X86_GETSEC_WAKEUP)
> +
> +.Laps_awake:
> +       /*
> +        * All of the APs are woken up and rendesvous in the relocated wake
> +        * block starting at sl_txt_ap_wake_begin. Wait for all of them to
> +        * halt.
> +        */
> +       pause
> +       cmpl    rva(sl_txt_cpu_count)(%ebx), %edx
> +       jne     .Laps_awake
> +
> +       popl    %esi
> +       ret
> +SYM_FUNC_END(sl_txt_wake_aps)
> +
> +/* This is the beginning of the relocated AP wake code block */
> +       .global sl_txt_ap_wake_begin
> +sl_txt_ap_wake_begin:
> +
> +       /* Get the LAPIC ID for each AP and stash it on the stack */
> +       movl    $(MSR_IA32_X2APIC_APICID), %ecx
> +       rdmsr
> +       pushl   %eax
> +
> +       /*
> +        * Get a pointer to the monitor location on this APs stack to test below
> +        * after mwait returns. Currently %esp points to just past the pushed APIC
> +        * ID value.
> +        */
> +       movl    %esp, %eax
> +       subl    $(TXT_BOOT_STACK_SIZE - 4), %eax
> +       movl    $0, (%eax)
> +
> +       /* Clear ecx/edx so no invalid extensions or hints are passed to monitor */
> +       xorl    %ecx, %ecx
> +       xorl    %edx, %edx
> +
> +       /*
> +        * Arm the monitor and wait for it to be poked by he SMP bringup code. The mwait
> +        * instruction can return for a number of reasons. Test to see if it returned
> +        * because the monitor was written to.
> +        */
> +       monitor
> +
> +1:
> +       mfence
> +       mwait
> +       movl    (%eax), %edx
> +       testl   %edx, %edx
> +       jz      1b
> +
> +       /*
> +        * This is the long absolute jump to the 32b Secure Launch protected mode stub
> +        * code in sl_trampoline_start32() in the rmpiggy. The jump address will be
> +        * fixed in the SMP boot code when the first AP is brought up. This whole area
> +        * is provided and protected in the memory map by the prelaunch code.
> +        */
> +       .byte   0xea
> +sl_ap_jmp_offset:
> +       .long   0x00000000
> +       .word   __SL32_CS
> +
> +SYM_FUNC_START(sl_txt_int_nmi)
> +       /* NMI context, just IRET */
> +       iret
> +SYM_FUNC_END(sl_txt_int_nmi)
> +
> +SYM_FUNC_START(sl_txt_int_reset)
> +       TXT_RESET $(SL_ERROR_INV_AP_INTERRUPT)
> +SYM_FUNC_END(sl_txt_int_reset)
> +
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_ap_idt_desc)
> +       .word   sl_ap_idt_end - sl_ap_idt - 1           /* Limit */
> +       .long   sl_ap_idt - sl_txt_ap_wake_begin        /* Base */
> +SYM_DATA_END_LABEL(sl_ap_idt_desc, SYM_L_LOCAL, sl_ap_idt_desc_end)
> +
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_ap_idt)
> +       .rept   NR_VECTORS
> +       .word   0x0000          /* Offset 15 to 0 */
> +       .word   __SL32_CS       /* Segment selector */
> +       .word   0x8e00          /* Present, DPL=0, 32b Vector, Interrupt */
> +       .word   0x0000          /* Offset 31 to 16 */
> +       .endr
> +SYM_DATA_END_LABEL(sl_ap_idt, SYM_L_LOCAL, sl_ap_idt_end)
> +
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_ap_gdt_desc)
> +       .word   sl_ap_gdt_end - sl_ap_gdt - 1
> +       .long   sl_ap_gdt - sl_txt_ap_wake_begin
> +SYM_DATA_END_LABEL(sl_ap_gdt_desc, SYM_L_LOCAL, sl_ap_gdt_desc_end)
> +
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_ap_gdt)
> +       .quad   0x0000000000000000      /* NULL */
> +       .quad   0x00cf9a000000ffff      /* __SL32_CS */
> +       .quad   0x00cf92000000ffff      /* __SL32_DS */
> +SYM_DATA_END_LABEL(sl_ap_gdt, SYM_L_LOCAL, sl_ap_gdt_end)
> +
> +       /* Small stacks for BSP and APs to work with */
> +       .balign 64
> +SYM_DATA_START_LOCAL(sl_stacks)
> +       .fill (TXT_MAX_CPUS * TXT_BOOT_STACK_SIZE), 1, 0
> +SYM_DATA_END_LABEL(sl_stacks, SYM_L_LOCAL, sl_stacks_end)
> +
> +/* This is the end of the relocated AP wake code block */
> +       .global sl_txt_ap_wake_end
> +sl_txt_ap_wake_end:
> +
> +       .data
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_gdt_desc)
> +       .word   sl_gdt_end - sl_gdt - 1
> +       .long   sl_gdt - sl_gdt_desc
> +SYM_DATA_END_LABEL(sl_gdt_desc, SYM_L_LOCAL, sl_gdt_desc_end)
> +
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_gdt)
> +       .quad   0x0000000000000000      /* NULL */
> +       .quad   0x00cf9a000000ffff      /* __SL32_CS */
> +       .quad   0x00cf92000000ffff      /* __SL32_DS */
> +SYM_DATA_END_LABEL(sl_gdt, SYM_L_LOCAL, sl_gdt_end)
> +
> +       .balign 8
> +SYM_DATA_START_LOCAL(sl_smx_rlp_mle_join)
> +       .long   sl_gdt_end - sl_gdt - 1 /* GDT limit */
> +       .long   0x00000000              /* GDT base */
> +       .long   __SL32_CS       /* Seg Sel - CS (DS, ES, SS = seg_sel+8) */
> +       .long   0x00000000      /* Entry point physical address */
> +SYM_DATA_END(sl_smx_rlp_mle_join)
> +
> +SYM_DATA(sl_cpu_type, .long 0x00000000)
> +
> +SYM_DATA(sl_mle_start, .long 0x00000000)
> +
> +SYM_DATA_LOCAL(sl_txt_spin_lock, .long 0x00000000)
> +
> +SYM_DATA_LOCAL(sl_txt_stack_index, .long 0x00000000)
> +
> +SYM_DATA_LOCAL(sl_txt_cpu_count, .long 0x00000000)
> +
> +SYM_DATA_LOCAL(sl_txt_ap_wake_block, .long 0x00000000)
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index f1bd7b91b3c6..aff899c4b6c3 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -323,6 +323,9 @@
>  #define MSR_IA32_RTIT_OUTPUT_BASE      0x00000560
>  #define MSR_IA32_RTIT_OUTPUT_MASK      0x00000561
>
> +#define MSR_MTRRphysBase0              0x00000200
> +#define MSR_MTRRphysMask0              0x00000201
> +
>  #define MSR_MTRRfix64K_00000           0x00000250
>  #define MSR_MTRRfix16K_80000           0x00000258
>  #define MSR_MTRRfix16K_A0000           0x00000259
> @@ -804,6 +807,8 @@
>  #define MSR_IA32_APICBASE_ENABLE       (1<<11)
>  #define MSR_IA32_APICBASE_BASE         (0xfffff<<12)
>
> +#define MSR_IA32_X2APIC_APICID         0x00000802
> +
>  #define MSR_IA32_UCODE_WRITE           0x00000079
>  #define MSR_IA32_UCODE_REV             0x0000008b
>
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 01d19fc22346..74e3e7df491e 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -26,6 +26,7 @@
>  /* loadflags */
>  #define LOADED_HIGH    (1<<0)
>  #define KASLR_FLAG     (1<<1)
> +#define SLAUNCH_FLAG   (1<<2)
>  #define QUIET_FLAG     (1<<5)
>  #define KEEP_SEGMENTS  (1<<6)
>  #define CAN_USE_HEAP   (1<<7)
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index 6913b372ccf7..c7c4d392b7d3 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -13,6 +13,8 @@
>  #include <linux/hardirq.h>
>  #include <linux/suspend.h>
>  #include <linux/kbuild.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
>  #include <asm/processor.h>
>  #include <asm/thread_info.h>
>  #include <asm/sigframe.h>
> @@ -120,4 +122,22 @@ static void __used common(void)
>         OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
>  #endif
>
> +#ifdef CONFIG_SECURE_LAUNCH
> +       BLANK();
> +       OFFSET(SL_txt_info, txt_os_mle_data, txt_info);
> +       OFFSET(SL_mle_scratch, txt_os_mle_data, mle_scratch);
> +       OFFSET(SL_boot_params_addr, txt_os_mle_data, boot_params_addr);
> +       OFFSET(SL_ap_wake_block, txt_os_mle_data, ap_wake_block);
> +       OFFSET(SL_ap_wake_block_size, txt_os_mle_data, ap_wake_block_size);
> +       OFFSET(SL_saved_misc_enable_msr, slr_entry_intel_info, saved_misc_enable_msr);
> +       OFFSET(SL_saved_bsp_mtrrs, slr_entry_intel_info, saved_bsp_mtrrs);
> +       OFFSET(SL_num_logical_procs, txt_bios_data, num_logical_procs);
> +       OFFSET(SL_capabilities, txt_os_sinit_data, capabilities);
> +       OFFSET(SL_mle_size, txt_os_sinit_data, mle_size);
> +       OFFSET(SL_vtd_pmr_lo_base, txt_os_sinit_data, vtd_pmr_lo_base);
> +       OFFSET(SL_vtd_pmr_lo_size, txt_os_sinit_data, vtd_pmr_lo_size);
> +       OFFSET(SL_rlp_wakeup_addr, txt_sinit_mle_data, rlp_wakeup_addr);
> +       OFFSET(SL_rlp_gdt_base, smx_rlp_mle_join, rlp_gdt_base);
> +       OFFSET(SL_rlp_entry_point, smx_rlp_mle_join, rlp_entry_point);
> +#endif
>  }
> --
> 2.39.3
>

