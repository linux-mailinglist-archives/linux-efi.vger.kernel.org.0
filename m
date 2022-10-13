Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106605FDD59
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJMPnY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJMPm4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 11:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBB4F398;
        Thu, 13 Oct 2022 08:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23C361843;
        Thu, 13 Oct 2022 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D069C433B5;
        Thu, 13 Oct 2022 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665675680;
        bh=7qWEM+SR3cR2PG8LEt6otdiWC9HHkyef1kIbNpUaNEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hC6KWRsbz+27P/4DOUeK/7jznv1u1CgL0NLM32aM/TCC0Y6evPBOw75lTFe71udqT
         1UARrk9IjOgMAG7/Pan79oVxztOpC9PpKAStyU/4/2zdbnnmusshXeCla7Xg7/rpB4
         v3TWtDrrD6eUadlfJnmF0qnTY/qAjHG6bVmBMXRDJz8nvQv7MtKZQgvsWqvnXmWpqQ
         +9LnRgdywq+VAJ7dMdQFX8uJ1Ub+Q2nOznorjWB8nk4zWZEoaAv6TcEC6zkd1GvLj+
         OHQ7D6IE7JVzKherE4Rnp1m6Ujm1jQHln9MeNmvYmN7LgbmLrsiK4e0duyNicxYAZE
         l4yKtCYwi919Q==
Received: by mail-lj1-f172.google.com with SMTP id a25so2878813ljk.0;
        Thu, 13 Oct 2022 08:41:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf3kBNl6316DhI1kdOME0T3HVBh4x+LNTg+0yDovzBjQCuxqja04
        eDNjjGCz4fEw4IRoqtULMFGUkTxtSQtxk02dRwM=
X-Google-Smtp-Source: AMsMyM6vbjatwq4fEjuKRBM0RiDk00hg4GApfofSwitpcvRL75etqMa0zGUNOauPeg+ftE1j/OkWGhp3ZA6jQfpO9uM=
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr195668ljt.352.1665675678206;
 Thu, 13 Oct 2022 08:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221010023559.69655-1-justin.he@arm.com> <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic> <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic> <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
In-Reply-To: <Y0gUpoaUBKw/jjaD@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Oct 2022 17:41:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
Message-ID: <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
To:     Borislav Petkov <bp@alien8.de>
Cc:     Justin He <Justin.He@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Oct 2022 at 15:37, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 12, 2022 at 12:04:57PM +0000, Justin He wrote:
> > I have a concern about what if cmpxchg failed? Do we have to still
> > guarantee the ordering since cmpxchg will not imply a smp_mb if it
> > failed.
>
> Of course it will imply that. At least on x86 it does. smp_wmb() is a
> compiler barrier there and cmpxchg() already has that barrier semantics
> by clobbering "memory". I'm pretty sure you should have the same thing
> on ARM.
>

No it definitely does not imply that. A memory clobber is a codegen
construct, and the hardware could still complete the writes in a way
that could result in another observer seeing a mix of old and new
values that is inconsistent with the ordering of the stores as issued
by the compiler.

> says, "new_cache must be put into array after its contents are written".
>
> Are we writing anything into the cache if cmpxchg fails?
>

The cache fields get updated but the pointer to the struct is never
shared globally if the cmpxchg() fails so not having the barrier on
failure should not be an issue here.

> > Besides, I didn't find the paired smp_mb or smp_rmb for this smp_wmb.
>
> Why would there be pairs? I don't understand that statement here.
>

Typically, the other observer pairs the write barrier with a read barrier.

In this case, the other observer appears to be ghes_estatus_cached(),
and the reads of the cache struct fields must be ordered after the
read of the cache struct's address. However, there is an implicit
ordering there through an address dependency (you cannot dereference a
struct without knowing its address) so the ordering is implied (and
rcu_dereference() has a READ_ONCE() inside so we are guaranteed to
always dereference the same struct, even if the array slot gets
updated concurrently.)

If you want to get rid of the barrier, you could drop it and change
the cmpxchg() to cmpxchg_release().

Justin: so why are the RCU_INITIALIZER()s needed here?
