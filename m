Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330262C88D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 19:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiKPS6U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 13:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiKPS5x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 13:57:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80B63CE6;
        Wed, 16 Nov 2022 10:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 215E461E61;
        Wed, 16 Nov 2022 18:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3846EC433C1;
        Wed, 16 Nov 2022 18:57:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WMsGR+12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668625060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNhNsj8YSgAzmrsU1zFNoUxV5SV96Yhp8Bnx2TEsK2Q=;
        b=WMsGR+12nhysRCYaqwow5tzQBtQnTkF/QyD/ljIOs8i2gk1eg64ovVhnSUXky9Kg+ZftM+
        qh9/cHJYRR+awwWlae0VWz+41Fc+lrgXwJJK2WVDxQTgoG4hR5P+DYR/x9hPGJqPRef14r
        DjllsjAOs+WbENhJsH0Rq0hzgQpvr+A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 80cee11a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 18:57:40 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id a36so5285612uax.9;
        Wed, 16 Nov 2022 10:57:40 -0800 (PST)
X-Gm-Message-State: ANoB5pn4OS2xjj5IP6CvYifCqBe1WFnqjsos//HTa1Td8Lv07hjRRCiu
        OzJqj9z2cnYDH9nMbK9yhZ4Inlap6H4oXKpCjio=
X-Google-Smtp-Source: AA0mqf7ph3A3bnJFE05KZ24alXL+FOnQnQDjALm9NVxTVfoGcvj5eOL9uBPhy+SJdyBWMje+JfW3nSO57Q4ygc1M3iA=
X-Received: by 2002:ab0:2c05:0:b0:40c:caeb:5130 with SMTP id
 l5-20020ab02c05000000b0040ccaeb5130mr13374644uar.24.1668625059928; Wed, 16
 Nov 2022 10:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20221116161642.1670235-1-Jason@zx2c4.com> <Y3UlCjbhXwZG0dEH@gardel-login>
In-Reply-To: <Y3UlCjbhXwZG0dEH@gardel-login>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 16 Nov 2022 19:57:28 +0100
X-Gmail-Original-Message-ID: <CAHmME9o=kDEWxOZ3cjJRaypgn5C9D-G7gzfnF-A2BzNB1ESwig@mail.gmail.com>
Message-ID: <CAHmME9o=kDEWxOZ3cjJRaypgn5C9D-G7gzfnF-A2BzNB1ESwig@mail.gmail.com>
Subject: Re: [PATCH RFC v1 0/6] Use EFI variables for random seed
To:     lennart@poettering.net
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
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

On Wed, Nov 16, 2022 at 6:59 PM Lennart Poettering
<lennart@poettering.net> wrote:
>
> On Mi, 16.11.22 17:16, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
>
> > Commit messages are rather sparse at the moment. I'll fill those out for
> > the next non-RFC patchset if this idea isn't immediately demolished.
> >
> > The biggest consideration is wear leveling on the EFI variable flash
> > chips. However, EFI *already* winds up writing to non-volatile memory on
> > every single boot anyway, so maybe it's not actually a big deal?
>
> So as mentioned elsewhere: This might (probably more than) double the
> wear on the flash chips, since firmware is unlikely to batch these
> writes with the monotonic counter write.
>
> I have no idea how realistic these issues are, there's a lot of
> handwaving involved, but to sidestep the issue I put sd-boot's seed in
> a file on disk (which should not have issues that much with wear)
> instead of efi vars.

Therein lies the rub indeed. Does anybody who knows something about
the hardware and historical hardware know for certain that this would
be a bad idea, or does it really not matter at all? Would be useful to
have some definitive advice here.

Jason
