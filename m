Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173A446BC0A
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 13:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhLGNDS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 08:03:18 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33285 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhLGNDS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 08:03:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uzmr3Eo_1638881983;
Received: from 30.240.125.66(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Uzmr3Eo_1638881983)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 20:59:45 +0800
Message-ID: <9a90c5a4-ec3c-5d82-4a8f-baf94ff65edc@linux.alibaba.com>
Date:   Tue, 7 Dec 2021 20:59:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] ghes_edac: refactor memory error location processing
Content-Language: en-US
To:     Robert Richter <rric@kernel.org>
Cc:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
 <Ya9F75xWt/IlwcKC@rric.localdomain>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Ya9F75xWt/IlwcKC@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Robert,

Thank you for your quick comments! I will change these in the next version.

On 2021/12/7 PM7:30, Robert Richter wrote:
> On 07.12.21 11:19:04, Shuai Xue wrote:
>> The memory error location processing in ghes_edac_report_mem_error() have
>> Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
>> cper_mem_err_type_str() in drivers/firmware/efi/cper.c.
>>
>> To avoid the duplicated code, this patch introduces the above cper_*() into
>> ghes_edac_report_mem_error().
> 
> It is not really duplicate yet, changes are slightly different which
> could trigger problems in some parsers. At least those differences
> should be listed in the patch description. 
I see your concerns. I will document the changes in patch description.

> I would rather remove the
> 'space' delimiter after the colon and take the ghes version of it as
> logs become harder to read. So ideally there is a unification patch
> before the "duplication" is removed with changes in both files as
> necessary for review and to document the change.
I will add a new patch to unify ghes and cper before removing duplication.


>> The EDAC error log is now properly reporting the error as follows (all
>> Validation Bits are enabled):
>>
>> [  375.938411] EDAC MC0: 1 CE single-symbol chipkill ECC on unknown memory (node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 page:0x898b86 offset:0x20 grain:1 syndrome:0x0 - APEI location: node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000 DIMM location: not present. DMI handle: 0x0000 status(0x0000000000000000): reserved)
>> [  375.938416] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
>> [  375.938417] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
>> [  375.938418] {2}[Hardware Error]: event severity: corrected
>> [  375.938419] {2}[Hardware Error]:  Error 0, type: corrected
>> [  375.938420] {2}[Hardware Error]:   section_type: memory error
>> [  375.938421] {2}[Hardware Error]:   error_status: 0x0000000000000000
>> [  375.938422] {2}[Hardware Error]:   physical_address: 0x0000000898b86020
>> [  375.938422] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
>> [  375.938426] {2}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 513 bank_group: 2 bank_address: 1 device: 0 row: 4887 column: 1032 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
>> [  375.938426] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
>> [  375.938428] {2}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> 
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 6ec8edec6329..08eabb2e23f8 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -211,7 +211,7 @@ const char *cper_mem_err_type_str(unsigned int etype)
>>  }
>>  EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
>>  
>> -static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>> +int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>>  {
>>  	u32 len, n;
>>  
>> @@ -265,7 +265,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>>  	return n;
>>  }
>>  
>> -static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>> +int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>>  {
>>  	u32 len, n;
>>  	const char *bank = NULL, *device = NULL;
> 
> Even though the ghes driver cannot be built as module,
> EXPORT_SYMBOL_GPL()s should be added for both.
I will add EXPORT_SYMBOL_GPL()s.

> It would be good to add a note to the description that the
> UEFI_CPER/EDAC_GHES dependency is always solved through
> ACPI_APEI_GHES/ACPI_APEI. But we should make the UEFI_CPER dependency
> explicit for EDAC_GHES in Kconfig anyway.
Will document the dependency and add UEFI_CPER dependency explicit for
EDAC_GHES in Kconfig in next version.

Cheers,
Shuai
