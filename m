Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6979316EC89
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 18:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgBYRa6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 12:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgBYRa5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 12:30:57 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFDC22464
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582651857;
        bh=kJ4gLV2zo9mOE8R3kJ+hUPYqzvlp2reTJzAAi88WqDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MdXTdtC4ZNyoLx+YYdwcKPTWewYOnxuU8W+bayx2tt1GEnQgUQruFbeuZmTRuAmGX
         fEv3uZihJTeyPlbVSHMZbTdNpVVY5voCaVPyGyHmqvocZN0cc2smEgCq9oLpmgoKIU
         IxN0kuvNw/s0S82X0v05wWZeqpsEKrpo1ju+gH4Q=
Received: by mail-wr1-f50.google.com with SMTP id y17so6931253wrn.6
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 09:30:56 -0800 (PST)
X-Gm-Message-State: APjAAAUGFL3V3Sn/K8nXGtXXlg2IVEW3UXCr7C/aS/9PKpvB41W2JJek
        VVSjEAyl/H+3SGR9/HVG82mJgQnkQa5gvLiZiygEMw==
X-Google-Smtp-Source: APXvYqywo7OQsDXLUxVIy25bJS38cWNxnmwkX5xj9lsCE2EG482HkO1IsQWZhIXYfri0DmUOaNr2JSCAeafbBYjgoH0=
X-Received: by 2002:adf:a411:: with SMTP id d17mr251171wra.126.1582651855177;
 Tue, 25 Feb 2020 09:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20200224121733.2202-1-ardb@kernel.org> <CACRpkda5VFzMHE483MPj86VN7uU7w4bNibY=ZeLUHyED=JD7Cw@mail.gmail.com>
 <CAKv+Gu8MOZHFLw-Of5yK15Q1z9gpOmdQNmYF405XRAkeiCoXDw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8MOZHFLw-Of5yK15Q1z9gpOmdQNmYF405XRAkeiCoXDw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 18:30:44 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9chiLCJ=HKLq4sXAP2ooqkRB-mfKVyEJ3tqxuxQTQgrg@mail.gmail.com>
Message-ID: <CAKv+Gu9chiLCJ=HKLq4sXAP2ooqkRB-mfKVyEJ3tqxuxQTQgrg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 25 Feb 2020 at 18:18, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 25 Feb 2020 at 16:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Mon, Feb 24, 2020 at 1:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > While making changes to the EFI stub startup code, I noticed that we are
> > > still doing set/way maintenance on the caches when booting on v7 cores.
> > > This works today on VMs by virtue of the fact that KVM traps set/way ops
> > > and cleans the whole address space by VA on behalf of the guest, and on
> > > most v7 hardware, the set/way ops are in fact sufficient when only one
> > > core is running, as there usually is no system cache. But on systems
> > > like SynQuacer, for which 32-bit firmware is available, the current cache
> > > maintenance only pushes the data out to the L3 system cache, where it
> > > is not visible to the CPU once it turns the MMU and caches off.
> > >
> > > So instead, switch to the by-VA cache maintenance that the architecture
> > > requires for v7 and later (and ARM1176, as a side effect).
> >
> > I took this v3 patch set for a ride on some ARMv7 and ARMv6
> > (hardware) boards using zImage:s so the compressed path
> > should be exercised:
> >
> > - Ux500 (ARMv7 Cortex A9 x 2) works like a charm
> > - RealView PB11MPCore (ARM1176 x 4 MPCore) works like a charm
> >
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I can do more thorough tests with more boards if needed.
> >
>
> Thanks Linus. Do you happen to have any boards that boot with appended DTB?

Actually, I can easily test that myself as well in QEMU.
