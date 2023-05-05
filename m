Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD11E6F87F5
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjEERtK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjEERtE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 13:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB120774;
        Fri,  5 May 2023 10:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E8863F8E;
        Fri,  5 May 2023 17:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1DDC433D2;
        Fri,  5 May 2023 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683308849;
        bh=NfN0GCjSEdHXPi1ej5pfJOPH9ri0obhBJcndRG6uy2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=taq7lefDB/OaQxUIqd7oJXE0A89RWT6AEchPfb1S4xfj+rcqHyKyUbLiMx85JD2oL
         cznusRyRTmaheCfREQHayoYyW3kk7AaJIrmGVDI7ln7Xdm/79y40rJdzIA5IwIbFrN
         js9eXejGUBpdOxB5ZoX+c9YWw2KzbTqy1Z1jAwbqZqmz5Wj0drzLN6p7W3uPRRH4+P
         slFtocWBdVT0jBjnCVPPehrdnY47J0zzWXNSLjrZUrRiyWVI4fQxgR6t/Wk0OCFmSj
         aFWMWZ4Vejhi5pWbJrUKzMUJk8T/yP6f665wfJ6OCxw9RZADU5hngRfeF7K6BBdXBk
         hlN2cNsl05Zlw==
Date:   Fri, 5 May 2023 19:47:24 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Message-ID: <ZFVBLCLVK7AAStst@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-8-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:
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

...

> diff --git a/arch/x86/boot/compressed/sl_main.c b/arch/x86/boot/compressed/sl_main.c

...

> +static void *evtlog_base;
> +static u32 evtlog_size;
> +static struct txt_heap_event_log_pointer2_1_element *log20_elem;
> +static u32 tpm_log_ver = SL_TPM12_LOG;
> +struct tcg_efi_specid_event_algs tpm_algs[SL_TPM20_MAX_ALGS] = {0};

tpm_algs seems to only be used in this file.
Should it be static?

> +
> +extern u32 sl_cpu_type;
> +extern u32 sl_mle_start;
> +extern struct boot_params *boot_params;
> +
> +static u64 sl_txt_read(u32 reg)

Perhaps reg should have an __iomem annotation.

> +{
> +	return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
> +}
> +
> +static void sl_txt_write(u32 reg, u64 val)

Likewise here.

...

> +static void sl_check_pmr_coverage(void *base, u32 size, bool allow_hi)
> +{
> +	struct txt_os_sinit_data *os_sinit_data;
> +	void *end = base + size;
> +	void *txt_heap;
> +
> +	if (!(sl_cpu_type & SL_CPU_INTEL))
> +		return;
> +
> +	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +
> +	if ((end >= (void *)0x100000000ULL) &&
> +	    (base < (void *)0x100000000ULL))
> +		sl_txt_reset(SL_ERROR_REGION_STRADDLE_4GB);
> +
> +	/*
> +	 * Note that the late stub code validates that the hi PMR covers
> +	 * all memory above 4G. At this point the code can only check that
> +	 * regions are within the hi PMR but that is sufficient.
> +	 */
> +	if ((end > (void *)0x100000000ULL) &&
> +	    (base >= (void *)0x100000000ULL)) {
> +		if (allow_hi) {
> +			if (end >= (void *)(os_sinit_data->vtd_pmr_hi_base +
> +					   os_sinit_data->vtd_pmr_hi_size))
> +				sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
> +		} else
> +			sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);

nit: if any arm of a condition has '{}' then all arms should have them.
     So:

		} else {
			sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);
		}

Also elsewhere in this patch.

