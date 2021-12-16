Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86534477243
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 13:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhLPMyW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 07:54:22 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42992 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236990AbhLPMyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 07:54:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V-oyp.9_1639659256;
Received: from 30.240.114.88(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V-oyp.9_1639659256)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 20:54:18 +0800
Message-ID: <74ea4177-b8b7-d60a-d468-d317b389aedd@linux.alibaba.com>
Date:   Thu, 16 Dec 2021 20:54:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 0/3] ghes_edac: refactor memory error reporting to
 avoid code duplication
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, ardb@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi folks,

On 2021/12/10 PM9:40, Shuai Xue wrote:
> ghes_edac_report_mem_error() in ghes_edac.c is Long Method and have
> Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
> cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
> cper_print_mem() in drivers/firmware/efi/cper.c only reports the error
> status and misses its description.
> 
> This patch set is to refactor ghes_edac_report_mem_error with:
> 
> - Patch 01 is to unify memory error report format with cper;
> - Patch 02 is to introduces cper_*(), into ghes_edac_report_mem_error(),
>   this can avoid bunch of duplicate code lines;
> - Patch 02 is to wrap up error status decoding logics and reuse it in
>     cper_print_mem().
> 
> Changes since v1:
> https://lore.kernel.org/all/20211207031905.61906-2-xueshuai@linux.alibaba.com/
> 
> - add a new patch to unify ghes and cper before removing duplication.
> - document the changes in patch description
> - add EXPORT_SYMBOL_GPL()s for cper_*()
> - document and the dependency and add UEFI_CPER dependency explicitly
> Thanks Robert Richter for review comments.
> 
> Shuai Xue (3):
>   ghes_edac: unify memory error report format with cper
>   ghes_edac: refactor memory error location processing
>   ghes_edac: refactor error status fields decoding
> 
>  drivers/edac/Kconfig        |   1 +
>  drivers/edac/ghes_edac.c    | 196 +++++++-----------------------------
>  drivers/firmware/efi/cper.c |  86 ++++++++++++----
>  include/linux/cper.h        |   3 +
>  4 files changed, 105 insertions(+), 181 deletions(-)
> 

I am wondering if you have any comments on this series of patches?

Best Regards,
Shuai
