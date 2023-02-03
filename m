Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7768B6899B7
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 14:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBCN3a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjBCN33 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 08:29:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C99DC94;
        Fri,  3 Feb 2023 05:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FEB6B8287A;
        Fri,  3 Feb 2023 13:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E243C433EF;
        Fri,  3 Feb 2023 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675430932;
        bh=lIoaREkLM6g0TnqhGUNFASq6fc2N0We2DZKhbjE6fRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OpsJnjiqV7lkfDDsO3yANw1zGg+x3ZqTR0/KPq49Z3nX9OOWoGAdA95qMMv8JKqXw
         3Jr6ukM+DzfzAgfpypwFqPSIscxYHe6OcAfJih7nbH+xovGoFbvcCLOtdgktGms7qy
         QKrYZF3lEO9XTv30AY1ZMRjz9z0DrC4QPY6eiDx0IZFU0EQ8bwvOT93ypyTIjpRohR
         p6JqxZ52l5j7ewuXuw1/tiYDtcyBXijLAk4TCqwgD0I/Varbnv15DnEB/hdQdP8TEd
         3chyiwSgDmdQl/cE/C70kNAP0HIywLLv+iagzT5ADufa9bybQgA/cMHqxh4hxfdv5c
         NDu96jsd6Qnbg==
Received: by mail-lf1-f51.google.com with SMTP id y25so7748190lfa.9;
        Fri, 03 Feb 2023 05:28:51 -0800 (PST)
X-Gm-Message-State: AO0yUKUj1KhTdLPYu5YU8pZrrk7MuoeDTT6x7I62ORr+xX6uahWXF/t6
        f7/qf/GK3M+0ai9GAL4SrpDkvO6F7HN/B6kMOK8=
X-Google-Smtp-Source: AK7set/E5uXOGJ3m9HtV/08/Wv1t5SL9hBNBohbDJ0PjyTKitFbUWohEloZ8ITtk/ZJDOBEJNSAg8ZjeHLnALUK8lyU=
X-Received: by 2002:ac2:53b3:0:b0:4b6:e197:3aeb with SMTP id
 j19-20020ac253b3000000b004b6e1973aebmr2002120lfh.233.1675430930105; Fri, 03
 Feb 2023 05:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20230203132213.11758-1-aagusev@ispras.ru>
In-Reply-To: <20230203132213.11758-1-aagusev@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Feb 2023 14:28:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG6x+mSR1Vu-MM6+4rr7A_abew53yqMvkx3=h114pcJBw@mail.gmail.com>
Message-ID: <CAMj1kXG6x+mSR1Vu-MM6+4rr7A_abew53yqMvkx3=h114pcJBw@mail.gmail.com>
Subject: Re: [PATCH] efi: fix potential NULL deref in efi_mem_reserve_persistent
To:     Anton Gusev <aagusev@ispras.ru>
Cc:     Jonathan Richardson <jonathan.richardson@broadcom.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Feb 2023 at 14:23, Anton Gusev <aagusev@ispras.ru> wrote:
>
> When iterating on a linked list, a result of memremap is dereferenced
> without checking it for NULL.
>
> This patch adds a check that falls back on allocating a new page in
> case memremap doesn't succeed.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 18df7577adae ("efi/memreserve: deal with memreserve entries in unmapped memory")
> Signed-off-by: Anton Gusev <aagusev@ispras.ru>
> ---
>  drivers/firmware/efi/efi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index a2b0cbc8741c..48d30c806d94 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -1007,6 +1007,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>         /* first try to find a slot in an existing linked list entry */
>         for (prsv = efi_memreserve_root->next; prsv; ) {
>                 rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
> +               if (!rsv)
> +                       break;

Thanks for the patch.

Why do you think 'break' is the correct action here?


>                 index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
>                 if (index < rsv->size) {
>                         rsv->entry[index].base = addr;
> --
> 2.39.1
>
