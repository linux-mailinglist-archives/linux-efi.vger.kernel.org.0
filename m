Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67D4B6EE8
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiBOOao (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 09:30:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbiBOOam (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 09:30:42 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7835EEA73;
        Tue, 15 Feb 2022 06:30:30 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o23so1450384oie.10;
        Tue, 15 Feb 2022 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=o8JsroBWHtIyrUhOn7dBaIXgVTUEl2NPmoZI9J5M7E4=;
        b=ifEIW3QyLIEZKOFGn1FWXIry5z0Qay9I8omD8m3/vwpHfFyn/gHzJv/UwFDjNCbHOy
         VO3/TxAvNOcLKNwOW0g44qaSAg/Y0X5hIzOy7p7RUsGHVxqxXpvGFhUpuCLGL7Ikt5kO
         hEfNdVggmT/piyRxBhNbeFU5rcnpi/lJyv2rpYOPfmCLvd1ECK58o9Xb1bQnNW4aAg7P
         494In7Sosgo8F9jjLzFOZ712RSjGjA1/FgazyRROU/nZMfqB+/0rNDUcFqwjFZWZEG4W
         jCfhjvBgm6/lCZrdin3d84fC/Py4V3LOgv8HO0S/0r4087uvBxOidGkL7nTntuywYh9Q
         N+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=o8JsroBWHtIyrUhOn7dBaIXgVTUEl2NPmoZI9J5M7E4=;
        b=2Nj5K7/8asei1ur660gNBe2kKEc21hMwTk9k7wQhGLqhLjacXU7hQ9/C4FjlRay2hp
         OqEDB5Jr5xh62nYhKOR53FKn74aaBTWK2/Biid8vpzLFgC/bYUnBSLsp8hotVYk2kbUZ
         ZTglIojYxXn0n55cl5BQxtPCsZ0ed85V+nognISragvX9z1cVrHDGct1xzxD69DrfirC
         4iKI8ptRWxQbpb0A5c2U+kpBaWZ4f7s2UhfuT5Ksa1FwzZfJL1SFJ3ehS134ryW2O1Ci
         8NR2cjqqFpsOGT6ulB2vQTSSyzybHJHxg9DhbiqfqG0jvFc5CkzwgYdksyBFhQf2ZJg7
         1tDw==
X-Gm-Message-State: AOAM531oxvgv97kjVNkgrM+saIvxXOD+4Bl930RBc5tacmv+ezvhUGDM
        V3F6U6hXwxlX0sgWGgYb6ns=
X-Google-Smtp-Source: ABdhPJwgF72oQR19E3uWYYaiJfKoD2vkjQwg+o0A+S/ZSkYjnRF039u9W2p4p8TBAT9ywgIuTXH7OQ==
X-Received: by 2002:a05:6808:1644:b0:2cd:6d80:9af1 with SMTP id az4-20020a056808164400b002cd6d809af1mr1709630oib.138.1644935429995;
        Tue, 15 Feb 2022 06:30:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l1sm13761263otd.18.2022.02.15.06.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:30:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <489b76f9-fbaf-dae0-c90d-c52ee0de92a4@roeck-us.net>
Date:   Tue, 15 Feb 2022 06:30:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        linux-efi@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N> <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
In-Reply-To: <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/15/22 00:44, Alexander Sverdlin wrote:
> Hello Mark, Ard,
> 
> On 01/02/2022 14:58, Mark Rutland wrote:
>>> You could argue that restart handlers were not created for that but they
>>> suit this purpose ideally and it wouldn't make much sense (in my
>>> opinion) to add yet another notifier chain that would run before reset
>>> notifiers, for code that is not supposed to reset the whole system and
>>> this is exacly what I would have to do if efi_reboot() is forced to be
>>> called before all handlers.
>>
>> As above, I think that's just using the wrong interface, and the reboot
>> notifier mechanism *already* exists, so I'm really confused here.
>>
>> Have I misunderstood what you're trying to achieve?
>>
>> Is there some problem with the reboot notifier mechanism that I am unaware of?
>> e.g. do we bypass them in some case where you think they're needed?
>>
>> Are you simply unaware of reboot notifiers?
> 
> Could you please check the simple case of pwrseq_emmc.c?
> 
> While that's currently the only example of this kind upstream I can imagine
> further use-cases, especially in storage area like above.
> 
> Would you suggest it's illegal usage of register_restart_handler()?
> Do we need to fix pwrseq_emmc.c by introducing new atomic notifier chain
> which will be called before restart handlers, so that it works on
> emergency_restart()?
> 

Abuse isn't just about using an API for something it isn't originally intended
for, abuse is also to intentionally _not_ use an API, as it is currently done
by the EFI restart code for arm64. Also, keep in mind that the same argument
(our restart handler _must_ be executed under all circumstances and does therefore
not use the restart API) is likely going to be used again in the future. All
it takes is for some other standard (or chip vendor, for that matter) to declare
their restart handler mandatory if present. That means there will be other
non-users of the restart API in the future, and you simply can not rely on it
being used. That was clearly not the intention of the restart API - quite the
opposite - but it is what it is.

Given that, I'd suggest to cut your losses and try to find another solution
for your problem. That may be to introduce yet another API, one that is called
before the EFI restart handling but that is always called, unlike reboot
notifiers, or simply stick with out-of-tree code.

Guenter
