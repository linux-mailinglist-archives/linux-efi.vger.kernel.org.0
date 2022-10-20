Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961596066AF
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTRGy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJTRGw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 13:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8805F1A402F
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C0C561CAF
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49C1C433C1
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666285606;
        bh=cErW3d4sCMVKCOftyQuQsSGfoMSwvoa1gfwZKKW305k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r82dVrpV2U4WsNHqanwIkJNj0yHI2ckOfCNfPMOUj2J/eS1vFh7vX4Ij4g6w0P4+P
         e+7yoq0fFA4kDbgiIgrr+r8/GtcnTHLahHe8H1KiKFtisRW+VNaWZNlxll3+kosBwK
         Tu8WulPg/bMjCgQxpjVW3lR5dfiQVmGVIWn40F8q2NF8tri3EAiq2YdksTUP+GbbuO
         ZRFIT8ZQ4n3T1RHhJ2ABNBxUxXMmR0yrHFS2FAfUZwvqZ2zieDgs7AT81ZR6ZqrhFQ
         dYFeWCmjQQPxJJ+EV40VqAz4qA26PD3mQ6F0O9RCVzkgsAC0zNCloLw2sd+o9qwrBM
         gda4T8uzaIvQA==
Received: by mail-lf1-f45.google.com with SMTP id f37so430259lfv.8
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 10:06:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf1SoWqprbJK8pGecbisfZ2ekx5NeOPDutx/oSowE+YvixS1xKpq
        +CPOsh2t3aUgPoZ1C1UdvMhZG+WojEfgpMFcKoM=
X-Google-Smtp-Source: AMsMyM4PXTNDfBDFlrd/i/ppb4TBXdqJaMF/5/tBU8yJVANQRIwUbKD3MVqgHhl77pKME+mhJdUZmQtQtM6YDcLfqIc=
X-Received: by 2002:a05:6512:314a:b0:4a2:d0b9:aa20 with SMTP id
 s10-20020a056512314a00b004a2d0b9aa20mr5808525lfi.110.1666285604929; Thu, 20
 Oct 2022 10:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221020083910.1902009-1-ardb@kernel.org> <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
In-Reply-To: <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Oct 2022 19:06:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGomAd153exTz_m=UANmybqait2eQeqy3n5UAUpU=xCFw@mail.gmail.com>
Message-ID: <CAMj1kXGomAd153exTz_m=UANmybqait2eQeqy3n5UAUpU=xCFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] efi: consume random seed provided by loader
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Oct 2022 at 18:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Oct 20, 2022 at 2:40 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > For maximum simplicity, just concatenate the existing seed with the one
> > obtained from EFI_RNG_PROTOCOL if both are available, and leave it to
> > the core kernel code to mix it in and credit it appropriately. This way,
> > we have no need for copies of the Blake2s library in the EFI stub and in
> > the zboot decompressor.
>
> FTR, while I think this is okay for the final stage that the kernel's
> EFI loader does, it's less good for earlier stages. So, for example,
> systemd-boot should still use the hashing scheme we discussed.

Not sure I follow. systemd-boot will put a seed in memory and publish
it via the the table. How does hashing come into play here?
