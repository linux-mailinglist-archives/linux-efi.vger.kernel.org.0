Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372A589B67
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiHDMDn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbiHDMDi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5B46564D
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FDCDB82520
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA8DC433D6;
        Thu,  4 Aug 2022 12:03:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KCtXlY3a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659614612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzY+1qEB4bBdsPHqGA7lAc00b6IQ30wvQR3vqGuF2Ys=;
        b=KCtXlY3ahUHvEhKHTU8IWB57Sz/mKyyYUzn6Qz28anxxb6XhSXARIQ1r18zlLQvhnck1UB
        tcJso0KGbt04E0xzigk2G9aM9N6IF/Osa5iUMHFBcplM62YPgtSWibNeYUQQ2fo88wmUow
        +AX44lcGHo8Prkp2xbhscxk/LZjMbqM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 167409e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Aug 2022 12:03:31 +0000 (UTC)
Date:   Thu, 4 Aug 2022 14:03:29 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <Yuu1kX9CAqSUNNAj@zx2c4.com>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuuQb3D/YY1SiUqY@redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

On Thu, Aug 04, 2022 at 10:25:36AM +0100, Daniel P. Berrangé wrote:
> Yep, and ultimately the inability to distinguish UEFI vs other firmware
> is arguably correct by design, as the QEMU <-> firmware interface is
> supposed to be arbitrarily pluggable for any firmware implementation
> not  limited to merely UEFI + seabios.

Indeed, I agree with this.

> 
> > For now I suggest either reverting the original patch, or at least not
> > enabling the knob by default for any machine types. In particular, when
> > using MicroVM, the user must leave the knob disabled when direct booting
> > a kernel on OVMF, and the user may or may not enable the knob when
> > direct booting a kernel on SeaBIOS.
> 
> Having it opt-in via a knob would defeat Jason's goal of having the seed
> available automatically.

Yes, adding a knob is absolutely out of the question.

It also doesn't actually solve the problem: this triggers when QEMU
passes a DTB too. It's not just for the new RNG seed thing. This bug
isn't new.

Jason
