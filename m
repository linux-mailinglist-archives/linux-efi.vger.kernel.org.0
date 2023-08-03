Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D276EB05
	for <lists+linux-efi@lfdr.de>; Thu,  3 Aug 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjHCNpG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Aug 2023 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbjHCNoh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Aug 2023 09:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200B211E;
        Thu,  3 Aug 2023 06:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0053361DA6;
        Thu,  3 Aug 2023 13:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952CC433D9;
        Thu,  3 Aug 2023 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691070144;
        bh=HkJvbwl/48R8J5YNsxtYO5+3r594Gr8/X4+1eEb9j2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dn8uTPdEfNbU02/ZXy9zzIgwuqU1ay6ISow6lFGOp+sBdGFeMHJaHfnyaTh3sO18U
         5Gv3C9Yh9hRStaK675kYLzxbGhB76lehmbN/v9dztbgAQ3YIIpJ5o+2Fo7yw5xU2Me
         Vp6TqVuHGb/T72Q+iVuYXA4fCVZqGJauckCRg4/lxuzTIgYsAGilMu6DAgtniFga12
         Vt+fmzJ1umXy1m7i2Mm/IrbPs3F9LqU4x/AKs8YVVDmRbQeTsv5Y9cztaLu1NEWu/y
         53RiovUKFe6hVD1nnxxZFqNFtR3GQBoKq6MsFvnNJP8o66UhaB/uKzPz5QUDylJFIz
         /71wck+YX7RLA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so1747362e87.3;
        Thu, 03 Aug 2023 06:42:24 -0700 (PDT)
X-Gm-Message-State: ABy/qLaZsX4ih9v3BFNahI/X4Ezp6Kx7FcmhnrTW6b1S46c3YPl9GvNk
        F5cWSymCxwbLg73/WUHysXD49m1jInE/NcJjwLM=
X-Google-Smtp-Source: APBJJlEg78HAokAHmCZSplx4tG+txNUrrxYn1f5dudWXxaEOGih0o7XxLDmQWbKI8l0FCPWeDFMIspm7qQ0z1fORLHc=
X-Received: by 2002:ac2:4e06:0:b0:4fe:993:2218 with SMTP id
 e6-20020ac24e06000000b004fe09932218mr8495427lfr.31.1691070142386; Thu, 03 Aug
 2023 06:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230731112001.212982-1-wangzhu9@huawei.com>
In-Reply-To: <20230731112001.212982-1-wangzhu9@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Aug 2023 15:42:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+jPH3h9YWCWVbq9hx2gT0iqqRC_zRRHaJwhRF2Su_QQ@mail.gmail.com>
Message-ID: <CAMj1kXG+jPH3h9YWCWVbq9hx2gT0iqqRC_zRRHaJwhRF2Su_QQ@mail.gmail.com>
Subject: Re: [PATCH -next] efi: memmap: Remove kernel-doc warnings
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
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

On Mon, 31 Jul 2023 at 13:20, Zhu Wang <wangzhu9@huawei.com> wrote:
>
> Remove kernel-doc warnings:
>
> arch/x86/platform/efi/memmap.c:94: warning: Function parameter or member
> 'data' not described in 'efi_memmap_install'
> arch/x86/platform/efi/memmap.c:94: warning: Excess function parameter
> 'ctx' description in 'efi_memmap_install'
>
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

Queued up in efi/next - thanks,

> ---
>  arch/x86/platform/efi/memmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> index c69f8471e6d0..4ef20b49eb5e 100644
> --- a/arch/x86/platform/efi/memmap.c
> +++ b/arch/x86/platform/efi/memmap.c
> @@ -82,7 +82,7 @@ int __init efi_memmap_alloc(unsigned int num_entries,
>
>  /**
>   * efi_memmap_install - Install a new EFI memory map in efi.memmap
> - * @ctx: map allocation parameters (address, size, flags)
> + * @data: efi memmap installation parameters
>   *
>   * Unlike efi_memmap_init_*(), this function does not allow the caller
>   * to switch from early to late mappings. It simply uses the existing
> --
> 2.17.1
>
