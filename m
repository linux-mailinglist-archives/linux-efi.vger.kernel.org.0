Return-Path: <linux-efi+bounces-5989-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1144D1E25F
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jan 2026 11:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC53B30505B8
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jan 2026 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC6392C4A;
	Wed, 14 Jan 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT1GHgrE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A99392C3A
	for <linux-efi@vger.kernel.org>; Wed, 14 Jan 2026 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386851; cv=none; b=ae4tgIx9paMKCq2e0YoiBEyHq58+wPFCkrQwxk/6/LgJZl7R2Ws94wANCisTvwhn77vIm7mbHMsf1VWJnekXXeUO8fmz2stJn67zTsHM/lmGSjBiEK9EBDLJGEyFrxqwvCr9aophazZPopbrozRwsgBL4NIyjovbVDczrCIL81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386851; c=relaxed/simple;
	bh=qQf1tdgTBslCWR63IUabxvqVX5uVSC1bhJP7yVlgTFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJP0/PxlKwQgK5MbATqTGjxzMzSKoMVpSJdQSROmP6uNL9wChNDnlaL9s2eXb+sG6RkFtLaOMTKrQw/tD2YCsDdEA1pxkd2/MrsI3Ma+QGk4bjQX3gnePbct3nsCvOmVOFCyTWbq0UHNEJLSzS5oA6c/J5pKIyOcSgQwCvVbtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT1GHgrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0151CC19425
	for <linux-efi@vger.kernel.org>; Wed, 14 Jan 2026 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768386850;
	bh=qQf1tdgTBslCWR63IUabxvqVX5uVSC1bhJP7yVlgTFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WT1GHgrEEgirONSBw2iqjrWEYT4+aIGlBf34TWUTWw/lbXCMxlTJd1lbMZBMVC8Ui
	 yFztCz5mgt9Tk/Vce9Ia9nc7qpu/VHqV82X7pZr4mPvgyGQsaTXT1StX+t1zsKLoWm
	 K25wyqf1rzfYdT7A76wDiO6eZkKVT5QZnwZB/PEwEg//V+iylNEseiNlC8dClKmIeW
	 Zbl7o12vtIXXszp8Qct6DCOUNQKYt+/i3W3DKIkRzBZFBqt3ETn3dHIM+xecqlZrIi
	 PDzVy5NH9/+z1jxvNwjwgBn7wU+2GbXM1N34xXZZ23DJLbiSzsq7DrN/ZP+kvFYnhT
	 tNYp010ECB5BQ==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso470998a91.0
        for <linux-efi@vger.kernel.org>; Wed, 14 Jan 2026 02:34:09 -0800 (PST)
X-Gm-Message-State: AOJu0Yz68w/pW9hl2dOS2oFkfrolShMEwkB+ebmKwCoYI9TboLIiDS9+
	5zc2fBnUEd3N/6pj0ajXFX9hCi69QuOMykM+PmtTqIoaBhElMkyxFis6TNG7aTNHzg2hlrpjlb1
	ECblhJeE523EUfzJSygyCPeSeRATDF0E=
X-Received: by 2002:a17:90b:4d82:b0:34c:2aac:21a7 with SMTP id
 98e67ed59e1d1-350fd112950mr6475820a91.7.1768386849569; Wed, 14 Jan 2026
 02:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7E55C4CEDE596906+20260114053033.124359-1-zhangdandan@uniontech.com>
In-Reply-To: <7E55C4CEDE596906+20260114053033.124359-1-zhangdandan@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Jan 2026 11:33:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFCzM4wTJQe13_BYEe5W_35=+UWwzzpUK8Jt-bOgWGFCg@mail.gmail.com>
X-Gm-Features: AZwV_QihCpUTc5EYNOPgUfmS6qqqW4vEe-aHfrnYHQUNVbQCf7Cj5PhvinIMyX0
Message-ID: <CAMj1kXFCzM4wTJQe13_BYEe5W_35=+UWwzzpUK8Jt-bOgWGFCg@mail.gmail.com>
Subject: Re: [PATCH] efi/cper: Fix cper_bits_to_str buffer handling and return value
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	guanwentao@uniontech.com, niecheng1@uniontech.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 06:32, Morduan Zang <zhangdandan@uniontech.com> wrote:
>
> The return value calculation was incorrect:
>     `return len - buf_size;`
>     Initially `len = buf_size`, then `len` decreases with each operation.
>     This results in a negative return value on success.
>
> Fix by returning `buf_size - len` which correctly calculates the
>     actual number of bytes written.
>
> Fixes: a976d790f494 ("efi/cper: Add a new helper function to print bitmasks")
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> ---
>  drivers/firmware/efi/cper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 0232bd040f61..bd99802cb0ca 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -162,7 +162,7 @@ int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
>                 len -= size;
>                 str += size;
>         }
> -       return len - buf_size;
> +       return buf_size - len;
>  }
>  EXPORT_SYMBOL_GPL(cper_bits_to_str);
>

Thanks for the fix. Queued up in efi/urgent.

