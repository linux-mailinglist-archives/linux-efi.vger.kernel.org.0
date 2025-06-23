Return-Path: <linux-efi+bounces-3909-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58842AE3E61
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17EA7A98AC
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 11:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0DD2405E8;
	Mon, 23 Jun 2025 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuLgdshq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6F23C4E1;
	Mon, 23 Jun 2025 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679125; cv=none; b=YcP7X7jxW3bsGtFAlM1EoWZnvjQX3GhHbDy8GhOarN38z7nhxGwSpZGeCsSGFkQrDfYqr5aZtxFI0+afrJV1F6nE0Bm+I0QtcTlnL/cnrxd3BYRpt2OVJrISoU71nIhcK9cGblNjtDI6CbYQTC+MYcqtX3gVJ4VA7+iO9HWbNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679125; c=relaxed/simple;
	bh=vsHKsIjfBoPWXTQyZsx8BusZYQAQmtv78aK+QOB1fzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwAgFMa6BHv9YHErSnDBCIcDQXhrFr5J+whTzYU1yRXML+zTs6NTkyI3tw0deCfRSffr2499UxMrUcV06AfjQvhUzL5FG7+tuvaBwJmkOO0pW9PnDnB9uXa+ChGfop7FK5oMWNf0v1mNKiwclteCenUVls6KrxmQaApbyxJ0Lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuLgdshq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750679123; x=1782215123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsHKsIjfBoPWXTQyZsx8BusZYQAQmtv78aK+QOB1fzw=;
  b=kuLgdshqDboREr3hd+aCLbufw1/YhMeVoGbWp4QwEF6TgWS3PcAQFNSk
   un0tW7jeaU90cJs39LkEgCBqa3HkymHApsGQ8tGaNtdR2BRvXX32HEDef
   3ozYPic2ejtdbOnNv3MAstq8fbxfQ7++dsuYyDm2q9oB1y8FyXBUIB4Ec
   q/YXS8ELhwyriM9CGq0QoObwTCA9atlDJuET3FdZcRMqoXCb5jgn0b3hz
   7h8mPDiKKzoThDZP5p89dT6U9ANL5xS3e8e0hvdqtkLG2WyeWJwYChnv6
   VzkxJlf+YLdrEg/7G9q9EB+4sz486jz8VgO0aZ6O4IlXpGMayJyLSI5WT
   w==;
X-CSE-ConnectionGUID: RXlQhnqmRvuTyI9mEj9ElQ==
X-CSE-MsgGUID: ZHUO3cvzTrSRcGYKYY580A==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52969896"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52969896"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 04:45:21 -0700
X-CSE-ConnectionGUID: c6ARgJ0bR6yOqWqlkLCkrg==
X-CSE-MsgGUID: Xlj+kWGuS26kFIyJdiB53Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151351020"
Received: from michalca-mobl.ger.corp.intel.com (HELO [10.245.86.188]) ([10.245.86.188])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 04:45:11 -0700
Message-ID: <e538d06a-fb9a-4b07-9a00-33879ea5c1cd@linux.intel.com>
Date: Mon, 23 Jun 2025 13:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/19] x86: Secure Launch main header file
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, daniel.kiper@oracle.com
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com,
 "Fedko, Artem" <artem.fedko@intel.com>,
 "Mowka, Mateusz" <mateusz.mowka@linux.intel.com>, adamx.pawlicki@intel.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-5-ross.philipson@oracle.com>
Content-Language: en-US
From: "Camacho Romero, Michal" <michal.camacho.romero@linux.intel.com>
Organization: FST FIR Dev Poland
In-Reply-To: <20250421162712.77452-5-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Ross,

I'm BIOS Engineer from Intel, working on the TXT-related security modules development, including TBOOT project.
I'm leaving you my thougths and objections on this patch:

On 4/21/2025 6:26 PM, Ross Philipson wrote:

Michal Camacho Romero: Replace all tabs with indentations (4 spaces) in the file

