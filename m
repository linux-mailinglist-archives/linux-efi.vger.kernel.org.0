Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB2599577
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 08:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiHSGlG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 02:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHSGlE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 02:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6040DAA2C
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660891262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWmOAYbsnJul6xY4V2fIRfx/cHSnZGhRwqC88WVpTYo=;
        b=gj9X9hAGSYiEkK2qWdVlCFSBeV4/6lj09pTWs9VeiNasRKmJjkl/eGUtQoB69l2DZuOM4t
        Dw5lJAL7V5TeWq2/Y4uQY+3VIjrJ1gDNUpMUfmx1uZyADEUJOEVWEBeF5b36fEJsE4QT8H
        LyOmR6XLetHWQVFvFgJA6gEA+Sy4lVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-Lq0nQECAPGmwsOCgryfV9g-1; Fri, 19 Aug 2022 02:40:59 -0400
X-MC-Unique: Lq0nQECAPGmwsOCgryfV9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 986538032FB;
        Fri, 19 Aug 2022 06:40:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB5842166B26;
        Fri, 19 Aug 2022 06:40:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9531C1800081; Fri, 19 Aug 2022 08:40:51 +0200 (CEST)
Date:   Fri, 19 Aug 2022 08:40:51 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <20220819064051.yopqxw3ynttnncca@sirius.home.kraxel.org>
References: <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com>
 <Yuu3ee1iB3IoLdZS@redhat.com>
 <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <cf60456e-a2cd-a64d-0cee-4bea30708fc9@redhat.com>
 <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
 <20220816085511.nw5w3wt5vemkyryt@sirius.home.kraxel.org>
 <Yv5c/UMrEhTUlIID@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv5c/UMrEhTUlIID@zx2c4.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 18, 2022 at 05:38:37PM +0200, Jason A. Donenfeld wrote:
> Hey Gerd,
> 
> > Joining the party late (and still catching up the thread).  Given we
> > don't need that anyway with EFI, only with legacy BIOS:  Can't that just
> > be a protocol between qemu and pc-bios/optionrom/*boot*.S on how to pass
> > those 48 bytes random seed?
> 
> Actually, I want this to work with EFI, very much so.

With EFI the kernel stub gets some random seed via EFI_RNG_PROTOCOL.
I can't see any good reason to derive from that.  It works no matter
how the kernel gets loaded.

OVMF ships with a driver for the virtio-rng device.  So just add that
to your virtual machine and seeding works fine ...

> If our objective was to just not break EFI, the solution would be
> simple: in the kernel we can have EFISTUB ignore the setup_data field
> from the image, and then bump the boot header protocol number. If QEMU
> sees the boot protocol number is below this one, then it won't set
> setup_data. Done, fixed.

As mentioned elsewhere in the thread patching in physical addresses on
qemu side isn't going to fly due to the different load methods we have.

> Your option ROM idea is interesting; somebody mentioned that elsewhere
> too I think.

Doing the setup_data patching in the option rom has the advantage that
it'll only happen with that specific load method being used.  Also the
option rom knows where it places stuff in memory so it is in a much
better position to find a good & non-conflicting place for the random
seed.  Also reserve/allocate memory if needed etc.

> I'm wondering, though: do option ROMs still run when
> EFI/OVMF is being used?

No, they are not used with EFI.  OVMF has a completely independent
implementation for direct kernel boot.

The options I see for EFI are:

  (1) Do nothing and continue to depend on virtio-rng.
  (2) Implement an efi driver which gets those 48 seed bytes from
      qemu by whatever means we'll define and hands them out via
      EFI_RNG_PROTOCOL.

take care,
  Gerd

