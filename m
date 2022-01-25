Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8249B361
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jan 2022 12:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377526AbiAYL4T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 06:56:19 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53432 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382406AbiAYLtx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 06:49:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2qSlR6_1643111382;
Received: from 30.240.125.206(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2qSlR6_1643111382)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jan 2022 19:49:43 +0800
Message-ID: <0e156b79-6343-72b2-47fb-baa29ffe60fd@linux.alibaba.com>
Date:   Tue, 25 Jan 2022 19:49:41 +0800
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
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Ye/PLDlOBhYmGb5D@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

Thank you for your reply.

I am sorry if you feel the RESEND tag is pushing you.

Take your time, I will be more patient :)

Best Regards,
Shuai

在 2022/1/25 PM6:21, Borislav Petkov 写道:
> On Tue, Jan 25, 2022 at 10:45:31AM +0800, Shuai Xue wrote:
>> I will fix it in next version.
> 
> Yes, thanks.
> 
> However, you don't have to resend immediately but wait instead until
> people have had time to review the whole thing. And while you're
> waiting, you can read through Documentation/process/...
> 
> There are passages like the following one, for example:
> 
> "Don't get discouraged - or impatient
> ------------------------------------
> 
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
> 
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> one week before resubmitting or pinging reviewers - possibly longer during
> busy times like merge windows.
> 
> It's also ok to resend the patch or the patch series after a couple of
> weeks with the word "RESEND" added to the subject line::
> 
>    [PATCH Vx RESEND] sub/sys: Condensed patch summary
> 
> Don't add "RESEND" when you are submitting a modified version of your
> patch or patch series - "RESEND" only applies to resubmission of a
> patch or patch series which have not been modified in any way from the
> previous submission."
> 