> Introduce the main Secure Launch header file used in the early SL stub
> and the early setup code.
> 
> This header file contains the following categories:
>  - Secure Launch implementation specific structures and definitions.
>  - Intel TXT architecture specific DRTM structures, definitions and functions
> used by Secure Launch.
>  - DRTM TPM event logging definitions and helper functions.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slaunch.h | 559 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 559 insertions(+)
>  create mode 100644 include/linux/slaunch.h
> 
> diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
> new file mode 100644
> index 000000000000..ae67314c2aad
> --- /dev/null
> +++ b/include/linux/slaunch.h
> @@ -0,0 +1,559 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Main Secure Launch header file.
> + *
> + * Copyright (c) 2025 Apertus Solutions, LLC
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLAUNCH_H
> +#define _LINUX_SLAUNCH_H
> +
> +/*
> + * Secure Launch Defined State Flags
> + */
> +#define SL_FLAG_ACTIVE		0x00000001
> +#define SL_FLAG_ARCH_TXT	0x00000002
> +
> +/*
> + * Secure Launch CPU Type
> + */
> +#define SL_CPU_INTEL	1
> +
> +#define __SL32_CS	0x0008
> +#define __SL32_DS	0x0010
> +
> +/*
> + * Intel Safer Mode Extensions (SMX)
> + *
> + * Intel SMX provides a programming interface to establish a Measured Launched
> + * Environment (MLE). The measurement and protection mechanisms supported by the
> + * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
> + * the processor's programming interface in an Intel TXT platform.
> + *
> + * See:
> + *   Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
> + *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide
> + */
> +
> +/*
> + * SMX GETSEC Leaf Functions
> + */
> +#define SMX_X86_GETSEC_SEXIT	5
> +#define SMX_X86_GETSEC_SMCTRL	7
> +#define SMX_X86_GETSEC_WAKEUP	8
> +

Michal Camacho Romero: Create a new header file, called include/linux/txt.h and move there the following code section (matched in the black quotations):

""" [START]> +/*
> + * Intel Trusted Execution Technology MMIO Registers Banks
> + */
> +#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
> +#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
> +#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
> +				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
> +
> +/*
> + * Intel Trusted Execution Technology (TXT) Registers
> + */
> +#define TXT_CR_STS			0x0000
> +#define TXT_CR_ESTS			0x0008
> +#define TXT_CR_ERRORCODE		0x0030
> +#define TXT_CR_CMD_RESET		0x0038
> +#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
> +#define TXT_CR_DIDVID			0x0110
> +#define TXT_CR_VER_EMIF			0x0200
> +#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
> +#define TXT_CR_SINIT_BASE		0x0270
> +#define TXT_CR_SINIT_SIZE		0x0278
> +#define TXT_CR_MLE_JOIN			0x0290
> +#define TXT_CR_HEAP_BASE		0x0300
> +#define TXT_CR_HEAP_SIZE		0x0308
> +#define TXT_CR_SCRATCHPAD		0x0378
> +#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
> +#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
> +#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
> +#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
> +#define TXT_CR_CMD_SECRETS		0x08e0
> +#define TXT_CR_CMD_NO_SECRETS		0x08e8
> +#define TXT_CR_E2STS			0x08f0
> +
> +/* TXT default register value */
> +#define TXT_REGVALUE_ONE		0x1ULL
> +
> +/* TXTCR_STS status bits */
> +#define TXT_SENTER_DONE_STS		BIT(0)
> +#define TXT_SEXIT_DONE_STS		BIT(1)
> +
> +/*
> + * SINIT/MLE Capabilities Field Bit Definitions
> + */


""" [END]

Michal Camacho Romero: Change TXT_SINIT_MLE_CAP_WAKE_GETSEC macro's name to TXT_SINIT_MLE_CAP_RLP_WAKE_GETSEC and also  TXT_SINIT_MLE_CAP_WAKE_MONITOR macro's name to TXT_SINIT_MLE_CAP_RLP_WAKE_MONITOR then move them to the newly created include/linux/txt.h: 

> +#define TXT_SINIT_MLE_CAP_WAKE_GETSEC	0
> +#define TXT_SINIT_MLE_CAP_WAKE_MONITOR	1
> +

Michal Camacho Romero: Move the following code section (matched in the black quotations) into the new header file include/linux/txt.h:

