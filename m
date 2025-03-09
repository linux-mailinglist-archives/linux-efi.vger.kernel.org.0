Return-Path: <linux-efi+bounces-2942-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD3A5803E
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 02:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381067A5E18
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702515AF6;
	Sun,  9 Mar 2025 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4oE9cDB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9414F70
	for <linux-efi@vger.kernel.org>; Sun,  9 Mar 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741484648; cv=none; b=MH3+VOpDD6YME0ZYPId92YPZ5/nxzCCvskFDZ2N78e7XLxUiEwtGUtUTSq0SeAldg3pXVomghzym3QaRvVES2QeCFryg0RNmXejAocPUMvT8FjszY5g/TLls3oq8qDtAZA0/yM32m2FmvWxGuDgBuHzyqUScJs9amwl1XWehVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741484648; c=relaxed/simple;
	bh=ZinUiLke6aR5I52RIB5QrLFEavSrG35mv4ax92n2iWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJlnmL29JFRm6ob2rRj8Hk3/DbwJP6l68RPgONyiFi7ug7JzFVwGk7Pkb39MSC4ey5BuJogOVZSuDlLbuMb5iDQLocYPgLydu8OXkNHE58bx/Wbo5vY0dU9CMty52J/7y9hgiNFcEltS+WRQJlJVLw3NBxkMdF2YKcPsgF8/CLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l4oE9cDB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e639040ec74so112417276.1
        for <linux-efi@vger.kernel.org>; Sat, 08 Mar 2025 17:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741484645; x=1742089445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jTjiaDv2Hwjh0TdCZJkAjiMT7ruBBOXVSyMwpYjY9GQ=;
        b=l4oE9cDBmW3k3vcFFWs4yLVif4R8wr2DTt5jSynYlYByHJWsk9KPL1CDh4/9j9W1Od
         pbKsuf6HA/rYK3B4+R0G6MU/ARnCkM4DdFU36ea6UDTEE3oNeYvd3QT7M4Qt/V5GXBqF
         GRPskpGgH4/x2maGlNpbm8jYnvC7AZi681CQusLaNpI7rLTkQ/W5KliakVkd6O8AdClo
         lHE8Ui8qDkQlheFIBUP2GdxgmDJ4NtVo2/gN/9eyB02ovyCBm/n/EFE4+fOhbbMLz+zw
         Rs3Lp9Z72ibTyCCfoBjzz+L1tYPeoiAQgrn6ZQKh35uKyje5hv1RjZeB/N7jufKHOD2x
         U1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741484645; x=1742089445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTjiaDv2Hwjh0TdCZJkAjiMT7ruBBOXVSyMwpYjY9GQ=;
        b=D74aYxtukrHFtY7EIv8ibFbySu58Jda2QNr4KEghrG74Bm/PV2PWa67IfIHsDKffZ+
         Y478YKZn2/HG/4W+w83m/rBgCYi4sG9CB12tKRey2IRgDkTNqVKQdNlVxW5Z6ldqcjAa
         YJc63S1Roh3f1B7UXE9RiNmuzD0hu5/4Pow2Qv+G4DALulyyvw95+7yZEgv6n/KBHoVz
         FdvZlWAq0QSRigTwM0iN/9uF6SonEQe4s9N0sFy+094ApZN3xC+OldWzKZeowuanTDZe
         6RzsLqIJDmfZBJrKmff6ZYNmAooBG1+xL+BTUAkVM7KqnWIeJW0DNV7DAT1b6EA1jZrz
         xl0g==
X-Forwarded-Encrypted: i=1; AJvYcCWGIdKcxPBnsiBnQbcIf8S356ITxW+63o/3COgaqrPy5KnAfeOF12PujMLUL2yOHk+IojN5Wn+BN04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybb7PtiKY7G4vCdGtq2NnanJm7mIVQZ+e8urfH4VOuQlraq+LB
	vTSwVHuV9TZfoxNEwEMiulRBpryrh8X0EyE42lbhXnOKaaUo56Z5Qf0qCVrJfZCAoLkTxsfe52F
	N3J+AMB0xbTJp3dPzzXZcyTPh473Sid4I4fCIGzkTaZIYu5RFhfo=
