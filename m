Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198362705E9
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRUDO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRUDO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Sep 2020 16:03:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F39C0613CE
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 13:03:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r19so3556832pls.1
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqKEUkrHSOcwIeCgxJ2NUiebQBDAPOQgRM5RvCzJmOk=;
        b=ASfssTNFF3QBgdX5pYpBG9enEvBoJR1VKhNYlQC+h0EGTsQ7lzr8938m1VWIo4ufWT
         0T9CUODz+4H8bFpPc3al0C9oV5wz15e7QFn23TcdVVm3a2u0g4H8bcHZ7FuArieAJZVj
         OiVDf2L0jv3n3R0lrU9ukaBNu7Ee1VoZS3yCxPOEJNwvYhpUOuDgjetrC4t+kUPepicF
         I8R0iWk4y4nwDTbISJUOUDFLtJHmNZaTzlzOkf2/nIyt/a+gT0XVM1Z+crSI9Eis42VJ
         04xFTrrSkm0wFanpYIGeDE7+GeenuhDx7G8rKs7n6oAxvk7VC8I3+LAZirSJHQOeWmaI
         88/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqKEUkrHSOcwIeCgxJ2NUiebQBDAPOQgRM5RvCzJmOk=;
        b=uf0q4MgeyVqt4cD74hI9gbreFDudqdEVBm0Z4K8IDAfdJBm4Snyt/kb1scwqzV7vtE
         pewgzH7nJRhqibGlIhfHpoahDdyjzbJRdXr97WV9ZY9qQImvBBadNNJpmEpWdZWXZWl/
         I3ynW2Y5pzI9jfrKEsBTbykN61kewsatabZ78XWSyM1Wmu2Imu3bkpclOI8B7lDJxXEG
         XnlPngmzDZbQnbpefmKOysecil+mwd/LsWF0wCzcJ0lslIPKXvlpEh+eohfMQmZ7M6hh
         2mQcGl8RoXKSvBtF1cyMyEfDHT/A/Ci7xGcaT+tNafWnVOygrAfjLTqItTArbspQ4D7y
         QsYw==
X-Gm-Message-State: AOAM530vRLTJZ5zBUFtMw22N97Z12tssvD0dgKmn6pEtQ2qpK+2ICunL
        uKdWLoJdwWJ/yLxNs0ijJtefT1tw+uqu7KQn4oN1/Dl7kowJWg==
X-Google-Smtp-Source: ABdhPJy143Ss6DQSvYCIZLlQeFneTjXF/NLcQX0YDjBCfOiUakA3lZrEv0tL4i03beLG9RF8r8C6N3L/7KqPJW/LJu8=
X-Received: by 2002:a17:90a:e517:: with SMTP id t23mr13887209pjy.25.1600459393285;
 Fri, 18 Sep 2020 13:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
 <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
 <CAKwvOdmkNgi_+kfauTSLwtpVChipW851_KGJG+gBbhwRxJJORA@mail.gmail.com>
 <CAMj1kXHTkP7-8xscGZGXN_0Sq=BCSnt3zWqkcm8xdO11xmditA@mail.gmail.com>
 <CAKwvOd=G2Rr3StUJ=oWu1L4b5y615m+uYNW-Y5sis13uqBvrYQ@mail.gmail.com>
 <CAMj1kXHEpPc0MSoMrCxEkyb44AkLM2NJJGtOXLpr6kxBHS0vfA@mail.gmail.com>
 <CAKwvOd=Sq3XOquw4ACEi+cYCQp0-LW-JXoecFt+yy+jtmtuhiQ@mail.gmail.com> <CAMj1kXG9WBZb9WYCCng7CkJ+v8X=xHVhih274iuXMd5ua2nKPg@mail.gmail.com>
In-Reply-To: <CAMj1kXG9WBZb9WYCCng7CkJ+v8X=xHVhih274iuXMd5ua2nKPg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Sep 2020 13:03:02 -0700
Message-ID: <CAKwvOd=8QUQK6hCQaAGjX6o_jz_vgFewW6v+SPHZ7ZKi9LYcYw@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 16, 2020 at 11:01 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 17 Sep 2020 at 00:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Also, it looks like the GCC build of milbeaut_m10v_defconfig fails to
> > boot for me in QEMU; so maybe not just a Clang bug (or maybe, more
> > than one bug).  (or maybe one of my command line params to QEMU is
> > wrong).
> >
>
> I understand that this is actually an existing issue in -next, but in
> general, why would you expect to be able to boot
> milbeaut_m10v_defconfig on anything other than a Milbeaut MV10
> machine?

We've been booting other configs in QEMU for a few years now, so I
don't see why yet another config would hurt.  Maybe there's some
hardware dependency, but I guess we'd find that out trying to boot it
in QEMU.  If it boots in QEMU, I guess not booting on metal wasn't so
bad?  Maybe this is considered an antipattern, but you can see how if
we've been getting away with it for years then that would lead to such
expectations.

> (whatever it is) Or does QEMU emulate a milbeaut machine?

$ qemu-system-arm -machine help

doesn't print anything that looks like it, on initial glance.  Looks
like a socionext part:
https://www.socionext.com/en/pr/sn_pr20170105_01e.pdf

> If
> not, better to stick with configs that are intended to boot on the
> QEMU machine emulation that you are using.

I can see in our CI that we've been building+boot testing
multi_v5_defconfig, aspeed_g5_defconfig, and multi_v7_defconfig for a
while now without specifying any machine.  Is there a preferred
machine we should be using for those?  (It looks like qemu supports
ast2500-evb and ast2600-evb; is ARM1176 and ARMv6 core? Is that what
aspeed_g5 uses? Why is virt versioned? Ahhhh!!!!)

> Also, while I see the point of regression testing of -next, using it
> as a base to test arbitrary series and then report failures against it
> produces a lot of noise. -next is *not* a good base for development,
> because you get everybody else's half baked crap as well.

Ack.

> When you
> test my stuff, please use a known good base so we're not off on a
> goose chase every time.

Goose Chase?! gOoSe ChAsE?! *gestures broadly at...everything*
Monsieur, here at the zoo, chasing the geese is not out of our
purview.  It's preferable to cleaning up after the elephants.
-- 
Thanks,
~Nick Desaulniers
