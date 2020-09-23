Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B62756E7
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 13:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIWLMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 07:12:33 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:58902 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWLMc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Sep 2020 07:12:32 -0400
X-Greylist: delayed 3877 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 07:12:30 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 08NA7t6X018693; Wed, 23 Sep 2020 19:07:56 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 08NA7M88029552; Wed, 23 Sep 2020 19:07:22 +0900
X-Iguazu-Qid: 2wHHjJER8cR1uaLOcL
X-Iguazu-QSIG: v=2; s=0; t=1600855641; q=2wHHjJER8cR1uaLOcL; m=em4N8ro/bqvmQjobQrvNWahNf98bQj6KJr+hhIewB/E=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1112) id 08NA7JYQ026085;
        Wed, 23 Sep 2020 19:07:19 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 08NA7JCE014101;
        Wed, 23 Sep 2020 19:07:19 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 08NA7Ik6017583;
        Wed, 23 Sep 2020 19:07:18 +0900
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
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
Date:   Wed, 23 Sep 2020 19:07:17 +0900
In-Reply-To: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
        (Smita Koralahalli's message of "Fri, 4 Sep 2020 09:04:44 -0500")
X-TSB-HOP: ON
Message-ID: <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Smita,

A few comments below.

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
> [ Build error in patch v1. ]
>
> Reported-by: kernel test robot <lkp@intel.com>

I know Boris asked you to add the reason for the Reported-by, but
usually we don't track version differences in the committed patch.

Boris, can you confirm if you want the Reported-by to be retained?

> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com
>
> v4:
> 	Included what kernel test robot reported.
> 	Changed function name from apei_mce_report_x86_error ->
> 	apei_smca_report_x86_error.
> 	Added comment for MASK_MCA_STATUS definition.
> 	Wrapped apei_smca_report_x86_error() with CONFIG_X86_MCE in
> 	arch/x86/include/asm/mce.h
> v3:
> 	Moved arch specific declarations from generic headers to arch
> 	specific headers.
> 	Cleaned additional declarations which are unnecessary.
> 	Included the check for context type.
> 	Added additional check to verify for appropriate MSR address in
> 	the register layout.
> v2:
> 	Fixed build error reported by kernel test robot.
> 	Passed struct variable as function argument instead of entire struct.
> ---
>  arch/x86/include/asm/acpi.h     | 11 ++++++++
>  arch/x86/include/asm/mce.h      |  5 ++++
>  arch/x86/kernel/acpi/apei.c     |  5 ++++
>  arch/x86/kernel/cpu/mce/apei.c  | 49 +++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper-x86.c | 10 +++++--
>  5 files changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 6d2df1ee427b..65064d9f7fa6 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -159,6 +159,8 @@ static inline u64 x86_default_get_root_pointer(void)
>  extern int x86_acpi_numa_init(void);
>  #endif /* CONFIG_ACPI_NUMA */
>  
> +struct cper_ia_proc_ctx;
> +
>  #ifdef CONFIG_ACPI_APEI
>  static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>  {
> @@ -177,6 +179,15 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>  	 */
>  	return PAGE_KERNEL_NOENC;
>  }
> +
> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +			       u64 lapic_id);
> +#else
> +static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +					     u64 lapic_id)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn_mapped << PAGE_SHIFT)
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 109af5c7f515..d07bd635acfd 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -173,17 +173,22 @@ extern void mce_unregister_decode_chain(struct notifier_block *nb);
>  #include <linux/atomic.h>
>  
>  extern int mce_p5_enabled;
> +struct cper_ia_proc_ctx;
>  
>  #ifdef CONFIG_X86_MCE
>  int mcheck_init(void);
>  void mcheck_cpu_init(struct cpuinfo_x86 *c);
>  void mcheck_cpu_clear(struct cpuinfo_x86 *c);
>  void mcheck_vendor_init_severity(void);
> +int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +			       u64 lapic_id);
>  #else
>  static inline int mcheck_init(void) { return 0; }
>  static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
>  static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
>  static inline void mcheck_vendor_init_severity(void) {}
> +static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> +					     u64 lapic_id) { return -EINVAL; }
>  #endif
>  
>  #ifdef CONFIG_X86_ANCIENT_MCE
> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> index c22fb55abcfd..0916f00a992e 100644
> --- a/arch/x86/kernel/acpi/apei.c
> +++ b/arch/x86/kernel/acpi/apei.c
> @@ -43,3 +43,8 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	apei_mce_report_mem_error(sev, mem_err);
>  #endif
>  }
> +
> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> +{
> +	return apei_smca_report_x86_error(ctx_info, lapic_id);
> +}
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index af8d37962586..d4b3a2053eef 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -51,6 +51,55 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  }
>  EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  
> +/*
> + * The first expected register in the register layout of MCAX address space.
> + * The address defined must match with the first MSR address extracted from
> + * BERT which in SMCA systems is the bank's MCA_STATUS register.
> + *
> + * Note that the decoding of the raw MSR values in BERT is implementation
> + * specific and follows register offset order of MCAX address space.
> + */
> +#define MASK_MCA_STATUS 0xC0002001

The macro value is already defined in mce.h as
MSR_AMD64_SMCA_MC0_STATUS.  Is there any reason to not use it?

You can move the comment to where you check the status register.


> +
> +int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> +{
> +	const u64 *i_mce = ((const void *) (ctx_info + 1));

This can directly be cast into (const u64 *).

> +	unsigned int cpu;
> +	struct mce m;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SMCA))
> +		return -EINVAL;
> +
> +	if ((ctx_info->msr_addr & MASK_MCA_STATUS) != MASK_MCA_STATUS)
> +		return -EINVAL;
> +
> +	mce_setup(&m);
> +
> +	m.extcpu = -1;
> +	m.socketid = -1;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu_data(cpu).initial_apicid == lapic_id) {
> +			m.extcpu = cpu;
> +			m.socketid = cpu_data(m.extcpu).phys_proc_id;
> +			break;
> +		}
> +	}
> +
> +	m.apicid = lapic_id;
> +	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
> +	m.status = *i_mce;
> +	m.addr = *(i_mce + 1);
> +	m.misc = *(i_mce + 2);
> +	/* Skipping MCA_CONFIG */
> +	m.ipid = *(i_mce + 4);
> +	m.synd = *(i_mce + 5);

Instead of using the raw pointer arithmetic, it is better to define a
structure for the MCA registers? Something like -

    struct {
        u64 addr;
        u64 misc;
        u64 config;
        u64 ipid;
        ...
    }

Checking back, this was mentioned in the previous review comments as
well. Please address all comments before posting a new version - either
by following the suggestion or explaining why it is not a good idea.

Thanks,
Punit

> +
> +	mce_log(&m);
> +
> +	return 0;
> +}
> +
>  #define CPER_CREATOR_MCE						\
>  	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
>  		  0x64, 0x90, 0xb8, 0x9d)
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 2531de49f56c..2f2b0c431c18 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -2,6 +2,7 @@
>  // Copyright (C) 2018, Advanced Micro Devices, Inc.
>  
>  #include <linux/cper.h>
> +#include <linux/acpi.h>
>  
>  /*
>   * We don't need a "CPER_IA" prefix since these are all locally defined.
> @@ -347,9 +348,12 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  			       ctx_info->mm_reg_addr);
>  		}
>  
> -		printk("%sRegister Array:\n", newpfx);
> -		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> -			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
> +		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
> +			printk("%sRegister Array:\n", newpfx);
> +			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> +				       (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +		}
>  
>  		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
>  	}
