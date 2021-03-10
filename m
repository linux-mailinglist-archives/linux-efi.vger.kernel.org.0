Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4087F334B78
	for <lists+linux-efi@lfdr.de>; Wed, 10 Mar 2021 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhCJWV7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Mar 2021 17:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhCJWVp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Mar 2021 17:21:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C52BC64FB9;
        Wed, 10 Mar 2021 22:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615414904;
        bh=Cjyb7pURCwOTaOfNNugU2rYNsrRSkbdM6Q3cp5FkEAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bG/TvSX3K8b/QOYSuA8BBUxoiaA1LIa6vW4VH6uqEcrXfn3N3lNP80Oa6i9EYqG+/
         PU9dk+KPp4xhHAexul7HoFCt8MiF9EEanRIX/GaiwOy+Uj6U5qrcIQENj4njgHSsME
         kfXmTLzvP8wLrtfNzf+MFtyTao7z6x6ndiYPMsMgK44OE+mKbvbsStYAfT4b+6y6Qj
         zt0PTRsxMA8XnMwtycE0YExAklA3Ndi3qHjea5MxFJSnVsj98T+9OKvw99qyeocZGN
         07D2+J8e8KvQLw433s5IW+6rDNG7ZnBizCkA3oaw8UG9CsThfjJ045mS9GbFyENnwW
         2efsNbEj4DxgA==
Date:   Wed, 10 Mar 2021 15:21:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] efi: use 32-bit alignment for efi_guid_t literals
Message-ID: <20210310222139.7frwtzxd5jgxvwsl@archlinux-ax161>
References: <20210310081210.95147-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310081210.95147-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 10, 2021 at 09:12:10AM +0100, Ard Biesheuvel wrote:
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

I ran this through my series of 32-bit and 64-bit x86 builds and I did
not see any additional warnings added because of it.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> I am currently testing this change via my for-kernelci branch. Please give
> this some soak time in the other CIs that we have access to.
> 
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
> +	u32	a;
> +	u16	b;
> +	u16	c;
> +	u8	d[8];
> +} efi_guid_t;
>  
>  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> -	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> +	(efi_guid_t){ a, b, c, { d0,d1,d2,d3,d4,d5,d6,d7 }}
>  
>  /*
>   * Generic EFI table header
> @@ -598,8 +603,8 @@ efi_guidcmp (efi_guid_t left, efi_guid_t right)
>  static inline char *
>  efi_guid_to_str(efi_guid_t *guid, char *out)
>  {
> -	sprintf(out, "%pUl", guid->b);
> -        return out;
> +	sprintf(out, "%pUl", guid);
> +	return out;
>  }
>  
>  extern void efi_init (void);
> -- 
> 2.30.1
> 