> +	}
> +
> +	if (end >= (void *)os_sinit_data->vtd_pmr_lo_size)
> +		sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
> +}
> +
> +/*
> + * Some MSRs are modified by the pre-launch code including the MTRRs.
> + * The early MLE code has to restore these values. This code validates
> + * the values after they are measured.
> + */
> +static void sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
> +{
> +	struct slr_txt_mtrr_state *saved_bsp_mtrrs;
> +	u64 mtrr_caps, mtrr_def_type, mtrr_var;
> +	struct slr_entry_intel_info *txt_info;
> +	u64 misc_en_msr;
> +	u32 vcnt, i;
> +
> +	txt_info = (struct slr_entry_intel_info *)os_mle_data->txt_info;
> +	saved_bsp_mtrrs = &(txt_info->saved_bsp_mtrrs);

nit: unnecessary parentheses

...

> +static void sl_validate_event_log_buffer(void)
> +{
> +	struct txt_os_sinit_data *os_sinit_data;
> +	void *txt_heap, *txt_end;
> +	void *mle_base, *mle_end;
> +	void *evtlog_end;
> +
> +	if ((u64)evtlog_size > (LLONG_MAX - (u64)evtlog_base))
> +		sl_txt_reset(SL_ERROR_INTEGER_OVERFLOW);
> +	evtlog_end = evtlog_base + evtlog_size;
> +
> +	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +	txt_end = txt_heap + sl_txt_read(TXT_CR_HEAP_SIZE);
> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +
> +	mle_base = (void *)(u64)sl_mle_start;
> +	mle_end = mle_base + os_sinit_data->mle_size;
> +
> +	/*
> +	 * This check is to ensure the event log buffer does not overlap with
> +	 * the MLE image.
> +	 */
> +	if ((evtlog_base >= mle_end) &&
> +	    (evtlog_end > mle_end))
> +		goto pmr_check; /* above */

Ditto.
Also, the if condition could be one line.
Also in several other places in this patch.

> +
> +	if ((evtlog_end <= mle_base) &&
> +	    (evtlog_base < mle_base))
> +		goto pmr_check; /* below */
> +
> +	sl_txt_reset(SL_ERROR_MLE_BUFFER_OVERLAP);
> +
> +pmr_check:
> +	/*
> +	 * The TXT heap is protected by the DPR. If the TPM event log is
> +	 * inside the TXT heap, there is no need for a PMR check.
> +	 */
> +	if ((evtlog_base > txt_heap) &&
> +	    (evtlog_end < txt_end))
> +		return;
> +
> +	sl_check_pmr_coverage(evtlog_base, evtlog_size, true);
> +}

> +static void sl_process_extend_policy(struct slr_table *slrt)
> +{
> +	struct slr_entry_policy *policy;
> +	struct slr_policy_entry *entry;
> +	u16 i = 0;
> +
> +	policy =(struct slr_entry_policy *)

nit: space after '='

...

> +static void sl_process_extend_uefi_config(struct slr_table *slrt)
> +{
> +	struct slr_entry_uefi_config *uefi_config;
> +	struct slr_uefi_cfg_entry *uefi_entry;
> +	u64 i;
> +
> +	uefi_config =(struct slr_entry_uefi_config *)
> +		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_UEFI_CONFIG);
> +
> +	/* Optionally here depending on how SL kernel was booted */
> +	if (!uefi_config)
> +		return;
> +
> +	uefi_entry = (struct slr_uefi_cfg_entry *)((u8 *)uefi_config + sizeof(*uefi_config));
> +
> +	for ( ; i < uefi_config->nr_entries; i++, uefi_entry++) {

nit: i seems to be used without first being initialised.

> +		sl_tpm_extend_evtlog(uefi_entry->pcr, TXT_EVTYPE_SLAUNCH,
> +				     (void *)uefi_entry->cfg, uefi_entry->size,
> +				     uefi_entry->evt_info);
> +	}
> +}
> +
> +asmlinkage __visible void sl_check_region(void *base, u32 size)
> +{
> +	sl_check_pmr_coverage(base, size, false);
> +}

I'm a nit unsure, what to do here, but clang-16 with W=1 says the following.

arch/x86/boot/compressed/sl_main.c:533:27: warning: no previous prototype for function 'sl_main' [-Wmissing-prototypes]
asmlinkage __visible void sl_main(void *bootparams)
                          ^
arch/x86/boot/compressed/sl_main.c:533:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
asmlinkage __visible void sl_main(void *bootparams)
                     ^
                     static

...

> diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
> new file mode 100644
> index 0000000..2d8aa3a
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sl_stub.S
> @@ -0,0 +1,690 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Secure Launch protected mode entry point.
> + *
> + * Copyright (c) 2022, Oracle and/or its affiliates.
> + */
> +	.code32
> +	.text
> +#include <linux/linkage.h>
> +#include <asm/segment.h>
> +#include <asm/msr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/bootparam.h>
> +#include <asm/page_types.h>
> +#include <asm/irq_vectors.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +
> +/* CPUID: leaf 1, ECX, SMX feature bit */
> +#define X86_FEATURE_BIT_SMX	(1 << 6)
> +
> +/* Can't include apiddef.h in asm */
> +#define XAPIC_ENABLE	(1 << 11)
> +#define X2APIC_ENABLE	(1 << 10)
> +
> +/* Can't include traps.h in asm */
> +#define X86_TRAP_NMI	2
> +
> +/* Can't include mtrr.h in asm */
> +#define MTRRphysBase0	0x200
> +
> +#define IDT_VECTOR_LO_BITS	0
> +#define IDT_VECTOR_HI_BITS	6
> +
> +/*
> + * See the comment in head_64.S for detailed informatoin on what this macro

nit: s/informatoin/information/

...

> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 01d19fc..74e3e7df 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -26,6 +26,7 @@
>  /* loadflags */
>  #define LOADED_HIGH	(1<<0)
>  #define KASLR_FLAG	(1<<1)
> +#define SLAUNCH_FLAG	(1<<2)
>  #define QUIET_FLAG	(1<<5)
>  #define KEEP_SEGMENTS	(1<<6)
>  #define CAN_USE_HEAP	(1<<7)

nit: please consider using BIT()

...
