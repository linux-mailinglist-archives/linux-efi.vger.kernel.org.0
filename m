Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5135D6B703B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 08:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCMHqJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMHqI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 03:46:08 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD34B81B
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678693559; bh=NFysSKVE1wf9oW0oIK6Ge70/Iljd0kpG6RDJOod3Ebc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c44oaVBiBrQ929NTBEKPUZ3u/g4f3awfMt2LgWbdXuNxB99v1Ul42FzkRwLsyZ2RD
         l9gx9GCTacUG9KK8/IQm5WRcIzKrXVyU4Fzch4jj4dYzui/EAwZNHs68A06sU0Yjwh
         HIQWqRl4LucvQOu2iC6WX4PLQpvzu1uc25uif6Ys=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3E785600CE;
        Mon, 13 Mar 2023 15:45:59 +0800 (CST)
Message-ID: <4126d5a2-8752-d79c-18fc-c9342996730b@xen0n.name>
Date:   Mon, 13 Mar 2023 15:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] efi: libstub: Always pass screen_info via config table
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20230312225838.3702574-1-ardb@kernel.org>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230312225838.3702574-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2023/3/13 06:58, Ard Biesheuvel wrote:
> In some cases, we expose the kernel's struct screen_info to the EFI stub
> directly, so it gets populated before even entering the kernel.  This
> means the early console is available as soon as the early param parsing
> happens, which is nice. It also means we need two different ways to pass
> this information, as this trick only works if the EFI stub is baked into
> the core kernel image, which is not always the case.
> 
> Huacai reports that the preparatory refactoring that was needed to
> implement this alternative method for zboot resulted in a non-functional
> efifb earlycon for other cases as well, due to the reordering of the
> kernel image relocation with the population of the screen_info struct,
> and the latter now takes place after copying the image to its new
> location, which means we copy the old, uninitialized state.
> 
> To fix this and simplify things at the same time, let's just always use
> the config table method.
> 
> Cc: loongarch@lists.linux.dev
> Cc: Xuefeng Li <lixuefeng@loongson.cn>
> Cc: Xuerui Wang <kernel@xen0n.name>
> Cc: loongson-kernel@lists.loongnix.cn
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@loongson.cn/
> Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/arm64/kernel/image-vars.h             |  1 -
>   arch/loongarch/kernel/image-vars.h         |  1 -
>   arch/riscv/kernel/image-vars.h             |  1 -
>   drivers/firmware/efi/libstub/efi-stub.c    |  9 ---------
>   drivers/firmware/efi/libstub/screen_info.c | 19 -------------------
>   5 files changed, 31 deletions(-)
> 

The cleanup looks good to me, thanks!

I'm currently unable to verify though, because my loongarch box 
currently has an RX 6400 plugged in which won't get initialized by the 
firmware (likely related to newer x86 emulation capability required by 
the card's VBIOS) so I can't see the efifb. I'll swap that card out 
maybe this week to test this (and the other "Reprobe after parsing 
config tables" patch) though!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

