Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD66273EE0
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVJvH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIVJvF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Sep 2020 05:51:05 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D594A239A1
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600768264;
        bh=IoVnS0L7AEALkU6FTkIebi+FFirfXZhqbQklp2E0Ki4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mpWZg5gISZLhCgl+KDkmqTyO1RHaKxuvjO9X4gzmzDUY2l7sWuWb8Y26RhGfW9usx
         TAR3h75OQtCKYFxKzCGc4xggCmx6LoJKSY43sbj93pzP28rqSIbQcoLpmaIPRlvLQc
         ejrStulHFMyR60kY0Ir089G87QhHqhDytZ/4T3t8=
Received: by mail-oi1-f179.google.com with SMTP id v20so20395860oiv.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:51:04 -0700 (PDT)
X-Gm-Message-State: AOAM531hMs65kEcKHmmG9+qnKRS+sWfGENo94oMTaR/TPiQ6MBVPXxM6
        qWQ0xLa33lKjkRBZmZZHYFwbR1CXlhuHPYGSH8U=
X-Google-Smtp-Source: ABdhPJyV3wzfAn46Va1JuM8pRPay6tVVChd6TDcgRRuDStYt7R5avVY4y0DHUByw2VYc/44WUP2+DrxerfpDgk53QLE=
X-Received: by 2002:a54:4517:: with SMTP id l23mr2217606oil.174.1600768264232;
 Tue, 22 Sep 2020 02:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-8-ardb@kernel.org>
 <CACRpkda9hF7ScfFF=Utk7yx-Rztpe4Kat3=51jM0cbDT9UoMog@mail.gmail.com>
In-Reply-To: <CACRpkda9hF7ScfFF=Utk7yx-Rztpe4Kat3=51jM0cbDT9UoMog@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 11:50:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFpzMM0DJ_orZFt+OFhYkS8mpXJc8UL7s+V5kYhm56XPw@mail.gmail.com>
Message-ID: <CAMj1kXFpzMM0DJ_orZFt+OFhYkS8mpXJc8UL7s+V5kYhm56XPw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ARM: p2v: use relative references in patch site arrays
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

On Tue, 22 Sep 2020 at 11:05, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Free up a register in the p2v patching code by switching to relative
> > references, which don't require keeping the phys-to-virt displacement
> > live in a register.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Neat!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks.

I just realized, though, that this patch requires the R_ARM_REL32 from
[0] as well, as there are a few rare occurrences of phys_to_virt() in
module code (musb_hdrc and vivid)

[0] https://lore.kernel.org/linux-arm-kernel/20200914095706.3985-4-ardb@kernel.org/

If nobody minds, I will just fold it into the PR, as it has been
reviewed and discussed already between Russel, Nico and myself.
