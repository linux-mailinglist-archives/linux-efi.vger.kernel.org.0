Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA772A8FF6
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKFHFq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 02:05:46 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:60624 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKFHFl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Nov 2020 02:05:41 -0500
X-Greylist: delayed 5290 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 02:05:39 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 0A65bTgp005425; Fri, 6 Nov 2020 14:37:29 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0A65arFR018126; Fri, 6 Nov 2020 14:36:53 +0900
X-Iguazu-Qid: 2wHHmca9fb4omt8CsG
X-Iguazu-QSIG: v=2; s=0; t=1604641012; q=2wHHmca9fb4omt8CsG; m=8omBj8jo2qzV/WJteuWe7FJml1+CQgKYuaV4OIgz5TE=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1110) id 0A65ao5p023434;
        Fri, 6 Nov 2020 14:36:51 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0A65aov5024147;
        Fri, 6 Nov 2020 14:36:50 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0A65anXV001086;
        Fri, 6 Nov 2020 14:36:50 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
Date:   Fri, 06 Nov 2020 14:36:46 +0900
In-Reply-To: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
        (Smita Koralahalli's message of "Tue, 3 Nov 2020 10:49:52 -0600")
X-TSB-HOP: ON
Message-ID: <87a6vv9hch.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Smita,

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
> [ Fix a build breakage in patch v1. ]
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[...]

> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 2531de49f56c..438ed9eff6d0 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -2,6 +2,7 @@
>  // Copyright (C) 2018, Advanced Micro Devices, Inc.
>  
>  #include <linux/cper.h>
> +#include <linux/acpi.h>

Did you mean to include <asm/acpi.h>?

>  
>  /*
>   * We don't need a "CPER_IA" prefix since these are all locally defined.
> @@ -347,9 +348,13 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  			       ctx_info->mm_reg_addr);
>  		}
>  
> -		printk("%sRegister Array:\n", newpfx);
> -		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> -			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
> +		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
> +			printk("%sRegister Array:\n", newpfx);
> +			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16,
> +				       groupsize, (ctx_info + 1),
> +				       ctx_info->reg_arr_size, 0);
> +		}
>  
>  		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
>  	}

With that addressed,

FWIW,

Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Thanks,
Punit
