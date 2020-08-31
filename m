Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A4257347
	for <lists+linux-efi@lfdr.de>; Mon, 31 Aug 2020 07:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHaF2B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Aug 2020 01:28:01 -0400
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:36154 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaF2A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Aug 2020 01:28:00 -0400
X-Greylist: delayed 1319 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2020 01:27:58 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 07V55xjM028905; Mon, 31 Aug 2020 14:06:00 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 07V55N5u031198; Mon, 31 Aug 2020 14:05:24 +0900
X-Iguazu-Qid: 34tMd2lTgy70XwD4cl
X-Iguazu-QSIG: v=2; s=0; t=1598850323; q=34tMd2lTgy70XwD4cl; m=Eo+lI7ZGnqBRi8KYw8EQ/Q4YFSXKrGQSVifG045e3U8=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1511) id 07V55LQQ032861;
        Mon, 31 Aug 2020 14:05:21 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 07V55K93009887;
        Mon, 31 Aug 2020 14:05:20 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 07V55Krc022628;
        Mon, 31 Aug 2020 14:05:20 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
        <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
Date:   Mon, 31 Aug 2020 14:05:18 +0900
In-Reply-To: <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
        (Smita Koralahalli's message of "Fri, 28 Aug 2020 15:33:31 -0500")
X-TSB-HOP: ON
Message-ID: <878sdvv20h.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Smita,

A couple of comments below -

Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> writes:

> Linux Kernel uses ACPI Boot Error Record Table (BERT) to report fatal
> errors that occurred in a previous boot. The MCA errors in the BERT are
> reported using the x86 Processor Error Common Platform Error Record (CPER)
> format. Currently, the record prints out the raw MSR values and AMD relies
> on the raw record to provide MCA information.
>
> Extract the raw MSR values of MCA registers from the BERT and feed it into
> the standard mce_log() function through the existing x86/MCA RAS
> infrastructure. This will result in better decoding from the EDAC MCE
> decoder or the default notifier.
>
> The implementation is SMCA specific as the raw MCA register values are
> given in the register offset order of the MCAX address space.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---

[...]


> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 2531de49f56c..374b8e18552a 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (C) 2018, Advanced Micro Devices, Inc.
>  
> -#include <linux/cper.h>

Why is the include dropped? AFAICT, the definitions from there are still
being used after this patch.

> +#include <acpi/apei.h>
>  
>  /*
>   * We don't need a "CPER_IA" prefix since these are all locally defined.
> @@ -347,9 +347,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  			       ctx_info->mm_reg_addr);
>  		}
>  
> -		printk("%sRegister Array:\n", newpfx);
> -		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> -			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +		if (arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
> +			printk("%sRegister Array:\n", newpfx);
> +			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> +				       (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +		}
>  
>  		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
>  	}
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index 680f80960c3d..44d4d08acce0 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -33,8 +33,15 @@ extern bool ghes_disable;
>  
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +			       u64 lapic_id);
>  #else
>  static inline void acpi_hest_init(void) { return; }
> +static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +					     u64 lapic_id)
> +{
> +	return -EINVAL;
> +}
>  #endif

Adding the declaration to this include violates the separation of
generic and architecture specific code.

Can this be moved to the appropriate architecture specific header?
Perhaps arch/x86/include/asm/apei.h.

>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> @@ -51,6 +58,8 @@ int erst_clear(u64 record_id);
>  
>  int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
>  void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +			       u64 lapic_id);


Why is the additional declaration needed?

Thanks,
Punit

>  
>  #endif
>  #endif
