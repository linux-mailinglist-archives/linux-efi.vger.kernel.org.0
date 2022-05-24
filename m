Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEBE53216E
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 05:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiEXDEb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 May 2022 23:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiEXDEa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 May 2022 23:04:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34D9CF54;
        Mon, 23 May 2022 20:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68C9B81722;
        Tue, 24 May 2022 03:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98201C34116;
        Tue, 24 May 2022 03:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653361467;
        bh=qWnVDWAjid71ooDdWOtq1OAHCdmb1NhF9I9GI1+mbTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IXF1vf9TQxnWhN8dyb3vXRY5i7C4ZVjfYQlP97K+EJygPTSUNJpNls03Ane6WsO5V
         cUwrLo/7drH1vxP/8EkITOY6qe1MMthQaS08Yjjd4KwYJmw5Kw/FGLqjnfd4xAkTNX
         OXq3axmQZkjjklCwGkfNGMKzoxKSn/GQQUBPk7PCeFS+T1Z4IhC3q/lvSDqCKFcMdf
         +28knuTRC3wAcycNHRNbvuy1taTsqMkQ82+PrZVMAvFTzl0DFnZ2H4LfrSgv+HG7vd
         taOgG4gDATPyxms/8+UW8VjaoQlPSuN27pQmmkANEYrLSoijzLepPAPeXuLC4XDuya
         jWJWy0cUCfrGA==
Received: by mail-vk1-f169.google.com with SMTP id x11so7429279vkn.11;
        Mon, 23 May 2022 20:04:27 -0700 (PDT)
X-Gm-Message-State: AOAM5314Kt0PFb0niCcHuFtJHG/gQQJHg+65OrE3ZpyXCdy9d8sGa0wC
        wlnJBM1D84uLxQtnWceM3XoUjyyMIf6bp+bu8xg=
X-Google-Smtp-Source: ABdhPJyBoHyDiFB9zfTrk0h3uCRubd66z4I9upiswv1OPAdoPpS7WY8TblRjzXBTimmr4NvDgW03JpCOs0xmADoIW6E=
X-Received: by 2002:a1f:2106:0:b0:357:a8c9:a8d6 with SMTP id
 h6-20020a1f2106000000b00357a8c9a8d6mr2606095vkh.2.1653361466571; Mon, 23 May
 2022 20:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <1653360446-15598-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1653360446-15598-1-git-send-email-baihaowen@meizu.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 11:04:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6VX5Bbmv4r8O=LbnZVWvVRr1GNUDs=6uHx337AdD52Fw@mail.gmail.com>
Message-ID: <CAAhV-H6VX5Bbmv4r8O=LbnZVWvVRr1GNUDs=6uHx337AdD52Fw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix unsigned function returning negative constant
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Haowen,

On Tue, May 24, 2022 at 10:47 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> The function set_virtual_map has an unsigned return type, but returns a
> negative constant to indicate an error condition. So we change unsigned
> to int.
Your patch is correct, but original hasn't been upstream, I don't
know how to handle it.

Huacai
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  arch/loongarch/kernel/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index 69ebdd4220ec..f9fdeb1ae358 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -102,7 +102,7 @@ static void __init fix_efi_mapping(void)
>   * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
>   * are also copied to @runtime_map, and their total count is returned in @count.
>   */
> -static unsigned int __init set_virtual_map(void)
> +static int __init set_virtual_map(void)
>  {
>         int count = 0;
>         unsigned int size;
> --
> 2.7.4
>
