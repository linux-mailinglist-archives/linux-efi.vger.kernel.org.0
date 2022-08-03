Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112A5589490
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHCWvZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Aug 2022 18:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiHCWvI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Aug 2022 18:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04FC13D1C
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 15:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F386164E
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 22:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B22C433D6;
        Wed,  3 Aug 2022 22:50:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ef9YMf0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659567052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTyfEeO9m1KFrXGl4270txc6Nr3v53BZLdMSL0IIQRk=;
        b=Ef9YMf0KczdRHsV0iUdGZveBHMm1OvFzMqT5Xeagyx44fwS5q2AAnk2Fz7zGQDSSBidCUf
        pUByTcevdvzDqIHIHjyDCTR1CThK1ElyAcD/jHxpon5R41GKi/0jSvLKGtX4DeFfNyha4c
        Xk+OOR08ADwUsEF2OYJvwPo31dysTIQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c703dd86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 Aug 2022 22:50:52 +0000 (UTC)
Date:   Thu, 4 Aug 2022 00:50:50 +0200
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
Message-ID: <Yur7ypNrSv8eO9/Q@zx2c4.com>
References: <20220803170235.1312978-1-Jason@zx2c4.com>
 <20220803182340-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220803182340-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Michael,

On Wed, Aug 03, 2022 at 06:25:39PM -0400, Michael S. Tsirkin wrote:
> > -    /* Offset 0x250 is a pointer to the first setup_data link. */
> > -    stq_p(header + 0x250, first_setup_data);
> > +    if (first_setup_data) {
> > +            /* Offset 0x250 is a pointer to the first setup_data link. */
> > +            stq_p(header + 0x250, first_setup_data);
> > +            rom_add_blob("setup_data", setup_datas, setup_data_total_len, setup_data_total_len,
> > +                         SETUP_DATA_PHYS_BASE, NULL, NULL, NULL, NULL, false);
> > +    }
> > +
> >
> 
> Allocating memory on x86 is tricky business.  Can we maybe use bios-linker-loader
> with COMMAND_WRITE_POINTER to get an address from firmware?

Hmm. Is BIOSLinker even available to us at this stage in preparation?

One thing to note is that this memory doesn't really need to be
persistent. It's only used extreeeemely early in boot. So it could be
somewhere that gets used/remapped later on.

Jason
