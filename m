Return-Path: <linux-efi+bounces-2374-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0A89F05B1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2024 08:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A2283E3C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33389185B6B;
	Fri, 13 Dec 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqBdTNMj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADF5674E;
	Fri, 13 Dec 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075923; cv=none; b=UzS+kZxErl6oMjfndae1bXFWJ0ip+Y7IGkU3C5sU4u54YBn3d4iT4woy9K0XSzxzb3QUpDZG0Dho7zwo+GwwYEUOYOi/9AQtJ0bw/dvb8nJHEQtUiOo3N4I+IbOF/hJG6r4PwoGF56AhnBBvCtrJRJIhii3/NEVEBiOlzs65BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075923; c=relaxed/simple;
	bh=29mSkljf80/3VXg/1SndyIxNTzC/9V2ignAhRGmnIPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9BuOUb3fR83SCK6bKdTrBilaRp82yIJwRIItH1JpEPmArWJjtGiSRx8QmKBaHHBgc7TtyZ9EaaiIGxRbrkVfyBCa6LAUoUbfwXdYjZHQnGBAaG9bkuICc9Hb6rvM7HdpNs5xKBZIrqb1DDlzRUckLmlK2wckvzn4E9QV4uGiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqBdTNMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83362C4CED6;
	Fri, 13 Dec 2024 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075922;
	bh=29mSkljf80/3VXg/1SndyIxNTzC/9V2ignAhRGmnIPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aqBdTNMjm0Bgmzn5pKZQcUdct+tgO6yjiDQv7Xn0NJ9Ql2Q0TaNpfd2lsuRAOYMYt
	 ZicQj6x2Wd2yHoJRdDi/WdkGCNlrp7Xq+5WJz9N51XZHt2dxB2rn+bHnLp7ijsguRc
	 0sisYIEL57JLoZ4wOf/4dw6I02ujZfqkar5CybSF4GPnna2qqiRm9YKX75JywxNyVJ
	 COAuUBBWZL6D/q54165BagFuxq5cranKwr1bSlGHlOJhMM12UpoAcaV8AcRG4mExW0
	 MXNsqee4oL5l2y01+ppk8U50FWRVK0eygHYI+O5v4coevyWVC4FFAKWW50Cd/8ZuX5
	 K0QtiYUNuDIGg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30033e07ef3so15467871fa.0;
        Thu, 12 Dec 2024 23:45:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJpqiwPl5jlyKmBcnBxAD/5JzsN/SWa7dGgjHqkgo75XdjXUiYNkOhcedXsYksr6KXi46C/WJGP2mMus4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSwFj14cWwmQeQbyy/Q2kVaPpRUHu3N0q6AmlGaeOf0Kd40OB
	oMYPk/6fqPDoEByTPJJh1FwiqpqQhzmMImxKYgtaU3dsN/GjtVd+nQAJl2X9yqqP6L62ipF48TG
	toQWTrHcysuz58ErK7yf2/Ev0/oA=
X-Google-Smtp-Source: AGHT+IGdyR1ZJBKwUQ5FZNz4n4ZpDnaZMlIxrFUn9O9uDUh3/i2FqU0yGeR0jvqwsu3DnIjtiGTUvfjnx/hZi/OlD5k=
X-Received: by 2002:a05:651c:1547:b0:2ff:bc33:b6d6 with SMTP id
 38308e7fff4ca-30251acc130mr11288761fa.0.1734075920894; Thu, 12 Dec 2024
 23:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211070503.87386-1-jirislaby@kernel.org>
In-Reply-To: <20241211070503.87386-1-jirislaby@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Dec 2024 08:45:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJi0_yuNWWOUefAqyha3usH5b32C1xVgnA9vnO+y-ZBw@mail.gmail.com>
Message-ID: <CAMj1kXHJi0_yuNWWOUefAqyha3usH5b32C1xVgnA9vnO+y-ZBw@mail.gmail.com>
Subject: Re: [PATCH] efi/esrt: remove esre_attribute::store()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 08:05, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> esre_attribute::store() is not needed since commit af97a77bc01c (efi:
> Move some sysfs files to be read-only by root). Drop it.
>
> Found by https://github.com/jirislaby/clang-struct.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org

Queued up, thanks.

> ---
>  drivers/firmware/efi/esrt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 7a81c0ce4780..4bb7b0584bc9 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -75,8 +75,6 @@ static LIST_HEAD(entry_list);
>  struct esre_attribute {
>         struct attribute attr;
>         ssize_t (*show)(struct esre_entry *entry, char *buf);
> -       ssize_t (*store)(struct esre_entry *entry,
> -                        const char *buf, size_t count);
>  };
>
>  static struct esre_entry *to_entry(struct kobject *kobj)
> --
> 2.47.1
>

