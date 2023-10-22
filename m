Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA667D2288
	for <lists+linux-efi@lfdr.de>; Sun, 22 Oct 2023 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJVKRD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Oct 2023 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVKRC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Oct 2023 06:17:02 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EDDE6
        for <linux-efi@vger.kernel.org>; Sun, 22 Oct 2023 03:16:59 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 235ED3FFF0
        for <linux-efi@vger.kernel.org>; Sun, 22 Oct 2023 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697969818;
        bh=gColUGB2JSdwsFjV3ExI1Ly4vT+H+2Kv7wPXR0ErwzI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nA1iJQjBmzlslyUpNOKyJCCSMcBkARErg0J0HIC+kbHpGJTBrH0NEoMHEhC5S8g/H
         jGC/w7l3LCcPwC+FYd3P9t+smYWKS797Uqerqi39USgjwTAAbLb3JnB2V9LDMOVyGB
         xttOahZXw5NRHbyXCutH/ggmc7ZxPVg0SE5k83WFWlyJfLT1zPmqvmS/eY/NOrENvD
         uViXz4ySajkaLiuitSbMkAYM3efczVQZqsI5QxDit6enG/h4GU/UORHqCbVeTxPkQC
         loypEykDAoa4JaEF3Sc4M/4IgRELGwkdUCyDTbpJcYLJu9XHPP3ZX8EtL9qUnfJyoD
         uXms0u2X9wX0A==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe182913c5so13322125e9.0
        for <linux-efi@vger.kernel.org>; Sun, 22 Oct 2023 03:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697969817; x=1698574617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gColUGB2JSdwsFjV3ExI1Ly4vT+H+2Kv7wPXR0ErwzI=;
        b=xPRU9ORWGiyCbLGl5if2yNnOrAldhFvDtvCZduMkorpg4jwpmw0gafTm4JDAZZc7n7
         YYN9RLEKivYRHY0NHurirnsYJuXjE5vdUZZOea2no+TWSuOa15IM5IXf5Yv3/SEP3idl
         k0pftVY55Z4/8tm49lcw1xOwFYQvUeBoJjWStJMRd0fdSg+HvFldy3yKffYlxauZIHg+
         7U+WIOAqoOdnCIwgH7iETAy7up8Ab+LB9yuMH5pG6LSy8E8fjuZsNKBm4JPrf1jSFXmJ
         Q+eProCWvyNEtR9jqWj0DebJIFszjci8zwOWkYiqlEFxU4Edmf1Yq0JGFrr6IZqi8LLz
         z0/w==
X-Gm-Message-State: AOJu0YzxvXPkp588MaPvWjDv8jl4GhAJ4hutSeoU5Gq3We5qOTh2nyiP
        ixuUsURkaGjHKt7nV27pjGSi22sRDgy/AVw4q1+t34h/0HmnI8nEHN0cggX/MY9NI/m8OutVCsm
        wGJeQ8/P3PdqEe/WHT2kO+rSGg6SCvMpCYtqTZA==
X-Received: by 2002:a05:600c:a02:b0:405:4daa:6e3d with SMTP id z2-20020a05600c0a0200b004054daa6e3dmr4857183wmp.39.1697969817325;
        Sun, 22 Oct 2023 03:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR9ajGyAKxGnJTHGXo85cKGVbITf+pxIsTZxiW6T8a2EGRQXazCWzonnmgcZkbqGRIZyg5GQ==
X-Received: by 2002:a05:600c:a02:b0:405:4daa:6e3d with SMTP id z2-20020a05600c0a0200b004054daa6e3dmr4857170wmp.39.1697969816846;
        Sun, 22 Oct 2023 03:16:56 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b004077219aed5sm11287461wmk.6.2023.10.22.03.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 03:16:56 -0700 (PDT)
Message-ID: <d3afc8dc-51db-43fd-abb8-b9030d86bbe2@canonical.com>
Date:   Sun, 22 Oct 2023 12:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
Content-Language: en-US, de-DE
To:     Ben Schneider <ben@bens.haus>
Cc:     Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <Nh-DzlX--3-9@bens.haus>
 <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
 <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
 <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com>
 <Nh30qsF--3-9@bens.haus> <57062702-f858-46d3-bccc-f0f96891128b@canonical.com>
 <Nh8pThy--3-9@bens.haus> <NhEYpWg--3-9@bens.haus>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <NhEYpWg--3-9@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/21/23 02:07, Ben Schneider wrote:
> Oct 20, 2023, 01:25 by ben@bens.haus:
> 
>> Oct 19, 2023, 07:21 by heinrich.schuchardt@canonical.com:
>>
>>> Compiling upstream U-Boot's qemu_arm64_defconfig yields lib/efi_loader/dtbdump.efi. If you run this instead of the kernel, you can write the device-tree as it is passed in a configuration table to the ESP.
>>>
>> I compiled and ran this fine, but I was unable to save the device tree. I suspect this is because the program searches for an ESP, and there is none on the device. U-boot was compiled with support to load directly from an ext4 filesystem so I didn't bother setting one up. I will work on it.
>>
> Hi Heinrich, I loaded dtbdump.efi from a FAT32 formatted partition with type EFI System, but attempts to run the save command return "Failed to open simple file system protocol". Sorry if there is something else I am missing.

On upstream U-Boot I cannot see this problem.

Best regards

Heinrich
