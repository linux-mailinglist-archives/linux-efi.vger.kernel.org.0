Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E1A49B732
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 16:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380312AbiAYPFK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 10:05:10 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52742 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1581208AbiAYPDA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 10:03:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2qsuta_1643122967;
Received: from 30.27.234.82(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2qsuta_1643122967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jan 2022 23:02:49 +0800
Message-ID: <94dababf-76dd-dd9f-61e4-fe05b02f6241@linux.alibaba.com>
Date:   Tue, 25 Jan 2022 23:02:47 +0800
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
 <98aae382-ac38-8811-f147-d00b953f608d@linux.alibaba.com>
 <Ye/PLDlOBhYmGb5D@zn.tnic>
 <0e156b79-6343-72b2-47fb-baa29ffe60fd@linux.alibaba.com>
 <Ye/u/UNqXr1/WUXH@zn.tnic>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Ye/u/UNqXr1/WUXH@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Borislav,

在 2022/1/25 PM8:37, Borislav Petkov 写道:
> On Tue, Jan 25, 2022 at 07:49:41PM +0800, Shuai Xue wrote:
>> I am sorry if you feel the RESEND tag is pushing you.
> 
> It is not pushing me - there are rules, simply. Rules you should read
> first before sending patches.

Got it. I will learn rules first.

> How about I start flooding you a patchset every day?

Haha, I see. I am sorry to bother you and thank you very much for your patient
and valuable comments, just take your time. By the way, after sending patchset
v3 8 days, I resend it yesterday, and the patchset v4 sent today is to address
your comments, not a resend patchset. Anyway, I will be more patient.

> Also, please do not top-post. That's also explained in that
> documentation directory I mentioned. Read about it too pls.

I will, thank you.

Best Regards,
Shuai
