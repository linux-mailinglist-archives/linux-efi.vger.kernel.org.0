Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD224821AA
	for <lists+linux-efi@lfdr.de>; Fri, 31 Dec 2021 04:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhLaDEO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 22:04:14 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56869 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241168AbhLaDEN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 22:04:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V0OKTNs_1640919848;
Received: from 30.240.117.58(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V0OKTNs_1640919848)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Dec 2021 11:04:10 +0800
Message-ID: <ae865b5e-f385-6aac-2838-cb76b82df68c@linux.alibaba.com>
Date:   Fri, 31 Dec 2021 11:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/3] ghes_edac: unify memory error report format with
 cper
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20211210134019.28536-2-xueshuai@linux.alibaba.com>
 <YctFli9oMBYTlf7h@zn.tnic>
 <9e0bf7c0-ed50-5b0b-0576-3651249ba5cd@linux.alibaba.com>
 <Yc3y+uVEcAFgTE5x@zn.tnic>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Yc3y+uVEcAFgTE5x@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

Thank you for your comments.

在 2021/12/31 AM1:57, Borislav Petkov 写道:
> On Wed, Dec 29, 2021 at 11:22:11AM +0800, Shuai Xue wrote:
>> Yep, these fields are unpopulated by BIOS, I manually enable all Validation
>> Bits for debug so that we see the difference more clearly. I will declare it
>> in next version.
> 
> Declare what? I can't parse your statement.

The ghes_edac log message is printed only when a validation bit is set, e.g.:

	if (mem_err->validation_bits & CPER_MEM_VALID_NODE)
		p += sprintf(p, "node:%d ", mem_err->node);

Not all bits are populated by BIOS in my platform, I manually enable all
validation bits during test so that we can see log message and differences of all
fields more clearly.

	+ 	mem_err->validation_bits = 0xfffffffffffffff;

>> Well, the purpose is not to improve but unify.
> 
> The most importang goal with kernel code is improvement and less bugs.
> Unification is second. We should not jump through hoops and unify at
> every price just because there's a duplicated function somewhere.
> Remember that when doing your changes.

I see. Thank you.

>> Well, Robert suggested me add a unification patch[1] so that we could review
>> the changes more clearly. I think it makes sense.
> 
> Not really. I can imagine why Robert suggested that but this strategy is
> causing unnecessary churn. What one usually does in such cases is:
> 
> 1. Add changes to the target functionality - the one in cper.c - by
> explaining *why* those changes are needed.
> 
> 2. Switch ghes_edac.c to that functionality and remove the redundant one
> there.
> 
> Simple and clean diffstat and easy review.
> 
> Thx.

Got it. I will send next version latter.

Merry Christmas and happy New Year.

Best Regards,
Shuai
