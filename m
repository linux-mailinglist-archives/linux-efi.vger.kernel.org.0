Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDBA414738
	for <lists+linux-efi@lfdr.de>; Wed, 22 Sep 2021 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhIVLGx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Sep 2021 07:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234760AbhIVLGw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Sep 2021 07:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EBC361050;
        Wed, 22 Sep 2021 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632308722;
        bh=lKxTtQAI2dVJN/lgVduhPktu2QvJtfw+Vyeet6Wg0kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tx3ksSSLnT10rE/aRMTTfisLEWB1roDYi4W1eVYJ3mwNTPUcFc1xRdYUed30yNnAk
         dqLWXreNv7I3qk+PvSQ2gJp3Z8h/PZgOn6XFkI0CAuxPn3TFxNrVu4C53+I9sDCGWo
         TY++0NtH5Vn2od4tifHGGPAikKWCYnS7qIkUc9IIezTuyojt9DIZ0iPepxsvXmO5rM
         Zz+KmNrft/j2XzhW/lJv+cfExHgPgu+WbV0k3HcAIZ+Rrl1+qrZtM1BByShI2pc7zl
         +1//r9FPD7l0IX/VjD5lOMbC9gdvqF2+cLD1PAHXzpYNENAgDQ+myBQL8NQMuP9Tck
         p4oqNIiezVLKw==
Received: by mail-oi1-f170.google.com with SMTP id s24so1274538oij.8;
        Wed, 22 Sep 2021 04:05:22 -0700 (PDT)
X-Gm-Message-State: AOAM5304lahi6KLy6hrXnjUMdRAELWIr7dDQ5SFUsH/txqtTTrO+2tTt
        Bry4yw2uCsqmF5D8kKZq6GVK2LAbzA4w3xVSnac=
X-Google-Smtp-Source: ABdhPJyqRljhIu3cnaTtcTjBsYyXn04mQxYNKOI8lDMU6oo+6R/HRFtbw4XbqGArYlNafsVzssonf+JD+jJaDgbmRtw=
X-Received: by 2002:a05:6808:15a2:: with SMTP id t34mr7416338oiw.47.1632308721925;
 Wed, 22 Sep 2021 04:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210906041424.115473-1-gshan@redhat.com> <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
In-Reply-To: <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 22 Sep 2021 13:05:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFgnbuQzqf4rnpzn+Ez-sL3859q=1z_PkE1Mgd3SL19rA@mail.gmail.com>
Message-ID: <CAMj1kXFgnbuQzqf4rnpzn+Ez-sL3859q=1z_PkE1Mgd3SL19rA@mail.gmail.com>
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Rob Herring <robh@kernel.org>
Cc:     Gavin Shan <gshan@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 21 Sept 2021 at 21:45, Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Sep 5, 2021 at 11:16 PM Gavin Shan <gshan@redhat.com> wrote:
> >
> > The empty memory nodes, where no memory resides in, are allowed.
> > For these empty memory nodes, the 'len' of 'reg' property is zero.
> > The NUMA node IDs are still valid and parsed, but memory may be
> > added to them through hotplug afterwards. Currently, QEMU fails
> > to boot when multiple empty memory nodes are specified. It's
> > caused by device-tree population failure and duplicated memory
> > node names.

Those memory regions are known in advance, right? So wouldn't it be
better to use something like 'status = "disabled"' here?

>
> I still don't like the fake addresses. I can't really give suggestions
> on alternative ways to fix this with you just presenting a solution.
>

Agreed. Please try to explain what the problem is, and why this is the
best way to solve it. Please include other solutions that were
considered and rejected if any exist.

> What is the failure you see? Can we relax the kernel's expectations?
> What about UEFI boot as the memory nodes aren't used (or maybe they
> are for NUMA?) How does this work with ACPI?
>

The EFI memory map only needs to describe the memory that was present
at boot. More memory can be represented as ACPI objects, including
coldplugged memory that is already present at boot. None of this
involves the memory nodes in DT.

> > As device-tree specification indicates, the 'unit-address' of
> > these empty memory nodes, part of their names, are the equivalents
> > to 'base-address'. Unfortunately, I finds difficulty to get where
> > the assignment of 'base-address' is properly documented for these
> > empty memory nodes. So lets add a section for empty memory nodes
> > to cover this in NUMA binding document. The 'unit-address',
> > equivalent to 'base-address' in the 'reg' property of these empty
> > memory nodes is specified to be the summation of highest memory
> > address plus the NUMA node ID.
> >
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  Documentation/devicetree/bindings/numa.txt | 60 +++++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> > index 21b35053ca5a..82f047bc8dd6 100644
> > --- a/Documentation/devicetree/bindings/numa.txt
> > +++ b/Documentation/devicetree/bindings/numa.txt
> > @@ -103,7 +103,65 @@ Example:
> >                 };
> >
> >  ==============================================================================
> > -4 - Example dts
> > +4 - Empty memory nodes
> > +==============================================================================
> > +
> > +Empty memory nodes, which no memory resides in, are allowed. The 'length'
> > +field of the 'reg' property is zero. However, the 'base-address' is a
> > +dummy and invalid address, which is the summation of highest memory address
> > +plus the NUMA node ID. The NUMA node IDs and distance maps are still valid
> > +and memory may be added into them through hotplug afterwards.
> > +
> > +Example:
> > +
> > +       memory@0 {
> > +               device_type = "memory";
> > +               reg = <0x0 0x0 0x0 0x80000000>;
> > +               numa-node-id = <0>;
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type = "memory";
> > +               reg = <0x0 0x80000000 0x0 0x80000000>;
> > +               numa-node-id = <1>;
> > +       };
> > +
> > +       /* Empty memory node */
> > +       memory@100000002 {
> > +               device_type = "memory";
> > +               reg = <0x1 0x2 0x0 0x0>;
> > +               numa-node-id = <2>;
> > +       };
> > +
> > +       /* Empty memory node */
> > +       memory@100000003 {
> > +               device_type = "memory";
> > +               reg = <0x1 0x3 0x0 0x0>;
> > +               numa-node-id = <3>;
> > +       };
>
> Do you really need the memory nodes here or just some way to define
> numa node id's 2 and 3 as valid?
>
>
> > +
> > +       distance-map {
> > +               compatible = "numa-distance-map-v1";
> > +               distance-matrix = <0 0  10>,
> > +                                 <0 1  20>,
> > +                                 <0 2  40>,
> > +                                 <0 3  20>,
> > +                                 <1 0  20>,
> > +                                 <1 1  10>,
> > +                                 <1 2  20>,
> > +                                 <1 3  40>,
> > +                                 <2 0  40>,
> > +                                 <2 1  20>,
> > +                                 <2 2  10>,
> > +                                 <2 3  20>,
> > +                                 <3 0  20>,
> > +                                 <3 1  40>,
> > +                                 <3 2  20>,
> > +                                 <3 3  10>;
> > +       };
> > +
> > +==============================================================================
> > +5 - Example dts
> >  ==============================================================================
> >
> >  Dual socket system consists of 2 boards connected through ccn bus and
> > --
> > 2.23.0
> >
