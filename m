Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3814EBBE2
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiC3HlX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiC3HlW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 03:41:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83851AF13;
        Wed, 30 Mar 2022 00:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E6B8B81B7D;
        Wed, 30 Mar 2022 07:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C97EC34118;
        Wed, 30 Mar 2022 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648625975;
        bh=0XeYhsl1ZxDhV4sY7GOOVxgbryVcP5F+HskgMIPxod4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ExC06KErHmWeEDo4Zhv8jhhzxIMG1rqWzp0/vfcmYfr8GgJgfXb0rTaznNTAdclYy
         k+piUt5CgH2QgNxa1be2bTf3tleGz4lc0hOvN08BW9W8xdHxqitPJYii4yGdKurXTt
         o0diCJUcD86JGy8q4nRLORpmkkr0i1coHwvI/ZduND1fyRqqnThtp9JBq4t1KCvp5D
         ykOCCxMMgx3Y+DOQWGc4iNnoofojEzIYGVOTPiOJaq2qf3SEENS475t/5amuAk3kib
         gYMB1JKlv2PI4q0yPeNS8sbajJMLg3WmvQfP9XhoJbDjz6l00H41Qa/e2UMu9yxjDo
         T3NYuemXFHnig==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-df26ea5bfbso3687338fac.1;
        Wed, 30 Mar 2022 00:39:35 -0700 (PDT)
X-Gm-Message-State: AOAM532IVYWfTOxQIhJgrVm5Ln7K1HrCq+tFS1W2PPfcQZmC7KVAJMtZ
        oPAYt6YHE0TsQyPB4uRmi6J5HKshzrzL4kPo2GA=
X-Google-Smtp-Source: ABdhPJx225Afar3LspP5RUzbPIziwrBqv25u8nl0BGy9GSxxPrtSeWBL3rp23u5kP4NBabwsdgPEW2W657+hTk1C3Bw=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1580495oap.228.1648625974238; Wed, 30
 Mar 2022 00:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <20220330071103.GA809@srcf.ucam.org> <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
 <20220330071859.GA992@srcf.ucam.org> <CAMj1kXHfw75GphiewQzbA-swsMD3AGunyhc9HSue_xqrHt9GhQ@mail.gmail.com>
 <20220330072755.GA1169@srcf.ucam.org>
In-Reply-To: <20220330072755.GA1169@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 09:39:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHJxmdLie1JE=k3O4zne8tHED7g63rj42q-sL_JQUpvNw@mail.gmail.com>
Message-ID: <CAMj1kXHJxmdLie1JE=k3O4zne8tHED7g63rj42q-sL_JQUpvNw@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Kees Cook <keescook@chromium.org>
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

On Wed, 30 Mar 2022 at 09:27, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Mar 30, 2022 at 09:23:17AM +0200, Ard Biesheuvel wrote:
> > On Wed, 30 Mar 2022 at 09:19, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > From a conceptual perspective we've thought of the EFI stub as being
> > > logically part of the bootloader rather than the early kernel, and the
> > > bootloader is a point where the line is drawn. My guy feeling is that
> > > jumping into the secure kernel environment before EBS has been called is
> > > likely to end badly.
> >
> > If you jump back into the system firmware, sure.
> >
> > But the point I was trying to make is that you can replace that with
> > your own minimal implementation of EFI that just exposes a memory map
> > and some protocols and nothing else, and then the secure launch kernel
> > would be entirely in charge of the execution environment.
>
> We can't just replace system firmware with an imitation of the same -
> for instance, configuring the cold boot prevention memory overwrite
> requires us to pass a variable through to the real firmware, and that's
> something that we do in the stub.
>

But these are exactly the kinds of things the secure launch kernel
wants to be made aware of, no? The secure launch kernel could just
MITM the calls that it chooses to allow, and serve other calls itself.

But more fundamentally, I am failing to see the distinction here
between stub code and other kernel code. Is it related to the exact
moment the secure launch event is triggered?

The way I see it, being able to marshall everything that goes on
between the stub and the secure launch kernel allows the latter to
make an informed decision about how the stub has manipulated the
global system state before triggering the secure launch event at
exitbootservices time.

But perhaps my mental model is simply too inaccurate - it would be
helpful to understand what exactly needs to be locked down, and what
aspects of the system state are of interest for the DRTM measurements.
