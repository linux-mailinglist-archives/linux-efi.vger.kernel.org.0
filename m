Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699B049D80C
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jan 2022 03:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiA0C2f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 21:28:35 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33118 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbiA0C2d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 21:28:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2xgVBs_1643250509;
Received: from 30.240.124.63(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2xgVBs_1643250509)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Jan 2022 10:28:30 +0800
Message-ID: <69183787-0a18-2d49-08c5-ca6e93c87b3a@linux.alibaba.com>
Date:   Thu, 27 Jan 2022 10:28:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/2] EDAC/ghes: refactor memory error reporting to
 avoid code duplication
Content-Language: en-US
To:     Boris Petkov <bp@alien8.de>
Cc:     rric@kernel.org, mchehab@kernel.org,
        zhangliguang@linux.alibaba.com, tony.luck@intel.com,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, ardb@kernel.org,
        linux-kernel@vger.kernel.org, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220126081702.55167-1-xueshuai@linux.alibaba.com>
 <YfEEN0ATgS+TakLV@zn.tnic>
 <8d89ffe0-6e34-a82d-09f0-9dd803fc256f@linux.alibaba.com>
 <5D5735C8-3922-49D9-9DD0-605746B5CCE4@alien8.de>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <5D5735C8-3922-49D9-9DD0-605746B5CCE4@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

在 2022/1/26 PM6:16, Boris Petkov 写道:
> On January 26, 2022 9:26:01 AM UTC, Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>> By the way, I have a question about review process: after waiting for a period
>> of time, how can I tell whether you have no comments or are still in review process?
>>
> 
> A good sign for when review is done is to wait to see replies to every patch.
> 
> BUT, there are other people on CC too so they would need to get a chance to have a look too.
> 
> Regardless, you wait for a week and then you incorporate all review comments and resend - not before.
> 
> This constant spamming with the patchset is not productive. You're not the only one who sends patches and wants review - you should consider that there are others who would need to get reviewed too.

Got it. Thank you very much.

Best Regards,
Shuai
