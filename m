Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C348B589C90
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 15:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiHDNZ7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiHDNZ6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 09:25:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B0BE3D
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 06:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B175CE2625
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 13:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A6C4347C
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 13:25:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KvF7F/jT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659619550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJwChJPqW5yYgZvwHhdHDcO5vZjLpvP+FfYNZRPIs/g=;
        b=KvF7F/jTWTei3Ylx8KpVUMsXR++z/X9kxskbih2vi44wJPldRf3rf26Xn2wxn3yu9ZxibM
        eAXsLMEffmh2C5hefTWf1Wz3yhQgOkuBMGWn3yDDkqvszm7hDd52VCbjf1n1hZ7YikZcKr
        Xh/mH8U5Jb/6K8ZejXHH4wu6L1fFHFM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5497a4f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Thu, 4 Aug 2022 13:25:49 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31f443e276fso200691147b3.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 06:25:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo3IckyB9OJmEAlGDwuatAP/mFSW1w7TNq7Mrjj5DaUoDi/1HtNU
        s2VVvrqqd7vVAZUd6WMLUHAMp++tOx1oWFXN2ro=
X-Google-Smtp-Source: AA6agR7VGtCGDy/xKzbNIibGDkvBRNQqDdAzczsuC9aF07Ujc+qdaysyi5sjNLsMZUR8VVk6yeBqaUU5f63RfmjsN9I=
X-Received: by 2002:a81:1590:0:b0:328:2f5c:4704 with SMTP id
 138-20020a811590000000b003282f5c4704mr1731575ywv.79.1659619548364; Thu, 04
 Aug 2022 06:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <YusVVLNbLgsk49PK@zx2c4.com> <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org> <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com> <CAMj1kXFr6Bv4_G0-wCTu4fp_iCrG060NHJx_j2dbnyiFJKYYeQ@mail.gmail.com>
 <eadc852a-63f9-a017-aef7-f046eb56e28f@redhat.com> <Yuu3YeTRLE/gx6YC@zx2c4.com>
 <CAHmME9qQQZH1+Dy4zY5L-MdxN4kXtujW9XaH1x+RyCn-SjsTOA@mail.gmail.com> <5528ca40-50fb-8e92-7f24-80e20c4c983e@redhat.com>
In-Reply-To: <5528ca40-50fb-8e92-7f24-80e20c4c983e@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 4 Aug 2022 15:25:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9pjwaHeczJjLgZoXe__J_OnMH4zAnwFyo=ieMtj7QMEDw@mail.gmail.com>
Message-ID: <CAHmME9pjwaHeczJjLgZoXe__J_OnMH4zAnwFyo=ieMtj7QMEDw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Aug 4, 2022 at 3:17 PM Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 08/04/22 14:47, Jason A. Donenfeld wrote:
> > On Thu, Aug 4, 2022 at 2:11 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>
> >> Hi Laszlo,
> >>
> >> On Thu, Aug 04, 2022 at 01:31:36PM +0200, Laszlo Ersek wrote:
> >>> None of the existing info passing methods seem early enough, generic
> >>> enough, and secure enough (at the same time)...
> >>
> >> Can you look at the v2 patch? It seems to work on every configuration I
> >> throw at it. Keep in mind that setup_data is only used very, very early.
> >> I can think of a few other places to put it too, looking at the x86
> >> memory map, that will survive long enough.
> >>
> >> I think this might actually be a straightforwardly solvable problem if
> >> you think about it more basically.
> >
> > And just to put things in perspective here... We only need like 48
> > bytes or something at some easy fixed address. That's not much. That's
> > *got* to be a fairly tractable problem. If v2 has issues, I can't see
> > why there wouldn't be a different easy place to put a meger 48 bytes
> > of stuff that then is allowed to be wiped out after early boot.
>
> I've looked at v2. It still relies on passing information from QEMU to
> the guest kernel through guest RAM such that the whole firmware
> execution takes place in-between, without the firmware knowing anything
> about that particular area -- effectively treating it as free system
> RAM. Such exceptions are time bombs.
>
> We *have* used hard-coded addresses, sometimes they are unavoidable, but
> then they are open-coded in both QEMU and the firmware, and some early
> part of the firmware takes care to either move the data to a "safe"
> place, or to cover it in-place with a kind of reservation that prevents
> other parts of the firmware from trampling over it. I've debugged
> mistakes (memory corruption) when such reservation was forgotten; it's
> not fun.
>
> In short, I have nothing against the QEMU patch, but then the current
> OvmfPkg maintainers should accept a patch for the firmware too, for
> protecting the area from later firmware components, as early as possible.

What you say mostly makes sense. Though, I was wondering if there's
some unused space (maybe a historical low address) that nothing
touches because it's always been considered reserved. Some kind of
ancient video data region, for example. We only need 48 bytes after
all... My hope was that somebody with a lot of deep x86 knowledge
would be able to smell their way to something that's always good like
that. (Alternatively, there's my real_addr thing from v2.)

Jason
