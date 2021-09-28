Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4739241B50C
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhI1RYG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 13:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241995AbhI1RYF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 13:24:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A36BD610E6;
        Tue, 28 Sep 2021 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632849744;
        bh=p1omdo8J0LTck4weGVlceL1bR9p0Zh2+XitDJiT9QIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W7e95aYScYjgBzh8nhBa4jglUt8uT5Zyk76gaF3/yQ2D7s4KfcgYaBrWJ08Di0zNM
         xIPk5nMpNO+l1I1rJqvfXavCgeKI7pZrYDKcn+K0Ow7yydL6PVo1D8LU08ZUUPbyxT
         z7LNpN16o03DwF5wNkf3JK4/9fSa7zr+c3P6s0CDlnAQC5qjSgztQiGpOCd+WCvH21
         VF4/BDYQyzA47h0+zDtfcSpIY+jqbzTXXk0BQxdX0asWQs52o6ouIMuci+2HyvAhz3
         RIcZz/mcKPFNrolrlRy4bkjyW/8JltpIC8U9AFRaxCfWhP+KMJYgTin09XgLGOhJ22
         rc0zGUJIMW/4w==
Received: by mail-ed1-f43.google.com with SMTP id bd28so24496787edb.9;
        Tue, 28 Sep 2021 10:22:24 -0700 (PDT)
X-Gm-Message-State: AOAM531lVz1zLn3+S1vuaykDvjFw5yfS3el2+sSdxGlaGyD9f4bkZrby
        Ww2GJcmbDnLZITTyI4tq8eDPDWXixwAZ3h1Sdw==
X-Google-Smtp-Source: ABdhPJyYj6eZo+4rVJU4CYW255+Mc68GtlF90gxDfm5SHY/AXdUWRENNY4sqvr/w1Y6jnQWE59TZVZjjORVMXH70how=
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr8026916ejz.128.1632849740003;
 Tue, 28 Sep 2021 10:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064119.127285-1-gshan@redhat.com> <20210927064119.127285-3-gshan@redhat.com>
 <CAL_JsqL8+_Q690-c3J4TS6LBF-mCUBxbhTfr994=Fwffqab0_w@mail.gmail.com> <c101363f-1de7-1d56-a8d9-243f003b48c1@redhat.com>
In-Reply-To: <c101363f-1de7-1d56-a8d9-243f003b48c1@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Sep 2021 12:22:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJtckde=Ngfhr7u3f_xsccavo+4Pt-v9o_nGHTX+wD91w@mail.gmail.com>
Message-ID: <CAL_JsqJtckde=Ngfhr7u3f_xsccavo+4Pt-v9o_nGHTX+wD91w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of, numa: Fetch empty NUMA node ID from distance map
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 27, 2021 at 6:59 PM Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Rob,
>
> On 9/28/21 12:49 AM, Rob Herring wrote:
> > On Mon, Sep 27, 2021 at 1:42 AM Gavin Shan <gshan@redhat.com> wrote:
> >>
> >> There is no device node for the empty NUMA node. However, the
> >> corresponding NUMA node ID and distance map is still valid in
> >> "numa-distance-map-v1" compatible device node.
> >>
> >> This fetches the NUMA node ID and distance map for these empty
> >> NUMA node from "numa-distance-map-v1" compatible device node.
> >
> > This is much nicer.
> >
>
> Indeed, thanks for your suggestions :)
>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   drivers/of/of_numa.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> >> index fe6b13608e51..5949829a1b00 100644
> >> --- a/drivers/of/of_numa.c
> >> +++ b/drivers/of/of_numa.c
> >> @@ -111,6 +111,8 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
> >>                          return -EINVAL;
> >>                  }
> >>
> >> +               node_set(nodea, numa_nodes_parsed);
> >> +
> >
> > With this, couldn't we remove of_numa_parse_cpu_nodes() as the only
> > thing it does is node_set()?
> >
>
> I don't think so for couple of reasons:
>
> (1) With problematic device-tree, the distance map node might be missed
>      or incomplete. In this case, of_numa_parse_cpu_nodes() still helps.

It's not the kernel's job to validate the DT (if it was, it is doing a
terrible job). I would suggest writing some checks for dtc if we're
worried about correctness. (The schemas don't work too well for cross
node checks.)

> (2) @numa_nodes_parsed is also updated when the memory nodes are iterated
>      in of_numa_parse_memory_nodes() and numa_add_memblk().
>
> So @numa_nodes_parsed, which is synchronized to @node_possible_map afterwards,
> is the gathering output of CPU nodes, memory nodes and distance map node.

Is it valid to have node id's that are not in the distance map?

Rob
