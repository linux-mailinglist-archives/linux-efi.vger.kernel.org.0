Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57050599603
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiHSHWi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiHSHWi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 03:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6115AE39A7
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 001DC60A1C
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5894DC433D6
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660893756;
        bh=zfZRkxoJtXkDJI5hREikgaBxaAPLQuFl63K3GXYWGNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gm7juNBAFy2Uxh1u7q3AphQCeKGtXjSmb2KpmHTuqNNc1SotMoL/Kd6muRx/uwXrL
         Rr7H3YOnvwyyO+4dn58U8kAlDKilNk2D7pwn2hoT4troxP4zikg1LEA4tTYObxQJJo
         0WfJWv2XMI6eimRabRuJLn3N0c/hUJdHIr1Yi9Fz+lHtNac3w6fRfKdwzwYZtAop0H
         r3qXQ14r8l+XUu9CXuEvCxc4YDL9CNaTLHY8zI3EsgYboPPx5Frosm3x/enD+G/CLx
         21VaNxAg6LE2+IC70EWggyAnkRdiJvklx7a2cw5lp406xxfnzMiqZX7ImpSBCRFpgu
         /GyI+B/+WWFqA==
Received: by mail-wr1-f53.google.com with SMTP id j7so4172683wrh.3
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:22:36 -0700 (PDT)
X-Gm-Message-State: ACgBeo2u0PfvJ9Yb8SCnNQQewmPryQRAqJZsWDZwL95FQQ5JFUviQc9H
        e5yLuIHOC4EgRJ9/ww+Q/GrbrB4gmYDxVdbS5wE=
X-Google-Smtp-Source: AA6agR7LICS2/EOIrVP63UgKBJRLfMaySSMS1pBGlZwIlW2kVoQVXehJARcFxr51qJAE5GGB2OIj6UtOSMSSMU9ZpWY=
X-Received: by 2002:a5d:6d89:0:b0:225:16c2:6816 with SMTP id
 l9-20020a5d6d89000000b0022516c26816mr3422381wrs.380.1660893754512; Fri, 19
 Aug 2022 00:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <2e9741aa-562c-cd0d-7ee4-8281512bc2e0@iam.tj>
In-Reply-To: <2e9741aa-562c-cd0d-7ee4-8281512bc2e0@iam.tj>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 Aug 2022 09:22:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH-uYwfxPrHv7YpKQ3iwS0aBEsj-OZ9aKpgr9SgyTdoWQ@mail.gmail.com>
Message-ID: <CAMj1kXH-uYwfxPrHv7YpKQ3iwS0aBEsj-OZ9aKpgr9SgyTdoWQ@mail.gmail.com>
Subject: Re: ExitBootServices() fails on Samsung W737 (Galaxy Book2)
To:     Tj <linux@iam.tj>, Steev Klimaszewski <steev@kali.org>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Steve - not sure who else still works on this stuff these days)

On Thu, 18 Aug 2022 at 13:00, Tj <linux@iam.tj> wrote:
>
> I've been diagnosing a failure to boot on a Samsung Galaxy Book2 (W737)
> but have not been able to get the kernel to boot, and would welcome some
> assistance:
>
> EFI stub: ERROR: Exit boot services failed
>
> The problem occurs in
> drivers/firmware/efi/libstub/efi-stub-helper.c::efi_exit_boot_services().
> EFI_INVALID_PARAMETER is returned by efi_bs_call(exit_boot_services...).
>
> Based on reading the EDK source I suspected either the key was changing
> or memory alignment is wrong based on a reading of EDK's
> CoreExitBootServices() and CoreTerminateMemoryMap() - making a large
> assumption that Lenovo/Aptio (American Megatrends) firmware is based
> around EDK.
>
> Since the addition of commit d4b341269efb3 "arm64: dts: qcom: Add
> support for Samsung Galaxy Book2" I had inferred it is now possible to
> boot this device into Linux, but so far it seems not.
>
> I added extensive efi_debug() logging to try to identify the problem and
> have reported the patches I'm using and results extensively (too
> extensively for including in this email) at "Issue #11: Samsung Galaxy
> Book2 (SM-W737Y) snapdragon 850" of the aarch64-laptops project:
>
> https://github.com/aarch64-laptops/debian-cdimage/issues/11
>

Looking at your adventures, it seems you are looking for something
that the EFI stub in Linux is doing wrong, causing the
ExitBootServices() call to fail.

One thing to be aware of is that vendors of such hardware don't care
about EFI compliance, and rarely run the certification tests or turn
up for plugfests, etc. They only care about the Windows Logo sticker,
which is a lower bar in terms of EFI compatibility, and apparently,
their buggy firmware manages to boot Windows fine.

One thing you could try is setting the TPL level to TPL_HIGH before
calling exit_boot_services (or just disable interrupts). That way,
your first call is more likely to succeed, as nothing that could
change the memory map could run in the meantime.

> The latest results show:
>
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: DEBUG: Entering allocate_new_fdt_and_exit_boot()
> EFI stub: Exiting boot services...
> EFI stub: DEBUG: Calling efi_exit_boot_services() with map:
> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>   key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
> EFI stub: DEBUG: Entered efi_exit_boot_services()
> EFI stub: DEBUG: Memory map before calling priv_func():
> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>   key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
> EFI stub: DEBUG: Memory map after calling priv_func():
> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>   key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
> EFI stub: DEBUG: Calling efi_bs_call(exit_boot_services,
> 0x00000000fcb87c98, 0x2b2c)
> EFI stub: DEBUG: efi_bs_call() returned -9223372036854775806
> (EFI_INVALID_PARAMETER)
> EFI stub: DEBUG: Calling efi_bs_call() with get_memory_map
> EFI stub: DEBUG: Memory map after calling get_memory_map() again:
> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>   key_ptr=0x000000009ffce868 *key_ptr=0x2b6e buff_size=0xc90 }
> EFI stub: DEBUG: Calling priv_func() again
> EFI stub: DEBUG: Memory map after calling priv_func() again:
> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>   key_ptr=0x000000009ffce868 *key_ptr=0x2b6e buff_size=0xc90 }
> EFI stub: DEBUG: Calling (again!) efi_bs_call(exit_boot_services,
> 0x00000000fcb87c98, 0x2b6e)
> EFI stub: DEBUG: fail: efi_exit_boot_services() returns -9223372036854775806
> EFI stub: DEBUG: Returned from efi_Exit_boot_services()
> EFI stub: ERROR: Exit boot services failed.
> EFI stub: DEBUG: fail_free_new_fdt: status= -9223372036854775806
> EFI stub: DEBUG: fail: status= -9223372036854775806
> EFI stub: DEBUG: Busy Wait so you can read the debug messages!
