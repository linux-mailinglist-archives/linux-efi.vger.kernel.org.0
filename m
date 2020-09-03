Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB925BB1B
	for <lists+linux-efi@lfdr.de>; Thu,  3 Sep 2020 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgICGeW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Sep 2020 02:34:22 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:52200 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgICGeW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Sep 2020 02:34:22 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0836XqkV026096; Thu, 3 Sep 2020 15:33:52 +0900
X-Iguazu-Qid: 2wGqimZzpdodzp3qKb
X-Iguazu-QSIG: v=2; s=0; t=1599114831; q=2wGqimZzpdodzp3qKb; m=3lD5yTuNA9UipE4IT4HqtHJpMosJZhyi/NRwtDEowSQ=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1111) id 0836Xnhn027327;
        Thu, 3 Sep 2020 15:33:49 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0836XnKm019408;
        Thu, 3 Sep 2020 15:33:49 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0836XmiJ027896;
        Thu, 3 Sep 2020 15:33:48 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
        <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
        <878sdvv20h.fsf@kokedama.swc.toshiba.co.jp>
        <102d0c75-d642-8f8b-68c7-792499c2a62a@amd.com>
Date:   Thu, 03 Sep 2020 15:33:47 +0900
In-Reply-To: <102d0c75-d642-8f8b-68c7-792499c2a62a@amd.com> (Smita Koralahalli
        Channabasappa's message of "Wed, 2 Sep 2020 14:29:28 -0500")
X-TSB-HOP: ON
Message-ID: <87a6y7qshg.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Smita,

Smita Koralahalli Channabasappa <skoralah@amd.com> writes:

> On 8/31/20 12:05 AM, Punit Agrawal wrote:
>
>> Hi Smita,
>>
>> A couple of comments below -
>>
>> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> writes:
>>
>> [...]
>>
>>
>>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>>> index 2531de49f56c..374b8e18552a 100644
>>> --- a/drivers/firmware/efi/cper-x86.c
>>> +++ b/drivers/firmware/efi/cper-x86.c
>>> @@ -1,7 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0
>>>   // Copyright (C) 2018, Advanced Micro Devices, Inc.
>>>   -#include <linux/cper.h>
>> Why is the include dropped? AFAICT, the definitions from there are still
>> being used after this patch.
>
> Dropped because <acpi/apei.h> already includes <linux/cper.h>

Generally, you want to follow the rule that if a declaration from a
header file is being used, it should show up in the includes. The same
applies to both source as well as header files.

It doesn't matter if another include in the source file in turn ends up
including the same header again; the #ifdef guards are there to prevent
duplicate declarations.

The rationale is that if future changes remove the usage of
<acpi/apei.h>, the C file can still be compiled after dropping the
include; there should be no need to then re-introduce <linux/cper.h> at
that point.

Hope that makes sense.

Thanks,
Punit

>>> +#include <acpi/apei.h>
>
> [...]
>
>>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>>> index 680f80960c3d..44d4d08acce0 100644
>>> --- a/include/acpi/apei.h
>>> +++ b/include/acpi/apei.h
>>> @@ -33,8 +33,15 @@ extern bool ghes_disable;
>>>     #ifdef CONFIG_ACPI_APEI
>>>   void __init acpi_hest_init(void);
>>> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>>> +			       u64 lapic_id);
>>>   #else
>>>   static inline void acpi_hest_init(void) { return; }
>>> +static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>>> +					     u64 lapic_id)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>>   #endif
>> Adding the declaration to this include violates the separation of
>> generic and architecture specific code.
>>
>> Can this be moved to the appropriate architecture specific header?
>> Perhaps arch/x86/include/asm/apei.h.
>
> Yes, I have fixed this and moved into arch/x86/include/asm/acpi.h.
>
>>>   typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>>> @@ -51,6 +58,8 @@ int erst_clear(u64 record_id);
>>>     int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
>>> void *data);
>>>   void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
>>> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>>> +			       u64 lapic_id);
>>
>> Why is the additional declaration needed?
>
> Will fix in the next revision.
>
> Thanks,
> Smita
>
> [...]
