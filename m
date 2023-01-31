Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3B68256D
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 08:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAaHTH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 02:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjAaHTG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 02:19:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF65193E8;
        Mon, 30 Jan 2023 23:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F95B819D3;
        Tue, 31 Jan 2023 07:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB447C433D2;
        Tue, 31 Jan 2023 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675149542;
        bh=uX2/bH9WGHCCUUunwf6C67W/qEW8rVdjV8xTQQk3OHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pwh5qPQnpYxIHPfVCBi7H8/X2pf/cRp73QmBk6/atEYC7+gPqBLWpXTCjUhyDKh0o
         nWOl/abexVL/hQRk7ufjcfXEG+ny/MPKcHg4ZVgPcfYtdjFBDZeXeMvuO3uHJPmq70
         /601FcSGUlz7ymGbn5AfTGMG+1EI3UnGPBfp9VXjHhoLfucksexL0ZkxxTCpsl0iq1
         lDoMdpxZ4AF+r1cJQnpAXf/aHOeGxJbiSX4m0Nj+j9Ve8WwjSHaRB57RHMekV8jgbX
         YTTjMxEwr58wgk5FhLPKU9L1oZrNBYIXUWigxyQz7TQUqbkkuxAhf5Ut8TKwJPiQVa
         xW2A7d3hg5oqw==
Received: by mail-lj1-f170.google.com with SMTP id a37so15076907ljq.0;
        Mon, 30 Jan 2023 23:19:02 -0800 (PST)
X-Gm-Message-State: AO0yUKURIXf0QoksqAldFd0QwWP2QeXIsbqXQAGeWQ7g32zu6NB8fYL4
        ChsC4wsyKv8RPen1zetrzvbAYaGU3f8YKfjLuNw=
X-Google-Smtp-Source: AK7set83NQyIRCuWEZCNsSx9COcZkE0ldB02gtlgZpPei3GlnSvI4rnKxTFCHm9GCxkqQ23HZOjoUgCDK38C48+gutk=
X-Received: by 2002:a2e:b00c:0:b0:290:5011:2332 with SMTP id
 y12-20020a2eb00c000000b0029050112332mr1273524ljk.120.1675149540620; Mon, 30
 Jan 2023 23:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com>
In-Reply-To: <20230131040355.3116-1-justin.he@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 08:18:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
Message-ID: <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
To:     Jia He <justin.he@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Jason for awareness)

On Tue, 31 Jan 2023 at 05:04, Jia He <justin.he@arm.com> wrote:
>
> I met a hung task warning and then kernel was hung forever with latest
> kernel on an Ampere Emag server.
>
> The root cause is kernel was hung  when invoking an efi rts call to set
> the RandomSeed variable during the booting stage. The arch_efi_call_virt
> call (set_variable) was never returned and then caused the hung task error.
>

Given that EFI variables work on this platform (as far as I know), the
problem may be that we are calling SetVariable() too early.

Could you double check whether setting variables works as expected?
You can use efibootmgr -t 10 as root (for example) to set the boot
timeout, and check whether the new value is retained after a reboot
(efibootmgr will print the current value for you)

Could you also please share the kernel log up until the point where it hangs?


> On the Emag server, efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)
> is returned with "true"
>

This is as expected: if the firmware does not expose the RT properties
table, all runtime services are assumed to be available.

> Fix it by introducing the efi_get_supported_rt_services() and then determine
> to set or clear the runtime services bit of efi.flags.
>
> Jia He (2):
>   efi: libstub: Fix the retriving of supported rutime services
>   efi: Introduce efi_get_supported_rt_services() to get the runtime
>     services mask
>
>  drivers/firmware/efi/arm-runtime.c      |  5 ++++-
>  drivers/firmware/efi/efi.c              | 28 +++++++++++++++++--------
>  drivers/firmware/efi/libstub/efi-stub.c |  2 ++
>  include/linux/efi.h                     |  1 +
>  4 files changed, 26 insertions(+), 10 deletions(-)
>
> --
> 2.25.1
>
