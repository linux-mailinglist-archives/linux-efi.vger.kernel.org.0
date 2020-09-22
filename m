Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34555274534
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVP0M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 11:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgIVP0L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Sep 2020 11:26:11 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E2B2075E
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600788370;
        bh=fdkOB95sADWwZavkaqHQDRTo4xEzI9y1dh3A7VyjwSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DRW07Ck0X54oFXooGluPImpJUQxiJrEZX8SydAwcJNDEit4ZPd7aNeh3WCed3IVw1
         5Z/HwBzre6kfvpeYn9hXZTtGtsalWCynzLQp+B4QvZJudeW2SQUOgvzQPh0ZG2p2Cq
         CZAHKu2jPTlYbeKY3ep9GS03P/Limp0tLviwbfwQ=
Received: by mail-oi1-f181.google.com with SMTP id x69so21412105oia.8
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 08:26:10 -0700 (PDT)
X-Gm-Message-State: AOAM533KWrZBqO+8uLa2w4w5hiPnhBSr53ubeMF70A1dOqKmSecUuSRa
        xxSfDAl/hQX43G0WtePs0SQVKTacVhgDv/pWiBA=
X-Google-Smtp-Source: ABdhPJx4ZqpTpDgW9K+kE6zyVU+cMw2Ul74cPwv6oTbT77zPxP5Al0VlHBd3f9rh7ymVVCrOZYe5DhCFYfQYCgV7whc=
X-Received: by 2002:a54:4517:: with SMTP id l23mr3082701oil.174.1600788370154;
 Tue, 22 Sep 2020 08:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-11-ardb@kernel.org>
 <CACRpkda=P-Kc=-ZhZo8vtW9CrFfCiBvfkqwfdipz4WO2Gb2L_g@mail.gmail.com>
 <CAMj1kXG+XuauH93OuQzx_2huWrUca+S6SKwqogXiaR2sQB727w@mail.gmail.com> <nycvar.YSQ.7.78.906.2009221109510.2680@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.78.906.2009221109510.2680@knanqh.ubzr>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 17:25:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgwan4gjHRwxwis9315rwFHkKM4WGinm7u--R+uarGXQ@mail.gmail.com>
Message-ID: <CAMj1kXHgwan4gjHRwxwis9315rwFHkKM4WGinm7u--R+uarGXQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: p2v: reduce p2v alignment requirement to 2 MiB
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Sep 2020 at 17:12, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Tue, 22 Sep 2020, Ard Biesheuvel wrote:
>
> > By changing the patchable sequences and the patching logic to carry
> > more bits of offset, we can improve this: 11 bits gives us 4 GiB >> 11
> > == 2 MiB granularity, and so you never waste more than that amount by
> > rounding up the physical start of DRAM to the next multiple of 2 MiB.
> > (Note that 2 MiB granularity guarantees that the linear mapping can be
> > created efficiently, whereas less than 2 MiB may result in the linear
> > mapping needing another level of page tables)
>
> That is IMHO the top argument for limiting it to 2 MiB.
> It would be worth making this explicit in the commit log.
>

OK, I will merge this paragraph into the commit log.
