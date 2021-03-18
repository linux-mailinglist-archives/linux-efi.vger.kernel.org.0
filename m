Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE0340EFA
	for <lists+linux-efi@lfdr.de>; Thu, 18 Mar 2021 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCRUWD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Mar 2021 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCRUWA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Mar 2021 16:22:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C0C06174A
        for <linux-efi@vger.kernel.org>; Thu, 18 Mar 2021 13:21:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 15so9216544ljj.0
        for <linux-efi@vger.kernel.org>; Thu, 18 Mar 2021 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=An0pBTX5Hn8j69HdV1+Skfw01dyPOnDBU7iE2TdS87s=;
        b=F5edTMuU5jbhMTggRkcSAr2X4u98R7FcEwDbZofLj4ADn5IpmO+KIpmrAeT72owYsA
         ZqQuw4aOiOdql949CGt7aGmqqUKJqXx1qXeXASQV0I6XGGRwB5xtJmWAm0RoZTJFKRVM
         Zt7pJv3hHYu0FoKRAeQ4ytI399TAm/gAVz3mIyPwmDiBXot3NPeb1p03G4Co3vUuQbBg
         n+qKjt3XZTuv6CzTNCjkfsAl46SSvRKxlFF+ohjrClrduzlFmV22/9kncLZmy8fvfV2N
         dZ2Nuc4H1AtVXIoBNwWEi+w7hExhGxmLqyG6w5LAES1+LV5JSKH0QcIdPaAx8IUAvO7W
         IarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=An0pBTX5Hn8j69HdV1+Skfw01dyPOnDBU7iE2TdS87s=;
        b=rQOjR6w9m/NBErzPckseUWoVRad8RWh9w9dzH6BC+dDoMYrNSUpIX7vyyhYZ1mftGZ
         PiA+QCPNG2ngaZTPKz6SpGTLz3nbBxnwGDfaiPkuoaG05pY4788lbT0rbPOrWui4P9vg
         qPAtKBD10Ws+3Udbc5uRLI5Rz8WaYg7MDlZyWXsk1dfAFzzyohR62TeFJdRq7vpgsGE7
         zhduq5fk/KMjYJ7afqxDrcInJAka7aFhk8VRDibx7bHG2//g5cXjgcUWCDut8hffwaYa
         XCP7wcYLCYt6POshYKtwdlY/lior+0msh4t47vspP/SLi24hObEqLQjynzSCAde7f0/+
         Nneg==
X-Gm-Message-State: AOAM531dpzw4vY1thW+BXqAy+zJoQ4oWrsKI4qjvaczMdapfhLXOqDqE
        xTWLLDz8BjFjcgN9XwDsY9xNO3BNxbIQojJntU0+mwHEZXLdCQ==
X-Google-Smtp-Source: ABdhPJykeXXrCYVfby9E103hwD+FaL4AYugilcvz34y9+Wekylttvrr5IQw67Zg6p6w+BhDzOHotJ07U6LAqKATBqH0=
X-Received: by 2002:a2e:5716:: with SMTP id l22mr6310046ljb.244.1616098918190;
 Thu, 18 Mar 2021 13:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210318182046.211165-1-ardb@kernel.org>
In-Reply-To: <20210318182046.211165-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 13:21:46 -0700
Message-ID: <CAKwvOdn106KfUUffPY6H9bQey6=_Ck-sAutu7aYTfWDYn0Rzrw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: use 32-bit alignment for efi_guid_t literals
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 18, 2021 at 11:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
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
> So re-implement the initializer in terms of our own efi_guid_t type, so that
> the alignment becomes a property of the literal's type.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Nice use of a variadic macro, and thanks for the patch.

494c704f9af0 landed in v5.1-rc1, would a Fixes: tag be appropriate?

Also, a tag like
Link: https://github.com/ClangBuiltLinux/linux/issues/1327
would help us track when/where this lands, in case the issue ever
comes up again, in branches of the stable tree for example.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

It might be further possible to share more code between EFI_GUID and
GUID_INIT if the cast for the literals are factored out, but this
looks fine to me as is.  Too much macro nesting gets hard to follow
anyways.

> ---
>  include/linux/efi.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 8710f5710c1d..6b5d36babfcc 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -72,8 +72,10 @@ typedef void *efi_handle_t;
>   */
>  typedef guid_t efi_guid_t __aligned(__alignof__(u32));
>
> -#define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> -       GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> +#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {                                        \
> +       (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,  \
> +       (b) & 0xff, ((b) >> 8) & 0xff,                                          \
> +       (c) & 0xff, ((c) >> 8) & 0xff, d } }
>
>  /*
>   * Generic EFI table header
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
