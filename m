Return-Path: <linux-efi+bounces-2939-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92BA57F69
	for <lists+linux-efi@lfdr.de>; Sat,  8 Mar 2025 23:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DEE3AA9DC
	for <lists+linux-efi@lfdr.de>; Sat,  8 Mar 2025 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F91AA791;
	Sat,  8 Mar 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgrBngCy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FB1AA1C8
	for <linux-efi@vger.kernel.org>; Sat,  8 Mar 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741474172; cv=none; b=bxADP+C6FefGkf0ZLqedr0sFZ74XWHLAlY98TbXHPQIrGcpkl6xzPxVgUAWfdc3q1pEaV2RU6iPpfPdzsYmWCblJZIDG3Pk9Ks2Smk84K6PUoXqh/XYURh3/whokz+tZ6uDaNRw4AAY8fbeDB9z2i3+FZEzR40LRdM6Qo+VlMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741474172; c=relaxed/simple;
	bh=t+KlZArrt/dHRuvu9YrNE6JZOvgDxC7prbYLAuc9dlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3P+fMgEIZHaA50/gEeH9yLpa/C92UfYDvBjfW8DXIvDCDUTx/xxC8B0VFladdnQi6cxlSnmn30XYK6+ip9GWl9JLGhnvCuSPqlZcl+c5Rsh0g+A2X1ogJRiRMSNI06ZNN5D0jPqxZ8KWvY60ClpBtmf5StSDDIaL5oe07+GzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgrBngCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC200C4CEE7
	for <linux-efi@vger.kernel.org>; Sat,  8 Mar 2025 22:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741474170;
	bh=t+KlZArrt/dHRuvu9YrNE6JZOvgDxC7prbYLAuc9dlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QgrBngCypE+bnyUSxU7Nwi621HWg9z+n+AZTXQ3WlJhBc+hV/IunWXTeEHAYgf9oc
	 +MjGOWk5oe/eNFObbpyWUU9TtjkXrgmYMp+lcM4eBx2QjlKHO3TDjbjC4YDgWjTKAJ
	 MKs59spHVNgK1lPF9tClCRSA6lJnyCSH/Rcy+i/kfvwldArT1pt1fqJoSxUlmYLYK0
	 diaVe9ZZVN6n5Tz2PEMyResCiRb4SjF2HfR/cd2E7MPP1ZIaaFhgCkeCS9RjO/IHRS
	 JDeTI2hFLxI9scP6WAaLsiweFSonuwVzgkR5M+rYksytW1pPgn/ywEt1fkHvaYWshC
	 qu/Oo6+AUVxqg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499659e669so1659650e87.3
        for <linux-efi@vger.kernel.org>; Sat, 08 Mar 2025 14:49:30 -0800 (PST)
X-Gm-Message-State: AOJu0Yz+wGzpRFi2njczyG4LInNzgNW/jc/YFqZt3DsdW4mFg4eZaTHw
	+BiN85V3uWVKeiguDyQNh7o94sbq0vweTAG/rIAmmu3vKQf07yLLx+lphsyhxJOaUmfJ9rFYUJa
	9KSzHIYwsJcj/VbcwtpLBe7X0rAM=
X-Google-Smtp-Source: AGHT+IH+16e/YCt0A0c3SKt6EqQhwFF6cbC5/SwU89dRr/8cu4uBWV4oCe4+/nIJ0S+D2swze0NdjQrwsQClZU9xHBA=
X-Received: by 2002:a05:6512:2342:b0:545:cc2:acd7 with SMTP id
 2adb3069b0e04-54990e67227mr2674215e87.27.1741474169120; Sat, 08 Mar 2025
 14:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus>
In-Reply-To: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 8 Mar 2025 23:49:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoYb88l_H3r3ENFRS9G9r4Mb8huLgupePajiVx7HUjlHJ7lMTQyh8gEGiI
Message-ID: <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 19:04, Ben Schneider <ben@bens.haus> wrote:
>
> Hi Ard, I am finding when trying to decompress a zboot compressed
> kernel, efi_random_alloc() is returning EFI_NOT_FOUND to
> efi_zboot_entry() which causes it to stop.
>
> I think this is happening because the second for loop in
> efi_random_alloc() seems to always break after only one
> iteration[1], and the first address it tries to ask for is
> reserved on my device. I suspect this behavior is not
> intentional--otherwise why have a loop at all. Also, when I block
> the break statement with the preceding if (status == EFI_SUCCESS),
> decompression proceeds as expected.
>

The code is a bit cryptic, but what happens is that the second loop
only considers memory regions that were found to be available during
the first loop. In this case, MD_NUM_SLOTS() is set to a non-zero
value, whereas it is set to 0x0 for regions that are not available. In
the latter case, the second 'continue' statement will always be
reached, and so the loop advances to the next region.

What firmware are you using? Can you share the contents of the EFI memory map?

