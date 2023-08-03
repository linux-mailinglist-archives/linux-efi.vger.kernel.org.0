Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8313676EB07
	for <lists+linux-efi@lfdr.de>; Thu,  3 Aug 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjHCNpP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Aug 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjHCNoj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Aug 2023 09:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927D128;
        Thu,  3 Aug 2023 06:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D4761D99;
        Thu,  3 Aug 2023 13:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C4C433C8;
        Thu,  3 Aug 2023 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691070160;
        bh=11fG7eUZQr+FKpPCRHbyy5SmxNH/PAwqQ9O1e9CkHjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uMFLVHxodr5jw4a7bzf2JflvW5MB77yPHl5aFunE75z/cVQiwSDKPMRxbU8goR9If
         ZC29FX5TL5Qe5QjBrLMW2gViVfGtiTJBQEXlJvJ+KhUbpYl2UdmP0IBHIwED938K82
         8YQhyF9l5i+w48YNDkOXr1EysaE5/igx+H4y1fr6Jjhn55QobfkU3T8PWj6ZwfzWqI
         rkorOfCOgJLfVrWdKXf+7OkrhE8nCsDqEvGnfo5sB4ubNncr9nWctDvvA0xyGd034O
         7mIzYsdlupJNwGm272IqhVtSPNTZgTUEcGP+eHOld6ixMyVnGL+CjF9gExGpKeswbf
         SLAGhFy4UBZFQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso14220141fa.2;
        Thu, 03 Aug 2023 06:42:40 -0700 (PDT)
X-Gm-Message-State: ABy/qLbt0yeuUWzPJKgCdzSDMRpmUo8UOikNEDCw+Gproj3O7hCKr42Q
        koUGkAgnAj12+GtMWXuumBOK/0ta55wMaP2Yi4I=
X-Google-Smtp-Source: APBJJlEfkX1QHAgiwOCLTcrNDCPEIydp4nEzJYE9kjfd2zsHOsBYvElcdFGRw2KqHZwlUl630rMN1nuUF8JXkF/r9Sw=
X-Received: by 2002:a2e:6e15:0:b0:2b9:f007:9908 with SMTP id
 j21-20020a2e6e15000000b002b9f0079908mr8548347ljc.41.1691070158878; Thu, 03
 Aug 2023 06:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230725140327.24960-1-yuehaibing@huawei.com>
In-Reply-To: <20230725140327.24960-1-yuehaibing@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Aug 2023 15:42:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF2edHZ65OXRWpS0mrvAW9JH5DpV0oN3En+TAnUQqNX=g@mail.gmail.com>
Message-ID: <CAMj1kXF2edHZ65OXRWpS0mrvAW9JH5DpV0oN3En+TAnUQqNX=g@mail.gmail.com>
Subject: Re: [PATCH -next] efi: Remove unused extern declaration efi_lookup_mapped_addr()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 25 Jul 2023 at 16:04, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Since commit 50a0cb565246 ("x86/efi-bgrt: Fix kernel panic when mapping BGRT data")
> this extern declaration is not used anymore.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Queued up in efi/next - thanks,


> ---
>  include/linux/efi.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c31a9895ecb8..d4ec0d9c896f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -727,7 +727,6 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
>         return EFI_SUCCESS;
>  }
>  #endif
> -extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
>
>  extern int __init __efi_memmap_init(struct efi_memory_map_data *data);
>  extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
> --
> 2.34.1
>
