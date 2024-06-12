Return-Path: <linux-efi+bounces-1206-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611849053FD
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19D0286D29
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDC17C7AD;
	Wed, 12 Jun 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF6U3Sma"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AC17C20B;
	Wed, 12 Jun 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199693; cv=none; b=sElq2TyE7SOBUZqSCdWHzu1lmMMgxFgiafJMK3BWtuJ+mPapG/7AYvVZ3g3/L8qL6L+TUiS9VS8FJYIa8nRZa2D1EZRwoUlghIqyULiKUcLGS++w0mQXw8nT9yFuyQcB4NOJSlyMCKIfiacUUcN62QcHexzlwKBT6VWMZrbWhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199693; c=relaxed/simple;
	bh=Hznc7hRgrzn2IxR8Fss2HdZtPD+nw6i8AeUbGDa+luw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdYjZDahuTLy8+TBlgpipVmK9fB7cWpF/n43HQ1j4D2JX3pgKGqdQUCph+Yfdngo31CK65R48NinLLW+ktJDG2SePOjaFAOPsTva8SUKwJARpXvHo5xRBNv/iRdJDz5j4MPApnwhiCaM+xqfRTZrKvB61TQML1XQYy+g8kh+j08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF6U3Sma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241C5C4AF48;
	Wed, 12 Jun 2024 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718199693;
	bh=Hznc7hRgrzn2IxR8Fss2HdZtPD+nw6i8AeUbGDa+luw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qF6U3SmaZoTFR60uJau309WxT7aGiKNezaclvjpZlyF/ZdiX3OvnUQhs2S7yoRAAO
	 wbCsV0VcJKmemuPgmiCnVJE4mfZTFi1k2fzMMhMRhKfJiwiqif1w/D9QBhWjBerBLL
	 dJLSN64KV63TJl9DYb1XPwmWbFuCDMgAvfhvMcyibNJa+QAzumSUFUCujcnBP0zkFB
	 LZ+RNKAYoxKyb97jsTWqEvWCtOcWJTH81ApayzRN5taSS7AaLYUAkcmbTwd0rBQlcM
	 qlLz506GaD8vZByd2gLiTa0JOSaTYC+khxAWMuwElYAAG6qxQ2IHt0hA3+YX/6sRU/
	 jpv+ZytdwVr9Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso861412e87.1;
        Wed, 12 Jun 2024 06:41:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkH3cfCFkcMq+DO32Wg8tcYsMofSMkuKVzOEAkBxemHUMuD7ktkJkeGmSfOST85DilL9/K0C9i8l5VcHjGh3kwPTo0KtYaLWV98PjS
X-Gm-Message-State: AOJu0Yw1bXtsoW6kbYXjwx/JHvKd05HIng0YgH6NSHLKOM/WzRkZMdyp
	+xxD8dDX+Vy3mj3Ie9eWJVTAeYTyXfrL8AqtQv61VbI5swPzRuE8a+8kQJzqKIrP1sVcJ9EUHWh
	mKxyqqMv0gUMR6caaTmskjvA6oRI=
X-Google-Smtp-Source: AGHT+IEun5Gtz0LCxq9yBb41flxm/g/kXOUXseEINgoIv9wOBEOLa8iFLxx8BeuDj8pfpBvS/ZBkQeXetjv0oZxS87c=
X-Received: by 2002:ac2:5b83:0:b0:52c:8dc6:e40b with SMTP id
 2adb3069b0e04-52c9a0bdf5cmr531653e87.4.1718199691497; Wed, 12 Jun 2024
 06:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612123710.177557-2-ardb+git@google.com>
In-Reply-To: <20240612123710.177557-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Jun 2024 15:41:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHm5QdzmzZOJSdaqpsS8AA0n6u_s=3ovp7Box=e28St3A@mail.gmail.com>
Message-ID: <CAMj1kXHm5QdzmzZOJSdaqpsS8AA0n6u_s=3ovp7Box=e28St3A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Free EFI memory map only when installing a
 new one.
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 14:37, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The logic in __efi_memmap_init() is shared between two different
> execution flows:
> - mapping the EFI memory map early or late into the kernel VA space, so
>   that its entries can be accessed;
> - cloning the EFI memory map in order to insert new entries that are
>   created as a result of creating a memory reservation
>   (efi_arch_mem_reserve())
>
> In the former case, the underlying memory containing the kernel's view
> of the EFI memory map (which may be heavily modified by the kernel
> itself on x86) is not modified at all, and the only thing that changes
> is the virtual mapping of this memory, which is different between early
> and late boot.
>
> In the latter case, an entirely new allocation is created that carries a
> new, updated version of the kernel's view of the EFI memory map. When
> installing this new version, the old version will no longer be
> referenced, and if the memory was allocated by the kernel, it will leak
> unless it gets freed.
>
> The logic that implements this freeing currently lives on the code path
> that is shared between these two use cases, but it should only apply to
> the latter. So move it to the correct spot.
>
> While at it, move __efi_memmap_free() into its only caller, and drop the
> dummy definition for non-x86 architectures, as that is no longer needed.
>
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
> Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2:
> - free old memory map only after installing the new one succeeded
> - move __efi_memmap_free() into its only caller

Ugh this breaks efi_fake_mem (which is another user of
__efi_memmap_free(), only not enabled by default.

I'll need to respin this.

