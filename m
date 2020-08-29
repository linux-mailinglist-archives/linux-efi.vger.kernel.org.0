Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E093F2569A7
	for <lists+linux-efi@lfdr.de>; Sat, 29 Aug 2020 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgH2SVK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Aug 2020 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SVI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Aug 2020 14:21:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD04C061236;
        Sat, 29 Aug 2020 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wM+3aUTCfqWWlQ1tJHVnOtNIBFAHIEvD/50Kk8jfavo=; b=MxZoREBsaBXG6+jt9ukV047v5Q
        XxKgvNn4fbCZZ14UAO7X0JIWw4Rkdqw87w7xo91fqNDwEae81IntJ9bQmzZH5vLAeaABDngfPIIWO
        Z4gI+dq8a8qu/Ezvmcs52pX52VRnNp/aTGZyZzCBNIR6y85WRcW09ga12FU4InFdcA5x+7UgsevZn
        qnXPfXWsrOT7j7Ilkd+TlmXqakOeskDPfMUlFeT1AwvjmpIjkqHcJEvmS3mLcAMLyPxoVY2LigNvn
        kga8QessGsBG3qdRJz6WkJhNno2tu1+yDN/R6y3NZGtaP2EohcVR+XbvWJn1MtJmMCw6BQEU77B96
        RO2HVuBQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC5TL-0007at-2k; Sat, 29 Aug 2020 18:21:03 +0000
Subject: Re: [PATCH 2/3] ia64: remove unneeded header includes from
 <asm/mca.h>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200829051524.706585-1-masahiroy@kernel.org>
 <20200829051524.706585-3-masahiroy@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3dabd8d-352f-7471-3e4a-4d24d74e715b@infradead.org>
Date:   Sat, 29 Aug 2020 11:20:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200829051524.706585-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/28/20 10:15 PM, Masahiro Yamada wrote:
> <asm/mca.h> includes too many unneeded headers.
> 
> This commit cuts off a lot of header includes.
> 
> What we need to include are:
> 
>  - <linux/percpu.h> for DECLARE_PER_CPU(u64, ia64_mca_pal_base)
>  - <linux/threads.h> for NR_CPUS
>  - <linux/types.h> for u8, u64, size_t, etc.
>  - <asm/ptrace.h> for KERNEL_STACK_SIZE
> 
> The other header includes are actually unneeded.
> 
> <asm/mca.h> previously included 436 headers, and now it includes
> only 138. I confirmed <asm/mca.h> is still self-contained.

Nice!

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> 
>  arch/ia64/include/asm/mca.h | 9 +++------
>  arch/ia64/kernel/efi.c      | 1 +
>  arch/ia64/kernel/mca.c      | 1 +
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 


thanks.
-- 
~Randy

