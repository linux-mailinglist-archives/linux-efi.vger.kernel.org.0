Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326BC480F39
	for <lists+linux-efi@lfdr.de>; Wed, 29 Dec 2021 04:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhL2DWR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 22:22:17 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38287 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231775AbhL2DWQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Dec 2021 22:22:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V0AWMYp_1640748132;
Received: from 30.240.117.58(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V0AWMYp_1640748132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Dec 2021 11:22:14 +0800
Message-ID: <9e0bf7c0-ed50-5b0b-0576-3651249ba5cd@linux.alibaba.com>
Date:   Wed, 29 Dec 2021 11:22:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] ghes_edac: unify memory error report format with
 cper
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20211210134019.28536-2-xueshuai@linux.alibaba.com>
 <YctFli9oMBYTlf7h@zn.tnic>
Content-Language: en-US
In-Reply-To: <YctFli9oMBYTlf7h@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

Thank you very much for your valuable comments.


在 2021/12/29 AM1:12, Borislav Petkov 写道:
> On Fri, Dec 10, 2021 at 09:40:17PM +0800, Shuai Xue wrote:
>> Subject: Re: [PATCH v2 1/3] ghes_edac: unify memory error report format with
> 
> "EDAC/ghes: Unify..."
> 
> is the format we use in the EDAC tree.
Got it, thank you. Will fix in next version.


>> The changes are to:
>>
>> - add device info into ghes_edac
>> - change bit_pos to bit_position, col to column, requestorID to
>>   requestor_id, etc in ghes_edac
>> - move requestor_id, responder_id, target_id and chip_id into memory error
>>   location in ghes_edac
>> - add "DIMM location: not present." for DIMM location in ghes_edac
>> - remove the 'space' delimiter after the colon in ghes_edac and cper
> 
> This commit message is useless: it should not talk about what your patch
> does - that should hopefully be visible in the diff itself. Rather, it
> should talk about *why* you're doing what you're doing.

The comments from Robert in v1[1] ask me to explicitly list those differences,

	It is not really duplicate yet, changes are slightly different which
	could trigger problems in some parsers. At least those differences
	should be listed in the patch description.

Should I keep it here? Or delete it and just add why.


> Also, your patch does a bunch of things at once.
> 
> From: Documentation/process/submitting-patches.rst
> 
> "Solve only one problem per patch.  If your description starts to get
> long, that's a sign that you probably need to split up your patch.
> See :ref:`split_changes`."
> 
> You should have a look at that file.
> 
> Also, avoid having "This patch" or "This commit" in the commit message.
> It is tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.

Got it, thank you very much. But as you mentioned bellow, the purpose of this
patch is to unify memory error report format with cper so that we can use use
cper_mem_err_location() directly. Actually, this patch series is originally
suggested by Tony[2] to share the same code with cper. Should I split this
patch by function?


>> The original EDAC and cper error log are as follows (all Validation Bits
>> are enabled):
>>
>> [31940.060454] EDAC MC0: 1 CE Single-symbol ChipKill ECC on unknown memory (node:0 card:0 module:0 rank:0 bank:257 bank_group:1 bank_address:1 row:75492 col:8 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 page:0x93724c offset:0x20 grain:1 syndrome:0x0 - APEI location: node:0 card:0 module:0 rank:0 bank:257 bank_group:1 bank_address:1 row:75492 col:8 bit_pos:0 DIMM DMI handle: 0x0000 chipID: 0 status(0x0000000000000000): reserved requestorID: 0x0000000000000000 responderID: 0x0000000000000000 targetID: 0x0000000000000000)
>> [31940.060459] {3}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
>> [31940.060460] {3}[Hardware Error]: It has been corrected by h/w and requires no further action
>> [31940.060462] {3}[Hardware Error]: event severity: corrected
>> [31940.060463] {3}[Hardware Error]:  Error 0, type: corrected
>> [31940.060464] {3}[Hardware Error]:   section_type: memory error
>> [31940.060465] {3}[Hardware Error]:   error_status: 0x0000000000000000
>> [31940.060466] {3}[Hardware Error]:   physical_address: 0x000000093724c020
>> [31940.060466] {3}[Hardware Error]:   physical_address_mask: 0x0000000000000000
>> [31940.060469] {3}[Hardware Error]:   node: 0 card: 0 module: 0 rank: 0 bank: 257 bank_group: 1 bank_address: 1 device: 0 row: 75492 column: 8 bit_position: 0 requestor_id: 0x0000000000000000 responder_id: 0x0000000000000000
>> [31940.060470] {3}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
>> [31940.060471] {3}[Hardware Error]:   DIMM location: not present. DMI handle: 0x0000
>>
>> Now, the EDAC and cper error log are properly reporting the error as
>> follows (all Validation Bits are enabled):
>>
>> [ 117.973657] EDAC MC0: 1 CE Single-symbol ChipKill ECC on 0x0000
> 
> What does "ECC on 0x0000" mean?
> 
>> (node:0 card:0 module:0 rank:0 bank:1026 bank_group:4
>> bank_address:2 device:0 row:6749 column:8 bit_position:0
> 
>> requestor_id:0x0000000000000000
>> responder_id:0x0000000000000000
>> target_id:0x0000000000000000
> 
> those look useless to me too. Probably invalid/unpopulated by BIOS...

Yep, these fields are unpopulated by BIOS, I manually enable all Validation
Bits for debug so that we see the difference more clearly. I will declare it
in next version.


>> chip_id:0 DIMM location:not present. DIMM
>> DMI handle:0x0000 page:0x8d2ef4 offset:0x20 grain:1 syndrome:0x0 -
>> APEI location: node:0 card:0 module:0 rank:0 bank:1026 bank_group:4
>> bank_address:2 device:0 row:6749 column:8 bit_position:0
>> requestor_id:0x0000000000000000 responder_id:0x0000000000000000
>> target_id:0x0000000000000000 chip_id:0 DIMM location:not present. DIMM
>> DMI handle:0x0000 status(0x0000000000000000):reserved)
> 
> Sorry but I fail to see how this changed error record is an improvement.

