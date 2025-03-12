Return-Path: <linux-efi+bounces-2977-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC95A5E59C
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 21:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803283AEEDB
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CE258A;
	Wed, 12 Mar 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxSY6SdT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608C18DB0B
	for <linux-efi@vger.kernel.org>; Wed, 12 Mar 2025 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812453; cv=none; b=MCldttZD44GYhFvwSW5ZuUljtWLK6Ubwjq/hjkxSkGJDRkTkDzc3IKmCNFlrY6LyJ6waS+HFzSlVF2GAwoSB6o4YV0hILTAGrv9Y9PzQJUBnU0KV8fx15koEOrsJu5oV3oKStEgJgWDSMA2S/hpjU2Bo9jZAvKzZpMI5iD3W10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812453; c=relaxed/simple;
	bh=zQw8UyRUd7yGeaJCsbE+Z4AsB8Y7qjnaQUXhsAswgcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOX876gsZdBDpi6O7k4vRS0wCyfO4F0CnrwL7Rrg6sdJ+ibdxYtCGczvbvvUv/QAieR0aMgCmasJSA5KkxUR6SqQDIp2Hw/yd6RETDOnzsb0OWnsK/GGK16mxCvU9zwnmYBUfD6wUL/zTvRYblr/Q13Iy4hPothja5EBj5bpKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RxSY6SdT; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e6343c68b8fso221670276.2
        for <linux-efi@vger.kernel.org>; Wed, 12 Mar 2025 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741812451; x=1742417251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQw8UyRUd7yGeaJCsbE+Z4AsB8Y7qjnaQUXhsAswgcE=;
        b=RxSY6SdToNkmq8g4SBt0vVamAAlcUpEe6PKY+1tAu558WwjRPsanoAON6mJOInNhBa
         B0WzC8Fqg+gXyee54PbjnsF/aFNdfVMYIIyB4+grl2EHhamBAoOyJXH/gDXrKrgOyNuR
         G1iFF5CZYj2PyN/8ygIn45UmVvKRtfSCfDburpchLHdIBm4NfOKJ/3qdH1UljoymduzS
         EKvXDPUxIvNpj/bMxfdTf3TzTY7MgL4LD+BGNkVdGLZg//zDr+QI5fig4YYlzzFScUhP
         VieQSUpwkC01qMhws2vMSXoS8lACUrK5nM/Dj5bJuEZfWMfhRonE0s/nDZZaQSjpRXCG
         KJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812451; x=1742417251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQw8UyRUd7yGeaJCsbE+Z4AsB8Y7qjnaQUXhsAswgcE=;
        b=qrhtmaj6Kug83ohYorpu8cBBNA7QAKlY3GZsnAXe8qpBJ/NQ7/SDCWB94yjIaXhPn7
         YHFmIDiYyd4qlG8MLLjHKYTc2OHtQXz8P8SgVSKyiKWbltQ21CheXHhkfmWVcMkrvqrP
         hOt+ACNzLVJEZg1zkG4IoewhsyVfAYHF+QoA25TTp3kd0YqMGGsBJX6yTTNJiEYBXEQg
         8azz02RhkMXkPnvQSp9EPe5EF/4WqujCfy/JNk2vLw1r+rE5HiMHxtBVQv15IDK+k2DF
         SmNnRvImX8y2BDHRTFmaLXBh/ut65jPOhgabftQb2odNE6IwigOMKgQc+imxPlLFMYvO
         ZyfA==
X-Forwarded-Encrypted: i=1; AJvYcCWqBRc+3m0QS13Almz+b5HQ6J3Kd8sSYcK96v2qikuc1lqxasB8g5PVSsC0VAAJPr6meHLYG/coXX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqvFM7tuxWrgCoJ0jQXY7DBR7CjGfNsi6aPJRh/B4VQqYYa3q
	Ymc+9lhNvlV0opuvYR8fH+eqr23Ut9M6Tsb2UvJ92jHMq4qxQ/Os0g9eg5gHRtVbLBxhADdVoD9
	6C6SIn2v4ao4pMp9GI9CYuOyglUWZogkQvBgw3XleXwFhZoZuOoU=
X-Gm-Gg: ASbGnctCUzP5iKi/ugCe90l1GkGwHWX3lKSX7TqOIJyIfDqKPbaihgUsVtlBZ5SlR/Y
	3hl8skHYB0Bd57tNfdQnue8SJQtfNU2KGQ61mKhD2nGKjUmJb3sxkay3KDmcXVL+PUP8QtBuOlm
	fXghmvkcWbXQp5cy9kwCZo2sVVdEQ=
