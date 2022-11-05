Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8D61DFA4
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 00:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKEXYl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 19:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKEXYk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 19:24:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6081056C
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 16:24:39 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A720412C9
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667690678;
        bh=P/rgZcAo1+lNmpLkxkcm/ZkBFG4Kx1WV6v8pkRnrGvI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=aF/H6JC2P1xHBtuEZXh6ih5FUdgHA6uBXkQXOHj0EtUR2NqJJ7MWwyLnpnfW8a8dD
         U19cYbVr9t5GXPTHnzu/MY2+rN0UY0bAdArcoi5maCVWab5234CYqADHx0xMHmMsk0
         cVSvs1WvVzcUJaFljaQyttSN2QuiLuIQCYo+X8kYFoyFps18iEXJPRZuQQzoBUj+wE
         Zh7VN9OV8g6DrvLcm1+bjaF/oJtJNScIbEwiYBHdRCkehskPz5ENt+Ptshh75l3bmS
         gyXko6gEBQSsCWNTvOk8qqo5Y8LG+IRe3/h2Gcduvc/MDGO45fRr5rzHWcvdLnh4EB
         vFEaGwEGClKaQ==
Received: by mail-wr1-f71.google.com with SMTP id o13-20020adfa10d000000b00232c00377a0so1945528wro.13
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 16:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/rgZcAo1+lNmpLkxkcm/ZkBFG4Kx1WV6v8pkRnrGvI=;
        b=vECtQR5Kymu/k5LCFtfh9nC/xgccYieSKWUE8ie/g4KJiqcvIg6Mlwy19c2AAS2xkM
         Hhy8e2UAuWuj8Wgb4WyI0Sc+KVNGAQYTczZCGnVcTeGTYGEl18ETvCA6o6Zj3SFYe7Dx
         RHA0TjKgLfk+dkB/40Vd47penSCvQV7wIY2YuHO+/q2o5RXUkSi6ee40+ej9NdQHKmAa
         SJB5tW5WgihXxKoNWAj/tZl3as/7vuMqIpducoeD7lZTpPd+Tsi88U7kJkPCx2JrSj3d
         BkRgREJeUcpIIAf9qK+yxlM6lPWV7BgsUos2lvfEL+pkkm+Cswp4mlV988DyvyQEa52L
         4F/Q==
X-Gm-Message-State: ACrzQf0X69AOcpXuxR/HnVORdYRDZKsIp/hUEDKoX0hHWdxDrA5k9E7F
        VzKTma4iudyIsqlWlDry5K1UEmgx9/+kxmWooZh3UjSjBxGkQ4OqZKpHGnxC82vunzZsW/6YteE
        UJhZ0TpSwfaWDP7siU8Ul9IJpoXByd6hB4QY8zQ==
X-Received: by 2002:a7b:cb81:0:b0:3c0:f8fc:ea23 with SMTP id m1-20020a7bcb81000000b003c0f8fcea23mr38896673wmi.31.1667690676321;
        Sat, 05 Nov 2022 16:24:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6MARusVTOVCnMBzQtDq+Mp+g/YLs8aPXUEbu+UwwYDX7RiQRyNn5KD012wkkBwSLdI4B/eTA==
X-Received: by 2002:a7b:cb81:0:b0:3c0:f8fc:ea23 with SMTP id m1-20020a7bcb81000000b003c0f8fcea23mr38896657wmi.31.1667690676003;
        Sat, 05 Nov 2022 16:24:36 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b0023647841c5bsm3224408wrr.60.2022.11.05.16.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 16:24:35 -0700 (PDT)
Message-ID: <86e2cd39-630a-da76-bbfd-99815a8c2753@canonical.com>
Date:   Sun, 6 Nov 2022 00:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: efi: Make runtime region misalignment warning less
 noisy
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20221105225234.3089177-1-ardb@kernel.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20221105225234.3089177-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/5/22 23:52, Ard Biesheuvel wrote:
> The EFI spec requires that on arm64 systems, all runtime code and data
> regions that share a 64k page can be mapped with the same memory type
> attributes. Unfortunately, this does not take permission attributes into
> account, and so the firmware is permitted to expose runtime code and
> data regions that share 64k pages, and this may prevent the OS from
> using restricted permissions in such cases, e.g., map data regions with
> non-exec attributes.

This is the relevant paragraph in the UEFI specification:

<cite>
The ARM architecture allows mapping pages at a variety of granularities, 
including 4KiB and 64KiB. If a 64KiB physical page contains any 4KiB 
page with any of the following types listed below, then all 4KiB pages 
in the 64KiB page must use identical ARM Memory Page Attributes (as 
described in Map EFI Cacheability Attributes to AArch64 Memory Types):

- EfiRuntimeServicesCode
- EfiRuntimeServicesData
- EfiReserved
- EfiACPIMemoryNVS

Mixed attribute mappings within a larger page are not allowed.
</cite>

It remains unclear if only EFI Cacheability of also other page 
attributes are meant. The UEFI specification should be clarified in this 
respect.

> 
> We currently emit a warning when hitting this at boot, but the warning
> is problematic for a number of reasons:
> - it uses WARN() which spews a lot of irrelevant information into the
>    log about the execution context where the issue was detected;
> - it only takes the start of the region into account and not the size

Is the occurrence of the warning specific to U-Boot or do you see the 
warning with EDK II too?

> 
> Let's just drop the warning, as the condition does not strictly violate
> the spec (although it only occurs with U-Boot), and fix the check to
> take both the start and the end addresses into account.
> 
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/arm64/kernel/efi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index e1be6c429810d0d5..3dd6f0c66f8aeb78 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -25,8 +25,8 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
>   	if (type == EFI_MEMORY_MAPPED_IO)
>   		return PROT_DEVICE_nGnRE;
>   
> -	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
> -		      "UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?"))
> +	if (!PAGE_ALIGNED(md->phys_addr) ||
> +	    !PAGE_ALIGNED(md->num_pages * EFI_PAGE_SIZE))

Enhancing the check is correct.

The warning tells that Linux cannot establish secure settings for some 
pages. It would be preferable to keep it and fix the UEFI specification 
and the firmware instead.

Best regards

Heinrich

>   		/*
>   		 * If the region is not aligned to the page size of the OS, we
>   		 * can not use strict permissions, since that would also affect
