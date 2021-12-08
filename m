Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2946D22A
	for <lists+linux-efi@lfdr.de>; Wed,  8 Dec 2021 12:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhLHLbV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Dec 2021 06:31:21 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41746 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhLHLbV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Dec 2021 06:31:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UztZwXh_1638962865;
Received: from 30.240.125.66(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UztZwXh_1638962865)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Dec 2021 19:27:46 +0800
Message-ID: <0cbb21bf-ff3b-2301-da0d-c7767589dbcd@linux.alibaba.com>
Date:   Wed, 8 Dec 2021 19:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ghes_edac: refactor error status fields decoding
Content-Language: en-US
To:     Robert Richter <rric@kernel.org>
Cc:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
 <20211207031905.61906-3-xueshuai@linux.alibaba.com>
 <Ya9JxfyXYYNtLoSf@rric.localdomain>
 <662eff5c-8c53-8035-cae0-99448734406c@linux.alibaba.com>
 <YbCN3yXUVsCgP+x7@rric.localdomain>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YbCN3yXUVsCgP+x7@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dear, Robert,

Thank you for your reply.

On 2021/12/8 PM6:50, Robert Richter wrote:
> On 07.12.21 21:20:25, Shuai Xue wrote:
> 
>>>> --- a/include/linux/cper.h
>>>> +++ b/include/linux/cper.h
>>>> @@ -568,7 +568,8 @@ void cper_print_proc_arm(const char *pfx,
>>>>  			 const struct cper_sec_proc_arm *proc);
>>>>  void cper_print_proc_ia(const char *pfx,
>>>>  			const struct cper_sec_proc_ia *proc);
>>>> -int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
>>>> -int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
>>>> +int cper_mem_err_location(const struct cper_mem_err_compact *mem, char *msg);
>>>> +int cper_dimm_err_location(const struct cper_mem_err_compact *mem, char *msg);
>>>
>>> Do we really need that 'const' here?
>> I think we do. It is read only and should not be modified in these functions,
>> just as cper_print_proc_arm' style.
> 
> Even if it is used read-only I don't see a real need for const here.
> So let's change this only if there is a reason such as avoiding
> unnecessary casts.
I will change it back to the original.


>>>> +const char *cper_mem_err_status_str(u64 status);
>>>
>>> The function i/f is different compared to the others, though the
>>> purpose is the same. Let's use same style:
>>>
>>>  int cper_mem_err_status(const struct cper_mem_err_compact *mem, char *msg);
>> Sorry, I don't catch it. cper_mem_err_status_str() decodes the error status and return
>> a string, the same style as cper_severity_str and cper_mem_err_type_str do. May
>> we need to move the declaration ahead with cper_severity_str?
> 
> Right, move it after cper_mem_err_type_str(). Looks good then.
OK, will change it in next send.

Thanks.

Shuai