""" [START]> +/*
> + * OS/MLE Secure Launch Specific Definitions
> + */
> +#define TXT_OS_MLE_STRUCT_VERSION	1
> +#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
> +
> +/*
> + * TXT Heap Table Enumeration
> + */
> +#define TXT_BIOS_DATA_TABLE		1
> +#define TXT_OS_MLE_DATA_TABLE		2
> +#define TXT_OS_SINIT_DATA_TABLE		3
> +#define TXT_SINIT_MLE_DATA_TABLE	4
> +#define TXT_SINIT_TABLE_MAX		TXT_SINIT_MLE_DATA_TABLE
> +

""" [END]> +/*
> + * Secure Launch Defined Error Codes used in MLE-initiated TXT resets.
> + *
> + * TXT Specification
> + * Appendix I ACM Error Codes
> + */
> +#define SL_ERROR_GENERIC		0xc0008001
> +#define SL_ERROR_TPM_INIT		0xc0008002
> +#define SL_ERROR_TPM_INVALID_LOG20	0xc0008003
> +#define SL_ERROR_TPM_LOGGING_FAILED	0xc0008004
> +#define SL_ERROR_REGION_STRADDLE_4GB	0xc0008005
> +#define SL_ERROR_TPM_EXTEND		0xc0008006
> +#define SL_ERROR_MTRR_INV_VCNT		0xc0008007
> +#define SL_ERROR_MTRR_INV_DEF_TYPE	0xc0008008
> +#define SL_ERROR_MTRR_INV_BASE		0xc0008009
> +#define SL_ERROR_MTRR_INV_MASK		0xc000800a
> +#define SL_ERROR_MSR_INV_MISC_EN	0xc000800b
> +#define SL_ERROR_INV_AP_INTERRUPT	0xc000800c
> +#define SL_ERROR_INTEGER_OVERFLOW	0xc000800d
> +#define SL_ERROR_HEAP_WALK		0xc000800e
> +#define SL_ERROR_HEAP_MAP		0xc000800f
> +#define SL_ERROR_REGION_ABOVE_4GB	0xc0008010
> +#define SL_ERROR_HEAP_INVALID_DMAR	0xc0008011
> +#define SL_ERROR_HEAP_DMAR_SIZE		0xc0008012
> +#define SL_ERROR_HEAP_DMAR_MAP		0xc0008013
> +#define SL_ERROR_HI_PMR_BASE		0xc0008014
> +#define SL_ERROR_HI_PMR_SIZE		0xc0008015
> +#define SL_ERROR_LO_PMR_BASE		0xc0008016
> +#define SL_ERROR_LO_PMR_MLE		0xc0008017
> +#define SL_ERROR_INITRD_TOO_BIG		0xc0008018
> +#define SL_ERROR_HEAP_ZERO_OFFSET	0xc0008019
> +#define SL_ERROR_WAKE_BLOCK_TOO_SMALL	0xc000801a
> +#define SL_ERROR_MLE_BUFFER_OVERLAP	0xc000801b
> +#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
> +#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
> +#define SL_ERROR_EVENTLOG_MAP		0xc000801e
> +#define SL_ERROR_TPM_INVALID_ALGS	0xc000801f
> +#define SL_ERROR_TPM_EVENT_COUNT	0xc0008020
> +#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
> +#define SL_ERROR_INVALID_SLRT		0xc0008022
> +#define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
> +#define SL_ERROR_SLRT_MAP		0xc0008024
> +
> +/*
> + * Secure Launch Defined Limits
> + */
> +#define TXT_MAX_CPUS		512
> +#define TXT_BOOT_STACK_SIZE	128
> +
> +/*
> + * Secure Launch event log entry type. The TXT specification defines the
> + * base event value as 0x400 for DRTM values.
> + */
> +#define TXT_EVTYPE_BASE			0x400
> +#define TXT_EVTYPE_SLAUNCH		(TXT_EVTYPE_BASE + 0x102)
> +#define TXT_EVTYPE_SLAUNCH_START	(TXT_EVTYPE_BASE + 0x103)
> +#define TXT_EVTYPE_SLAUNCH_END		(TXT_EVTYPE_BASE + 0x104)
> +
> +/*
> + * MLE scratch area offsets
> + */
> +#define SL_SCRATCH_AP_EBX		0
> +#define SL_SCRATCH_AP_JMP_OFFSET	4
> +#define SL_SCRATCH_AP_STACKS_OFFSET	8
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/io.h>
> +#include <linux/tpm.h>
> +#include <linux/tpm_eventlog.h>
> +
> +/*
> + * Secure Launch AP stack and monitor block
> + */
> +struct sl_ap_stack_and_monitor {
> +	u32 monitor;
> +	u32 cache_pad[15];
> +	u32 stack_pad[15];
> +	u32 apicid;
> +} __packed;
> +
> +/*
> + * Secure Launch AP wakeup information fetched in SMP boot code.
> + */
> +struct sl_ap_wake_info {
> +	u32 ap_wake_block;
> +	u32 ap_wake_block_size;
> +	u32 ap_jmp_offset;
> +	u32 ap_stacks_offset;
> +};
> +

 Michal Camacho Romero: Move the following code section (matched in the black quotations) into the new header file include/linux/txt.h:

