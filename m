Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64367D671
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jan 2023 21:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjAZUcn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Jan 2023 15:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAZUcn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Jan 2023 15:32:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A94B896;
        Thu, 26 Jan 2023 12:32:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A5461935;
        Thu, 26 Jan 2023 20:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F687C433D2;
        Thu, 26 Jan 2023 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674765161;
        bh=y6Sok3t3jR+yv3Qj4HUra7R9HfrmWOMNp3q+9NrPezQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sQNOs+r0a/nh/qi3EnQtfJNsK5HJSmePSJR0S7PBO6/k6kIyI261lNX5zLwKr/LI/
         W1WVIrKGJw3cVnxy6AiJ6ocm1eWF2AhjGM8dmBu8ISlhHVVOc0J/5lKUsUG4fphtLI
         v5WoLVLRaxJ2BjnrwHtQGpX36ApEPxux2V9ka/xVxdRW8C4oQvCfWi9uOsfl9PccS/
         bTZItdsPmk8c4/wqm7K+kJg4wpLIo/aEujm7ZF8pPmaiVxOtcgCY+mcsEZEXEsW+ZN
         f5+p9i3TtLhLBSoHri+RUm7PnUNw7MalcM0CmpU2sbmfO2q0OsV3tAlTa7vmAMfPsc
         jAw1OgCuidcrA==
Received: by mail-lj1-f171.google.com with SMTP id a37so3322999ljq.0;
        Thu, 26 Jan 2023 12:32:41 -0800 (PST)
X-Gm-Message-State: AO0yUKUK3ndww/9Q/Myf6a13hbuyOmo8TC5xwRi0do2ivbQ0xA0ZTvWG
        dn4exveGw1Yh7/XGCQGcY/OZVpWrmU7o5ni7hyM=
X-Google-Smtp-Source: AK7set9Bhs+pNcgP6w52oyqkvvzqoFggV5VbDVK+JlEeuvCk5/5+aIaXi03TcGW6fmbxqlN4SnaYb0bNaFYa2vElStA=
X-Received: by 2002:a2e:b604:0:b0:28f:9f99:dd29 with SMTP id
 r4-20020a2eb604000000b0028f9f99dd29mr150240ljn.234.1674765159356; Thu, 26 Jan
 2023 12:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20230126112129.4602-1-johan+linaro@kernel.org>
In-Reply-To: <20230126112129.4602-1-johan+linaro@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Jan 2023 21:32:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEUKChvqA8D_T3Bt-pQhvjBmsGxyy69uqDqyn0EBmQ1pw@mail.gmail.com>
Message-ID: <CAMj1kXEUKChvqA8D_T3Bt-pQhvjBmsGxyy69uqDqyn0EBmQ1pw@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 26 Jan 2023 at 12:23, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The VFS calls kill_sb() also in case mount fails in get_tree().
>
> Add the missing check to make sure that efivars has been registered also
> to kill_sb() to avoid dereferencing a NULL pointer when trying to remove
> efivar entries.
>
> Fixes: c3fd71b428b8 ("efivarfs: always register filesystem")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Thanks - I have squashed this with the original patch.

> ---
>  fs/efivarfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index b67d431c861a..482d612b716b 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -246,6 +246,9 @@ static void efivarfs_kill_sb(struct super_block *sb)
>  {
>         kill_litter_super(sb);
>
> +       if (!efivar_is_available())
> +               return;
> +
>         /* Remove all entries and destroy */
>         efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
>  }
> --
> 2.39.1
>
