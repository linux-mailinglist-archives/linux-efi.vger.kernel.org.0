Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FB1DE841
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgEVNoe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 09:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVNod (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 09:44:33 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C07207D8;
        Fri, 22 May 2020 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590155073;
        bh=uJcG2OQ2rSI4SuWWuLzjgm2Ceju6BKG1zcJBZTzbQ8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lw24PK1kRgyDaZ0ciGSyLQ/QWtRXiiAHFW6rlKtsogEp3Tat4AnELfuXBDpiCTP0V
         aCdwu+mGw1W7icZlD9oxFmBRSqWIGRxjmi92ia5Zxmmn4ASsYuA3bBk201wu6fAvc9
         o3uDJyV1B7QJSQJ5DK+ISNPv19wIs921sVCNq2w8=
Received: by mail-il1-f177.google.com with SMTP id w18so10651521ilm.13;
        Fri, 22 May 2020 06:44:33 -0700 (PDT)
X-Gm-Message-State: AOAM5323MKaZ64Svb5I6igjMMrnJEGko9WTP/VuWoNIWth9ucpik+NPV
        XVIu/8wCr9wy3wLQlW3O2HBnpiLKCWjf6Ctwa4k=
X-Google-Smtp-Source: ABdhPJzbGhgU2FO1RXLapvTMCcL+3fVf/Gte05lXmIm8Z1k+ZjyZdMHtkgAqfkOyO6a0rnF/fPLfTlqqhi07lUxOhN0=
X-Received: by 2002:a92:5ec1:: with SMTP id f62mr10773461ilg.80.1590155072870;
 Fri, 22 May 2020 06:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200517125754.8934-1-ardb@kernel.org> <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com>
 <20200522134004.GF28750@zn.tnic>
In-Reply-To: <20200522134004.GF28750@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 May 2020 15:44:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHogO=3wAyZPi9WtHP9++N5KH6OjNgY_CQ_o8nZJ5jjVA@mail.gmail.com>
Message-ID: <CAMj1kXHogO=3wAyZPi9WtHP9++N5KH6OjNgY_CQ_o8nZJ5jjVA@mail.gmail.com>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 22 May 2020 at 15:40, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, May 22, 2020 at 03:06:20PM +0200, Ard Biesheuvel wrote:
> > Ping?
>
> Did you want to make your tags unique from the next pull request onwards
> and I were supposed to pull this one as is?
>

What usually happens is that Ingo applies the patches piecemeal,
ignoring the tag altogether, so without any coordination between you
as x86 maintainers or communication back to me, that is what i was
expecting to happen this time as well.

Note that I have another PR pending since two weeks ago [0].

So if you want to start dealing with the EFI trees in a different way
from now on, that is perfectly fine with me, but please align with
Ingo and Thomas first.

Thanks,
Ard.



[0] https://lore.kernel.org/linux-efi/20200508180157.1816-1-ardb@kernel.org/
