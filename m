Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B913673F695
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jun 2023 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF0IOc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jun 2023 04:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjF0IOb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jun 2023 04:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4EC7
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F8561047
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 08:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A82C433C9
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687853670;
        bh=ljrWWz34djZgNJv9CXbm8C26vYYVWO6psWYWUNMrCSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UWP4A4B9uUgJmGPtIi4hK0Y8iv5yurFM8/vMygSw+gLJe5m8NvWmIh2MORSPG+JiK
         LnCWeKuhtbZ4U9050xagCih5XiuJ+drskW1f8ewmEWbxWlc5lhjvMrSKqflWgazM3G
         dawcKQuSgKiO99YTEhS7Y5pS3gF1nbJqCd6Tqr42eyQBee0hdW7dEOVfKVl4+G4VuC
         ffN5iZe5vA7boojoLHEEx3eY37ayuLIbetRDGu+atMqz9USLt85TnJMmX76vLHhqyu
         96Oyk1SFmZ8yz8SAjyBJFraWVsBB/l1p0O5iG5NElL1nk6JMO3Ga+xXA7jIj84d9Gc
         0MyIq8VjZHWbQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f122ff663eso5695712e87.2
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:14:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDxA+vTvfc5AKquyOf+C+MEGkUDVPDfdM8L3/4EpV/H+ucr3i5B9
        RgPjqkyMaFT7L/e2JhxVpqOBYzthZETc6QLnB2Y=
X-Google-Smtp-Source: ACHHUZ5+ik7RMwZiTukuprLGLVcjvqIcT1gLJT8umOqrlrkRcNlyfUQ8JKyliodBmSkIs6EbnAsColmxWLfkRFWoKMo=
X-Received: by 2002:ac2:4f0a:0:b0:4fb:7404:538b with SMTP id
 k10-20020ac24f0a000000b004fb7404538bmr3962615lfr.66.1687853668007; Tue, 27
 Jun 2023 01:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230627074132.1016795-1-ardb@kernel.org> <20230627080039.GA20512@srcf.ucam.org>
In-Reply-To: <20230627080039.GA20512@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jun 2023 10:14:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF7g92VqnjWwbp0Y9hKXfMc2iZSmvtT2B6ZEHQ3c478bA@mail.gmail.com>
Message-ID: <CAMj1kXF7g92VqnjWwbp0Y9hKXfMc2iZSmvtT2B6ZEHQ3c478bA@mail.gmail.com>
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

On Tue, 27 Jun 2023 at 10:00, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Tue, Jun 27, 2023 at 09:41:32AM +0200, Ard Biesheuvel wrote:
>
> > However, the stub will invoke DisconnectController() on all endpoints
> > downstream of the PCI bridges it disables, and this may affect the
> > layout of the EFI memory map, making it likely that ExitBootServices()
> > will fail the first time around, and that the EFI memory map needs to be
> > reloaded.
>
> Isn't it always likely that ExitBootServices() will fail the first time
> around, but disable_early_pci_dma makes it more likely it'll have
> changed by enough that we need a bigger map?

Not quite. It should only fail the first time if the memory map
changed since the last call to GetMemoryMap(), and normally, this will
only happen if some kind of asynchronous event was triggered after
GetMemoryMap() but before ExitBootServices(). (This is why calling
ExitBootServices() at most twice should always suffice: the first call
disables the timer interrupt, so the second time around, no events
will fire in the mean time)

In this case, we explicitly invoke boot services between
GetMemoryMap() and ExitBootServices(), making the first failure
substantially more likely.

> Other than that potential
> quibble over the changelog,
>
> Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>

Thanks
