Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EC58FECA
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiHKPHi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKPHh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 11:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FABDEF9;
        Thu, 11 Aug 2022 08:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2288CB82129;
        Thu, 11 Aug 2022 15:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA5AC433C1;
        Thu, 11 Aug 2022 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660230453;
        bh=ZStvnTwsGcquNJ460V8fyJyMUjAHUOp2M0FccCg9/jQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uj49lUMyC1dsSTuHj4ANnIYmtp/uHvz/TYvMUlVp5lPI34bKMvfbgBhfBIrmzJWMb
         q0VXYQQr7i7wOyVfGBc6Pcflvj6L0KjRPgziWk4sJ8pFT9EoqcOaLEKW5qUtvE2lel
         zec9JNABt6gBvVlySwW0RwaL642Fvdrw5sq933dDquQ5t0QT4bp246yEc/tqHz9Sk+
         rBDj3y6cbiThMG/tQAjPdClXHHjeOkQJRHajB3t9iz/S23SoUcGdZoj8aELi4t/N+P
         4BssIOFFfrPsGpAztDqvZFXZGZFgERzcqMK4iabQdw/pHx9syX3+HN6I9j7Vntp/cP
         a0gWSNZH5XfSQ==
Received: by mail-wm1-f53.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso2863112wma.3;
        Thu, 11 Aug 2022 08:07:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo0whmZiYXixrwU6P3sHo1t7imG8JrqQHGU+OUDiR99sgKsh2pu5
        mWuBnzRG1YkKRzgVxm1zB8Wx5r4JeMaLHQwEhMs=
X-Google-Smtp-Source: AA6agR7TAYHqajxN2ie6/6Fe0ZHbqdXgNFKYEPlRByFmsZVpkomUiHgvC1hEo/eGOXMZ7d35LbslY/4k26JuFKUikSM=
X-Received: by 2002:a05:600c:a45:b0:3a4:d07e:112d with SMTP id
 c5-20020a05600c0a4500b003a4d07e112dmr5946494wmq.141.1660230452130; Thu, 11
 Aug 2022 08:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220811091713.10427-1-justin.he@arm.com> <20220811091713.10427-2-justin.he@arm.com>
In-Reply-To: <20220811091713.10427-2-justin.he@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 11 Aug 2022 17:07:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGJ9_B48n-vDJC45m5kEYgVnsG--MDDO_crWTgBKj05rQ@mail.gmail.com>
Message-ID: <CAMj1kXGJ9_B48n-vDJC45m5kEYgVnsG--MDDO_crWTgBKj05rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/cper: export several helpers for ghes edac to use
To:     Jia He <justin.he@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, toshi.kani@hpe.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 11 Aug 2022 at 11:17, Jia He <justin.he@arm.com> wrote:
>
> Before modularizing the ghes_edac codes, we need to export several efi/cper
> helpers to avoid linking error of ghes_edac.
>
> Signed-off-by: Jia He <justin.he@arm.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/cper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index e4e5ea7ce910..053eae13f409 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -290,6 +290,7 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>
>         return n;
>  }
> +EXPORT_SYMBOL_GPL(cper_mem_err_location);
>
>  int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>  {
> @@ -310,6 +311,7 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
>
>         return n;
>  }
> +EXPORT_SYMBOL_GPL(cper_dimm_err_location);
>
>  void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
>                        struct cper_mem_err_compact *cmem)
> @@ -331,6 +333,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
>         cmem->mem_array_handle = mem->mem_array_handle;
>         cmem->mem_dev_handle = mem->mem_dev_handle;
>  }
> +EXPORT_SYMBOL_GPL(cper_mem_err_pack);
>
>  const char *cper_mem_err_unpack(struct trace_seq *p,
>                                 struct cper_mem_err_compact *cmem)
> --
> 2.25.1
>
