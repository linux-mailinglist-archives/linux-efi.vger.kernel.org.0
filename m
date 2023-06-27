Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE473F756
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jun 2023 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjF0IeJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jun 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjF0Idz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jun 2023 04:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1E35BB
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF72761085
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 08:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A2C433C0
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 08:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687854770;
        bh=k+7RnQYhNKsIJAK4G89sZ4QKYpo+oBe6rHA/ZVxByAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YQLi1jKDd9NphHeBwRXg/dNh5B8AvWJTFr1zT4jERYTHqAO+ibTTQraTu8yJAaMh/
         47gOp8lsJ1hnqhBczw6M+olPxlMlHAC8WN++fSrvW1Mb/NRqIZvmiYCS8mohaOEsys
         eDNGF1JwCd9sRiVsKAq+osAVgLx08N2G2Pcm3LPU/3wrFtjcYHJRD8CpPXSbaHqRYe
         wQDpMre6h5S5P88nttBfg1KfZWFe18nKHofzkZ1DppDlN3aQP1CprJKzfOpwRCxm5W
         Ce7j5J6DMQPnea3wZpmUokuCARVDGs1GI+4HR2WUy1ys17s4QY3sLZtK8EzGndTMr8
         RybTNpuC2211g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so5899907e87.0
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:32:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDyUu+92U9z1jlQrjZ1FjAmR0PSkNe3uVXLSywyRAVr4ehXkw03t
        mTCvAbpWpjl3W9Rip873g2cwkG34SmQvmTmTRJw=
X-Google-Smtp-Source: ACHHUZ7kWE5sZiz+KOiJqQtED9rJsXQcN2IVooK6aPmrZNCQISTf63DD/Kd2nNxxJXPS+Oe32c9cZLFcgE+4F3TXu/o=
X-Received: by 2002:a05:6512:280b:b0:4fb:2c1e:4e03 with SMTP id
 cf11-20020a056512280b00b004fb2c1e4e03mr4567764lfb.32.1687854768364; Tue, 27
 Jun 2023 01:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230627074132.1016795-1-ardb@kernel.org> <20230627080039.GA20512@srcf.ucam.org>
 <CAMj1kXF7g92VqnjWwbp0Y9hKXfMc2iZSmvtT2B6ZEHQ3c478bA@mail.gmail.com> <20230627081706.GA20814@srcf.ucam.org>
In-Reply-To: <20230627081706.GA20814@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jun 2023 10:32:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEO6x_UcwtGE774h04kXKDYn_m34V9tNTQd0oWxw-UR0g@mail.gmail.com>
Message-ID: <CAMj1kXEO6x_UcwtGE774h04kXKDYn_m34V9tNTQd0oWxw-UR0g@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable PCI DMA before grabbing the EFI
 memory map
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-efi@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>,
        Glenn Washburn <development@efficientek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 27 Jun 2023 at 10:17, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Tue, Jun 27, 2023 at 10:14:16AM +0200, Ard Biesheuvel wrote:
>
> > Not quite. It should only fail the first time if the memory map
> > changed since the last call to GetMemoryMap(), and normally, this will
> > only happen if some kind of asynchronous event was triggered after
> > GetMemoryMap() but before ExitBootServices(). (This is why calling
> > ExitBootServices() at most twice should always suffice: the first call
> > disables the timer interrupt, so the second time around, no events
> > will fire in the mean time)
>
> Can't driver shutdown code also end up altering it?

Yes, but doing so violates the UEFI spec:
EVT_SIGNAL_EXIT_BOOT_SERVICES is documented as not permitting the use
of memory allocation services, either directly or indirectly (via the
use of other external code that might use them)

> I've certainly had
> extremely deterministic requirements to call it twice, which doesn't
> line up terribly well with it just being down to async events.

Yeah, I guess you can still get the Windows sticker if you violate
this requirement :-)
