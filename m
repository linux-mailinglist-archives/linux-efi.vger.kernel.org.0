Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2B6B735C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 11:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCMKB6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMKBc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 06:01:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1FD1CF53
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 03:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F07EB80F98
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 10:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D25C4339E
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678701617;
        bh=fbmby0jK3o9esgZAXhEtKAqf/P42qKsJfHNH8wihVLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KPpfzdDglMSNO3KezAmwjddzsekIznGvrHHdTJGz9Y2UDD+cxGkO048PPQzijKL5q
         H9OACQbMSpwunBznshjPIWXpG4DYAfd8yCtJKbq8IyaV4VQM8Pw+eHYgRjvTFWdu+f
         f3+39UR5agin+zxe+SSTkVWD5xKzGG+k6NiUclBtUwyCAWKG8JxfoNbJQRRb+/AM7t
         j2sz8PrBE35SqOios8bw9CY4AkEiYOlcOnCziKbc3pn3d1Zj5/WcefkECh+1rJ4/yQ
         LbkZVO0PakqRsX3OfGWuaeMgpq3ZZqn2fEkInSSd0XlrJWPeqfycc0nQntNyiIah5u
         N2jFdmk2m9Bhg==
Received: by mail-lj1-f180.google.com with SMTP id a32so11967086ljr.9
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 03:00:17 -0700 (PDT)
X-Gm-Message-State: AO0yUKUwr2+VUly2o5xExcW+oDmv9vYo0xD0EtW6EZ1Swglgr72UR5fS
        V9Tl0GyY6yjCR+IF8Gul8mjCIMGx1AeoCzSY/zw=
X-Google-Smtp-Source: AK7set+CYAWcAggcfZBV/DcUpV19dEieGqB4orxVaybAx6VW3CBUFV6CT9DH+7wo0t+D+aYsUZkdVAJfvHi0/sOB5gc=
X-Received: by 2002:a05:651c:11c6:b0:295:d460:5a2d with SMTP id
 z6-20020a05651c11c600b00295d4605a2dmr10418442ljo.2.1678701615664; Mon, 13 Mar
 2023 03:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230313081432.3769496-1-ardb@kernel.org> <CAMj1kXFBB9DK_zNL2h2=5-8P+VzOO=K1SgJ+07C55zbZoMHRLw@mail.gmail.com>
In-Reply-To: <CAMj1kXFBB9DK_zNL2h2=5-8P+VzOO=K1SgJ+07C55zbZoMHRLw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Mar 2023 11:00:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGFb+0-e_t+LeRSJzqweU=SL98cfFnem625PGjjuGCv0A@mail.gmail.com>
Message-ID: <CAMj1kXGFb+0-e_t+LeRSJzqweU=SL98cfFnem625PGjjuGCv0A@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: Use relocated version of kernel's struct screen_info
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Mar 2023 at 09:48, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 13 Mar 2023 at 09:14, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > In some cases, we expose the kernel's struct screen_info to the EFI stub
> > directly, so it gets populated before even entering the kernel.  This
> > means the early console is available as soon as the early param parsing
> > happens, which is nice. It also means we need two different ways to pass
> > this information, as this trick only works if the EFI stub is baked into
> > the core kernel image, which is not always the case.
> >
> > Huacai reports that the preparatory refactoring that was needed to
> > implement this alternative method for zboot resulted in a non-functional
> > efifb earlycon for other cases as well, due to the reordering of the
> > kernel image relocation with the population of the screen_info struct,
> > and the latter now takes place after copying the image to its new
> > location, which means we copy the old, uninitialized state.
> >
> > So let's ensure that alloc_screen_info() produces the correct
> > screen_info pointer, by keeping its relocated address in a global
> > variable.
> >
> > Cc: loongarch@lists.linux.dev
> > Cc: Xuefeng Li <lixuefeng@loongson.cn>
> > Cc: Xuerui Wang <kernel@xen0n.name>
> > Cc: loongson-kernel@lists.loongnix.cn
> > Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> > Link: https://lore.kernel.org/linux-efi/20230310021749.921041-1-chenhuacai@loongson.cn/
> > Fixes: 42c8ea3dca094ab8 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> This is still not working :-(
>

Huacai, could you try this patch please? It is working now - I don't
know what I did wrong before when testing it.
