Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F214079776C
	for <lists+linux-efi@lfdr.de>; Thu,  7 Sep 2023 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjIGQZf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Sep 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbjIGQYI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Sep 2023 12:24:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612431FDF;
        Thu,  7 Sep 2023 09:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05308C4AF1E;
        Thu,  7 Sep 2023 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694094181;
        bh=Ch7WblfpRipfDsuU7KUHy0F8vKh0ktD+BcNoYhc8y+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b/8JNqqseFOR0e9l5PZBJaIzhgEHXNoIDyKqiJLOltxBAFysfDS8BUMZUMTFaqg6L
         MPScSWVBGue0KFRKHWA0MnIkl/i+HYxJDUYBY/d6WP33EO/3Ignt0QbgAzz3mmwSq8
         oWSq4uWHpeeBpPW+RxAyM+fXP5Q4QjXravMtT3rrpcGR9L0vpZYNO95FXo9xIK5W9k
         izVGHWxJOa6lSYPsDFAcI1ftMh6aHbLDeagdeB7KPe3NhLoTNEOsNw+CSw3PDzD5A7
         p6QA3WzuReIVD4VNVESXRYIrTzIoUdpPIrpNmmNVS2h5yHp0MtRcwRtDDx8SFG7XoU
         rNrZ4pz2H8vSg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-502153ae36cso1532565e87.3;
        Thu, 07 Sep 2023 06:43:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw2g7BwxmKwGT3UaW0H/eHCcbGEY5HyyjU+FBzRRqoylfy5nJUl
        BlDzfBJVGWhq7FQBGZl6Z8O1t4Bn6x0uo71Gsqg=
X-Google-Smtp-Source: AGHT+IHu6xlf9Nt86B4MNq35FJyEJ2bVFSEf4fWRycJTBsW+Zv6qVuk98yeu06hp9URFP8EVR0kovvh3HF3Ux14Dgik=
X-Received: by 2002:a05:6512:12ca:b0:500:a2d0:51b6 with SMTP id
 p10-20020a05651212ca00b00500a2d051b6mr6218457lfg.37.1694094179012; Thu, 07
 Sep 2023 06:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230904113214.4147021-1-mikko.rapeli@linaro.org>
In-Reply-To: <20230904113214.4147021-1-mikko.rapeli@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 15:42:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGveLhJ1fNgZe_SSN4DrPeJc4VLpx+or2vqO8eezHdOUw@mail.gmail.com>
Message-ID: <CAMj1kXGveLhJ1fNgZe_SSN4DrPeJc4VLpx+or2vqO8eezHdOUw@mail.gmail.com>
Subject: Re: [PATCH] Documentation efi-stub.rst: fix arm64 EFI source location
To:     mikko.rapeli@linaro.org
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-efi@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 4 Sept 2023 at 13:42, <mikko.rapeli@linaro.org> wrote:
>
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> arch/arm64/kernel/efi-entry.S has been moved to
> drivers/firmware/efi/libstub/arm64-entry.S by commit
> v6.1-rc4-6-g4ef806096bdb and to
> drivers/firmware/efi/libstub/arm64.c by commit
> v6.2-rc3-6-g617861703830
>
> Fixes: 4ef806096bdb (arm64: efi: Move efi-entry.S into the libstub source directory)
> Fixes: 617861703830 (efi: arm64: enter with MMU and caches enabled)
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-efi@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  Documentation/admin-guide/efi-stub.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index b24e7c40d832..090f3a185e18 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -15,7 +15,7 @@ between architectures is in drivers/firmware/efi/libstub.
>
>  For arm64, there is no compressed kernel support, so the Image itself
>  masquerades as a PE/COFF image and the EFI stub is linked into the
> -kernel. The arm64 EFI stub lives in arch/arm64/kernel/efi-entry.S
> +kernel. The arm64 EFI stub lives in drivers/firmware/efi/libstub/arm64.c
>  and drivers/firmware/efi/libstub/arm64-stub.c.
>
>  By using the EFI boot stub it's possible to boot a Linux kernel
> --
> 2.34.1
>
