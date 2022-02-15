Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24EF4B783B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiBOQ5f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 11:57:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbiBOQ5c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 11:57:32 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A161106CAF;
        Tue, 15 Feb 2022 08:57:22 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso23927123oon.5;
        Tue, 15 Feb 2022 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=5d7WVUUfZAnPeTJZvnrGfhbC4/1fj7LtJSpw7xhtIaY=;
        b=EWRB6XePt/v8KpbSsv6/xc/qmK7tm4os0aOnlYc8LQx8p3e6Yl1zvQoVSCO+QvnIVw
         gjm2/kB85UN/wmCZx7IA4rgI4T7cEPgFlQw/XccC6788kNWMnlaFuJ+Xz8yHyvnhMzwz
         N94GBKqPJz25G6syi6gKMRMw9Zko0gBD/Ql4LdS6naHdg/ujdhJEUQlW1CZwBnqiYvNI
         rEBRe6tevbc/OwrufUZmVXPkc0ed4v+dpzitdbexzt3wJIP8cc8aQXJee4NmGwaOmTv3
         YvLdg+cs6Qa/dZVgFF/Vn+Zqy7zM1NoXxbP5JXwXSlZeu9mFQUPA43g86KbMI76MvL+x
         ShHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=5d7WVUUfZAnPeTJZvnrGfhbC4/1fj7LtJSpw7xhtIaY=;
        b=ddzM2RhhHbVTtrgSLRGHBggEcuhCHhFCkzI2nrZu8MfYKHolawayHqiyLMgMeujpG8
         gRMG4nmiKqB02jZyviHDppNnEdGtCKpMSncHhFuoJuAauxvs1I9vDxex8gQvmJ884lop
         vVcgBLE6+sMJUZ5dyzAjy3Jp96dbxP6Epz17N5LgO8Ei/wmotp1f3unGcZ3XlEmrwrTK
         pDvxf4Y5ZMZyPC5TdK2Apv36yCwEzLQUVrmJd33TnUNPnfh/3+Qg6C8tesnM5Vi0a0Eg
         oHQsVjbcUjEJ3wPBeliyeFGxW0IJQVamyk2CJLzCMRHx0UmRxfjQS9IfBAVgEuAOdPZy
         7Bxw==
X-Gm-Message-State: AOAM530VPLZuLMap3nQIINj1joARvkDaaYh1Bo7NwbRisbBfdvACpmIL
        UrIlbN4f2CcYz83CCGbyVpM=
X-Google-Smtp-Source: ABdhPJz1IMJYE7Ar8+Qo06GAHwDrKQqOi7lZCysHqnpFMFJRwtB5IIxSckXafM8ST1fDXrqQbpECJQ==
X-Received: by 2002:a05:6870:a603:: with SMTP id e3mr1792271oam.87.1644944240995;
        Tue, 15 Feb 2022 08:57:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14sm14255468otk.77.2022.02.15.08.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:57:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <be9cc279-1d62-3d57-9347-6cfaffc00cb4@roeck-us.net>
Date:   Tue, 15 Feb 2022 08:57:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N> <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com>
 <489b76f9-fbaf-dae0-c90d-c52ee0de92a4@roeck-us.net>
 <YgvAO1UbZcbcj5na@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
In-Reply-To: <YgvAO1UbZcbcj5na@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/15/22 07:01, Krzysztof Adamski wrote:
> Dnia Tue, Feb 15, 2022 at 06:30:26AM -0800, Guenter Roeck napisał(a):
>> On 2/15/22 00:44, Alexander Sverdlin wrote:
>>> Hello Mark, Ard,
>>>
>>> On 01/02/2022 14:58, Mark Rutland wrote:
>>>>> You could argue that restart handlers were not created for that but they
>>>>> suit this purpose ideally and it wouldn't make much sense (in my
>>>>> opinion) to add yet another notifier chain that would run before reset
>>>>> notifiers, for code that is not supposed to reset the whole system and
>>>>> this is exacly what I would have to do if efi_reboot() is forced to be
>>>>> called before all handlers.
>>>>
>>>> As above, I think that's just using the wrong interface, and the reboot
>>>> notifier mechanism *already* exists, so I'm really confused here.
>>>>
>>>> Have I misunderstood what you're trying to achieve?
>>>>
>>>> Is there some problem with the reboot notifier mechanism that I am unaware of?
>>>> e.g. do we bypass them in some case where you think they're needed?
>>>>
>>>> Are you simply unaware of reboot notifiers?
>>>
>>> Could you please check the simple case of pwrseq_emmc.c?
>>>
>>> While that's currently the only example of this kind upstream I can imagine
>>> further use-cases, especially in storage area like above.
>>>
>>> Would you suggest it's illegal usage of register_restart_handler()?
>>> Do we need to fix pwrseq_emmc.c by introducing new atomic notifier chain
>>> which will be called before restart handlers, so that it works on
>>> emergency_restart()?
>>>
>>
>> Abuse isn't just about using an API for something it isn't originally intended
>> for, abuse is also to intentionally _not_ use an API, as it is currently done
>> by the EFI restart code for arm64. Also, keep in mind that the same argument
>> (our restart handler _must_ be executed under all circumstances and does therefore
>> not use the restart API) is likely going to be used again in the future. All
>> it takes is for some other standard (or chip vendor, for that matter) to declare
>> their restart handler mandatory if present.
> 
> Wait, but it is up to us to decide if we want to follow such standard or
> not. If we want to have code that is more flexible, nobody can refuse us
> to do so, right? None of the standards says that we can't support
> restart handlers in case of EFI on ARM64, it was decided by kernel
> developers, not some vendors. We can change that.
> 

Of course it was decided by kernel developers. Point is that they use
the EFI standard as argument for bypassing the API. What I am saying is
that others can (and likely will, since the flood doors have been opened)
do the same in the future, using the same line of arguments.

>> Given that, I'd suggest to cut your losses and try to find another
>> solution for your problem. That may be to introduce yet another API,
>> one that is called before the EFI restart handling but that is always
>> called, unlike reboot notifiers, or simply stick with out-of-tree code.
> 
> Sure I could create yet another API like you suggest but in practice it
> would be a copy of existing API as i would have to work exactly the
> same - would be called at the same time in the same situations. The only
> thing that would be different would be separate chain.

Correct.

> But if we want to prevent registering some custom code to be run before > efi_reboot(), that new API would have to be rejected as well, for the
> same reason. So what is the point?
> 

Ah, yes, you are right. The emmc example does reset the emmc, after all,
which one could use as argument that it "violates" the EFI mandate.
Sorry, I guess you'll be stuck with out-of-tree code (and, realistically,
so is everyone using emmc in an arm64 based system with an EFI restart
handler which does not implement emmc reset). Actually, turns out that
the emmc restart handling code is not reliable anyway, since for example
x86 doesn't use/support the restart handler call chain, and neither
do several other architectures.

Interestingly, in this context, x86 isn't as inflexible as arm64 and does
support other means to reset the system even in the presence of EFI
(and actually seems to prefer ACPI reset over EFI reset unless I
misunderstand the code).

Other options for you might be to disable EFI restart handling in your
system (assuming that is possible), or to implement the necessary code
as part of the EFI restart handler, ie outside Linux, again if that is
possible.

Guenter
