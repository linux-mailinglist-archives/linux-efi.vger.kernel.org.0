Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6E799E8B
	for <lists+linux-efi@lfdr.de>; Sun, 10 Sep 2023 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjIJNyX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 10 Sep 2023 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjIJNyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 10 Sep 2023 09:54:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D8CC5;
        Sun, 10 Sep 2023 06:54:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5483AC433C9;
        Sun, 10 Sep 2023 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694354058;
        bh=9BAMS8WkwoUOiB0TvEfMv+g67C+YDguWQRteutbYFIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O4mohHC52JBcownURoAKzzxxKxnOJmwbU6hhY72delTfrRbHYSs866M99+wQoiYLY
         wtingMSOj9z/w+mSoPutX1cZKAbyos6X3rQ2Lmo1oxHlru+TSwkhXzBQ37FDJ0gR9H
         HzNS2WU0gnyPnEJMdy0ZGheJ3ZTSK23gx8/ykK2EK9FcvrorZk3fH7zRFK8AiH7bWy
         3vuSDwNZHOYs+60FU1IsnbNScjm6geahwRvffx5HQyJnb5jboK8GiP5iZDMmMLLegS
         Tb1lPRfIHyVW6k1bRwsp4tJXSEK8rxYLGxUYSzXDgkxx4bnCg1Ltu4HnUQVbvwX8SC
         OzdSYfxkyihkQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso60898071fa.3;
        Sun, 10 Sep 2023 06:54:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWNIs59nUWS86arOVr0Hgudu6iqhgwv9uytus46b2sS5nPbbqB
        sWWh+KO2YYzzuGSZwcZf6MYQIAg9FCMSH5ribHI=
X-Google-Smtp-Source: AGHT+IGUOzMwqUV2dOh6AnDLr1JJ8JkjDGnmpt6nh9NVkLo0JsR9ZEIddrvlGN+TDyGAzA7yjBtSAy95ci4UVNa5QG0=
X-Received: by 2002:a2e:9783:0:b0:2bc:d582:e724 with SMTP id
 y3-20020a2e9783000000b002bcd582e724mr5450134lji.31.1694354056517; Sun, 10 Sep
 2023 06:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com> <CAMj1kXEh3=vzJiCe1hy3r55akqSn0+t1AGZNEF8wqWCR3_rRcg@mail.gmail.com>
In-Reply-To: <CAMj1kXEh3=vzJiCe1hy3r55akqSn0+t1AGZNEF8wqWCR3_rRcg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 10 Sep 2023 15:54:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com>
Message-ID: <CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 10 Sept 2023 at 15:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 10 Sept 2023 at 06:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Some firmware (notably U-Boot) provides GetVariable() and
> > GetNextVariableName() but not QueryVariableInfo().
> >
> > With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> > statfs syscall was broken for such firmware.
> >
> > If QueryVariableInfo() does not exist or returns an error, just report the
> > file-system size as 0 as statfs_simple() previously did.
> >
> > Fixes: d86ff3333cb1 ("efivarfs: expose used and total size")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         initialize remaining_space to 0
>
> Thanks for the patch, and apologies for the oversight.
>
> > ---
> >  fs/efivarfs/super.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index e028fafa04f3..3893aae6a9be 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -29,14 +29,9 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >         const u32 attr = EFI_VARIABLE_NON_VOLATILE |
> >                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >                          EFI_VARIABLE_RUNTIME_ACCESS;
> > -       u64 storage_space, remaining_space, max_variable_size;
> > +       u64 storage_space, remaining_space = 0, max_variable_size;
>
> Shouldn't storage_space be set to 0 too?
>
> >         efi_status_t status;
> >
> > -       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
> > -                                           &max_variable_size);
> > -       if (status != EFI_SUCCESS)
> > -               return efi_status_to_err(status);
> > -
> >         /*
> >          * This is not a normal filesystem, so no point in pretending it has a block
> >          * size; we declare f_bsize to 1, so that we can then report the exact value
> > @@ -44,10 +39,19 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >          */
> >         buf->f_bsize    = 1;
> >         buf->f_namelen  = NAME_MAX;
> > -       buf->f_blocks   = storage_space;
> > -       buf->f_bfree    = remaining_space;
> >         buf->f_type     = dentry->d_sb->s_magic;
> >
> > +       /* Some UEFI firmware does not implement QueryVariable() */
> > +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> > +               status = efivar_query_variable_info(attr, &storage_space,
> > +                                                   &remaining_space,
> > +                                                   &max_variable_size);
> > +               if (status == EFI_SUCCESS) {
> > +                       buf->f_blocks   = storage_space;
> > +                       buf->f_bfree    = remaining_space;
> > +               }
> > +       }
> > +
>
> I'd prefer not to ignore the error completely here. How about we do
>
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -32,10 +32,15 @@ static int efivarfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>         u64 storage_space, remaining_space, max_variable_size;
>         efi_status_t status;
>
> -       status = efivar_query_variable_info(attr, &storage_space,
> &remaining_space,
> -                                           &max_variable_size);
> -       if (status != EFI_SUCCESS)
> -               return efi_status_to_err(status);
> +       /* Some UEFI firmware does not implement QueryVariableInfo() */
> +       storage_space = remaining_space = 0;
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> +               status = efivar_query_variable_info(attr, &storage_space,
> +                                                   &remaining_space,
> +                                                   &max_variable_size);
> +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> +                       return efi_status_to_err(status);
> +       }
>
>         /*
>          * This is not a normal filesystem, so no point in pretending
> it has a block
>
> (no need to resend if you agree)

Actually, perhaps it would be better to simply fall back to the old
logic if QueryVariableInfo is not provided:

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..50b05f1fa974 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -30,10 +30,15 @@ static int efivarfs_statfs(struct dentry *dentry,
struct kstatfs *buf)
                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
                         EFI_VARIABLE_RUNTIME_ACCESS;
        u64 storage_space, remaining_space, max_variable_size;
-       efi_status_t status;
+       efi_status_t status = EFI_UNSUPPORTED;
+
+       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO))
+               status = efivar_query_variable_info(attr, &storage_space,
+                                                   &remaining_space,
+                                                   &max_variable_size);
+       if (status == EFI_UNSUPPORTED)
+               return simple_statfs(dentry, buf);

-       status = efivar_query_variable_info(attr, &storage_space,
&remaining_space,
-                                           &max_variable_size);
        if (status != EFI_SUCCESS)
                return efi_status_to_err(status);
