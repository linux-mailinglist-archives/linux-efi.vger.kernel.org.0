Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E51799E6B
	for <lists+linux-efi@lfdr.de>; Sun, 10 Sep 2023 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbjIJNIz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 10 Sep 2023 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJNIz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 10 Sep 2023 09:08:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6414DCCD;
        Sun, 10 Sep 2023 06:08:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EA8C433CB;
        Sun, 10 Sep 2023 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694351330;
        bh=06TCWhhNaPcXhNliGYsP4LF/Cwg8cceqJIrPIcchQC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nUhpT3ez+tRlG1qKGeKuY3N74tmjgygmH900zRvjZwa0kwhlQfD50HEhe2zSwH5bQ
         vXblBq40V6OwLPAyZUHpnX/nD9bgU6wIWH1bHYzgh7Ah82cdPR4YRjyxmLndyqeg+M
         SewkFy1TYvrmmdrN1ecFQJ7FNjiSQpU41SYYAroIvkClX95gWECtnmFzSbS1P5gfit
         tMO7Cy5FdwU/+9Ob4xAV8W1tItRJbXF+0azUkEISRV01gQjg89N64ydwbZB9+a2V3I
         aN2Gc/Hm8Jd32rZ/RboO7ctE9s5YuKkTDCrtojdvHKNtSA12iR02+csCCe6tpwWz1I
         2IZ3076zqTz4A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso57669761fa.1;
        Sun, 10 Sep 2023 06:08:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YxlED+rUsNnpNDsuHgeqQkXLjjd01Y+jQn/nUWqWn7zcnnUJA0R
        +/PmYg9MaQJ3q8oiK4ESbIXyYJ4xWBPaDMKOa6k=
X-Google-Smtp-Source: AGHT+IFIZnimPRaY6IPZz/3CkdKFl7CePRXC49Ub/MgsC8Wh4H7WKsZWw9ZKtn2hbE6ekgD2E9RKGbjhx1iYmClGwSg=
X-Received: by 2002:a2e:9987:0:b0:2bb:c212:5589 with SMTP id
 w7-20020a2e9987000000b002bbc2125589mr5771501lji.17.1694351329054; Sun, 10 Sep
 2023 06:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 10 Sep 2023 15:08:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEh3=vzJiCe1hy3r55akqSn0+t1AGZNEF8wqWCR3_rRcg@mail.gmail.com>
Message-ID: <CAMj1kXEh3=vzJiCe1hy3r55akqSn0+t1AGZNEF8wqWCR3_rRcg@mail.gmail.com>
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

On Sun, 10 Sept 2023 at 06:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Some firmware (notably U-Boot) provides GetVariable() and
> GetNextVariableName() but not QueryVariableInfo().
>
> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> statfs syscall was broken for such firmware.
>
> If QueryVariableInfo() does not exist or returns an error, just report the
> file-system size as 0 as statfs_simple() previously did.
>
> Fixes: d86ff3333cb1 ("efivarfs: expose used and total size")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         initialize remaining_space to 0

Thanks for the patch, and apologies for the oversight.

> ---
>  fs/efivarfs/super.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..3893aae6a9be 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -29,14 +29,9 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>         const u32 attr = EFI_VARIABLE_NON_VOLATILE |
>                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
>                          EFI_VARIABLE_RUNTIME_ACCESS;
> -       u64 storage_space, remaining_space, max_variable_size;
> +       u64 storage_space, remaining_space = 0, max_variable_size;

Shouldn't storage_space be set to 0 too?

>         efi_status_t status;
>
> -       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
> -                                           &max_variable_size);
> -       if (status != EFI_SUCCESS)
> -               return efi_status_to_err(status);
> -
>         /*
>          * This is not a normal filesystem, so no point in pretending it has a block
>          * size; we declare f_bsize to 1, so that we can then report the exact value
> @@ -44,10 +39,19 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>          */
>         buf->f_bsize    = 1;
>         buf->f_namelen  = NAME_MAX;
> -       buf->f_blocks   = storage_space;
> -       buf->f_bfree    = remaining_space;
>         buf->f_type     = dentry->d_sb->s_magic;
>
> +       /* Some UEFI firmware does not implement QueryVariable() */
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> +               status = efivar_query_variable_info(attr, &storage_space,
> +                                                   &remaining_space,
> +                                                   &max_variable_size);
> +               if (status == EFI_SUCCESS) {
> +                       buf->f_blocks   = storage_space;
> +                       buf->f_bfree    = remaining_space;
> +               }
> +       }
> +

I'd prefer not to ignore the error completely here. How about we do

--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -32,10 +32,15 @@ static int efivarfs_statfs(struct dentry *dentry,
struct kstatfs *buf)
        u64 storage_space, remaining_space, max_variable_size;
        efi_status_t status;

-       status = efivar_query_variable_info(attr, &storage_space,
&remaining_space,
-                                           &max_variable_size);
-       if (status != EFI_SUCCESS)
-               return efi_status_to_err(status);
+       /* Some UEFI firmware does not implement QueryVariableInfo() */
+       storage_space = remaining_space = 0;
+       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
+               status = efivar_query_variable_info(attr, &storage_space,
+                                                   &remaining_space,
+                                                   &max_variable_size);
+               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
+                       return efi_status_to_err(status);
+       }

        /*
         * This is not a normal filesystem, so no point in pretending
it has a block

(no need to resend if you agree)
