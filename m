Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75028589564
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiHDAj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Aug 2022 20:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiHDAj4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Aug 2022 20:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1B5018F
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 17:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C103C61744
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 00:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270F7C433D6;
        Thu,  4 Aug 2022 00:39:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fjyTt1s0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659573591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvSXlWD+cS9yGOzybyFGDKHO/SGsFqKKLZblP+7jNRE=;
        b=fjyTt1s0K4PmgcKdDSS2CXfWUyFTpYssqh0lf0T5W+BwqNdgaxm9tbyq+sryjOBc/rNoV3
        LUiYDlkZ21fRnAOQBm4qTpKq6wCTZEg07he/eC4VrZ66JJLHG1FjAiZ3uItroH8WzUNPy4
        e2sQU9q/QX6q0z2LXrhQM5Jv9XfZdBM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 478e5ec0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Aug 2022 00:39:50 +0000 (UTC)
Date:   Thu, 4 Aug 2022 02:39:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC v1] hw/i386: place setup_data at fixed place in memory
Message-ID: <YusVVLNbLgsk49PK@zx2c4.com>
References: <20220803170235.1312978-1-Jason@zx2c4.com>
 <20220803182340-mutt-send-email-mst@kernel.org>
 <Yur7ypNrSv8eO9/Q@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yur7ypNrSv8eO9/Q@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey again,

On Thu, Aug 04, 2022 at 12:50:50AM +0200, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Wed, Aug 03, 2022 at 06:25:39PM -0400, Michael S. Tsirkin wrote:
> > > -    /* Offset 0x250 is a pointer to the first setup_data link. */
> > > -    stq_p(header + 0x250, first_setup_data);
> > > +    if (first_setup_data) {
> > > +            /* Offset 0x250 is a pointer to the first setup_data link. */
> > > +            stq_p(header + 0x250, first_setup_data);
> > > +            rom_add_blob("setup_data", setup_datas, setup_data_total_len, setup_data_total_len,
> > > +                         SETUP_DATA_PHYS_BASE, NULL, NULL, NULL, NULL, false);
> > > +    }
> > > +
> > >
> > 
> > Allocating memory on x86 is tricky business.  Can we maybe use bios-linker-loader
> > with COMMAND_WRITE_POINTER to get an address from firmware?
> 
> Hmm. Is BIOSLinker even available to us at this stage in preparation?
> 
> One thing to note is that this memory doesn't really need to be
> persistent. It's only used extreeeemely early in boot. So it could be
> somewhere that gets used/remapped later on.

Actually, it's possible there's one place that's already available, and
that this isn't so bad after all. In my tests, this seems to be working
in a wide variety of configurations. I'll send a v2.

Jason
