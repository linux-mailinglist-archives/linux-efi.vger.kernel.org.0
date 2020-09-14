Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A953A268FF1
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINPas (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgINPad (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 11:30:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52FC061788;
        Mon, 14 Sep 2020 08:30:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09260028f4716b73cc78b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:28f4:716b:73cc:78b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FF221EC058B;
        Mon, 14 Sep 2020 17:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600097430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IO3nJCxiAaLTozpIMPP+zcFAu5QWr1+m3yLnakXhZ/c=;
        b=qdH3yHi18x7LvT7GDCEl2cq+OXEBSOlCfo/k+7Z4tyANVhlIri1j9CGyFZM/8Kl4GAlqY0
        uhVStXSphAV1KQPDcmFuYz/SFHRMoZ1zmSJMlbrsqc5j2iSTmwu18Kzfz67/9DAFSk2M9f
        W6viYl3K2oRHuas9qQ8EqtgGAMzJa9Y=
Date:   Mon, 14 Sep 2020 17:30:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200914153024.GC680@zn.tnic>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 03, 2020 at 06:45:30PM -0500, Smita Koralahalli wrote:
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

What's that Reported-by for?

Pls put in [] brackets over it what the 0day robot has reported.

> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com
> 
> v3:
> 	Moved arch specific declarations from generic header file to arch
> 	specific header file.
> 	Cleaned additional declarations which are unnecessary.
> 	Included the check for context type.
> 	Added a check to verify for the first MSR address in the register
> 	layout.
> v2:
> 	Fixed build error reported by kernel test robot.
> 	Passed struct variable as function argument instead of entire struct
> ---
>  arch/x86/include/asm/acpi.h     | 11 +++++++++
>  arch/x86/include/asm/mce.h      |  3 +++
>  arch/x86/kernel/acpi/apei.c     |  9 +++++++
>  arch/x86/kernel/cpu/mce/apei.c  | 42 +++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper-x86.c | 10 +++++---
>  5 files changed, 72 insertions(+), 3 deletions(-)

...

> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> index c22fb55abcfd..13d60a91eaa0 100644
> --- a/arch/x86/kernel/acpi/apei.c
> +++ b/arch/x86/kernel/acpi/apei.c
> @@ -43,3 +43,12 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	apei_mce_report_mem_error(sev, mem_err);
>  #endif
>  }
> +
> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> +{
> +	int err = -EINVAL;
> +#ifdef CONFIG_X86_MCE
> +	err = apei_mce_report_x86_error(ctx_info, lapic_id);
> +#endif
> +	return err;
> +}

Add a stub for apei_mce_report_x86_error() in
arch/x86/include/asm/mce.h, in one of the !CONFIG_X86_MCE ifdeffery
which returns -EINVAL and get rid of this ifdeffery and simply do:

	return apei_mce_report_x86_error(ctx_info, lapic_id);

here.

If you wanna fix the above apei_mce_report_mem_error() too, you can do
that in a separate patch.

> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index af8d37962586..65001d342302 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -26,6 +26,8 @@
>  
>  #include "internal.h"
>  
> +#define MASK_MCA_STATUS 0xC0002001

What does that mask mean? Either here or where it is used needs a
comment.

>  void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
> @@ -51,6 +53,46 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  }
>  EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  
> +int apei_mce_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> +{
> +	const u64 *i_mce = ((const void *) (ctx_info + 1));
> +	unsigned int cpu;
> +	struct mce m;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SMCA))

If this function you're adding is SMCA-specific, then its name cannot be
as generic as it is now.

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

I don't like that but I don't think we have a reverse mapping from LAPIC
ID to logical CPU numbers in the kernel...

> +			m.extcpu = cpu;
> +			m.socketid = cpu_data(m.extcpu).phys_proc_id;

			m.socketid = cpu_data(cpu).phys_proc_id;

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

Is that structure after cper_ia_proc_ctx defined somewhere in the UEFI
spec so that you can cast to it directly instead of doing this ugly
pointer arithmetic?

> +
> +	mce_log(&m);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(apei_mce_report_x86_error);

Why is this function exported?

If "no reason", you can fix the above one too, with a separate commit.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
