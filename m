Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07F4EE825
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 08:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiDAGWD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbiDAGWC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 02:22:02 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC111987A;
        Thu, 31 Mar 2022 23:20:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V8o8chS_1648794008;
Received: from 30.240.122.30(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V8o8chS_1648794008)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Apr 2022 14:20:10 +0800
Message-ID: <f0053246-10b8-4fb9-6cc1-5db9e797b1d0@linux.alibaba.com>
Date:   Fri, 1 Apr 2022 14:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v7 0/3] EDAC/ghes: refactor memory error reporting to
 avoid code duplication
Content-Language: en-US
To:     bp@alien8.de, rric@kernel.org
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220308144053.49090-1-xueshuai@linux.alibaba.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220308144053.49090-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Borislav,

在 2022/3/8 PM10:40, Shuai Xue 写道:
> ghes_edac_report_mem_error() in ghes_edac.c is a Long Method and have
> Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
> cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
> cper_print_mem() in drivers/firmware/efi/cper.c only reports the error
> status and misses its description.
> 
> This patch set is to refactor ghes_edac_report_mem_error with:
> 
> - Patch 01 is to wrap up error status decoding logics and reuse it in
>     cper_print_mem().
> - Patch 02 is to introduces cper_*(), into ghes_edac_report_mem_error(),
>   this can avoid bunch of duplicate code lines;
> - Patch 03 is to improve report format  
> 
> Changes since v6:
> - Rework patch 02 by Borislav Petkov
> - add patch 03 to improve format
> - Link: https://lore.kernel.org/r/20220303122626.99740-3-xueshuai@linux.alibaba.com
>   
> Changes since v5:
> - Delete change summary in commit log
> - Link: https://lore.kernel.org/all/20220126081702.55167-1-xueshuai@linux.alibaba.com/
> - Thanks Borislav Petkov for review comments.
> 
> Changes since v4:
> - Fix alignment and format problem
> - Link: https://lore.kernel.org/all/20220125024939.30635-1-xueshuai@linux.alibaba.com/
> 
> Changes since v3:
> 
> - make cper_mem_err_status_str table a lot more compact
> - Fix alignment and format problem
> - Link: https://lore.kernel.org/all/20220124024759.19176-1-xueshuai@linux.alibaba.com/
> 
> Changes since v2:
> 
> - delete the unified patch
> - adjusted the order of patches
> - Link: https://lore.kernel.org/all/20211210134019.28536-1-xueshuai@linux.alibaba.com/
> 
> Changes since v1:
> 
> - add a new patch to unify ghes and cper before removing duplication.
> - document the changes in patch description
> - add EXPORT_SYMBOL_GPL()s for cper_*()
> - document and the dependency and add UEFI_CPER dependency explicitly
> - Link: https://lore.kernel.org/all/20211207031905.61906-2-xueshuai@linux.alibaba.com/
> 
> Shuai Xue (3):
>   efi/cper: add cper_mem_err_status_str to decode error description
>   EDAC/ghes: Unify CPER memory error location reporting
>   efi/cper: reformat CPER memory error location to more readable
> 
>  drivers/edac/Kconfig        |   1 +
>  drivers/edac/ghes_edac.c    | 200 +++++++-----------------------------
>  drivers/firmware/efi/cper.c |  64 ++++++++----
>  include/linux/cper.h        |   3 +
>  4 files changed, 87 insertions(+), 181 deletions(-)


Ping. I am wondering if you have any comments on this series of patches?

Best Regards,
Shuai
