Return-Path: <linux-efi+bounces-1415-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32BF92DFD8
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0291C2113B
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924207E574;
	Thu, 11 Jul 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAwacWNy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE420E3;
	Thu, 11 Jul 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720677956; cv=none; b=bkPy1Sdq9Wk2YD0JVqMhB5SnRwfe93ODdlDUKMPNibKXK5OTQf9CZ+TlQw4uqPWZ9WRjf7+3d/BCnYA5tsmWZF31cBBbrnTxtAGJKVZ+MITvw3PqLf0mCafaCJr+Zku8FVqEnvvlzxcSh4NcTwBvZdP5vKwAIGA9TBK7JiqwAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720677956; c=relaxed/simple;
	bh=yQ8vc/mTO1yzL6nySZ9wEfYYL0O1XltTsf+4qKABHt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVsQgwrS9+M33fNgR66ml7hP8NgI+aK7/VgXlk5Wu4HT4zTKqbB8Eomc/A6TI4FjTDq1MZik9VHJp1SdWtS5oorvZ7QoskTcyzL1lE++810rCFLiAjccqtVvlO3ifi2BAJ9C47rLc+4Ac+aKs6adVE99wjP4pf7B2/8I8tesjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAwacWNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8209C4AF0A;
	Thu, 11 Jul 2024 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720677955;
	bh=yQ8vc/mTO1yzL6nySZ9wEfYYL0O1XltTsf+4qKABHt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fAwacWNyNnUJhyaz6kTzFC+aQN9FW3nHkMDgB633KRoqtSwyIWMFMKvEdMPSyq09g
	 drgzutwkAQSHJWG+YgIeG2Kd50z2p4ujjjHaSLi9O89LDAwgQmVZnPqdrUavMFHIi9
	 83E5FFti1UKtTmne8OiZ0hX+TVoAvQ8/sBz7CrqoUqrSYShseBeFfvDVgvFKVKlPT9
	 ST7jGwblLeLlbkQcy5Ufyu3VnSGifJE3mAOE3XYrzyIF0lR02tns31tsyyYRXuNUzp
	 g+bkiO1SB02YMZ04TywWdqFb0lrMzMtCw9FrEqRTAa5Hbs8eJLBq4a/0cLuK8pwGCN
	 Q/RgQnscu62Jw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so525471e87.3;
        Wed, 10 Jul 2024 23:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbgJo7oAM3kbWj9QYN2E8jBQOEbjz2S6gC7h+7eQv7nRbbIlzojPGdHNLsvx1Q2tcjx5lr0ivsa/aipXCkPBWHADHKm+MtfOUHVBqKcMjT+wO96PHmIcwp+4IRqS9jsstqPwtMofEU13O9YIFHakKd6QGOQNDyKfIJ8zhjdwGkCG4LKN988OoP
X-Gm-Message-State: AOJu0Yw01Tz6C75+hfgbdJ93yVuSpmnLJ21FZvZALHOjit5YhT+mnD/z
	Ru8RymxsKnDDzQjj3oihAth7VTpM8dk/NimzpQRu01kmUDEeKjEyYnYlTRqr8+VXXHvYdNTnlJ+
	UIR21ZOrwHH9oU+NZun0VuzOs6cg=
X-Google-Smtp-Source: AGHT+IF9yNz2aZVjovoxsbcGl9/km3XbnRfQHzNtIdc766X8nKOwNyd0Y83MS7zEjdEFUPGw5A4bGuBWSzUDXrLVDgM=
X-Received: by 2002:ac2:58e8:0:b0:52e:9b87:233c with SMTP id
 2adb3069b0e04-52eb99a3116mr3674073e87.36.1720677954106; Wed, 10 Jul 2024
 23:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710225538.work.224-kees@kernel.org> <d2b9e11a-749b-47cd-9cc2-0734ec5849b0@embeddedor.com>
 <175fc58f-b12a-4bc7-bc74-3365e5b0ee3e@embeddedor.com>
In-Reply-To: <175fc58f-b12a-4bc7-bc74-3365e5b0ee3e@embeddedor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Jul 2024 08:05:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyDjH0uu3Z4eBesV3PEnKGi5ArXXMp7R-hn8HdRytiPg@mail.gmail.com>
Message-ID: <CAMj1kXEyDjH0uu3Z4eBesV3PEnKGi5ArXXMp7R-hn8HdRytiPg@mail.gmail.com>
Subject: Re: [PATCH] efi: Replace efi_memory_attributes_table_t 0-sized array
 with flexible array
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 01:34, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 10/07/24 17:32, Gustavo A. R. Silva wrote:
> >
> >
> > On 10/07/24 16:55, Kees Cook wrote:
> >> While efi_memory_attributes_table_t::entry isn't used directly as an
> >> array, it is used as a base for pointer arithmetic. The type is wrong
> >> as it's not technically an array of efi_memory_desc_t's; they could be
> >> larger. Regardless, leave the type unchanged and remove the old style
> >> "0" array size. Additionally replace the open-coded entry offset code
> >> with the existing efi_early_memdesc_ptr() helper.
> >>
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >> ---
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: linux-efi@vger.kernel.org
> >> ---
> >>   drivers/firmware/efi/memattr.c | 2 +-
> >>   include/linux/efi.h            | 6 +++++-
> >>   2 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> >> index ab85bf8e165a..01142604e8df 100644
> >> --- a/drivers/firmware/efi/memattr.c
> >> +++ b/drivers/firmware/efi/memattr.c
> >> @@ -164,7 +164,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
> >>           bool valid;
> >>           char buf[64];
> >> -        valid = entry_is_valid((void *)tbl->entry + i * tbl->desc_size,
> >> +        valid = entry_is_valid(efi_early_memdesc_ptr(tbl->entry, tbl->desc_size, i),
> >>                          &md);
> >>           size = md.num_pages << EFI_PAGE_SHIFT;
> >>           if (efi_enabled(EFI_DBG) || !valid)
> >> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >> index 418e555459da..b06639c4f6a5 100644
> >> --- a/include/linux/efi.h
> >> +++ b/include/linux/efi.h
> >> @@ -607,7 +607,11 @@ typedef struct {
> >>       u32 num_entries;
> >>       u32 desc_size;
> >>       u32 flags;
> >> -    efi_memory_desc_t entry[0];
> >> +    /*
> >> +     * There are @num_entries following, each of size @desc_size bytes,
> >> +     * including an efi_memory_desc_t header.
> >> +     */
> >> +    efi_memory_desc_t entry[];
> >
> > a candidate for future __counted_by(num_entries * desc_size) ? :p
>
> ah no, this rather be something more like __sized_by(num_entries * desc_size).
>
> --
> Gustavo
>
> >
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >

Thanks. I'll take this for the next cycle, but would you mind adding a
preceding patch that drops the 'early' from the macro name and updates
the existing users (not the ones in arch/x88/boot, which has its own
private copy for some reason). The 'early' is kind of irrelevant, and
no longer accurate now that we use the macro for the memory attributes
table as well as the memory map.

