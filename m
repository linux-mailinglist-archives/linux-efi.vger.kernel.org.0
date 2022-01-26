Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2449C334
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 06:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiAZFZg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 00:25:36 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48753 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232517AbiAZFZf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 00:25:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2u0NHN_1643174730;
Received: from 30.240.122.215(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2u0NHN_1643174730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 13:25:31 +0800
Message-ID: <f1e3d27d-3fe1-68e1-7df0-641f2229ab29@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 13:25:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] efi/cper: add cper_mem_err_status_str to decode
 error description
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220125024939.30635-2-xueshuai@linux.alibaba.com>
 <YfBKxGFbRozNdJiD@zn.tnic>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YfBKxGFbRozNdJiD@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

Thank you for your comments.

在 2022/1/26 AM3:08, Borislav Petkov 写道:
> On Tue, Jan 25, 2022 at 10:49:38AM +0800, Shuai Xue wrote:
>> Introduce a new helper function cper_mem_err_status_str() which is used to
>> decode the description of error status, and the cper_print_mem() will call
>> it and report the details of error status.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/firmware/efi/cper.c | 29 ++++++++++++++++++++++++++++-
>>  include/linux/cper.h        |  1 +
>>  2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 6ec8edec6329..7f08d4ea906e 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -211,6 +211,31 @@ const char *cper_mem_err_type_str(unsigned int etype)
>>  }
>>  EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
>>  
>> +const char *cper_mem_err_status_str(u64 status)
>> +{
>> +	switch ((status >> 8) & 0xff) {
>> +	case  1:	return "Error detected internal to the component";
>> +	case  4:	return "Storage error in DRAM memory";
>> +	case  5:	return "Storage error in TLB";
>> +	case  6:	return "Storage error in cache";
>> +	case  7:	return "Error in one or more functional units";
>> +	case  8:	return "component failed self test";
> 
> Well, at least start them all with capital letters: "Component... " And
> yes, I know this is how it is in the spec but the spec has typos and
> other problems - doesn't mean we have to copy them too.

You are right, I will fix it in next version.

>> +	case  9:	return "Overflow or undervalue of internal queue";
>> +	case 16:	return "Error detected in the bus";
>> +	case 17:	return "Virtual address not found on IO-TLB or IO-PDIR";
>> +	case 18:	return "Improper access error";
>> +	case 19:	return "Access to a memory address which is not mapped to any component";
>> +	case 20:	return "Loss of Lockstep";
>> +	case 21:	return "Response not associated with a request";
>> +	case 22:	return "Bus parity error - must also set the A, C, or D Bits";
>> +	case 23:	return "Detection of a PATH_ERROR ";
> 
> Trailing space here.

Sorry, will delete it.

> Also what is PATH_ERROR?
> 
> That "PATH_ERROR" is nowhere else explained in that big fat UEFI spec.
> 2558 pages and they can't explain *that*. Geez.

I don't know either. A related item I found is "iSCSI Device Path error".
Section 10 defines the device path protocol, but I don't know if "PATH_ERROR"
means the path of the device is not found, or something else.

>> +	case 25:	return "Bus operation timeout";
>> +	case 26:	return "A read was issued to data that has been poisoned";
>> +	default:	return "reserved";
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(cper_mem_err_status_str);
>> +
>>  static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>>  {
>>  	u32 len, n;
>> @@ -334,7 +359,9 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>>  		return;
>>  	}
>>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
>> -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
>> +		printk("%s""error_status: %s (0x%016llx)\n",
> 
> Why do you insist on having two back-to-back strings instead of one
> here?
> 
> (And don't tell me it is because the other function calls here do it
> too.)
> 
> FWIW, even checkpatch complains here:
> 
> WARNING: Consecutive strings are generally better as a single string
> #87: FILE: drivers/firmware/efi/cper.c:362:
> +               printk("%s""error_status: %s (0x%016llx)\n",
> 
> Btw, please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.

Sorry, I did integrate scripts/checkpatch.pl before sending patch. And as you see,
other function calls here do the same, so I ignored the warnings. I will change as
your comments in next version:

-		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
+		printk("%s error_status: %s (0x%016llx)\n",


Best regards,
Shuai
