Return-Path: <linux-efi+bounces-1231-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF090B051
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D991C22DF8
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F5198E7D;
	Mon, 17 Jun 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHPBz4FC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E6198E6D;
	Mon, 17 Jun 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630695; cv=none; b=JNJgtI6yZDCVjYpw0PuQL9p1ujY4uwkZQ7t4wPv7LbY41lvHeDFV5teF0hXE3zg8jP1jxDsHYSdU+H2YC6QwJm/QaedeOBZzvyM7rCKQ1Twenxio9vKk+nc8/lFnryeUJVvtkk/F4RmJGC0YOx+dWZtxDmxL6DbNZJPmezraTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630695; c=relaxed/simple;
	bh=p6IjLVb6CaHWuEGcpqzec/0TKNN2PB5mvz90D2rRwGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpOvLJ+9X7bUJHxvY+AKxRY8vlMYMxLr20/B644jbIU0GmRccQ+ddvONQkIHvu4ja8EWHFGThVm32S7FAubp+qpf5k/RytanIgQt/jwlynCXtG5gCADfxsRvWFiFmA+F6/EKQkgHqKVq58bb9qeKOULE8n+fnZ7wBRLG8fkQqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHPBz4FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C619BC4AF50;
	Mon, 17 Jun 2024 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630694;
	bh=p6IjLVb6CaHWuEGcpqzec/0TKNN2PB5mvz90D2rRwGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHPBz4FCseWxe/AwZIxpXdXz13S1IPXQAMTnMi5MJc+aIdv8JMRMcYd7Yco9m91gC
	 2gWLc+kxRcaOu/eahWfwMnh8ZmXXxcdQHsvp7Ey5KWfSe0chuya+uW4cGwuNgBfbtk
	 u7XicNhJToWjoKni6Ggo8ExNZIuTzu5f0XETzvJ91nRydN/foBkId3WysR9wZQF7oi
	 ipIJt/9lS8x54RQAWlw++oV5e2YMJG1pOg3RW3/8AaCIDv4pxx4ZGtIERtB/4nZOam
	 uoo4f4EONjMfikZ/10WGyTlU6mkdzWJu/Q3v9Z9XBBNJBHYX+Ads8MNzCZwclgdHBt
	 iISi28DZPu5yA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e724bc466fso52163481fa.3;
        Mon, 17 Jun 2024 06:24:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXobh00tW33HYlSCRSLjNyJKH60CmYSCz/+lX2vsBhElcnUZ4RumD8TXKAlxUfh6PDpkZ+vmCA6cY50bxL6CaQjlivKV9YvDKNshn8703sqC3Id3wX8fiROKxaGG09YpyprMRWX+FFcf2lGLPQ9ikYW0j2L9RP6eWSIYcsnwZkE0F6f
X-Gm-Message-State: AOJu0YyD5laB7Zg8OgL0SHDE1lGrtIrhMMBT6OjtKh6IIRs+AyB0skb9
	bJGmUPZPKejy6s8awkmnAsqxaX2kVe+OgLZVCaVK2E1ubm1ZjqsBTfjx+RIkXN4lKdAettgF8mz
	HQnRytsJnkwLmVrfd0TzmA/KdQI4=
X-Google-Smtp-Source: AGHT+IGd7Il8L/x2VYYvwI+TdyWZk0q6mXYe8OBC5mf9mEsKmgun6wdGhwkf6pmC2QN5hkUrCDpYZTyYfbmDqwUmMIs=
X-Received: by 2002:a2e:3814:0:b0:2ec:2283:38f6 with SMTP id
 38308e7fff4ca-2ec228339ddmr45302391fa.40.1718630693141; Mon, 17 Jun 2024
 06:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617132309.2588101-1-sashal@kernel.org> <20240617132309.2588101-7-sashal@kernel.org>
In-Reply-To: <20240617132309.2588101-7-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 17 Jun 2024 15:24:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDCUfExvB8aD7HduT4-XQ64juFR1k6Q7MTis4MbtcPfA@mail.gmail.com>
Message-ID: <CAMj1kXFDCUfExvB8aD7HduT4-XQ64juFR1k6Q7MTis4MbtcPfA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 07/35] efi: pstore: Return proper errors on
 UEFI failures
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

NAK

This is not a bugfix so it does not belong in stable.


On Mon, 17 Jun 2024 at 15:23, Sasha Levin <sashal@kernel.org> wrote:
>
> From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
>
> [ Upstream commit 7c23b186ab892088f76a3ad9dbff1685ffe2e832 ]
>
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
>
> So, let's use this helper here.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/firmware/efi/efi-pstore.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index e7b9ec6f8a86a..5669023bdd1de 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -109,7 +109,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
>                                      &size, record->buf);
>         if (status != EFI_SUCCESS) {
>                 kfree(record->buf);
> -               return -EIO;
> +               return efi_status_to_err(status);
>         }
>
>         /*
> @@ -154,7 +154,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
>                         return 0;
>
>                 if (status != EFI_SUCCESS)
> -                       return -EIO;
> +                       return efi_status_to_err(status);
>
>                 /* skip variables that don't concern us */
>                 if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
> @@ -192,7 +192,7 @@ static int efi_pstore_write(struct pstore_record *record)
>                                             record->size, record->psi->buf,
>                                             true);
>         efivar_unlock();
> -       return status == EFI_SUCCESS ? 0 : -EIO;
> +       return efi_status_to_err(status);
>  };
>
>  static int efi_pstore_erase(struct pstore_record *record)
> @@ -203,7 +203,7 @@ static int efi_pstore_erase(struct pstore_record *record)
>                                      PSTORE_EFI_ATTRIBUTES, 0, NULL);
>
>         if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
> -               return -EIO;
> +               return efi_status_to_err(status);
>         return 0;
>  }
>
> --
> 2.43.0
>

