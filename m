Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20155273E34
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIVJLX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgIVJLX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 05:11:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C119C061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:11:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so13473505ljd.10
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqZgem6BJmrZ0JtkRcobJqbv7+7ypfGFIJM6UEgR3ww=;
        b=j6QqzBJVnVxwzHP22NPCuGurcBNTXDGvRQ9pLHMHG+uTdTeBOk7jzNkh6n7iQkYH5R
         FhkbcJSNBKu+8/iMoNgkfApcox7CmHjzuPD7D0ozq1NFYaxsjzbzHYjC1bMJt53ai5Hx
         9xzFNZop2fFoCSwEaHj+shE4EOasKPJ7GarR1eTDIl+sGKT9obH1EgFF2yQL10ncJ3/A
         5+M+RDWYufp4P60wo2Uq6B87qZeHrj4iqVGOzT7WWnIrUxkWs0ARVKRbriEquDcMRqw7
         kS1P/nz+3ThxTSI/71FJnqGXtALKe5xiLLOgOnr0kZQyj1wZTi/N+CLlD7tWac8sS+rh
         fDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqZgem6BJmrZ0JtkRcobJqbv7+7ypfGFIJM6UEgR3ww=;
        b=n2WN38Xb2whpMT6jgztJ0pqqktMOuC6alRCQR3B+Onci2DWCDTwKjc3gzXyi6ht92c
         kAUHNoy8NwimBKIg0SilH/vi5uBqynKf8E0j8SFUE2TjZ2n5Iejo/CCNoMa3KLVXIYhJ
         mEm1zG/rXDckIJzIUJiJpv3lcMtGxUv10Vjvg+tERI+vWxVoEwrsBl2jJyMLht6+e3mb
         meTVDClZg55K/GMXUGyZx/AMLT4vC8NSLm04+j4WNNeDNQ0PqizLNQQBXVpoIPu5Vuyf
         3PNki+mekaN03tSOjbfMHaxo7lmO5HFFLvAAlVUpqrV3bVZsIQSiGcpx0D2Ir6XIsZ1H
         yyFw==
X-Gm-Message-State: AOAM5335VcKGPIBGRWPYe7AWHoL8H9S8S3xzjTerFTiBxJlTNeOkc0YP
        JSicRoc4BeVGgmNMG6fjl5HqLXQGTRlBWypmQwQ9aw==
X-Google-Smtp-Source: ABdhPJyJKELpcCd3CMJDPpnheTz6EBPR+KFmMQqYzJ9ro8Ld21LTG7hqSvT+vhdovbgwcW3BH866nRpQL3D6UfcbeG8=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr1245164ljo.293.1600765881575;
 Tue, 22 Sep 2020 02:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-11-ardb@kernel.org>
In-Reply-To: <20200921154117.757-11-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 11:11:10 +0200
Message-ID: <CACRpkda=P-Kc=-ZhZo8vtW9CrFfCiBvfkqwfdipz4WO2Gb2L_g@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: p2v: reduce p2v alignment requirement to 2 MiB
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> Update the p2v patching code so we can deal with displacements that are
> not a multiple of 16 MiB but of 2 MiB, to prevent wasting of up to 14 MiB
> of physical RAM when running on a platform where the start of memory is
> not correctly aligned.
>
> For the ARM code path, this simply comes down to using two add/sub
> instructions instead of one for the carryless version, and patching
> each of them with the correct immediate depending on the rotation
> field. For the LPAE calculation, it patches the MOVW instruction with
> up to 12 bits of offset.
>
> For the Thumb2 code path, patching more than 11 bits off displacement
> is somewhat cumbersome, and given that 11 bits produce a minimum
> alignment of 2 MiB, which is also the granularity for LPAE block
> mappings, it makes sense to stick to 2 MiB for the new p2v requirement.
>
> Suggested-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

My understanding of what is going on is limited to the high
level of things, and being able to do this is just a great thing
so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If you or Russell need more thorough review I can sit down
and try to understand at the bit granularity what is going on
but it requires a bunch of time. Just tell me if you need this.

Yours,
Linus Walleij
