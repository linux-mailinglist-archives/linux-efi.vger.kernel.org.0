Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE468255A
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAaHFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 02:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjAaHEz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 02:04:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F481701;
        Mon, 30 Jan 2023 23:04:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEEC061419;
        Tue, 31 Jan 2023 07:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1C3C433D2;
        Tue, 31 Jan 2023 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675148694;
        bh=huVTQwzYzVAXQ6wYf9houIiEm7uaCfjktcFfNyfAwPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjhJyftftwGyQzt3u8T8GQs6mmXdRjRdYK+VhfPITJDA3vZg69u6T9U0XIxQafdv+
         0Zmcr1hd9GwSsynRPDSdd0YllZT7FL50qVKdt3SLPsgV28XsVVrzfGHBsS/uv5+20c
         15l+MfAxYZ+6Wprtm0MI1GX2pzdNcprABpEyeyVRNUbPnu0mImIGWBPd1eLtBz03zJ
         YV1J8tT/UEBRZNK5HgFxuQEE90b6rIviaFDfqBidGVvdSgV2y4CBLSRXY7q6Vecn1C
         QHNQZG1vbfkLgjZGN2s9cACjMGBeat0H1pLCTYC8+G/wdkOp+RXl8X8gliGobZwKJc
         zKQfndJviY2Kw==
Received: by mail-lf1-f48.google.com with SMTP id cf42so22836948lfb.1;
        Mon, 30 Jan 2023 23:04:54 -0800 (PST)
X-Gm-Message-State: AFqh2ko65SQOlC9WSkJFEe8gRSn6UpiExnr2bG98j8d5lhZddNfSIj2z
        wdCHz/eUkzgLQg+RMyPDRxw781bJJLxG+90wWHE=
X-Google-Smtp-Source: AMrXdXsAbS3qFCU+cDSque43gME4irlZAr7w/EAqWFmZgCnU5AYHvaBiXQXNPnb1B9mEn30TcT/3JxeN1cfj9fsSaXA=
X-Received: by 2002:a05:6512:2247:b0:4ca:f9e3:c324 with SMTP id
 i7-20020a056512224700b004caf9e3c324mr5396460lfu.190.1675148692155; Mon, 30
 Jan 2023 23:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com> <20230131040355.3116-2-justin.he@arm.com>
In-Reply-To: <20230131040355.3116-2-justin.he@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 08:04:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF6nuuA-jOyUNhXY-A-pmo4D9Qoccq=E6CBjzz=VuTA4g@mail.gmail.com>
Message-ID: <CAMj1kXF6nuuA-jOyUNhXY-A-pmo4D9Qoccq=E6CBjzz=VuTA4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: libstub: Fix the retriving of supported rutime services
To:     Jia He <justin.he@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Jan 2023 at 05:04, Jia He <justin.he@arm.com> wrote:
>
> If retrieving UEFI configuration table is failed, the supported runtime
> services mask should be regarded as 0 instead of EFI_RT_SUPPORTED_ALL.
> Otherwise efi_novamap might be incorrectly assigned to "false" on the
> Ampere Emag server.
>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 2955c1ac6a36..f24b5436729c 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -111,6 +111,8 @@ static u32 get_supported_rt_services(void)
>         rt_prop_table = get_efi_config_table(EFI_RT_PROPERTIES_TABLE_GUID);
>         if (rt_prop_table)
>                 supported &= rt_prop_table->runtime_services_supported;
> +       else
> +               supported = 0;
>
>         return supported;
>  }

Hello Justin,

This is not how things are supposed to work. On systems that do not
implement the RT properties table, all runtime services are assumed to
be implemented.

Note that this table is informational only - the runtime services
themselves must be callable and return EFI_UNSUPPORTED if they are
marked as unavailable in the RT properties table.
