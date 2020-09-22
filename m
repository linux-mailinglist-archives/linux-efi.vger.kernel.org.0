Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58A1273F17
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 12:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIVKA3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 06:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVKA2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Sep 2020 06:00:28 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C41238A1
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600768828;
        bh=XwNjZd1KT0Bq1tYNPxSB5WlmPxjC67ZecncYcuP04Fo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dmg0Sz61YTCcwBY7SLbK1E10/CoicQwE95QMiNPTfUf3W/JNHsIQ2ZaOHvEAmFYUe
         l0pPpPfg8W77HSYIFadxoRCR74uaNlGoafio6hYOHkPcKkwQ0g/s61ZpbdmXYR6/u/
         2wSs/oZT6lQ3oJyxMbz6zPjpV5ntxgmas1swjZkQ=
Received: by mail-oi1-f178.google.com with SMTP id u126so20376216oif.13
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 03:00:28 -0700 (PDT)
X-Gm-Message-State: AOAM532mlfVtW2+4ASXEfX5ZL4RcEqT8bwpfMFlJ9BkLkm8pze2mjLUm
        Ox2KqVIqgzmPeJneAuvTFTD2LSHJHu47eOMvvgA=
X-Google-Smtp-Source: ABdhPJwjLsT6FYhaw3eWOA1H2yEpTz9h0rbfTM3ahe6+GIJoH1glgtoSM+ReI6OJ+swkJJTxygefqOITRNi0TSyB5+8=
X-Received: by 2002:aca:d845:: with SMTP id p66mr1993448oig.47.1600768827405;
 Tue, 22 Sep 2020 03:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-6-ardb@kernel.org>
 <CACRpkdactgVcSsm8wpqSDg=JkSM102GkeS4EM2YRr7y_hDDRFg@mail.gmail.com>
In-Reply-To: <CACRpkdactgVcSsm8wpqSDg=JkSM102GkeS4EM2YRr7y_hDDRFg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 12:00:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFo4xX+-b9cLYXqnJmKfQ0R+HQyjQrJ6XvHRo0P2YBWZg@mail.gmail.com>
Message-ID: <CAMj1kXFo4xX+-b9cLYXqnJmKfQ0R+HQyjQrJ6XvHRo0P2YBWZg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] ARM: p2v: factor out BE8 handling
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Sep 2020 at 10:51, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > The big and little endian versions of the ARM p2v patching routine only
> > differ in the values of the constants, so factor those out into macros
> > so that we only have one version of the logic sequence to maintain.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Since you had patch 1 fixing up BE on LPAE I suppose
> it is implicit in the commit that this was tested with BE
> on classic MMU and LPAE. Very nice patch!
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

I tested this to the extent possible on the hardware I have available,
but this does not include Keystone2, which does the funky remapping of
the physical mapping of DRAM. I don't think we have such hardware in
kernelci though ...
