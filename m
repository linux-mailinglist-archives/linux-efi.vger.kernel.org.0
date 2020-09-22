Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9A273F0C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIVJ6q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJ6q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Sep 2020 05:58:46 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F32B7239CF
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600768726;
        bh=UXUntZUEJ8LeePpZFO2JueVZy7ZWPRtPHWSNGeZZqxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iY/rIzZn2d3r2cFQEz0uO91Rr8z/k9Ko/rz+9Ac+ooHVRIBjAG6dJ6FScGDemkKD4
         tMyseV4IFYTpe1evGgcmA3/wFVTMVMkfCdXIVIgGTPatxa2hFrD6nzPVcy3uAnFBze
         fus6QipkiFcKRJnaCb1FDX6bwr/coqgqUl5FM3M4=
Received: by mail-oi1-f181.google.com with SMTP id x69so20368100oia.8
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:58:45 -0700 (PDT)
X-Gm-Message-State: AOAM531wlsaiG8r5hCdv1X7EXVez0PxcTbjyHgR6EEy08Pv6D6ZHlJWQ
        VcBj3bo3saBpRrG8Fwm1Sy7gFb6AGdKUni6Zn3A=
X-Google-Smtp-Source: ABdhPJw+E6oEtL89+9g72bzfA5aRV4Uz1z8ZZClxUgxuK3XLSBjtAZkzntlpPsZFXZ0MzuehQhscjEqShGlDKC/jGpI=
X-Received: by 2002:aca:d845:: with SMTP id p66mr1990699oig.47.1600768724548;
 Tue, 22 Sep 2020 02:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-5-ardb@kernel.org>
 <CACRpkdZETueMXpH-x=n=SUWSLZ_AVu1MKbx202K6WhyrmQAE-w@mail.gmail.com>
In-Reply-To: <CACRpkdZETueMXpH-x=n=SUWSLZ_AVu1MKbx202K6WhyrmQAE-w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 11:58:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHF9Mk7E5Mr-BsviJssa3s4y4JUb+J0635nWweXJQyJ=g@mail.gmail.com>
Message-ID: <CAMj1kXHF9Mk7E5Mr-BsviJssa3s4y4JUb+J0635nWweXJQyJ=g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ARM: p2v: factor out shared loop processing
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

On Tue, 22 Sep 2020 at 10:39, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > The ARM and Thumb2 versions of the p2v patching loop have some overlap
> > at the end of the loop, so factor that out.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Would add to commit message: "changes numeric labels to
> symbolic labels while we're at it".

Will do

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks
