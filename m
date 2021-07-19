Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8F3CCE48
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhGSHQE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 03:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234314AbhGSHQD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 03:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1AC3611AF;
        Mon, 19 Jul 2021 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626678784;
        bh=EYabTI88I7XIbufiiYgGBcMFw033HqY+rFyQgdAOxdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kQfD7GCe6PE4R6vRbo1pbEM1JSAk19gT3USixVR7yZt1kdnDCFoI28vDyyWmkLMAj
         F4OQJhb2fRUdIbwe0itA20TxBL/fwLipMY8Q/dm43nDopcuJsPPqmtC+avIfAt6D/k
         P5dAWVOyZQ2q3EdrPJ5jql92Ia0PZCVmvsIj6p90qC2lwo6qGDyNxPVlmgikv2ACyM
         uTZy8F1VmZIGoIG+F7tYZk6Xid9G+TbpXOe4uR6kI3DxkcYld/QQiPEcTAPFnKqRON
         uHANrjRWpPX0XBULJbmBd3Q57gYPwaO5Y6mr6pzaWZk1NnqDMJKDCuKOQK6oo1lDnd
         sriTxMGIM40sA==
Received: by mail-oo1-f45.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so4219614oos.1;
        Mon, 19 Jul 2021 00:13:04 -0700 (PDT)
X-Gm-Message-State: AOAM532o31t2r/OdbfJi6G66JTnWOS4PQyEa5zF322p5SzocyH4VJ4JP
        PCYKyOJ4XEpZ22gHPwoMRwDHubxI5Sjpt0rz4CQ=
X-Google-Smtp-Source: ABdhPJwuhTxA+Wh+bYt7u+sqUJV740cGnwcCmNCfOYWDD7g5TKapBaSaJmsEEpsOfksXPAbxrf8gZww+vV0VokGU3CY=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr16356559ooe.45.1626678784054;
 Mon, 19 Jul 2021 00:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <YNwu7LmZaImyoOer@zn.tnic> <CAMj1kXE--H53wu_X=GpgeJmWs7vjpnkUnG_fc+59GaNDF+sYEw@mail.gmail.com>
 <YPJgYp9kt5p06WX+@nazgul.tnic>
In-Reply-To: <YPJgYp9kt5p06WX+@nazgul.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Jul 2021 09:12:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGX=dMsCe-Na5f3LJtS_9=9cN4y7+rgLx2k04ifduJ8vw@mail.gmail.com>
Message-ID: <CAMj1kXGX=dMsCe-Na5f3LJtS_9=9cN4y7+rgLx2k04ifduJ8vw@mail.gmail.com>
Subject: Re: [RFC PATCH] efi/mokvar: Reserve the table only if it is in boot
 services data
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lenny Szubowicz <lszubowi@redhat.com>, Gary Lin <glin@suse.com>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 17 Jul 2021 at 06:46, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 16, 2021 at 07:10:17PM +0200, Ard Biesheuvel wrote:
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks for checking me here.
>
> > Would you like me to queue this as a fix?
>
> Well, I wanna say it is unnecessary to send it as an urgent fix because
> we have the SEV fix in place now and I guess we'll leave it in in case
> something else is in boot services and is needed for SEV guests to boot.
>
> So I guess just a normal, unexpedited fix please, so that it sees more
> testing before it goes up.
>

I have accumulated a handful of EFI fixes which are not urgent, but
fixes nonetheless. I will add it to the set.
