Return-Path: <linux-efi+bounces-6015-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A14D3A251
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 10:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F8703012757
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE035295B;
	Mon, 19 Jan 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YskzRx0f"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC1352953
	for <linux-efi@vger.kernel.org>; Mon, 19 Jan 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813337; cv=none; b=L1cd8Xcb72HgTQ5VNAfDY12B8BjPcbIxyZBK9zmvAE84IHSekIOw6m/gPj1I1h8lXnsxgESHdcbT98JQIopDssPlYTjF+oHuv728un7s54Va+O5XTEqlN5mB0XVDadOzy14tPNHKcgLEzFwndUdSdpjcKe8+gHXtZL4VvtNOWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813337; c=relaxed/simple;
	bh=Uhcjhv5Dlh4TO5jbAWReOVe/XOv/BBHJqhFlbJbuocQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0sQr8hjnkfqav5pisW5ruKW3srMekxCNRYekv+9FlLOr20TqSFsY/T/2J6kfQdVp3ODCskIvgNfRKce6r0RNMHq0Dn6H2GqmQiQkNSxwHANgapwDPae2l1GY2XlCGBbzxPpJJ5vgIxI43TvO4vLvdIT2Z83FGj61R9uVcVpwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YskzRx0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FD9C4AF09
	for <linux-efi@vger.kernel.org>; Mon, 19 Jan 2026 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768813337;
	bh=Uhcjhv5Dlh4TO5jbAWReOVe/XOv/BBHJqhFlbJbuocQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YskzRx0fuvjNxFW07CXAIyP4FtFnMxvNAm4QjtaRe1iV+7ga8lRLY4Y5B6h1gYNDF
	 lOaydipEWSSaG7CdgDvc6BagEXeiIxkaw380pNFNBn3yfVBcaoM1FCk84hducvYieN
	 KPJ0zlC2O3o5THLroPEIc/CLO8T+NA+wGxbXdFNRzEPGts+R54gYSFfhQX1l6mXLMQ
	 SoZYiXhP0LfhFL4GqtvItfkRIW0CqZkJrPk+jo3RLA4bbHFYGNy8Y4fwHhLrWHWAkM
	 HgSYcOYWsKpaeCkfmbm3YBkOf/gCBaEFmCdF38uFGxv3yaC82uR/LVCZyzKIzoxDhN
	 T3YC42PW/g4Hg==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c0bccb8037eso1668412a12.1
        for <linux-efi@vger.kernel.org>; Mon, 19 Jan 2026 01:02:16 -0800 (PST)
X-Gm-Message-State: AOJu0YyxteYYfdvK+YPYmIJXlDju8EWmLJp8sFbQdOKDMFfMLbYdNKFR
	UxfUNDe6VWFZZIAfWBfpLUVpr+C4fXwM5uZfxBd01cd/xQfupJ2vokvKxUkebzub4TuJQubqXO1
	/9zhAXNyliBp6evIgBSMLmi+zJlxcQWc=
X-Received: by 2002:a17:90b:574b:b0:340:bde5:c9e3 with SMTP id
 98e67ed59e1d1-35272f96da6mr9036752a91.23.1768813336557; Mon, 19 Jan 2026
 01:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117160048.370063-1-kohei@enjuk.jp>
In-Reply-To: <20260117160048.370063-1-kohei@enjuk.jp>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Jan 2026 10:02:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHNNgtBgoz9QgYiK1e3AagGy5Lb=7nrza8GPExgOD+heg@mail.gmail.com>
X-Gm-Features: AZwV_Qj0F_tGvj_kAZ2BaXx5bK8Vy4PTAbtNIov_rwy8tPpSw9bUw1pZ4CukIIk
Message-ID: <CAMj1kXHNNgtBgoz9QgYiK1e3AagGy5Lb=7nrza8GPExgOD+heg@mail.gmail.com>
Subject: Re: [PATCH v1] efivarfs: fix error propagation in efivar_entry_get()
To: Kohei Enju <kohei@enjuk.jp>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, kohei.enju@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Jan 2026 at 17:01, Kohei Enju <kohei@enjuk.jp> wrote:
>
> efivar_entry_get() always returns success even if the underlying
> __efivar_entry_get() fails, masking errors.
>
> This may result in uninitialized heap memory being copied to userspace
> in the efivarfs_file_read() path.
>
> Fix it by returning the error from __efivar_entry_get().
>
> Fixes: 2d82e6227ea1 ("efi: vars: Move efivar caching layer into efivarfs")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  fs/efivarfs/vars.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
> index 6edc10958ecf..70e13db260db 100644
> --- a/fs/efivarfs/vars.c
> +++ b/fs/efivarfs/vars.c
> @@ -552,7 +552,7 @@ int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
>         err = __efivar_entry_get(entry, attributes, size, data);
>         efivar_unlock();
>
> -       return 0;
> +       return err;
>  }
>
>  /**

Queued as a fix, thanks!

