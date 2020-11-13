Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB64D2B13F2
	for <lists+linux-efi@lfdr.de>; Fri, 13 Nov 2020 02:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMBlT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 12 Nov 2020 20:41:19 -0500
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:44126 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMBlT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Nov 2020 20:41:19 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0AD1evdt031978; Fri, 13 Nov 2020 10:40:57 +0900
X-Iguazu-Qid: 34trXZNYeNEyzvpCth
X-Iguazu-QSIG: v=2; s=0; t=1605231656; q=34trXZNYeNEyzvpCth; m=woCVqhSyszefYnXa0h+3xqIDuJphGUkqWVHEK5sBHa8=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 0AD1etNG000808;
        Fri, 13 Nov 2020 10:40:55 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0AD1esrr025901;
        Fri, 13 Nov 2020 10:40:54 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0AD1es0E028816;
        Fri, 13 Nov 2020 10:40:54 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
        <87a6vv9hch.fsf@kokedama.swc.toshiba.co.jp>
        <20201106120950.GC14914@zn.tnic>
        <874klz9vk9.fsf@kokedama.swc.toshiba.co.jp>
        <982e0243-b144-f8b6-d69d-45af94ed8bb9@amd.com>
        <651b7dba-d36a-d4db-4a0f-fd67aa9b985f@amd.com>
Date:   Fri, 13 Nov 2020 10:40:50 +0900
In-Reply-To: <651b7dba-d36a-d4db-4a0f-fd67aa9b985f@amd.com> (Smita Koralahalli
        Channabasappa's message of "Wed, 11 Nov 2020 14:37:29 -0600")
X-TSB-HOP: ON
Message-ID: <87361e8259.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita Koralahalli Channabasappa <skoralah@amd.com> writes:

> Punit,
>
> On 11/9/20 1:05 PM, Smita Koralahalli Channabasappa wrote:
>
>> On 11/8/20 7:18 PM, Punit Agrawal wrote:
>>> Borislav Petkov <bp@alien8.de> writes:
>>>> On Fri, Nov 06, 2020 at 02:36:46PM +0900, Punit Agrawal wrote:
>>>>>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>>>>>> index 2531de49f56c..438ed9eff6d0 100644
>>>>>> --- a/drivers/firmware/efi/cper-x86.c
>>>>>> +++ b/drivers/firmware/efi/cper-x86.c
>>>>>> @@ -2,6 +2,7 @@
>>>>>>    // Copyright (C) 2018, Advanced Micro Devices, Inc.
>>>>>>      #include <linux/cper.h>
>>>>>> +#include <linux/acpi.h>
>>>>> Did you mean to include <asm/acpi.h>?
>>>> Why?
>>> Because arch_apei_report_x86_error() used in the patch is defined
>>> there. The indirect include works but pulls in additional definitions
>>> not needed by the patch.
>>>
>>> Do you prefer the more generic include?
>> I agree, it's generally a good practice to avoid pulling up additional
>> definitions. I had this when I made the declaration in generic header
>> file and may be I did not consider it changing initially as my build
>> didn't break after moving the declaration from generic header to arch
>> specific header file.
>> I will take care henceforth and make the changes as required.
>
> The asm specific include throws out a warning when I run checkpatch.pl
>
> WARNING: Use #include <linux/acpi.h> instead of <asm/acpi.h>
> #215: FILE: drivers/firmware/efi/cper-x86.c:5:
> +#include <asm/acpi.h>
>
> Should I just keep the generic include?

Thanks for checking.

I had a quick look at checkpatch to understand the reason for the
warning. It seems to warn when "asm" includes are used when a suitable
"linux" include exists[0].

I am not convinced that the rationale for that check applies in this
case as the function being used is indeed an architecture specific one
but also don't feel strongly enough to object.

Feel free to pick up the "Reviewed-by" tag in either case.

Thanks,
Punit

[0] https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl#L5333
