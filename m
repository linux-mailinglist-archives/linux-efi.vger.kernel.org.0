Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2249C643
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiAZJ0H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 04:26:07 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51475 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239089AbiAZJ0G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 04:26:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2ucTth_1643189162;
Received: from 30.240.122.215(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2ucTth_1643189162)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 17:26:03 +0800
Message-ID: <8d89ffe0-6e34-a82d-09f0-9dd803fc256f@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 17:26:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/2] EDAC/ghes: refactor memory error reporting to
 avoid code duplication
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220126081702.55167-1-xueshuai@linux.alibaba.com>
 <YfEEN0ATgS+TakLV@zn.tnic>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YfEEN0ATgS+TakLV@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

在 2022/1/26 PM4:20, Borislav Petkov 写道:
> On Wed, Jan 26, 2022 at 04:17:00PM +0800, Shuai Xue wrote:
>> ghes_edac_report_mem_error() in ghes_edac.c is a Long Method and have
>> Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
>> cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
>> cper_print_mem() in drivers/firmware/efi/cper.c only reports the error
>> status and misses its description.
> 
> Dude, what about
> 
> 	wait for a week or until the patchset has been fully reviewed
> 
> don't you understand?!
> 
> Please let me know what about the review process is not clear to you so
> that we can document it better.

Emmm, when I received your replied email, I thought you had fully reviewed them. So
I work to address your comments and reply as soon as possible. Sorry, I misunderstood.

Of course, I can wait. As I said before, take your time.

By the way, I have a question about review process: after waiting for a period
of time, how can I tell whether you have no comments or are still in review process?

Best Regards,
Shuai