X-Google-Smtp-Source: AGHT+IHvlKNNvIVaGV6n19LBNB4WzBuMcTWdiwTN6ypVlCWnsCT6GIq6kIYeX142iCq56PC7bI5mfYSbfsl2J7gxP2k=
X-Received: by 2002:a25:1504:0:b0:e63:6d28:1492 with SMTP id
 3f1490d57ef6-e6386586a68mr16650567276.13.1741812450300; Wed, 12 Mar 2025
 13:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus>
 <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
 <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus>
 <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com>
 <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus>
 <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com>
 <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus>
 <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com>
 <gqqWrf3trBPlLLAJDR55YYQBffE1dToIMzSMgebh-GuI-06E3pX4WcYuFU7XOF3s_ZEjK70ePUUJBXu_V0tAxKc8dmNcQjlqR55cLRAHAJI=@bens.haus>
 <CAC_iWjKL7nSkr8CyFW6hOzfOTiCU+tES_PsEYC7hkcCA9gAp=Q@mail.gmail.com> <xPmYxk1shimT-7PEuiLsqTN03MY68Lcvo9Yud8PBo6IW7UdpvL-sS60VXmLbH3o3CgkyG4bH7kpZ2sgWaVQPn2y69m1vCj_AC_ukMKJKaz4=@bens.haus>
In-Reply-To: <xPmYxk1shimT-7PEuiLsqTN03MY68Lcvo9Yud8PBo6IW7UdpvL-sS60VXmLbH3o3CgkyG4bH7kpZ2sgWaVQPn2y69m1vCj_AC_ukMKJKaz4=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Mar 2025 22:46:54 +0200
X-Gm-Features: AQ5f1Jp4lTONnTyTokLCaGpp5exOT6N1LXW-QwpIL-K16Y2TDeJXt_Zvqz6jhM8
Message-ID: <CAC_iWj+L9CJjg9ZMdT5aOM26osXo=90Xw1JKz+u102wa50W0jQ@mail.gmail.com>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Mar 2025 at 20:05, Ben Schneider <ben@bens.haus> wrote:
>
> On Wednesday, March 12th, 2025 at 4:24 AM, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> >
> > Can you please apply[...]to make
> > sure the map doesn't change from the time the slots were calculated.
>
> It doesn't seem like they do. This is the output:
>
> 7 0-4000000
> 0 4000000-4200000
> 7 4200000-4400000
> 0 4400000-5400000
> 7 5400000-3daef000
> 1 3daef000-3e2d5000
> 7 3e2d5000-3ea78000
> 2 3ea78000-3ea7b000
> 1 3ea7b000-3eaa1000
> 4 3eaa1000-3eaa7000
> 2 3eaa7000-3eaba000
> 4 3eaba000-3eabb000
> 2 3eabb000-3eabd000
> 4 3eabd000-3eabe000
> 9 3eabe000-3eac5000
> 4 3eac5000-3eac9000
> 6 3eac9000-3eaca000
> 4 3eaca000-3eacb000
> 6 3eacb000-3eaed000
> 4 3eaed000-3eaf6000
> 3 3eaf6000-3fb92000
> 6 3fb92000-3fb93000
> 3 3fb93000-3ff00000
> 5 3ff00000-3ff10000
> 3 3ff10000-40000000
>
> Inside get_entry_num_slots() it skips everything that's not
> conventional which just leaves these four entries:
>
> 7 0-4000000
> 7 4200000-4400000
> 7 5400000-3daef000
> 7 3e2d5000-3ea78000
>
> As a reminder, size is 18087936.

This is a decimal right ?

>
> For the first entry, I am seeing region_end = 67108863, first_slot
> = 0, last_slot = 48234496 so the function returns 24. This is the
> entry that is then subsequently used in the efi_allocate_pages()
> call that returns EFI_NOT_FOUND.
>
> For the second entry, first_slot > last_slot so we return 0.
>
> For the third entry, I am seeing region_end = 1034874879,
> first_slot = 88080384, last_slot = 1015021568 so the function
> returns 443. This is the entry that, when used by allocate pages
> by ignoring the first EFI_NOT_FOUND, returns EFI_SUCCESS and we
> continue to boot.
>
> For the fourth entry, first_slot > last_slot so we return 0.

Ok this helps. I don't think there's anything wrong in the kernel.
U-Boot has 64mb available and you are requesting to allocate ~17mb which fails.
On top of that, if you skip the failed allocation, the kernel tries
the next available slot starting at 0x5400000 which corresponds to the
correct memory map.

Since this seems a U-Boot issue, I'll send a patch over to the other
thread and we can continue from there

Thanks
/Ilias
>
> Ben

