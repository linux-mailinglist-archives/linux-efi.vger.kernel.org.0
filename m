Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF96A471A
	for <lists+linux-efi@lfdr.de>; Mon, 27 Feb 2023 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0Qe5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Feb 2023 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjB0Qe4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Feb 2023 11:34:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F856181;
        Mon, 27 Feb 2023 08:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B8B2B80D7A;
        Mon, 27 Feb 2023 16:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD5C4339B;
        Mon, 27 Feb 2023 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677515691;
        bh=ysg1g/ZcQSWNVuTE8NtkzMkkLbwHUGn9rkR86nbbHY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sepxnuDvLBxSScNXeyQEUBu20wjXDXrDsNrCzMQbKStwMRSy8nYajOX+LtmkLCLZl
         pFyFDUgwy2/Yas0WmIsh+os+rgImLgl7gUoanVRxIOzpvsJt5EIce0rZ4eV2CIvR7m
         9yoRgpK87zcMPnh6o4SIo90kgsH7vjSP7mVn4QFzwRHwswqnDxlCmV1j6sgutY76oi
         30ZYoA6ov8mSyIcumLxc4BmXoTWnMeJt8+wTQ66qfktxgDD1gArQc+ZRmlh3eXTkAm
         IEw2YoprQYMj9SfF3vi1nWN/LpurN9BrtaZchbK0ErWxiczAAfKg7KkpQgxtMyxZYt
         KKURXOuCVdKGA==
Received: by mail-lf1-f51.google.com with SMTP id n2so9275789lfb.12;
        Mon, 27 Feb 2023 08:34:51 -0800 (PST)
X-Gm-Message-State: AO0yUKUX8LxcNj+umkHc1kXSHs8JDl5wBTYOqGowDUnBtP+QBjBA6gFL
        KsmJTBrTi0imNR0Gtc9S8HlFEl2zifSzzs2+TFg=
X-Google-Smtp-Source: AK7set++oeaP/IwOS2ZLnIc+IJsuRWJDDYe+9s9Vu25q1q3duZvdr2T5DHawYNExoRi/zeceX8KJhT6MAfTs1x5Bx1Y=
X-Received: by 2002:ac2:5a41:0:b0:4dd:805b:5b75 with SMTP id
 r1-20020ac25a41000000b004dd805b5b75mr7602881lfn.7.1677515689640; Mon, 27 Feb
 2023 08:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20230227-kobj_type-x86-efi-v1-1-a335952d2536@weissschuh.net>
In-Reply-To: <20230227-kobj_type-x86-efi-v1-1-a335952d2536@weissschuh.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Feb 2023 17:34:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGwZxjjB3ojmH5cHDOLnveGY2vSz7t=xgj2dN7dg1K09Q@mail.gmail.com>
Message-ID: <CAMj1kXGwZxjjB3ojmH5cHDOLnveGY2vSz7t=xgj2dN7dg1K09Q@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: make kobj_type structure constant
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 27 Feb 2023 at 04:09, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Thanks, I'll queue these up after the merge window.

> ---
>  arch/x86/platform/efi/runtime-map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/runtime-map.c b/arch/x86/platform/efi/=
runtime-map.c
> index bbee682ef8cd..a6f02cef3ca2 100644
> --- a/arch/x86/platform/efi/runtime-map.c
> +++ b/arch/x86/platform/efi/runtime-map.c
> @@ -93,7 +93,7 @@ static void map_release(struct kobject *kobj)
>         kfree(entry);
>  }
>
> -static struct kobj_type __refdata map_ktype =3D {
> +static const struct kobj_type __refconst map_ktype =3D {
>         .sysfs_ops      =3D &map_attr_ops,
>         .default_groups =3D def_groups,
>         .release        =3D map_release,
>
> ---
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> change-id: 20230227-kobj_type-x86-efi-7591b1343b08
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
