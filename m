Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292F376EAF9
	for <lists+linux-efi@lfdr.de>; Thu,  3 Aug 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjHCNov (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Aug 2023 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbjHCNoe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Aug 2023 09:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DEA44B5;
        Thu,  3 Aug 2023 06:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B673761DA6;
        Thu,  3 Aug 2023 13:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132EBC433AB;
        Thu,  3 Aug 2023 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691070122;
        bh=r4s3ur9QdCGpsgh3oEwBZT6hFanHdwrcpg4wERGLJmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZ1l5Ayx8C7Zp/tulDNSVBYkZJWqK57C3x6l59CjA3yonV/xGx38ic7sMk0FEbL1I
         7r+FAQR3CkGmag1uOdZJupMitc5su95trmpQq+hg4gOWYcLn7aG45g7fcQv9DiNlFc
         b/VYhdSnihf/wX9znQuY2PwkJDBsdy54DsTcrExL4JSslp9PDasgfhMSyLwbO/jfRk
         ePcLdGiZ0IFcpZvNUboF4S48ZQnvT7uP/WO4smdysBrHfDkzCnPJBWe3B77Cwiji8H
         wADXLQkVWoPA0PcsdSlZwSD4/GXAUlgYC6snnw/FOSRpfrfiJLJMTtb9hUnPJP9VO9
         D9UTD9IQM6Khg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso14645251fa.3;
        Thu, 03 Aug 2023 06:42:01 -0700 (PDT)
X-Gm-Message-State: ABy/qLb+mjKgdeaB2aUuHDEYFqYDAzbUNF53IYhFVUcUmqSH87EXjO0C
        aT6SjTzxlkbDXro1GdDPanuDjRMfdNUaCNW7ggI=
X-Google-Smtp-Source: APBJJlHpRNTBRSJY8f35QI0ZpCnxRMpG0BXG7sw1yanHmNpSx4z+ia17IG/byRlJSLtHTAAVz0fbvlrffdUyAKzLM0k=
X-Received: by 2002:a05:651c:106:b0:2b6:ded8:6fc1 with SMTP id
 a6-20020a05651c010600b002b6ded86fc1mr7321871ljb.25.1691070119999; Thu, 03 Aug
 2023 06:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230803055611.2343011-1-xiao.w.wang@intel.com>
In-Reply-To: <20230803055611.2343011-1-xiao.w.wang@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Aug 2023 15:41:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECv+JU-ahvWENk4XRrjxkfBmWoWHhOSdwGpfxC1LVLkg@mail.gmail.com>
Message-ID: <CAMj1kXECv+JU-ahvWENk4XRrjxkfBmWoWHhOSdwGpfxC1LVLkg@mail.gmail.com>
Subject: Re: [PATCH] efi/riscv: libstub: Fix comment about absolute relocation
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 3 Aug 2023 at 07:48, Xiao Wang <xiao.w.wang@intel.com> wrote:
>
> We don't want absolute symbols references in the stub, so fix the double
> negation in the comment.
>
> Fixes: d7071743db31 ("RISC-V: Add EFI stub support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>

Queued up in efi/next (without the cc stable)

Thanks,


> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index b0f8c495c10f..ed6e8ebd89b4 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -146,7 +146,7 @@ STUBCOPY_RELOC-$(CONFIG_ARM64)      := R_AARCH64_ABS
>
>  # For RISC-V, we don't need anything special other than arm64. Keep all the
>  # symbols in .init section and make sure that no absolute symbols references
> -# doesn't exist.
> +# exist.
>  STUBCOPY_FLAGS-$(CONFIG_RISCV) += --prefix-alloc-sections=.init \
>                                    --prefix-symbols=__efistub_
>  STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> --
> 2.25.1
>
