Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4D4B34A8
	for <lists+linux-efi@lfdr.de>; Sat, 12 Feb 2022 12:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiBLL2W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Feb 2022 06:28:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiBLL2U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Feb 2022 06:28:20 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17C26AEA;
        Sat, 12 Feb 2022 03:28:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4DXVLp_1644665291;
Received: from 30.240.120.83(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V4DXVLp_1644665291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Feb 2022 19:28:13 +0800
Message-ID: <d26e3f1f-86b0-3638-0e9d-66d893a980b9@linux.alibaba.com>
Date:   Sat, 12 Feb 2022 19:28:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 2/2] EDAC/ghes: use cper functions to avoid code
 duplication
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220126081702.55167-3-xueshuai@linux.alibaba.com>
 <YfU8fW+lLiAgJ9D4@zn.tnic>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YfU8fW+lLiAgJ9D4@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

在 2022/1/29 PM9:09, Borislav Petkov 写道:
> On Wed, Jan 26, 2022 at 04:17:02PM +0800, Shuai Xue wrote:
>> The memory error location processing in ghes_edac_report_mem_error() have
> 
> I will look at this patch again after you have incorporated in all
> review comments from last time:
> 
> https://lore.kernel.org/r/YctFli9oMBYTlf7h@zn.tnic
> 

Happy Chinese New Year. Sorry for getting back to you late. I was on holiday
last weak.

I have try to address your comments in this version. If I missed your comments,
please let me know, thank you.

Best Regards,
Shuai



