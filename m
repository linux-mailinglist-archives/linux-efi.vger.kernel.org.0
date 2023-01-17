Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2166E1F4
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 16:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAQPUx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 10:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjAQPU1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 10:20:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB7141B78
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 07:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2EFEB8164E
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 15:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988F3C43392
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673968822;
        bh=DfQ/x8nqVRwr3hlqidQGTMu/vq+mXEzELdAU5PFaPdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QnSQsf9U2Rq709xSNQQ4mKk+r7HY8g4gPas+O5gsvyr2wzOncR8pVX73bCFkCqHAh
         wjgdSdXTEVWOzWDKiy5Jm+eYcGQC4bDlq7Bl/OSQrmDcjfyaoPXvutILtQkaivc2p0
         fSGREa7by51vWqvz/uw5VxPwpRLKzAi1FxVmV1DNeW8fcQIEEW9Gk+Z8vGsRDh75Ar
         I3wA7k3TWxP8D2mShgrHM0DaQ5kiWI15kFgGoC+Sv2C83q0t4+yRqxPoYeIwuGygSz
         yXkjwUVa5cUnG7bHMku20h0QMVUPtMTvwtlgX4huVGkdfKuJ9C5WvR82O75Rh/N3bw
         /ABdE5MrUzb7w==
Received: by mail-lf1-f49.google.com with SMTP id d30so42651672lfv.8
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 07:20:22 -0800 (PST)
X-Gm-Message-State: AFqh2kp/11lgrCMY9AOxz/hPP8QrqQUoZJBT7evXyg3h6Q2vm1exsrR5
        qThMtHiDKzrkn3GbYZyulwxXOB6+3MacnSNcyC8=
X-Google-Smtp-Source: AMrXdXse7ab2CyQ3+rBtQd42cAyOtrUIM55LJmhv33/JTApwFe8cKP1g4EapzToBafXUUZGpjUc/RpzrxcGUFKj83Wg=
X-Received: by 2002:ac2:4ade:0:b0:4d0:7b7:65dc with SMTP id
 m30-20020ac24ade000000b004d007b765dcmr149587lfp.122.1673968820610; Tue, 17
 Jan 2023 07:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20230117142718.564299-1-ardb@kernel.org>
In-Reply-To: <20230117142718.564299-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Jan 2023 16:20:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHbWwtxb8dL1G8OG4evTg448Xv_DZ_pi8rNF+oVmdtx4g@mail.gmail.com>
Message-ID: <CAMj1kXHbWwtxb8dL1G8OG4evTg448Xv_DZ_pi8rNF+oVmdtx4g@mail.gmail.com>
Subject: Re: [RFT PATCH 0/2] arm64: efi: Call SetVaMap() with a 1:1 mapping
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 17 Jan 2023 at 15:27, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Linux on arm64 is now in the same boat as x86, where supporting laptops
> that were built to run Windows and never tested beyond what is required
> for the Windows Logo certification need workarounds for all kinds of
> bizarre behaviors.
>
> On Snapdragon laptops, we cannot call SetVirtualAddressMap() from the
> stub, because the firmware will crash while trying to access memory via
> the virtual addresses being installed, which is explicitly unsupported
> by the EFI spec.
>
> However, not calling SetVirtualAddressMap() results in other problems:
> on Ampere Altra, it causes SetTime() to crash. On Surface and Flex5g
> Windows-on-ARM laptops, it causes ResetSystem() to crash.
>
> So let's try to work around this while not making too much of a mess.
>
> First of all, install a 1:1 mapping instead of avoiding SetVaMap()
> altogether - from the EFI spec pov, this should amount to the same
> thing.
>
> Then, given that we already use a SMBIOS based hack for Altra to force
> the use of SetVirtualAddressMap(), let's check for Surface systems in
> the same way.
>
> Please test, and please report the SMBIOS type 1 family field for which
> this workaround is needed.
>
> Also, note that these changes will not make a difference if the
> EFI_RT_PROPERTIES_TABLE lists SetVirtualAddressMap() as not implemented.
>
> Nathan, I would appreciate it if you could give this a spin on your
> Altra box (only patch #1 should make a difference), and for good
> measure, double check that hwclock still works as it should.
>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
>
> Ard Biesheuvel (2):
>   arm64: efi: Prefer a flat virtual mapping of the runtime services
>   arm64: efi: Force use of SetVirtualAddressMap() on MS Surface
>

Bah this does not even work on Yoga C630, so this is not going to help us.

If we want ResetSystem() on these machines, we'll have to retain other
memory ranges and map the in the EFI runtime map. Yuck.

Nathan - still interested in whether patch #1 works on Altra,
