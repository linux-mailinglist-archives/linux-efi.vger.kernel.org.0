Return-Path: <linux-efi+bounces-3760-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF2DABF662
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3068C7657
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D4267AFD;
	Wed, 21 May 2025 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1fbFTFt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A019ABDE;
	Wed, 21 May 2025 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834837; cv=none; b=qSkz+kv5UyFw3lL1BXp2sEgBqNAFdEdRn0paqazDGCRQQPhAy7pTSUGnmbn/GCYvETo9ylq8bzVdX1DilaLpg+Dfxy4z27OlYQXIoy/2lpUmCpwNe007D3I867hL9/j4jOt7lNs8JN5An9ehgBGjTlVvmB3GFacTMPDQE56XV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834837; c=relaxed/simple;
	bh=S41ONH2RQb/eAC6RwFm9EFiCOzrKdyDYkfUPN02wA7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oADA2MCm+w8ahJSplbNIc4iN3ExKoJ/9RKuAkjlKrhupp3kaezFapB8cfkGw8c7ed6PX1BzeqEeS7y0j9/CFiaRgR89+H+nr+hKvKU+UqOokgiGxlF7uS0nhhm+IiX+sUXRicxiwUg2+VW/4ye9IOe9pjXwDAAU+5Ow6EOst5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1fbFTFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A21DC4CEE4;
	Wed, 21 May 2025 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834837;
	bh=S41ONH2RQb/eAC6RwFm9EFiCOzrKdyDYkfUPN02wA7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S1fbFTFtIc2Uum74H9/RVGdj9oeVl4a+sz1qcieuOWXqn8i03ThrhJvOUivAJ9FvZ
	 jCt3StXtcrZGQ81WH3EPcvVMRP38/mgvdPE6AWc0Lw4SnXZcyPtfE1sisouTRfegb4
	 Jy+QiUjzAXtOfcZTkx4RcYFs/iDCoStUIyERMF6mk1sq4uoHms84rqyvKbCfAFYFQy
	 OsJ4SIfiWE1jDVLI+xQCdaNzK4n4+ixWGyq0fqkipa7ZAMAI6X928MRVyBRep8ZeF7
	 +WF8LunWZ8esD5p5ZNbXYPezGzueqopggJ31FG6JMhgDm0E4YuHWNT5W76k2BdzD3q
	 guTHwuAgbmJAg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so65706401fa.2;
        Wed, 21 May 2025 06:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnrPurikY/EtUbpNVwCjTl44311Z3xCKLmdolTnbzfA7vrMgUhMjj5FXYBCPvnERMvLPJy8adYJaTGbGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNFS/SS3J6hxAVHbnyVnTKHsodVwIBR14fTJX0TWq01hARrOX
	z2nA9rc+3dFJxc83hMtZ/luzl+2N9t6Yer9d1k7/eYDTw7F2EspZOmXbmQkvQwdZPVkNpbmWyM4
	JpAdjOBRqwge1X6Pi+a94ATXfIGY7yTQ=
X-Google-Smtp-Source: AGHT+IEOf3Q8WO4Hq2KCPhiY/a4/sBcNuo9tOOydYdTlEJZ6JxLYHCMOr3To94n4nUi2Q+CtADyl7x/0/6iuHhdNVFI=
X-Received: by 2002:a05:651c:31c1:b0:30b:be23:3ad with SMTP id
 38308e7fff4ca-328096b4c41mr55978141fa.10.1747834835492; Wed, 21 May 2025
 06:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331074504.4096087-1-ivan.hu@canonical.com>
In-Reply-To: <20250331074504.4096087-1-ivan.hu@canonical.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 May 2025 15:40:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGzn4sbb3DZWLsfUT9DePW0M1AUTduo9g06d75D=tiJ-A@mail.gmail.com>
X-Gm-Features: AX0GCFs9UhHv2Bl8dQyEf-NwUDUTe7i1NrEH-zUbTuEtQr37klB8mYTBbv6ke4Q
Message-ID: <CAMj1kXGzn4sbb3DZWLsfUT9DePW0M1AUTduo9g06d75D=tiJ-A@mail.gmail.com>
Subject: Re: [PATCH] efi/efi_test: Fix missing pending status update in getwakeuptime
To: Ivan Hu <ivan.hu@canonical.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 09:45, Ivan Hu <ivan.hu@canonical.com> wrote:
>
> The pending status was not being passed to user space, leading to
> false test alarms when using the pending status. This patch ensures
> that the pending status is correctly updated and exposed to user space
> when calling getwakeuptime, preventing incorrect handling of the pending
> status.
>
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
> ---
>  drivers/firmware/efi/test/efi_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Queued up now, thanks.

> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
> index 9e2628728aad..77b5f7ac3e20 100644
> --- a/drivers/firmware/efi/test/efi_test.c
> +++ b/drivers/firmware/efi/test/efi_test.c
> @@ -361,6 +361,10 @@ static long efi_runtime_get_waketime(unsigned long arg)
>                                                 getwakeuptime.enabled))
>                 return -EFAULT;
>
> +       if (getwakeuptime.pending && put_user(pending,
> +                                               getwakeuptime.pending))
> +               return -EFAULT;
> +
>         if (getwakeuptime.time) {
>                 if (copy_to_user(getwakeuptime.time, &efi_time,
>                                 sizeof(efi_time_t)))
> --
> 2.34.1
>

