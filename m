Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6904D6225F6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKII4w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKII4w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 03:56:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521B1C413
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 00:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3154B81D46
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 08:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B011C433D7
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667984208;
        bh=eVH+Zo4NA6upQDThOyUxhxtnhMaiTbA87NjaQrYQjlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rFZWuHFCqjyoNBswyEQp4WUFN1oQcY9sjrLSt+TAq+EG8HBw3zshEVtTmT55v+giq
         aAed/NeFpQuzXVM0kfNh4ejDnnfGJe8PMZcjWklBya1iH3hyLIRYaLSM1PaM3s6DLu
         mC4lrK/coZ2+fi8Pwsb954L3HvKvapV0FKBCRM5RT/mnEe7ocRwPyY1R8ep/aq6Utq
         njSel+7Vb5IR5b/YP+QiX1nCV7SxnEA7ja3MCIZJ4UqFmpmIBUMpxODJKFH0ZWdI9i
         /gwB2dGpUyuxK/tgDk7R3L1K5wWZYk5QuINb7f0JZpoIl/KAwHPNojTr7b13laOkSD
         2z0pNAKaQNQSw==
Received: by mail-lj1-f182.google.com with SMTP id c25so24717010ljr.8
        for <linux-efi@vger.kernel.org>; Wed, 09 Nov 2022 00:56:48 -0800 (PST)
X-Gm-Message-State: ACrzQf0juCtqJKo17so+Q6J+mZqCsWhF1AR0xMVSBRvGOc9xtK/NnhI7
        j22crt3H/XWt34qUMg47+FE9UanYh9b7IKOPIXg=
X-Google-Smtp-Source: AMsMyM59Vv5Iuoqq8Eu+MzZnXsh7dIM7NNE7Uc1szsQB4DunVha9ePjMNMEqEBR0slK6J9UvmOROzLJQHnGa2IY44oU=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr21789379lji.291.1667984206654; Wed, 09
 Nov 2022 00:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20221107083134.234918-1-ardb@kernel.org> <CALu+AoRXJbvYWoKijLt2vK2G-zsv7ro8d4NEMOsLrowsmrYmKw@mail.gmail.com>
In-Reply-To: <CALu+AoRXJbvYWoKijLt2vK2G-zsv7ro8d4NEMOsLrowsmrYmKw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 09:56:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEjGD7dAPpzShqUyctCqNTTjJK2SUHd_WYgqMa7bakiRQ@mail.gmail.com>
Message-ID: <CAMj1kXEjGD7dAPpzShqUyctCqNTTjJK2SUHd_WYgqMa7bakiRQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi/x86: Move runtime map sysfs code into arch/x86
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 8 Nov 2022 at 04:47, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Ard,
>
> On Mon, 7 Nov 2022 at 16:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The EFI runtime map code is only used on x86, so let's move it out of
> > the generic code and into arch/x86. While at it, clarify the Kconfig
> > description so that it gets enabled automatically when required (i.e.,
> > when kexec is enabled), and can only be disabled when CONFIG_EXPERT=y
> >
> > Ard Biesheuvel (2):
> >   efi: runtime-maps: Clarify purpose and enable by default for kexec
> >   efi: x86: Move EFI runtime map sysfs code to arch/x86
>
> For the series:
>
> Reviewed-by: Dave Young <dyoung@redhat.com>
>

Thanks Dave, I've queued these up now.

> >
> >  arch/x86/Kconfig                                          | 11 ++++++++
> >  arch/x86/include/asm/efi.h                                | 22 +++++++++++++++
> >  arch/x86/platform/efi/Makefile                            |  1 +
> >  {drivers/firmware => arch/x86/platform}/efi/runtime-map.c |  6 ++---
> >  drivers/firmware/efi/Kconfig                              | 11 --------
> >  drivers/firmware/efi/Makefile                             |  1 -
> >  drivers/firmware/efi/efi.c                                |  5 +---
> >  include/linux/efi.h                                       | 28 --------------------
> >  8 files changed, 38 insertions(+), 47 deletions(-)
> >  rename {drivers/firmware => arch/x86/platform}/efi/runtime-map.c (97%)
> >
> > --
> > 2.35.1
> >
>
