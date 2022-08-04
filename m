Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51F589BE1
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiHDMrd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiHDMr2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:47:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31031E3DC
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FAF2B82528
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286DFC433C1
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 12:47:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i6ZNWnpE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659617240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAXGyIxUn4hcMqb27DFCWyb6XuANRmBrMYgNdrS7MhY=;
        b=i6ZNWnpEG+WZ3kZOqbnXfmD8SsY0Ag/fAaQR+Am6Dry7Wc4f8duu70YDngPTWC5h7eRFRZ
        JiZBTK186sYw+mdZv0VKwj+6XOeFEk62Nb25FopsLK+mGPcnxs3ZL4J1K1RGBoIxEj7tB/
        /JJAdGhAMfs4E/tqdrhyqV8kqirmZA0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c743019b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Thu, 4 Aug 2022 12:47:20 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-32269d60830so199508047b3.2
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 05:47:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo2o6w91YD7pJ+w4Dhz+JGIf+A/j7fUPj3kw/RQsnLS0z5SDElzf
        LzixulZE83KQmAtOZs2VXVFIC604cxmgpTRUvqc=
X-Google-Smtp-Source: AA6agR7KRBephODycnpxsH5pnFL9H2EiQgK1FhjFDV/LGhi4J60cmLVby1E61gmT3x955E8jyVPK/adfiBB8MJQQ3u0=
X-Received: by 2002:a0d:f082:0:b0:31f:1d1d:118d with SMTP id
 z124-20020a0df082000000b0031f1d1d118dmr1551196ywe.124.1659617238797; Thu, 04
 Aug 2022 05:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <YusVVLNbLgsk49PK@zx2c4.com> <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org> <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com> <CAMj1kXFr6Bv4_G0-wCTu4fp_iCrG060NHJx_j2dbnyiFJKYYeQ@mail.gmail.com>
 <eadc852a-63f9-a017-aef7-f046eb56e28f@redhat.com> <Yuu3YeTRLE/gx6YC@zx2c4.com>
In-Reply-To: <Yuu3YeTRLE/gx6YC@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 4 Aug 2022 14:47:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9qQQZH1+Dy4zY5L-MdxN4kXtujW9XaH1x+RyCn-SjsTOA@mail.gmail.com>
Message-ID: <CAHmME9qQQZH1+Dy4zY5L-MdxN4kXtujW9XaH1x+RyCn-SjsTOA@mail.gmail.com>
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

On Thu, Aug 4, 2022 at 2:11 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Laszlo,
>
> On Thu, Aug 04, 2022 at 01:31:36PM +0200, Laszlo Ersek wrote:
> > None of the existing info passing methods seem early enough, generic
> > enough, and secure enough (at the same time)...
>
> Can you look at the v2 patch? It seems to work on every configuration I
> throw at it. Keep in mind that setup_data is only used very, very early.
> I can think of a few other places to put it too, looking at the x86
> memory map, that will survive long enough.
>
> I think this might actually be a straightforwardly solvable problem if
> you think about it more basically.

And just to put things in perspective here... We only need like 48
bytes or something at some easy fixed address. That's not much. That's
*got* to be a fairly tractable problem. If v2 has issues, I can't see
why there wouldn't be a different easy place to put a meger 48 bytes
of stuff that then is allowed to be wiped out after early boot.

Jason