""" [START]> +/*
> + * TXT heap extended data elements.
> + */
> +struct txt_heap_ext_data_element {
> +	u32 type;
> +	u32 size;
> +	/* Data */
> +} __packed;
> +
> +#define TXT_HEAP_EXTDATA_TYPE_END			0
> +
> +struct txt_heap_end_element {
> +	u32 type;
> +	u32 size;
> +} __packed;
> +
> +#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
> +
> +struct txt_heap_event_log_element {
> +	u64 event_log_phys_addr;
> +} __packed;
> +
> +#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
> +
> +struct txt_heap_event_log_pointer2_1_element {
> +	u64 phys_addr;
> +	u32 allocated_event_container_size;
> +	u32 first_record_offset;
> +	u32 next_record_offset;
> +} __packed;
> +
> +/*
> + * Secure Launch defined OS/MLE TXT Heap table
> + */
> +struct txt_os_mle_data {
> +	u32 version;
> +	u32 reserved;
> +	u64 slrt;
> +	u64 txt_info;
> +	u32 ap_wake_block;
> +	u32 ap_wake_block_size;
> +	u8 mle_scratch[64];
> +} __packed;
> +
> +/*
> + * TXT specification defined BIOS data TXT Heap table
> + */
> +struct txt_bios_data {
> +	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
> +	u32 bios_sinit_size;
> +	u64 reserved1;
> +	u64 reserved2;
> +	u32 num_logical_procs;


Michal Camacho Romero: Put the comment /* Versions >= 5 with updates in version 6 */ under the sinit_flags struct member. The sinit_flags member exists in the BiosData struct since version 3. 

> +	/* Versions >= 5 with updates in version 6 */


> +	u32 sinit_flags;
> +	u32 mle_flags;
> +	/* Versions >= 4 */
> +	/* Ext Data Elements */
> +} __packed;
> +
> +/*
> + * TXT specification defined OS/SINIT TXT Heap table
> + */
> +struct txt_os_sinit_data {
> +	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
> +	u32 flags;
> +	u64 mle_ptab;
> +	u64 mle_size;
> +	u64 mle_hdr_base;
> +	u64 vtd_pmr_lo_base;
> +	u64 vtd_pmr_lo_size;
> +	u64 vtd_pmr_hi_base;
> +	u64 vtd_pmr_hi_size;
> +	u64 lcp_po_base;
> +	u64 lcp_po_size;
> +	u32 capabilities;
> +	/* Version = 5 */
> +	u64 efi_rsdt_ptr;
> +	/* Versions >= 6 */
> +	/* Ext Data Elements */
> +} __packed;
> +
> +/*
> + * TXT specification defined SINIT/MLE TXT Heap table
> + */
> +struct txt_sinit_mle_data {
> +	u32 version;             /* Current values are 6 through 9 */
> +	/* Versions <= 8 */
> +	u8 bios_acm_id[20];
> +	u32 edx_senter_flags;
> +	u64 mseg_valid;
> +	u8 sinit_hash[20];
> +	u8 mle_hash[20];
> +	u8 stm_hash[20];
> +	u8 lcp_policy_hash[20];
> +	u32 lcp_policy_control;
> +	/* Versions >= 7 */
> +	u32 rlp_wakeup_addr;
> +	u32 reserved;
> +	u32 num_of_sinit_mdrs;
> +	u32 sinit_mdrs_table_offset;
> +	u32 sinit_vtd_dmar_table_size;
> +	u32 sinit_vtd_dmar_table_offset;
> +	/* Versions >= 8 */
> +	u32 processor_scrtm_status;
> +	/* Versions >= 9 */
> +	/* Ext Data Elements */
> +} __packed;
> +
> +/*
> + * TXT data reporting structure for memory types
> + */
> +struct txt_sinit_memory_descriptor_record {
> +	u64 address;
> +	u64 length;
> +	u8 type;
> +	u8 reserved[7];
> +} __packed;
> +
> +/*
> + * TXT data structure used by a responsive local processor (RLP) to start
> + * execution in response to a GETSEC[WAKEUP].
> + */
> +struct smx_rlp_mle_join {
> +	u32 rlp_gdt_limit;
> +	u32 rlp_gdt_base;
> +	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
> +	u32 rlp_entry_point; /* phys addr */
> +} __packed;
> +
> +/*
> + * TPM event log structures defined in both the TXT specification and
> + * the TCG documentation.
> + */
> +#define TPM_EVTLOG_SIGNATURE "TXT Event Container"
> +
> +struct tpm_event_log_header {
> +	char signature[20];
> +	char reserved[12];
> +	u8 container_ver_major;
> +	u8 container_ver_minor;
> +	u8 pcr_event_ver_major;
> +	u8 pcr_event_ver_minor;
> +	u32 container_size;
> +	u32 pcr_events_offset;
> +	u32 next_event_offset;
> +	/* PCREvents[] */
> +} __packed;
> +
> +/*
> + * Functions to extract data from the Intel TXT Heap Memory. The layout
> + * of the heap is as follows:
> + *  +----------------------------+
> + *  | Size Bios Data table (u64) |
> + *  +----------------------------+
> + *  | Bios Data table            |
> + *  +----------------------------+
> + *  | Size OS MLE table (u64)    |
> + *  +----------------------------+
> + *  | OS MLE table               |
> + *  +--------------------------- +
> + *  | Size OS SINIT table (u64)  |
> + *  +----------------------------+
> + *  | OS SINIT table             |
> + *  +----------------------------+
> + *  | Size SINIT MLE table (u64) |
> + *  +----------------------------+
> + *  | SINIT MLE table            |
> + *  +----------------------------+
> + *
> + *  NOTE: the table size fields include the 8 byte size field itself.
> + */
> +static inline u64 txt_bios_data_size(void *heap)
> +{
> +	return *((u64 *)heap);
> +}
> +
> +static inline void *txt_bios_data_start(void *heap)
> +{
> +	return heap + sizeof(u64);
> +}
> +
> +static inline u64 txt_os_mle_data_size(void *heap)
> +{
> +	return *((u64 *)(heap + txt_bios_data_size(heap)));
> +}
> +
> +static inline void *txt_os_mle_data_start(void *heap)
> +{
> +	return heap + txt_bios_data_size(heap) + sizeof(u64);
> +}
> +
> +static inline u64 txt_os_sinit_data_size(void *heap)
> +{
> +	return *((u64 *)(heap + txt_bios_data_size(heap) +
> +			txt_os_mle_data_size(heap)));
> +}
> +
> +static inline void *txt_os_sinit_data_start(void *heap)
> +{
> +	return heap + txt_bios_data_size(heap) +
> +		txt_os_mle_data_size(heap) + sizeof(u64);
> +}
> +
> +static inline u64 txt_sinit_mle_data_size(void *heap)
> +{
> +	return *((u64 *)(heap + txt_bios_data_size(heap) +
> +			txt_os_mle_data_size(heap) +
> +			txt_os_sinit_data_size(heap)));
> +}
> +
> +static inline void *txt_sinit_mle_data_start(void *heap)
> +{
> +	return heap + txt_bios_data_size(heap) +
> +		txt_os_mle_data_size(heap) +
> +		txt_os_sinit_data_size(heap) + sizeof(u64);
> +}
> +
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +
> +/*
> + * TPM event logging functions.
> + */
> +
> +/*
> + * Find the TPM v2 event log element in the TXT heap. This element contains
> + * the information about the size and location of the DRTM event log. Note
> + * this is a TXT specific structure.
> + *
> + * See:
> + *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide - Appendix C.
> + */
> +static inline struct txt_heap_event_log_pointer2_1_element*
> +tpm2_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
> +{
> +	struct txt_heap_ext_data_element *ext_elem;
> +
> +	/* The extended element array as at the end of this table */
> +	ext_elem = (struct txt_heap_ext_data_element *)
> +		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
> +
> +	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
> +		if (ext_elem->type == TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
> +			return (struct txt_heap_event_log_pointer2_1_element *)
> +				((u8 *)ext_elem + sizeof(struct txt_heap_ext_data_element));
> +		}
> +		ext_elem = (struct txt_heap_ext_data_element *)
> +			    ((u8 *)ext_elem + ext_elem->size);
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Log a TPM v1 formatted event to the given DRTM event log.
> + */
> +static inline int tpm_log_event(void *evtlog_base, u32 evtlog_size,
> +				u32 event_size, void *event)
> +{
> +	struct tpm_event_log_header *evtlog =
> +		(struct tpm_event_log_header *)evtlog_base;
> +
> +	if (memcmp(evtlog->signature, TPM_EVTLOG_SIGNATURE,
> +		   sizeof(TPM_EVTLOG_SIGNATURE)))
> +		return -EINVAL;
> +
> +	if (evtlog->container_size > evtlog_size)
> +		return -EINVAL;
> +
> +	if (evtlog->next_event_offset + event_size > evtlog->container_size)
> +		return -E2BIG;
> +
> +	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
> +	evtlog->next_event_offset += event_size;
> +
> +	return 0;
> +}
> +
> +/*
> + * Log a TPM v2 formatted event to the given DRTM event log.
> + */
> +static inline int tpm2_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
> +				 void *evtlog_base, u32 evtlog_size,
> +				 u32 event_size, void *event)
> +{
> +	struct tcg_pcr_event *header =
> +		(struct tcg_pcr_event *)evtlog_base;
> +
> +	/* Has to be at least big enough for the signature */
> +	if (header->event_size < sizeof(TCG_SPECID_SIG))
> +		return -EINVAL;
> +
> +	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
> +		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
> +		return -EINVAL;
> +
> +	if (elem->allocated_event_container_size > evtlog_size)
> +		return -EINVAL;
> +
> +	if (elem->next_record_offset + event_size >
> +	    elem->allocated_event_container_size)
> +		return -E2BIG;
> +
> +	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
> +	elem->next_record_offset += event_size;
> +
> +	return 0;
> +}
> +
"""[END]

> +/*
> + * External functions available in mainline kernel.
> + */
> +void slaunch_setup_txt(void);
> +void slaunch_fixup_jump_vector(void);
> +u32 slaunch_get_flags(void);
> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
> +void __noreturn slaunch_txt_reset(void __iomem *txt,
> +					 const char *msg, u64 error);
> +void slaunch_finalize(int do_sexit);
> +
> +static inline bool slaunch_is_txt_launch(void)
> +{
> +	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
> +
> +	return (slaunch_get_flags() & mask) == mask;
> +}
> +
> +#else
> +
> +static inline void slaunch_setup_txt(void)
> +{
> +}
> +
> +static inline void slaunch_fixup_jump_vector(void)
> +{
> +}
> +
> +static inline u32 slaunch_get_flags(void)
> +{
> +	return 0;
> +}
> +
> +static inline struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
> +{
> +	return dmar;
> +}
> +
> +static inline void slaunch_finalize(int do_sexit)
> +{
> +}
> +
> +static inline bool slaunch_is_txt_launch(void)
> +{
> +	return false;
> +}
> +
> +#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLAUNCH_H */
Regards,
Michal Camacho Romero (michal.camacho.romero@linux.intel.com)

