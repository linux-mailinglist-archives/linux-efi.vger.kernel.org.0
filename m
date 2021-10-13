Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA842B991
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 09:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhJMHxE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 03:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238626AbhJMHxD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 13 Oct 2021 03:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA3DB60F94;
        Wed, 13 Oct 2021 07:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634111460;
        bh=OXCqkhh4wPeAYcArRqvAfGp3MlPsBVIOg7joR3nwwmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nMCMOuPrDQuPbS+XQ0PC5jK7hV5MAY1+SYszB0z0L3g4lSapQXCtooKSLHzqfRbCA
         uCMvyNLQN4q7rMULxd4s3/QgvyRETNssjKsgsMTIRhKymonkWkAGid8HXpq+W/lCzW
         XWVARwXuGZzXsEmNhax2j7RD2SDGY/1qx3GNAIureFtSSoBEdoIdu9RoOVtSZQI9mN
         JDcheFuwrGoQnxURMtjMLSAj0yTqaTFp3EL67ZzHG8PKLYPVbJeWAUVj0JRnVz2gyZ
         vatgiMENXuuU+tr7jUcx+xEE/M8l+SvbFMKTXDo8+jGEek7+lx8Q4sdX434vEbPFMl
         a6YTvLwpBwyLw==
Received: by mail-ot1-f51.google.com with SMTP id w10-20020a056830280a00b0054e4e6c85a6so2586392otu.5;
        Wed, 13 Oct 2021 00:51:00 -0700 (PDT)
X-Gm-Message-State: AOAM531piHKYS/FT7H9U5fF136dgLVYlgF5ruvY4pNDDsZ9LW2Qo90h7
        46GtcZ+mzOdlk9XsZDPr9nzPHqLVKdrR6rbqRo8=
X-Google-Smtp-Source: ABdhPJyGECDlxM/1cIMBiZbjeplAKBVbiJLIuV2qyOa5uJNP+N0IfjjQq54Bet9dtKDzxCSdFURkpbSkD8XamyDr+Lg=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr30224626oto.112.1634111459964;
 Wed, 13 Oct 2021 00:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <4eccf707f2553f0f66ae3789b5689231@suse.de>
In-Reply-To: <4eccf707f2553f0f66ae3789b5689231@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Oct 2021 09:50:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
Message-ID: <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
Subject: Re: [RESEND] Re: [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL
 output as bootloader randomness"
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 13 Oct 2021 at 09:30, Ivan T. Ivanov <iivanov@suse.de> wrote:
>
> Hi,
>
> Quoting Dominik Brodowski (2021-10-12 11:40:34)
> > Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
> > > This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
> > >
> > > When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled add_bootloader_randomness()
> > > calls add_hwgenerator_randomness() which might sleep,
> >
> > Wouldn't it be better to fix add_bootloader_randomness(), considering
> > that
> > calls to that function are likely to happen quite early during kernel
> > initialization? Especially as it seems to have worked beforehand?
>
> I have tried. I made wait_event_interruptible() optional, but then
> crng_reseed() segfault badly. And I don't think crng_reseed() is
> something that I could fix easily. Suggestions are welcomed ;-)
>

How about

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..1828dc691ebf 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2297,9 +2297,8 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
  */
 void add_bootloader_randomness(const void *buf, unsigned int size)
 {
+       add_device_randomness(buf, size);
        if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
-               add_hwgenerator_randomness(buf, size, size * 8);
-       else
-               add_device_randomness(buf, size);
+               credit_entropy(&input_pool, size * 8);
 }
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
