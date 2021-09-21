Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335A3413AE6
	for <lists+linux-efi@lfdr.de>; Tue, 21 Sep 2021 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhIUTqf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Sep 2021 15:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231468AbhIUTqf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Sep 2021 15:46:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D87F6112F;
        Tue, 21 Sep 2021 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632253506;
        bh=TG/Sor91iMlLGQKzaFrGTL6wc9VnOoLST+DeZedZHa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=omHIxpIW3eT4kf2aXXTpbZBkJtpwkJXWG6FiY3eVv5ZfRA5wx02Y0qmjlJaDRmF+E
         SjVitdjtNLVqWQDHNQ2k4VW/LuQmMsmZ/fRU74xqrcmw0NRzbuK7U+JLAw9hBG2mhC
         lpovLVsKZqW3CtV6AlLQ4q7m1y/iVr+hfSgpatHuSwo7GOf7xVeL7u3IUap6S/cNpI
         8q6t7ReEsSBOsgGUekkxKZ74lKAYmlDr+ykmQPuh5KaqmezovKBN3gAF+/8MoEsT0U
         Z/45mgoZfUWzdruBFzQRsrZtHYr16YAQZfNXhQzcfhLOLrS6O99CV2IOVh2iqWbI+9
         Ymj8I5NmXNtTg==
Received: by mail-ed1-f43.google.com with SMTP id ee50so525390edb.13;
        Tue, 21 Sep 2021 12:45:06 -0700 (PDT)
X-Gm-Message-State: AOAM532RwEEQjZq1j3EXbotb+e2hnMRFIfxwFuNMR8gmCybh9ujn0cSs
        xB+cmd/tZG86s3ZyOcAQyC1mXEeOAFEpsA22mg==
X-Google-Smtp-Source: ABdhPJztD14XM+ABXOQ8afWfcx03LpCn85LuBtodjgJNaa1df1UXoQ8GgYwkn75WV9713c6C+KbGt+a3JQIc3ibERr0=
X-Received: by 2002:a05:6402:b23:: with SMTP id bo3mr38015381edb.145.1632253505043;
 Tue, 21 Sep 2021 12:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210906041424.115473-1-gshan@redhat.com>
In-Reply-To: <20210906041424.115473-1-gshan@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Sep 2021 14:44:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
Message-ID: <CAL_JsqLccwTEhzonvdOOox+D6=3gHxbDbtsXTJpqtQfuxA4xvg@mail.gmail.com>
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-efi@vger.kernel.org,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        Randy Dunlap <rdunlap@infradead.org>, drjones@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Sep 5, 2021 at 11:16 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The empty memory nodes, where no memory resides in, are allowed.
> For these empty memory nodes, the 'len' of 'reg' property is zero.
> The NUMA node IDs are still valid and parsed, but memory may be
> added to them through hotplug afterwards. Currently, QEMU fails
> to boot when multiple empty memory nodes are specified. It's
> caused by device-tree population failure and duplicated memory
> node names.

I still don't like the fake addresses. I can't really give suggestions
on alternative ways to fix this with you just presenting a solution.

What is the failure you see? Can we relax the kernel's expectations?
What about UEFI boot as the memory nodes aren't used (or maybe they
are for NUMA?) How does this work with ACPI?

> As device-tree specification indicates, the 'unit-address' of
> these empty memory nodes, part of their names, are the equivalents
> to 'base-address'. Unfortunately, I finds difficulty to get where
> the assignment of 'base-address' is properly documented for these
> empty memory nodes. So lets add a section for empty memory nodes
> to cover this in NUMA binding document. The 'unit-address',
> equivalent to 'base-address' in the 'reg' property of these empty
> memory nodes is specified to be the summation of highest memory
> address plus the NUMA node ID.
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/devicetree/bindings/numa.txt | 60 +++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> index 21b35053ca5a..82f047bc8dd6 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -103,7 +103,65 @@ Example:
>                 };
>
>  ==============================================================================
> -4 - Example dts
> +4 - Empty memory nodes
> +==============================================================================
> +
> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
> +field of the 'reg' property is zero. However, the 'base-address' is a
> +dummy and invalid address, which is the summation of highest memory address
> +plus the NUMA node ID. The NUMA node IDs and distance maps are still valid
> +and memory may be added into them through hotplug afterwards.
> +
> +Example:
> +
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x80000000>;
> +               numa-node-id = <0>;
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0x0 0x80000000>;
> +               numa-node-id = <1>;
> +       };
> +
> +       /* Empty memory node */
> +       memory@100000002 {
> +               device_type = "memory";
> +               reg = <0x1 0x2 0x0 0x0>;
> +               numa-node-id = <2>;
> +       };
> +
> +       /* Empty memory node */
> +       memory@100000003 {
> +               device_type = "memory";
> +               reg = <0x1 0x3 0x0 0x0>;
> +               numa-node-id = <3>;
> +       };

Do you really need the memory nodes here or just some way to define
numa node id's 2 and 3 as valid?


> +
> +       distance-map {
> +               compatible = "numa-distance-map-v1";
> +               distance-matrix = <0 0  10>,
> +                                 <0 1  20>,
> +                                 <0 2  40>,
> +                                 <0 3  20>,
> +                                 <1 0  20>,
> +                                 <1 1  10>,
> +                                 <1 2  20>,
> +                                 <1 3  40>,
> +                                 <2 0  40>,
> +                                 <2 1  20>,
> +                                 <2 2  10>,
> +                                 <2 3  20>,
> +                                 <3 0  20>,
> +                                 <3 1  40>,
> +                                 <3 2  20>,
> +                                 <3 3  10>;
> +       };
> +
> +==============================================================================
> +5 - Example dts
>  ==============================================================================
>
>  Dual socket system consists of 2 boards connected through ccn bus and
> --
> 2.23.0
>
