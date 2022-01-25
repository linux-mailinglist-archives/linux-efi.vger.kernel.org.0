Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564F649AAE6
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 05:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385322AbiAYDrU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jan 2022 22:47:20 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50742 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1312859AbiAYCrG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jan 2022 21:47:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2oJpOQ_1643078732;
Received: from 30.240.125.206(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2oJpOQ_1643078732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jan 2022 10:45:33 +0800
Message-ID: <98aae382-ac38-8811-f147-d00b953f608d@linux.alibaba.com>
Date:   Tue, 25 Jan 2022 10:45:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v3 1/2] efi/cper: add cper_mem_err_status_str to
 decode error description
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220124024759.19176-2-xueshuai@linux.alibaba.com>
 <Ye8XMvfXCetzJLTH@zn.tnic>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Ye8XMvfXCetzJLTH@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

Thank you for your valuable comments.

在 2022/1/25 AM5:16, Borislav Petkov 写道:
> On Mon, Jan 24, 2022 at 10:47:58AM +0800, Shuai Xue wrote:
>> Introduce a new helper function cper_mem_err_status_str() which is used to
>> decode the description of error status, and the cper_print_mem() will call
>> it and report the details of error status.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/firmware/efi/cper.c | 46 ++++++++++++++++++++++++++++++++++++-
>>  include/linux/cper.h        |  1 +
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 6ec8edec6329..addafccecd84 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -211,6 +211,49 @@ const char *cper_mem_err_type_str(unsigned int etype)
>>  }
>>  EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
>>  
>> +const char *cper_mem_err_status_str(u64 status)
>> +{
>> +	switch ((status >> 8) & 0xff) {
>> +	case 1:
>> +		return "Error detected internal to the component";
> 
> You can make that table a lot more compact:
> 
>         switch ((status >> 8) & 0xff) {
>         case  1:        return "Error detected internal to the component";
>         case  4:        return "Storage error in DRAM memory";
>         case  5:        return "Storage error in TLB";
>         case  6:        return "Storage error in cache";
>         case  7:        return "Error in one or more functional units";
>         case  8:        return "component failed self test";
>         case  9:        return "Overflow or undervalue of internal queue";
>         case 16:        return "Error detected in the bus";
> 	...
> 
>> +	case 16:
>> +		return "Error detected in the bus";
> 
> And yes, that 16 needs to come before 17, ofc.

I will fix it in next version.

>> @@ -334,7 +377,8 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>>  		return;
>>  	}
>>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
>> -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
>> +		printk("%s""error_status: 0x%016llx, %s\n", pfx, mem->error_status,
>> +				cper_mem_err_status_str(mem->error_status));
> 
> Arguments need to be aligned at opening brace, i.e.:
> 
>                 printk("%s""error_status: 0x%016llx, %s\n",
>                         pfx, mem->error_status, cper_mem_err_status_str(mem->error_status));
> 
> 
> Also, the naked error status number is not as user-friendly when we have
> the decoded string. So the format should be:
> 
>                 printk("%s error_status: %s (0x%016llx)\n",
>                         pfx, cper_mem_err_status_str(mem->error_status), mem->error_status);
> 

Good point. Will fix it.

Best Regard,
Shuai
