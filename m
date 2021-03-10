Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17C333757
	for <lists+linux-efi@lfdr.de>; Wed, 10 Mar 2021 09:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCJIc7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Mar 2021 03:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhCJIcg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Mar 2021 03:32:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A6864FF1
        for <linux-efi@vger.kernel.org>; Wed, 10 Mar 2021 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615365155;
        bh=PNdAS/mTlUGP0BENBQF2q15QeFNfRijmwR2vqiJm5z4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CX1JeVkN4MlMvrvNzojX+4YYdcnpW6n9wd9RhJg7I8TpVH8tWdY+mKnyBKlRC1Ir+
         Yh5fQKc3qyBzrTrpF5In0w193g0l0Hx72KZnL8cWQDTlKF182GmPQZ8nXL1/KshE6N
         OwsKKWw0DNuNdSuk3O98151hwEAs0falTrxkGfzQ/Losfu/OferQRKe07ARKA7hz8S
         +jH90gP27HeP2s/P9mxku6miWVLEYj+XqT5MsPa6T+Boi2O6hyVQKpi3rnl3Fx3SWy
         svc0g0AAttVk7PnfTN0s4FIO6rNkGSe7JAIW/M87PxC0wANTrSaS4oNUMNNlAGrlBC
         06SFyUv+xpE3w==
Received: by mail-ot1-f46.google.com with SMTP id t16so15622881ott.3
        for <linux-efi@vger.kernel.org>; Wed, 10 Mar 2021 00:32:35 -0800 (PST)
X-Gm-Message-State: AOAM530I1oPHbxA9T/nwfzvsAXBGVSstDLUK7JYnvg86fblZoHHZG34w
        gwuxGBEey5UnCnDZ3+lK355ro721awiK6wTAP68=
X-Google-Smtp-Source: ABdhPJzZoYFuw1NY6109ap7T6MERy5G5rAEatPGD9Bb5a9+KXLnOEixF0vJu8xDxbfCVcBko4AOiWpw8GKybl2LpQWk=
X-Received: by 2002:a9d:7512:: with SMTP id r18mr1812027otk.90.1615365155174;
 Wed, 10 Mar 2021 00:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20210310081210.95147-1-ardb@kernel.org>
In-Reply-To: <20210310081210.95147-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Mar 2021 09:32:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH5aZvTZqNkse0A5p8bQMTCGm3Hk5Z2StcJYUUGRvDdAw@mail.gmail.com>
Message-ID: <CAMj1kXH5aZvTZqNkse0A5p8bQMTCGm3Hk5Z2StcJYUUGRvDdAw@mail.gmail.com>
Subject: Re: [PATCH] efi: use 32-bit alignment for efi_guid_t literals
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Mar 2021 at 09:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Commit 494c704f9af0 ("efi: Use 32-bit alignment for efi_guid_t") updated
> the type definition of efi_guid_t to ensure that it always appears
> sufficiently aligned (the UEFI spec is ambiguous about this, but given
> the fact that its EFI_GUID type is defined in terms of a struct carrying
> a uint32_t, the natural alignment is definitely >= 32 bits).
>
> However, we missed the EFI_GUID() macro which is used to instantiate
> efi_guid_t literals: that macro is still based on the guid_t type,
> which does not have a minimum alignment at all. This results in warnings
> such as
>
>   In file included from drivers/firmware/efi/mokvar-table.c:35:
>   include/linux/efi.h:1093:34: warning: passing 1-byte aligned argument to
>       4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
>       access [-Walign-mismatch]
>           status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
>                                           ^
>   include/linux/efi.h:1101:24: warning: passing 1-byte aligned argument to
>       4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer
>       access [-Walign-mismatch]
>           get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
>
> The distinction only matters on CPUs that do not support misaligned loads
> fully, but 32-bit ARM's load-multiple instructions fall into that category,
> and these are likely to be emitted by the compiler that built the firmware
> for loading word-aligned 128-bit GUIDs from memory
>
> Instead of bodging this further, let's simply switch to our own definition
> of efi_guid_t that carries a uint32_t as well. Since efi_guid_t is used as
> an opaque type everywhere in the EFI code, this is only a minor code change.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>
> I am currently testing this change via my for-kernelci branch. Please give
> this some soak time in the other CIs that we have access to.
>

Note: efivarfs needs a tweak as well:

--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -84,7 +84,7 @@ static int efivarfs_create(struct user_namespace
*mnt_userns, struct inode *dir,
        /* length of the variable name itself: remove GUID and separator */
        namelen = dentry->d_name.len - EFI_VARIABLE_GUID_LEN - 1;

-       err = guid_parse(dentry->d_name.name + namelen + 1,
&var->var.VendorGuid);
+       err = guid_parse(dentry->d_name.name + namelen + 1, (guid_t
*)&var->var.VendorGuid);
        if (err)
                goto out;


>  include/linux/efi.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 8710f5710c1d..f39e9ec7485f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -63,17 +63,22 @@ typedef void *efi_handle_t;
>   * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
>   * this means that firmware services invoked by the kernel may assume that
>   * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
> - * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
> + * do not tolerate misalignment.
>   *
>   * Note that the UEFI spec as well as some comments in the EDK2 code base
>   * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
>   * a mistake, given that no code seems to exist that actually enforces that
>   * or relies on it.
>   */
> -typedef guid_t efi_guid_t __aligned(__alignof__(u32));
> +typedef struct {
> +       u32     a;
> +       u16     b;
> +       u16     c;
> +       u8      d[8];
> +} efi_guid_t;
>
>  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> -       GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> +       (efi_guid_t){ a, b, c, { d0,d1,d2,d3,d4,d5,d6,d7 }}
>
>  /*
>   * Generic EFI table header
> @@ -598,8 +603,8 @@ efi_guidcmp (efi_guid_t left, efi_guid_t right)
>  static inline char *
>  efi_guid_to_str(efi_guid_t *guid, char *out)
>  {
> -       sprintf(out, "%pUl", guid->b);
> -        return out;
> +       sprintf(out, "%pUl", guid);
> +       return out;
>  }
>
>  extern void efi_init (void);
> --
> 2.30.1
>
