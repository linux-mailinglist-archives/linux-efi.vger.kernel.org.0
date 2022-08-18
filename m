Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1A598798
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbiHRPit (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbiHRPir (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 11:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E282856
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A190F614B4
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 15:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1BAC433C1;
        Thu, 18 Aug 2022 15:38:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ldr/BVSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1660837122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1nUSHzbEorkvLX3MaeFGTOlIHQ34YWBsx68QaCBcpE=;
        b=ldr/BVSajANhMyo8M2QlK0j5wFH5b+wGmzIcpEBAabO4kC72DNi4UdtUwLGA9gISH8bMKf
        8PQ7pR7A/7kdmVJ5w+9lPjkkjcwTbMKH4pgJWWjM4jkWO0oquMGe2eZehvGYTUpE8UN3Y8
        JtOGI9wfypoX3RM4FGN+aQNynFpRVr4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5be51194 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 18 Aug 2022 15:38:41 +0000 (UTC)
Date:   Thu, 18 Aug 2022 17:38:37 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
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
Message-ID: <Yv5c/UMrEhTUlIID@zx2c4.com>
References: <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com>
 <Yuu3ee1iB3IoLdZS@redhat.com>
 <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <cf60456e-a2cd-a64d-0cee-4bea30708fc9@redhat.com>
 <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
 <20220816085511.nw5w3wt5vemkyryt@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816085511.nw5w3wt5vemkyryt@sirius.home.kraxel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey Gerd,

On Tue, Aug 16, 2022 at 10:55:11AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > We can make setup_data chaining work with OVMF, but the whole chain
> > > should be located in a GPA range that OVMF dictates.
> > 
> > It sounds like what you describe is pretty OVMF-specific though,
> > right? Do we want to tie things together so tightly like that?
> > 
> > Given we only need 48 bytes or so, isn't there a more subtle place we
> > could just throw this in ram that doesn't need such complex
> > coordination?
> 
> Joining the party late (and still catching up the thread).  Given we
> don't need that anyway with EFI, only with legacy BIOS:  Can't that just
> be a protocol between qemu and pc-bios/optionrom/*boot*.S on how to pass
> those 48 bytes random seed?

Actually, I want this to work with EFI, very much so.

If our objective was to just not break EFI, the solution would be
simple: in the kernel we can have EFISTUB ignore the setup_data field
from the image, and then bump the boot header protocol number. If QEMU
sees the boot protocol number is below this one, then it won't set
setup_data. Done, fixed.

Except I think there's value in passing seeds even through with EFI.

Your option ROM idea is interesting; somebody mentioned that elsewhere
too I think. I'm wondering, though: do option ROMs still run when
EFI/OVMF is being used?

Jason
