Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D931854CD62
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiFOPtj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiFOPti (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 11:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE515FD1
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 08:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE819617C7
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 15:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE35C34115
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655308177;
        bh=btYuattQlY3+yfbB5rv4Kea1Zz5par/ieeNjePTbxQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j8B04AI7I/+YoTurK07GE1byp8gnpSZq+tIAp42/6Ppdpy/6ph+W4MdutqeStdrIm
         DUt6/YkOVdilNWeZZcgUAGYu3JnVQuZHbrxZA5Mlv6q+boqBgcYjhXNSj3ZkfiSqUT
         h58RmzuTC8BiwUJVIlOIkrbK5OkPlUzO5DyD+V2XWsu1kG5W7hLw0I4bSMJgmPCuRN
         IXctZch3EF7dlRMGAQdUlvg5ac3Z3pNvCxvEvO38Xx+SC3V1LrWeijE6QnwAHVRHtU
         KnaQRP58ebmdiV9FKXNTtekjjGVh2vXi34wDbEImWjlDp7wKizBAY9SRLb6qStQG93
         YZDSNJb63MuZA==
Received: by mail-oi1-f179.google.com with SMTP id bf7so14767627oib.11
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 08:49:37 -0700 (PDT)
X-Gm-Message-State: AOAM530NWBXC4PP7kEfroVLMOlCj7TE7eicQm/0t9qU3fZxZoNYkIrmm
        JsLM6TX0dbZ1AhXl5J8o6FUHZyAiVNyI9XAp3tc=
X-Google-Smtp-Source: ABdhPJytBueWy+kL3STv0h8CkO7mbpcQw6+9cqJE8HpuWyp/eCXmZv3zwADutGN7rO5634x0J3+rQ/ZT8gkNla31Gnk=
X-Received: by 2002:aca:aad5:0:b0:32f:3b9b:e0f with SMTP id
 t204-20020acaaad5000000b0032f3b9b0e0fmr5447234oie.228.1655308176362; Wed, 15
 Jun 2022 08:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220614114805.631-1-liuzixian4@huawei.com>
In-Reply-To: <20220614114805.631-1-liuzixian4@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jun 2022 17:49:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4HZjkurV1+u6r+g-yjpMk=b_0LXc++meb-zhL7r5omg@mail.gmail.com>
Message-ID: <CAMj1kXE4HZjkurV1+u6r+g-yjpMk=b_0LXc++meb-zhL7r5omg@mail.gmail.com>
Subject: Re: [PATCH] Correct comment on efi_memmap_alloc
To:     Liu Zixian <liuzixian4@huawei.com>
Cc:     dan.j.williams@intel.com, mingo@kernel.org,
        linux-efi@vger.kernel.org, linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 14 Jun 2022 at 13:48, Liu Zixian <liuzixian4@huawei.com> wrote:
>
> Returning zero means success now.
>
> Fixes: 1db91035d01a("efi: Add tracking for dynamically allocated memmaps")
> Signed-off-by: Liu Zixian <liuzixian4@huawei.com>

Applied, thanks.

> ---
>  drivers/firmware/efi/memmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 4df55a55d..cf87dd7bb 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -59,8 +59,7 @@ static void __init efi_memmap_free(void)
>   * Depending on whether mm_init() has already been invoked or not,
>   * either memblock or "normal" page allocation is used.
>   *
> - * Returns the physical address of the allocated memory map on
> - * success, zero on failure.
> + * Returns zero on success, a negative error code on failure.
>   */
>  int __init efi_memmap_alloc(unsigned int num_entries,
>                 struct efi_memory_map_data *data)
> --
> 2.33.0
>
