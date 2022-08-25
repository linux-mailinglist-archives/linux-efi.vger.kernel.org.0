Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7754C5A0C5E
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiHYJSr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbiHYJST (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 05:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5330DA0635
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 02:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FD761B8D
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 09:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F83C433B5
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419093;
        bh=hEwlboP3RBFNrx2oNCf5Qin7BNeTZ2hbRMxWmTZQkxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rENg2noZ7qwZjRC7USMStNXRkDRhuyRysjUG4LkpksS6pZQAP3HAnc50tgEifTJg1
         Vnz8YqS11MQwvs0nGI50xtNqA0eRS4dFidytTaw4Et1bcj+3a1gLlduCh26FETHQLm
         k0u1rRMKZEgclXnBR2kx2BhuJiwhsm6x4gBcNwG2YJI/7KQS8Dzb7XtfARkSzrch2Z
         Yg6VP/Jb1Bayw8LXlYDsYsbTJnJGgk+jVt32ldIcLdGhxDK2MMQv9jPTJxZoZB3LEC
         u5T9Tq24oROeGwmeGEXipGFjZhiT+jhWlDagAbk087i6aJ2oi/dXPgqvDGjSSdk2Tz
         JNd0rAy2Hxpyg==
Received: by mail-wr1-f43.google.com with SMTP id n7so23778353wrv.4
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 02:18:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ElZQMDeiN/33Qj1ZTrXrJdtjHC3dQGQU9x9DQzpDY43bYF7k2
        VYyx019q6XPSgq3mvUVbJR59LvECjgwB0L0LJy4=
X-Google-Smtp-Source: AA6agR7sj85g6run7/9q3ElPHmG3BJu9dcvgn+PmeiICgFkihk/hqiHM9P+cywrvXqk3Da0mNaQ4pfnEtCy54u8S6wM=
X-Received: by 2002:a05:6000:782:b0:225:3e46:3dd5 with SMTP id
 bu2-20020a056000078200b002253e463dd5mr1549377wrb.103.1661419091393; Thu, 25
 Aug 2022 02:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220822172953.3918414-1-ardb@kernel.org> <202208221257.06B78617C5@keescook>
In-Reply-To: <202208221257.06B78617C5@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Aug 2022 11:18:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG=boOiRJh3siwkxCwKWafNnxvbMELZPOOVkROEBbP=zg@mail.gmail.com>
Message-ID: <CAMj1kXG=boOiRJh3siwkxCwKWafNnxvbMELZPOOVkROEBbP=zg@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Disable struct randomization
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 22 Aug 2022 at 21:58, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Aug 22, 2022 at 07:29:53PM +0200, Ard Biesheuvel wrote:
> > The EFI stub is a wrapper around the core kernel that makes it look like
> > a EFI compatible PE/COFF application to the EFI firmware. EFI
> > applications run on top of the EFI runtime, which is heavily based on
> > so-called protocols, which are struct types consisting [mostly] of
> > function pointer members that are instantiated and recorded in a
> > protocol database.
> >
> > These structs look like the ideal randomization candidates to the
> > randstruct plugin (as they only carry function pointers), but of course,
> > these protocols are contracts between the firmware that exposes them,
> > and the EFI applications (including our stubbed kernel) that invoke
> > them. This means that struct randomization for EFI protocols is not a
> > great idea, and given that the stub shares very little data with the
> > core kernel that is represented as a randomizable struct, we're better
> > off just disabling it completely here.
> >
> > Reported-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> > Tested-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>

I've queued this up as a fix with a cc:stable

Thanks all,
Ard.
