Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0C366E324
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 17:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjAQQLf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 11:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAQQLa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 11:11:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A66E3D09A;
        Tue, 17 Jan 2023 08:11:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B5B8B81889;
        Tue, 17 Jan 2023 16:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCABC433EF;
        Tue, 17 Jan 2023 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673971882;
        bh=xTE1yPH1rkI229fDj+mC/YQJ2/eMMUOTQWvvR5fFIIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bHm+CBhcboVNz5rG1WbVwfQE5aVQ+BNmnw8XM3cVs+tTgk62flhe20y/b3ZQiWmXk
         Rvhfherw/i/XlKW+jW3C7uEdFmMuIiIpZknz6eftkm2nw0BSHLZjZRBoajW0pzEtVg
         K34cy5s1BuFHE9sz2K4FqVmoBXNK5Z3uk+Mlv5MNw0DTvismLOG30G+M5SmCnZMk/9
         imGLajNYI/g/S+Lb0DV1qei3bFApRfPA5mu8VbZhQBJH8fIXekVxaLp1Vkbf3DVisI
         2w2l22KuWEKSUued5SgIBCPSFTsDx7J3dBMjNDJg+yOLA8iQ7h2Iu8QOFQmGAFCEhg
         XxK1Iuonx+CLg==
Received: by mail-lj1-f180.google.com with SMTP id o7so33286464ljj.8;
        Tue, 17 Jan 2023 08:11:22 -0800 (PST)
X-Gm-Message-State: AFqh2kpvTJ/uz7GHLPCPjTd0XDgAuVbPzGkDqb2s3shut1tJjqKglGmu
        /to+dYV0KOxjaGs0IywTYEVCXA4PWJtNW8C/m6A=
X-Google-Smtp-Source: AMrXdXvkVCs1iwIH0KvKagZhEQTEXSRkrHt/O1bjnxfiMtqvEZbqqeCQ6fgCeuYYSNnBbisBnhmGp4pV1xaPlIvwLm8=
X-Received: by 2002:a2e:964e:0:b0:27f:b833:cf6d with SMTP id
 z14-20020a2e964e000000b0027fb833cf6dmr323491ljh.291.1673971880890; Tue, 17
 Jan 2023 08:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20230117124310.16594-1-johan+linaro@kernel.org>
In-Reply-To: <20230117124310.16594-1-johan+linaro@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Jan 2023 17:11:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEC3u9pGJU5NAETVUdwMpWpgHdeorJA50QaZZBH_mJcgg@mail.gmail.com>
Message-ID: <CAMj1kXEC3u9pGJU5NAETVUdwMpWpgHdeorJA50QaZZBH_mJcgg@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi: efivars: drop kobject from efivars_register()
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 17 Jan 2023 at 13:46, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Since the removal of the deprecated efivars sysfs interface there are
> no users of the efivars kobject, which can be removed.
>
> Included is also a related patch changing the return type of
> efivar_supports_writes() to match the new efivar_is_available()
> function.
>
> Note that I intend to use efivar_is_available() in a driver with
> optional EFI support (hence the dummy implementation) and the removal of
> the kobject will simplify the upcoming Qualcomm UEFI Secure Application
> driver somewhat too.
>
> Johan
>
>
> Johan Hovold (2):
>   efi: efivars: drop kobject from efivars_register()
>   efi: efivars: make efivar_supports_writes() return bool
>

Thanks, I've queued these up now


>  drivers/firmware/efi/efi.c     |  2 +-
>  drivers/firmware/efi/vars.c    | 21 +++++++--------------
>  drivers/firmware/google/gsmi.c |  2 +-
>  fs/efivarfs/super.c            |  2 +-
>  include/linux/efi.h            | 13 ++++++++-----
>  5 files changed, 18 insertions(+), 22 deletions(-)
>
> --
> 2.38.2
>