Well, the purpose is not to improve but unify.


>> [  117.973663] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
>> [  117.973664] {2}[Hardware Error]: It has been corrected by h/w and requires no further action
>> [  117.973665] {2}[Hardware Error]: event severity: corrected
>> [  117.973666] {2}[Hardware Error]:  Error 0, type: corrected
>> [  117.973667] {2}[Hardware Error]:   section_type: memory error
>> [  117.973668] {2}[Hardware Error]:   error_status: 0x0000000000000000
>> [  117.973669] {2}[Hardware Error]:   physical_address: 0x00000008d2ef4020
>> [  117.973670] {2}[Hardware Error]:   physical_address_mask: 0x0000000000000000
>> [  117.973672] {2}[Hardware Error]:   node:0 card:0 module:0 rank:0 bank:1026 bank_group:4 bank_address:2 device:0 row:6749 column:8 bit_position:0 requestor_id:0x0000000000000000 responder_id:0x0000000000000000 target_id:0x0000000000000000 chip_id:0
>> [  117.973673] {2}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
>> [  117.973674] {2}[Hardware Error]:   DIMM location: not present. DMI handle:0x0000
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/edac/ghes_edac.c    | 35 +++++++++++++++++++----------------
>>  drivers/firmware/efi/cper.c | 34 +++++++++++++++++-----------------
>>  2 files changed, 36 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>> index 6d1ddecbf0da..526a28cbb19b 100644
>> --- a/drivers/edac/ghes_edac.c
>> +++ b/drivers/edac/ghes_edac.c
>> @@ -378,6 +378,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>  	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
>>  		p += sprintf(p, "bank_address:%d ",
>>  			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
>> +	if (mem_err->validation_bits & CPER_MEM_VALID_DEVICE)
>> +		p += sprintf(p, "device:%d ", mem_err->device);
>>  	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
>>  		u32 row = mem_err->row;
>>  
>> @@ -385,9 +387,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>  		p += sprintf(p, "row:%d ", row);
>>  	}
>>  	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
>> -		p += sprintf(p, "col:%d ", mem_err->column);
>> +		p += sprintf(p, "column:%d ", mem_err->column);
>>  	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
>> -		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>> +		p += sprintf(p, "bit_position:%d ", mem_err->bit_pos);
> 
> What for?

To unify memory error report format with cper. Should we use cper
or ghes_edac version?


>> +	if (mem_err->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
>> +		p += sprintf(p, "requestor_id:0x%016llx ",
>> +			     (long long)mem_err->requestor_id);
>> +	if (mem_err->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
>> +		p += sprintf(p, "responder_id:0x%016llx ",
>> +			     (long long)mem_err->responder_id);
> 					^^^^^^^^^^^^^^^^^^^^^^
> 
>> +	if (mem_err->validation_bits & CPER_MEM_VALID_TARGET_ID)
>> +		p += sprintf(p, "target_id:0x%016llx ",
>> +			     (long long)mem_err->responder_id);
> 					^^^^^^^^^^^^^^^^^^^^^^
> 
> mem_err->responder_id for both responder and target?!

Sorry for this bug. Will fix in next version.

> 
>> +	if (mem_err->validation_bits & CPER_MEM_VALID_CHIP_ID)
>> +		p += sprintf(p, "chip_id:%d ",
>> +			     mem_err->extended >> CPER_MEM_CHIP_ID_SHIFT);
> 
> I don't know if some dumb BIOS simply sets those valid bits regardless
> of whether those fields are populated or not... It looks like it...
> 
> Right, so first this needs to explain *why* you're doing what you're
> doing. And then with each reason why, you should do a patch, one by one,
> explaining the rationale.
> 
> /me goes and looks at the next patches.
> 
> Aha, and you add all that crap here just to remove it in patch 2. But
> this is all useless churn.
> 
> If you want to use cper_mem_err_location(), why don't you simply use it
> directly?
> 
> And so on and so on...

Well, Robert suggested me add a unification patch[1] so that we could review
the changes more clearly. I think it makes sense.

	It is not really duplicate yet, changes are slightly different which
	could trigger problems in some parsers. At least those differences
	should be listed in the patch description. I would rather remove the
	'space' delimiter after the colon and take the ghes version of it as
	logs become harder to read. So ideally there is a unification patch
	before the "duplication" is removed with changes in both files as
	necessary for review and to document the change.

[1]https://lore.kernel.org/all/Ya9F75xWt%2FIlwcKC@rric.localdomain/
[2]https://lore.kernel.org/lkml/YaZ3yiIBRj6qIg2h@agluck-desk2.amr.corp.intel.com/T/#m8cdf77bee7d20ba094130707363359e765e8459f


Best Regards,
Shuai
