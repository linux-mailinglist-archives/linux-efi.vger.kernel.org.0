Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB47CF10D
	for <lists+linux-efi@lfdr.de>; Thu, 19 Oct 2023 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjJSHVP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Oct 2023 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjJSHVO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Oct 2023 03:21:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33E3123
        for <linux-efi@vger.kernel.org>; Thu, 19 Oct 2023 00:21:11 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 33EB53F69E
        for <linux-efi@vger.kernel.org>; Thu, 19 Oct 2023 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697700070;
        bh=x91R+lC/YKZONC3H6UuQ7fgHRxPTzGFAHyvdz6tJ5Ok=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rX9gRrLizFOKGYJSIkhGquZaah1vWqZVX3uwTAR5amjdvjSarO+hcFtXplR35/PZ7
         Xp2SLaUh3ymClSSf+pGGqXn/5Elahw98GTEJM8sQQykQXwfw8V4KMDS3s38nexx7pZ
         8Y6CF+3HbCUsjZub7e2qAkmzYHEIcEbtD/K1HA6LJQ0ApvU0TevhJ0pG9dRiqno9dm
         a0OOd62+Jwh7By1/IYV7YvNUgDKH1irR4dg2UWzaac7ThkiqhG6FCgrwr51JCeDTFd
         OnpVRNg2TRjCBLwboF5Knfri9dwNol2frLQ4GbF5jRP1Qez9p+Iks6dTF45k8Z4SZF
         H5EKQnkHOPvIA==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5047f94bdso47561271fa.1
        for <linux-efi@vger.kernel.org>; Thu, 19 Oct 2023 00:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700069; x=1698304869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x91R+lC/YKZONC3H6UuQ7fgHRxPTzGFAHyvdz6tJ5Ok=;
        b=s+WmW1JgPui/HrWg/tFNDHcdX3sxkNj7MgMLgqjsVvIRyeiFwiU270aNO36xHeRZ1V
         oZ32MsX4ozPdck4erKg7EFpwTCk2RkCAAei12UVSCCJ+vxxfAQLOBglHsKz8CLn2/Tww
         GDNepvq03q5HfDDVeP0U9KZHTZ+AsJsojoyQa+FjcuviCBe6nPUfBNgNNep8VHWWQRkk
         d6Tae5/cJCgbY68Y7TfhJSBz67S4fxkkG+2DmxpmZU+jgKaMkj6bE/BFPHFMfm7EZz2A
         lJoCayT01lBWvvlsbTotJy4dImtkyq16QCBVUHXPDJhiz/HWyfd714eRtBUYq7ByttNI
         JptA==
X-Gm-Message-State: AOJu0YwUVZ6CSnwd/1GDzGrFsPXTdu4aQn8eMPRONvD71y3nP7tbyUI1
        y8vC2vV5YmD+CbfIRUoKBHNufX6JEwGKOlJz/zezaBlYBIQcdNbDJqm7lOt2UHbFqBiXjbauiBd
        aPasM71g3vHj0fp6zLYpGlQPLx6J8kIlXHBPO7Q==
X-Received: by 2002:a05:651c:1507:b0:2bc:f252:6cc4 with SMTP id e7-20020a05651c150700b002bcf2526cc4mr1042798ljf.10.1697700068813;
        Thu, 19 Oct 2023 00:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrEU16y5JLCrQA1zLjr1UsCW+KYgjOi+xUvCvHEVOlrHclgBiPupWNCqAkJ1xwc+J1xs6X/A==
X-Received: by 2002:a05:651c:1507:b0:2bc:f252:6cc4 with SMTP id e7-20020a05651c150700b002bcf2526cc4mr1042779ljf.10.1697700068371;
        Thu, 19 Oct 2023 00:21:08 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b00402ff8d6086sm3610975wml.18.2023.10.19.00.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:21:07 -0700 (PDT)
Message-ID: <57062702-f858-46d3-bccc-f0f96891128b@canonical.com>
Date:   Thu, 19 Oct 2023 09:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
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
 <Nh30qsF--3-9@bens.haus>
Content-Language: en-US, de-DE
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <Nh30qsF--3-9@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/19/23 03:51, Ben Schneider wrote:
>> How old is the u-boot build on this platform?
> 
> U-Boot 2018.03-devel-18.12.3-g926d08c7ce (Apr 11 2022 - 15:48:13 +0800)
> 
> This appears to be the most recent version the manufacturer has released for this device. Source: https://github.com/globalscaletechnologies/u-boot-marvell.
> 
>>> arch/arm64/boot/marvell/armada-3720-espressobin-ultra.dts
>> This is a uboot path, right? Not a linux path? Are you sure this DTS is compatible with the v6.5 kernel?
> 
> Sorry for the confusion; that is the path in the linux source to the DTS used to compile the DTB that I am using to boot the device. I booted v5.15.135 using the DTB compiled from v6.5.7 source and that works fine. I also tried to boot v6.5.7 with the factory DTB and that failed.

To which kernel and device-tree are the messages below related?

> 
>> Please add message inside the update_fdt() routine...
> 
> I added a bunch and here's what I got back:
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: ERROR: FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value
> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
> EFI stub: ERROR: Failed to install memreserve config table!
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> EFI stub: Starting update_fdt()...
> EFI stub: fdt_num_mem_rsv() returned 1
> EFI stub: fdt_subnode_offset() returned 8944
> EFI stub: Setting bootargs=console=ttyMV0,115200 earlycon=ar3700_uart,0xd0012000 root=/dev/sda1 rw rootwait
> EFI stub: Adding FDT entries...
> EFI stub: fdt_setprop_var() for linux,uefi-system-table returned 0
> EFI stub: fdt_setprop_var() for linux,uefi-mmap-start returned -11

11 = FDT_ERR_BADSTRUCTURE
This is probably set in scripts/dtc/libfdt/fdt_ro.c.
Something in the structure of your device-tree is invalid.

Please, check the load addresses in U-Boot. Is something overwriting the 
tail of the device-tree?

Compiling upstream U-Boot's qemu_arm64_defconfig yields 
lib/efi_loader/dtbdump.efi. If you run this instead of the kernel, you 
can write the device-tree as it is passed in a configuration table to 
the ESP.

Best regards

Heinrich

> EFI stub: update_fdt() failed with status -11
> EFI stub: ERROR: Unable to construct new device tree.
> EFI stub: ERROR: Failed to update FDT and exit boot services
> 
> That's as far as I could get today but hopefully that starts to narrow it down. Appreciate the help!
> 
> Sincerely,
> 
> Ben

