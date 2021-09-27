Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D044196B4
	for <lists+linux-efi@lfdr.de>; Mon, 27 Sep 2021 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhI0OvV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Sep 2021 10:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234819AbhI0OvV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 27 Sep 2021 10:51:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526FB60FC2;
        Mon, 27 Sep 2021 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632754183;
        bh=nlm+GXqBOJFgPGuqH4ktEyVp0rZXsByzVCpaKGKn9Pw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CtSY0hs0nhLxHyr6ErsvWuAR1cv3yUK5t2GqYnY79ud/jOLtgMBvrFATh1DTQk5Wr
         emdDTnPAPoArKZsQl3de5W+/e+Ei/O8rV7O0zRGuu/hG2q+3r5n400glzNY3fMncfY
         bSsFfTIP/pPxAJ9T2baDtHFfCMU6qXpUwXfEghNuIyrGlhOP79telufsEH0MrhRfuR
         Uon1rEsEJDFbGdqfsvYSUDQgTmmfQCqiOuqp47yPXAUHLS0DodF2zvxGFADDNU45P8
         6QyNaDEy01x74UUZCCMh3Joul+V3W09gvDMPW/qq0YTwZdYKRkrNasv7R6CLNsnUDn
         QI/RyzqUaefig==
Received: by mail-ed1-f44.google.com with SMTP id v18so35111970edc.11;
        Mon, 27 Sep 2021 07:49:43 -0700 (PDT)
X-Gm-Message-State: AOAM531Ko2UvvAP8b06FLyk0UhnaNVgl9vvAEyNyBWdA5Sj4GRWIZbjy
        aGjFR69yOPiCNg6h5FCCDiJakN4BsikI+46fag==
X-Google-Smtp-Source: ABdhPJwAdi6VamHHELYSAbPUEIJOXg9VYm6jMbUqTQD67z8h2BqyDUn/kOFm4ji2hkz/vqnJ2ZIn0ddX0WT5DJGrUCg=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr449630ejk.147.1632754181882;
 Mon, 27 Sep 2021 07:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064119.127285-1-gshan@redhat.com> <20210927064119.127285-3-gshan@redhat.com>
In-Reply-To: <20210927064119.127285-3-gshan@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Sep 2021 09:49:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8+_Q690-c3J4TS6LBF-mCUBxbhTfr994=Fwffqab0_w@mail.gmail.com>
Message-ID: <CAL_JsqL8+_Q690-c3J4TS6LBF-mCUBxbhTfr994=Fwffqab0_w@mail.gmail.com>
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

On Mon, Sep 27, 2021 at 1:42 AM Gavin Shan <gshan@redhat.com> wrote:
>
> There is no device node for the empty NUMA node. However, the
> corresponding NUMA node ID and distance map is still valid in
> "numa-distance-map-v1" compatible device node.
>
> This fetches the NUMA node ID and distance map for these empty
> NUMA node from "numa-distance-map-v1" compatible device node.

This is much nicer.

> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/of/of_numa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index fe6b13608e51..5949829a1b00 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -111,6 +111,8 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
>                         return -EINVAL;
>                 }
>
> +               node_set(nodea, numa_nodes_parsed);
> +

With this, couldn't we remove of_numa_parse_cpu_nodes() as the only
thing it does is node_set()?

>                 numa_set_distance(nodea, nodeb, distance);
>
>                 /* Set default distance of node B->A same as A->B */
> --
> 2.23.0
>
