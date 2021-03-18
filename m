Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3B341136
	for <lists+linux-efi@lfdr.de>; Fri, 19 Mar 2021 00:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhCRXut (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Mar 2021 19:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhCRXuf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Mar 2021 19:50:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65E9964ED7;
        Thu, 18 Mar 2021 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616111435;
        bh=rzKFwnLa8KCdM4pN4BXE1ucrplLeLdyRuEuS+RV/zXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIyLnrrSzRT5mF77dn3OQf0KLJ82cfCk110SdU9kMh+gHRlDmtEJ+KJXw0TtEEDkN
         B3B5OZ0UITDw5Ndv4HY5JL4JFVurfSMQ2m/EIOozTBfhfB4rXM2DZnz0c9EzciOrjw
         byZlXuDsxHqkH4xrj6WqK179jtw5vAhTAC+/v4N0lHFgdRcyo5fm32v1mHfRoHn24O
         9Sn0WW4btwkHkzhWmYBzf3jX9dceb8OPZ9w/JcTHm1JOERkhLRoQdVDt4msWjMzqjl
         RgUN+z+N72y5XG8DNbGLa5beg37VRz0OId4dBwGf24R7wU4vzf6CIE+NJ20g0Z/ujn
         OnuYm+ZQcEkYA==
Date:   Thu, 18 Mar 2021 16:50:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH v2] efi: use 32-bit alignment for efi_guid_t literals
Message-ID: <20210318235030.wb2ysuyurgcrzovv@archlinux-ax161>
References: <20210318182046.211165-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318182046.211165-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 18, 2021 at 07:20:46PM +0100, Ard Biesheuvel wrote:
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

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
> -	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> +#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {					\
> +	(a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,	\
> +	(b) & 0xff, ((b) >> 8) & 0xff,						\
> +	(c) & 0xff, ((c) >> 8) & 0xff, d } }
>  
>  /*
>   * Generic EFI table header
> -- 
> 2.30.2
> 
