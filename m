Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32273F7B5
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jun 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjF0IsP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jun 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjF0IsO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jun 2023 04:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB610D
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C3D61086
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 08:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADD9C433CB
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687855692;
        bh=FKNuEjyr/LhZnVMidoD1P+FS/y71tUYah/jcB2Spnos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N3tbIiZCHWFCEFBM+gX+np2pM1YId9eQ3gv3GptZnbhDRT8Qvoo79AbiDUIHX3utb
         RULuRXc2JDOQRtKTDguh+kbHko8blVCz+06BZV19Og4i5gZDcMkyhkNI6U+B76zLY3
         55FTMRSYUacTm6G0AnAoovEck/Be6I97CZ0OcLp5LFprMlF6uinoYWutpI7Ixqmwdf
         iM3cNU3lgfA76s2Kb0qPyUXA7GkyAESJ1LF8TFWAIIH0GFNcld7nAXtsnTgKWym7te
         SeDC8pnthqeGKUTwc2TlGGELq/fRjlMFHG6jzRry5g13U9Xsk3kuHoW3fnMcyOfSot
         tw8i957GjtpEA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso3401181e87.3
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:48:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDytU5hxD8XN4kBspMd6LXCeB51pEB/zXeFf7yeIbCEi0fvCoUZ6
        SltTrxdVDJlcbsMGkO9uz4zkjl4DzDITzFPEvHQ=
X-Google-Smtp-Source: ACHHUZ5m5pBAS7jMY2gnJ4z6jRuf0hEFzyY2ubmwMNGo/+B19FC+38cGPJgzKmx018rqSCe+gvOGFJNVkaVgx6wFqUI=
X-Received: by 2002:a05:6512:239a:b0:4fb:744c:2e9a with SMTP id
 c26-20020a056512239a00b004fb744c2e9amr4373418lfv.32.1687855689922; Tue, 27
 Jun 2023 01:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230627074132.1016795-1-ardb@kernel.org> <20230627080039.GA20512@srcf.ucam.org>
 <CAMj1kXF7g92VqnjWwbp0Y9hKXfMc2iZSmvtT2B6ZEHQ3c478bA@mail.gmail.com>
 <20230627081706.GA20814@srcf.ucam.org> <CAMj1kXEO6x_UcwtGE774h04kXKDYn_m34V9tNTQd0oWxw-UR0g@mail.gmail.com>
 <20230627083746.GA21374@srcf.ucam.org>
In-Reply-To: <20230627083746.GA21374@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jun 2023 10:47:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHM=PBV+wFmjUdsNd38LUFhC1X9Zk7_Gb_8w1YHfOAukA@mail.gmail.com>
Message-ID: <CAMj1kXHM=PBV+wFmjUdsNd38LUFhC1X9Zk7_Gb_8w1YHfOAukA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable PCI DMA before grabbing the EFI
 memory map
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-efi@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>,
        Glenn Washburn <development@efficientek.com>
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

On Tue, 27 Jun 2023 at 10:37, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Tue, Jun 27, 2023 at 10:32:36AM +0200, Ard Biesheuvel wrote:
> > On Tue, 27 Jun 2023 at 10:17, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > >
> > > On Tue, Jun 27, 2023 at 10:14:16AM +0200, Ard Biesheuvel wrote:
> > >
> > > > Not quite. It should only fail the first time if the memory map
> > > > changed since the last call to GetMemoryMap(), and normally, this will
> > > > only happen if some kind of asynchronous event was triggered after
> > > > GetMemoryMap() but before ExitBootServices(). (This is why calling
> > > > ExitBootServices() at most twice should always suffice: the first call
> > > > disables the timer interrupt, so the second time around, no events
> > > > will fire in the mean time)
> > >
> > > Can't driver shutdown code also end up altering it?
> >
> > Yes, but doing so violates the UEFI spec:
> > EVT_SIGNAL_EXIT_BOOT_SERVICES is documented as not permitting the use
> > of memory allocation services, either directly or indirectly (via the
> > use of other external code that might use them)
>
> Maybe people have become better at observing that restriction! Anyway,
> feel free to ignore my nit in that case.

I haven't dealt with actual production x86 hardware built to boot
Windows via EFI (or CSM) as much as you have, so my world view tends
to be a bit naive when it comes to actual EFI compliance :-)