X-Gm-Gg: ASbGncsm99MLqOlSRNvdXJp0936JKkg7cignHxu32ane7SnhCYlwRaEpoY0d4uJeuzK
	vmWJ7QBP2fnKvwX7iHt2IDUjeeVrXEZUVi+tX2E8WxPn9LNwqpiZU+mqyVtJUDSYaNBY227IaxS
	lMDOOoA4F3k8cM445sflnvB3qSt0k=
X-Google-Smtp-Source: AGHT+IGbVrN3egiIwHAAQIj+JhWXoX4vpmBcUqcfTLOCnEXmtmdDpdPBTjjyupwKriwtyoXaOhhn5ZIn+bJ++sVOXyg=
X-Received: by 2002:a05:6902:1027:b0:e60:e14a:df7b with SMTP id
 3f1490d57ef6-e636f69df5cmr6107433276.12.1741484645551; Sat, 08 Mar 2025
 17:44:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus>
 <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com> <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus>
In-Reply-To: <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 03:43:29 +0200
X-Gm-Features: AQ5f1JrzgHJQBSKg95kwzGAXa131PNt_MdfPS5o8jWv5ZqBg_rbSCqwjJGd8ChU
Message-ID: <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ben

On Sun, 9 Mar 2025 at 02:03, Ben Schneider <ben@bens.haus> wrote:
>
> On Saturday, March 8th, 2025 at 2:49 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > what happens is that the second loop only considers memory regions that were found to be available during the first loop.
>
> Ah, I see what the intention is now. Sorry I missed that.
>
> > What firmware are you using?
>
> U-Boot 2025.04-rc3 which I use to load systemd-boot which then
> tries to load the kernel.
>
> > Can you share the contents of the EFI memory map?
>
> This is the memory map at power-on (before systemd-boot has
> loaded):
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x0-0x3fffffff], 0x40000000 bytes, flags: none
>  reserved.count = 0x4
>  reserved[0]    [0x4000000-0x41fffff], 0x200000 bytes, flags: no-map
>  reserved[1]    [0x4400000-0x53fffff], 0x1000000 bytes, flags: no-map
>  reserved[2]    [0x3eaf3000-0x3eaf5fff], 0x3000 bytes, flags: no-notify, no-overwrite
>  reserved[3]    [0x3eaf6950-0x3fffffff], 0x15096b0 bytes, flags: no-overwrite
>
> When efi_allocate_pages() is first called, U-Boot reports the
> memory map looks like this:
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x0-0x3fffffff], 0x40000000 bytes, flags: none
>  reserved.count = 0x5
>  reserved[0]    [0x4000000-0x41fffff], 0x200000 bytes, flags: none
>  reserved[1]    [0x4400000-0x53fffff], 0x1000000 bytes, flags: none
>  reserved[2]    [0x3dae6000-0x3e2cbfff], 0x7e6000 bytes, flags: no-overwrite, no-map
>  reserved[3]    [0x3ea6f000-0x3eaf0fff], 0x82000 bytes, flags: no-overwrite, no-map
>  reserved[4]    [0x3eaf1960-0x3fffffff], 0x150e6a0 bytes, flags: no-map

The lmb stuff is U-Boot internals for reserving memory. It makes it a
bit more difficult to debug this.
The 'efidebug' command will dump the EFI memory map. Can you send that?
Any idea if we can reproduce this on QEMU? In your U-Boot thread you
mentioned real hardware only [0].

>
> It also seems like when it makes that first call it is asking for
> 4,416 pages at address 0x3faf1138. It seemed to me like this was
> inside an already reserved range which I assumed is why U-Boot
> returns EFI_NOT_FOUND.
>

[0] https://lore.kernel.org/u-boot/CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus/

Cheers
/Ilias

