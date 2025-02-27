Return-Path: <linux-efi+bounces-2837-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD0A476E3
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 08:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AA518868DE
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B71E521D;
	Thu, 27 Feb 2025 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh/azzO8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA04A1A
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642861; cv=none; b=s/TSM3+DTD706AYMDYVjUnzUZ8fq3srAk+kdJZ4pnYTJPrUI2jZ3bMg10al/qP+XFSJUqJjNnQlYD7weg15D9q2GBxsbNQcNj+Lai0USOjF8ndOwuW86fEiWJU0KlfKpQ/dwS6pVwkgJKivpWTNhYb+VqoPLYdb7TVpFKYeK5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642861; c=relaxed/simple;
	bh=fSsfVe8bMfnOwkux9R7UDid12osPT3qM6YEnIkQT4gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtjN4B/aoe8O0i0xbEmj58CJ+vkG2FepAWp1cXwVMPI0yRye+cL9GBZ7ijts+DoLj0EZeKmfvYwIdXVcOLBB23nEF4+YZ0qsKUeHrklVC/syQeFhsYiI5jhl90m6fCx1hz7enTE9U7i2b74m+pVcvqUDa+i5zB8dXBEi5nxMzM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh/azzO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21826C4CEE4
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740642861;
	bh=fSsfVe8bMfnOwkux9R7UDid12osPT3qM6YEnIkQT4gQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uh/azzO8A6ZZHFbN+lKaj/rSszRMGY/ppGZeh+u1f0erCqMZ0bskuzxShJEmenIkx
	 jyRZNSJ4IqhrKtzzNMZQ50N0Ji2z1N8SaNQS9EjVVcRSIxH1b/0J2o17aK9qUqF5gW
	 xoY+lZvCo90vNr0gyNeUmKNG2ZskNNyPSBi2jnXXOzwraBy+72KpXZt7TKo/bXuNEl
	 6ybfaeh9fIs88YJc9620HGQJV0J08MIW9ELNxHuU67+kvOxH875MNNrQUeFaYrcuLl
	 UHSEk5IvlXFinS2lFui5RD5H0FTbsl8dgD1FqXN8+hw1srzfa/2zB8G/elbHuxqq4I
	 oYG642Tr1hJww==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fcfso7148551fa.0
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 23:54:21 -0800 (PST)
X-Gm-Message-State: AOJu0YwhLj7ebZj2yusTqg6Sk1miKP0N2nkSjEdVAh1ksSqRz2Mf5lsZ
	RvaZN9XA1pxa8glUNIR1uLc5s3xi2hU5+JG6L9nuHFq/3aMtWLSHW8Whm5Z/dGShFodVDB8vCDC
	QjdrrbfROjNzInvGAYjlSOXGhvMc=
X-Google-Smtp-Source: AGHT+IG2TuJN5VzpQEJbMVgEokmnSwXpLsFkhpxf9QcA4rZRwaCr2MdnQsCY1nqLvzPNgbwAzK9wtMc9nmFc77gY8l0=
X-Received: by 2002:a05:651c:1516:b0:308:f4cc:9505 with SMTP id
 38308e7fff4ca-30a80c0f592mr56002801fa.2.1740642859468; Wed, 26 Feb 2025
 23:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63837c36eceaf8cf2af7933dccca54ff4dd9f30d.camel@HansenPartnership.com>
In-Reply-To: <63837c36eceaf8cf2af7933dccca54ff4dd9f30d.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Feb 2025 08:54:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFqFHZHntOp78wmhpBzTMoCcSQXVDd1yOVv3Z3VpRj0pw@mail.gmail.com>
X-Gm-Features: AQ5f1JprwVCMc3VkDat9u1I7ek_q4VcDGR3cvJrNMzF6876Oxubt5OPlLAYVLdk
Message-ID: <CAMj1kXFqFHZHntOp78wmhpBzTMoCcSQXVDd1yOVv3Z3VpRj0pw@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: allow creation of zero length files
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, Richard Hughes <richard@hughsie.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 22:48, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Temporarily allow the creation of zero length files in efivarfs so the
> Linux Vendor Firmware Service can continue to operate. This hack should
> be reverted as soon as the LVFS mechanisms for updating firmware have
> been fixed.
>
> LVFS has been coded to open a firmware file, close it, remove the
> immutable bit and write to it.  Since commit 908af31f4896 ("efivarfs:
> fix error on write to new variable leaving remnants") this behaviour
> results in the first close removing the file which causes the second
> write to fail.  To allow LVFS to keep working code up an indicator of
> size 1 if a write fails and only remove the file on that condition (so
> create at zero size is allowed).
>
> Tested-by: Richard Hughes <richard@hughsie.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
> This should be reverted in the 6.15 release
>

Thanks James. Mind resending this with a MUA that doesn't mangle patches?


>  fs/efivarfs/file.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> index cb1b6d0c3454..c294a8fc566d 100644
> --- a/fs/efivarfs/file.c
> +++ b/fs/efivarfs/file.c
> @@ -57,10 +57,11 @@ static ssize_t efivarfs_file_write(struct file
> *file,
>
>         if (bytes == -ENOENT) {
>                 /*
> -                * zero size signals to release that the write deleted
> -                * the variable
> +                * FIXME: temporary workaround for fwupdate, signal
> +                * failed write with a 1 to keep created but not
> +                * written files
>                  */
> -               i_size_write(inode, 0);
> +               i_size_write(inode, 1);
>         } else {
>                 i_size_write(inode, datasize + sizeof(attributes));
>                 inode_set_mtime_to_ts(inode,
> inode_set_ctime_current(inode));
> @@ -124,7 +125,8 @@ static int efivarfs_file_release(struct inode
> *inode, struct file *file)
>         struct efivar_entry *var = inode->i_private;
>
>         inode_lock(inode);
> -       var->removed = (--var->open_count == 0 && i_size_read(inode)
> == 0);
> +       /* FIXME: temporary work around for fwupdate */
> +       var->removed = (--var->open_count == 0 && i_size_read(inode)
> == 1);
>         inode_unlock(inode);
>
>         if (var->removed)
> --
> 2.43.0
>
>

