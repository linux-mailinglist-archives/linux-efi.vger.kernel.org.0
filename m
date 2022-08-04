Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B158A3B9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 00:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiHDW7G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 18:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbiHDW6v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 18:58:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC453A4A6
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 15:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9EFCB8279C
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 22:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E57C433D6;
        Thu,  4 Aug 2022 22:56:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gz+bXkLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659653766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hD6z8veO6eb05DcK1fTPRt9+fi4P9XPTHuLXyF8CHZ0=;
        b=gz+bXkLdKjQuCg+i5hQXzVzTSWWJzsvuf+kKt8mnOlOA3YGq3C+0dHdJxwlsX3VlHPFu/G
        u2mPOiIjoXStoZzAwOFw4wAbJIzrgIqU7tcSnbonsolTS3oUJtzPrR0fkNDOTPqSjVpsy+
        Ora4NsNVl728QebMyD2cKLb+qXtaj2M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6b0c2d32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Aug 2022 22:56:05 +0000 (UTC)
Date:   Fri, 5 Aug 2022 00:56:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <YuxOgtykRQb1HU3e@zx2c4.com>
References: <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com>
 <Yuu3ee1iB3IoLdZS@redhat.com>
 <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <cf60456e-a2cd-a64d-0cee-4bea30708fc9@redhat.com>
 <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
 <8254819e-d509-59f4-79e6-e8c0ba4eb2a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8254819e-d509-59f4-79e6-e8c0ba4eb2a6@redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey Laszlo,

On Thu, Aug 04, 2022 at 03:56:54PM +0200, Laszlo Ersek wrote:
> - do we want setup_data chaining work generally?
> 
> - or do we want only the random seed injection to stop crashing OVMF guests?

Preferably the first - generally. Which brings us to your point:
 
> > Given we only need 48 bytes or so, isn't there a more subtle place we
> > could just throw this in ram that doesn't need such complex
> > coordination?
> 
> These tricks add up and go wrong after a while. The pedantic
> reservations in the firmware have proved necessary.
> 
> IIUC, with v2, the setup_data_base address would (most frequently) be 96
> KB. edk2 does have uses for very low memory. If OVMF's PlatformPei does
> not reserve away the area, UefiCpuPkg or other drivers might allocate an
> overlapping chunk, even if only temporarily. That might not break the
> firmware, but it could overwrite the random seed. 

Yea, so we don't want an address that something else might overwrite. So
my question is: isn't there some 48 bytes or so available in some low
address (or maybe a high one?) that is traditionally reserved for some
hardware function, and so software doesn't use it, but it turns out QEMU
doesn't use it for anything either, so we can get away placing it at
that address? It seems like there *ought* to be something like that. I
just don't (yet) know what it is...

Jason
