Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1C589B78
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiHDMLW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDMLW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:11:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F225E98
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08D0DB82449
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8B4C433C1;
        Thu,  4 Aug 2022 12:11:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="REjCpMC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659615076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiSEeWRQb6joG6MZeiuccFEoGsTnn1HIxi6dV4Mq9J8=;
        b=REjCpMC4X1jxFq2qBATBn3v49cMIE0+FeaCCCylhQgmAU2LuzNvRLNz5LyGnxC/ziZs7ba
        Jtar7MESK1ocuMggiJ8rgcUt6BrQcyoJrRKN3o77S1awYnnLxojNseIAfGM3A7CsSCM6nM
        lvLPucQtgeRzD+gkpqxHm1Jt3eGQRzA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f5eacb56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Aug 2022 12:11:15 +0000 (UTC)
Date:   Thu, 4 Aug 2022 14:11:13 +0200
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
Message-ID: <Yuu3YeTRLE/gx6YC@zx2c4.com>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <CAMj1kXFr6Bv4_G0-wCTu4fp_iCrG060NHJx_j2dbnyiFJKYYeQ@mail.gmail.com>
 <eadc852a-63f9-a017-aef7-f046eb56e28f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eadc852a-63f9-a017-aef7-f046eb56e28f@redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Laszlo,

On Thu, Aug 04, 2022 at 01:31:36PM +0200, Laszlo Ersek wrote:
> None of the existing info passing methods seem early enough, generic
> enough, and secure enough (at the same time)...

Can you look at the v2 patch? It seems to work on every configuration I
throw at it. Keep in mind that setup_data is only used very, very early.
I can think of a few other places to put it too, looking at the x86
memory map, that will survive long enough.

I think this might actually be a straightforwardly solvable problem if
you think about it more basically.

Jason
