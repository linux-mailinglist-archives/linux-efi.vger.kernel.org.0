Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE158AB03
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiHEMs2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 08:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHEMs1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 08:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D593175A7
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 05:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D187861A43
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 12:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0263CC433D7;
        Fri,  5 Aug 2022 12:48:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M8dPhoUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659703699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4NrhcEjpw9Lq9/iIXgxKiypFZXFjHgXpfkuLSB3Izw=;
        b=M8dPhoUEY48No20FG6YkbwRHCVyOo2hbfFBRaKys3p2ykPnzDMAXnSDrdodxk/c7hcCHqr
        MCCIo/fHg+3jVC0W95XdNzaqnwzS9jLOf/mtIl06d2oBWY0/qt/OLsyohu/GQS5PfZGheV
        oF3ysb+lIeFp1qq2EGS7Qfv66AWzgzw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eee15885 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 5 Aug 2022 12:48:18 +0000 (UTC)
Date:   Fri, 5 Aug 2022 14:47:27 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
Message-ID: <Yu0RX2b+e9BpGsJ6@zx2c4.com>
References: <YuxOgtykRQb1HU3e@zx2c4.com>
 <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Paolo,

On Fri, Aug 05, 2022 at 10:10:02AM +0200, Paolo Bonzini wrote:
> On 8/5/22 01:04, Jason A. Donenfeld wrote:
> > +    /* Nothing else uses this part of the hardware mapped region */
> > +    setup_data_base = 0xfffff - 0x1000;
> 
> Isn't this where the BIOS lives?  I don't think this works.

That's the segment dedicated to ROM and hardware mapped addresses. So
that's a place to put ROM material. No actual software will use it.

Jason
