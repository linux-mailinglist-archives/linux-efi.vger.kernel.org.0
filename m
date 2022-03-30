Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611664EBBAE
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiC3HZu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiC3HZT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 03:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15316C74A4;
        Wed, 30 Mar 2022 00:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5650B81AD7;
        Wed, 30 Mar 2022 07:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F760C34111;
        Wed, 30 Mar 2022 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648625009;
        bh=R/T3aArnlfnflrQnUboyFDwT5H72naKb57OFEjZvwXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pYgUsZCZMzg7mgWSVuaElaVir7+gwCfkNU4yxoIlbZzU0XX2DCCkKzvnskfofb8p+
         sP2xpKB8J+sEzTtGcDmMJd07m90nAs/b/eKyy+c5VOmoCe+ASxUbsiX5IYnAQ/EHug
         jc+VZDuJE5lnhm8zu0NElEVrC5nUm5QZ5hIXw86CqdPjvrv0BM//avG9GRkKvIMQTu
         IdLKh/uStmSwtjc8H9WWuecZirkRfx/tfUjKgFRsSLJH9CLjdWm3NVZ1d6MpQcQSn4
         zwdzhk6cJa5qFy2/iBBAvVoTx0bW1FiZwwYlunYQKaJICGG7iwM3FYie7PfDTeevSC
         UMdwFEnRX7QmA==
Received: by mail-oi1-f170.google.com with SMTP id w127so21263127oig.10;
        Wed, 30 Mar 2022 00:23:29 -0700 (PDT)
X-Gm-Message-State: AOAM532/a2tQKyPacC2tBFPCTTLNh6d3fHAmAiPao3Uo/ZzEM/h6pWbe
        vmyopLMZN70gzrCn3RE2kfyin/InYja1aK6HVZU=
X-Google-Smtp-Source: ABdhPJyDL6KJdy5vGqVb+2rxElgdip3XqfStt1O8bFFMxdGbREHYsnQCKndJhNt08PYL76Hra1F5wz1zTTVlRefmbDw=
X-Received: by 2002:aca:674c:0:b0:2d9:c460:707c with SMTP id
 b12-20020aca674c000000b002d9c460707cmr1276853oiy.126.1648625008413; Wed, 30
 Mar 2022 00:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <20220330071103.GA809@srcf.ucam.org> <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
 <20220330071859.GA992@srcf.ucam.org>
In-Reply-To: <20220330071859.GA992@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Mar 2022 09:23:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHfw75GphiewQzbA-swsMD3AGunyhc9HSue_xqrHt9GhQ@mail.gmail.com>
Message-ID: <CAMj1kXHfw75GphiewQzbA-swsMD3AGunyhc9HSue_xqrHt9GhQ@mail.gmail.com>
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

On Wed, 30 Mar 2022 at 09:19, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Mar 30, 2022 at 09:12:19AM +0200, Ard Biesheuvel wrote:
> > On Wed, 30 Mar 2022 at 09:11, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > The EFI stub carries out a bunch of actions that have meaningful
> > > security impact, and that's material that should be measured. Having the
> > > secure launch kernel execute the stub without awareness of what it does
> > > means it would need to measure the code without measuring the state,
> > > while the goal of DRTM solutions is to measure state rather than the
> > > code.
> >
> > But how is that any different from the early kernel code?
>
> From a conceptual perspective we've thought of the EFI stub as being
> logically part of the bootloader rather than the early kernel, and the
> bootloader is a point where the line is drawn. My guy feeling is that
> jumping into the secure kernel environment before EBS has been called is
> likely to end badly.

If you jump back into the system firmware, sure.

But the point I was trying to make is that you can replace that with
your own minimal implementation of EFI that just exposes a memory map
and some protocols and nothing else, and then the secure launch kernel
would be entirely in charge of the execution environment.

In fact, I have been experimenting with running the EFI stub
unprivileged on arm64, which would give the secure launch kernel very
tight control over what goes on between the stub entry and
ExitBootServices(). I would be happy to entertain patches that remove
any issues that complicate running the stub unprivileged for x86 or
other architectures.
