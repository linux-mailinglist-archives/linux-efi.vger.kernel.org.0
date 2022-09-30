Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9E5F02AB
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 04:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI3CUT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Sep 2022 22:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiI3CUN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Sep 2022 22:20:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F55E4BD09;
        Thu, 29 Sep 2022 19:20:09 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mdv3M2LHwzWh3Y;
        Fri, 30 Sep 2022 10:15:59 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:20:05 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:20:05 +0800
Message-ID: <fbe66f3b-72b6-b7d3-7af9-fa36db546938@huawei.com>
Date:   Fri, 30 Sep 2022 10:20:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] efi/arm: dump UEFI runtime page tables for ARM
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-kernel@vger.kernel.org>
References: <20220930022410.107297-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220930022410.107297-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

sorry，please ignore it， need to udpate.

On 2022/9/30 10:24, Kefeng Wang wrote:
> UEFI runtime page tables dump only for ARM64 at present,
> but ARM support EFI and ARM_PTDUMP_DEBUGFS now, so enable
> it for ARM too.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> note: build test only.
>   drivers/firmware/efi/arm-runtime.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 3359ae2adf24..e04956ed1b0a 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -25,7 +25,7 @@
>   #include <asm/mmu.h>
>   #include <asm/pgalloc.h>
>   
> -#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
> +#if defined(CONFIG_PTDUMP_DEBUGFS) || defined(CONFIG_ARM_PTDUMP_DEBUGFS)
>   #include <asm/ptdump.h>
>   
>   static struct ptdump_info efi_ptdump_info = {
