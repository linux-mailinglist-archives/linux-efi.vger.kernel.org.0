Return-Path: <linux-efi+bounces-1074-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE68CCCC8
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E341C21D5C
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 07:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABB13C9BD;
	Thu, 23 May 2024 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnLv/C28"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4813C9B8;
	Thu, 23 May 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448281; cv=none; b=p8AfP89AD0sI8fqvwGG0a9UuCb/oUHzI0HSxlXfjRNRAmDvqCnGEs5vUYpwZ+L2PY3pxfBGyiaCctEb94uLvGQJuva+Xzj2Y8spXK1vHS1pcSKdAZMpVlKUcYk37OpJVsZEVwL2ufncDTmpD/PxjJy+8GjUG+NkuFizkq4lc7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448281; c=relaxed/simple;
	bh=AiCAiJTWL70M3TYJmHX5/1Q3INZY8/kkXBt3Hemylm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQM1YBF/bOC+sH1Nh4d2b5BzBjPzOCW5h3Pfqalnn+Jfddof1Il0nNQyL36AmG898+TwyEAnee9WjM9+pRaDy3f6An/PZ/lA0XP7SxeuZYO0XhtL1PnUj//Umq30d+nxFbO7EbGnComHJtbHsj083Hrix8XnlDLoVgazhSB9Dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnLv/C28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C2AC32789;
	Thu, 23 May 2024 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716448280;
	bh=AiCAiJTWL70M3TYJmHX5/1Q3INZY8/kkXBt3Hemylm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MnLv/C28ezQOo2RerOHKfCrSIjAq4SxyPoCUio/9dV1bZjBno3KdcojMbKu335vbo
	 ki9OAiPCz12rnkT/CnhE0uavmdzNQLDd4WWk+5719O4XhDsj+d+Q3WSY7rTcpWC/lN
	 0EXV6YN9ofCiPYaYnn/0/yPG1QPhlOMf9rRJ0h7Q50bOcHmZKhW1/h+fbWGHOkg72/
	 /fXRUIQ9rncF8n0cI6YvhlBBzRzfMo/Mdy040Xud4ZHlwQfjeBZ+8PwIgrjEAaom1L
	 8ppC7Vsda/fFiRWzQoN9Oa1M5x5L2oZ/yJuXbHDYAP2KFLVlPwbU2KGJeTYL9W7lZ7
	 SMOgs/65TJpkQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e538a264f7so80948971fa.0;
        Thu, 23 May 2024 00:11:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUss4dV56Ah9OJ0y23l5f9VXJN6ZVgF6zpdfac/o5Sq4rLGwWI3fqKzpfv+qNl/w8uJIyK5UdUY+6b9EmlAOgHHC34GCwGBKMVjeYrV+fOR
X-Gm-Message-State: AOJu0YxsEYnRJ8Fy3DY2N6y3OxebAgraaXEy82i0YNnpmFDBQ4lWPwzb
	tck6PJ+YuZrhPNKBXKPfC9f4Zr53Sc2TKKNmqWRR9jTPZh0qK1Wf/8Q9fp0ElZsTaggn3+n74Yx
	ZMG8FDT+BDG2dtyp1FvRl5+HItMc=
X-Google-Smtp-Source: AGHT+IFZ+QAavKFjKASS9bPkK1iUQCWqsqnMMiMVMtWh5VKQhmYhPQ4dSN2TKtu5XOUR6HDJZ6Y+2CDLolSaS8NqMeg=
X-Received: by 2002:a2e:7a08:0:b0:2e8:4c3d:c9e6 with SMTP id
 38308e7fff4ca-2e9496b8e7amr26623101fa.48.1716448278907; Thu, 23 May 2024
 00:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519163428.1148724-1-gpiccoli@igalia.com>
In-Reply-To: <20240519163428.1148724-1-gpiccoli@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 May 2024 09:11:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGKj57jSyjZGmro-rjvduohmEhZP9VBnU+R3NGy5rsy2Q@mail.gmail.com>
Message-ID: <CAMj1kXGKj57jSyjZGmro-rjvduohmEhZP9VBnU+R3NGy5rsy2Q@mail.gmail.com>
Subject: Re: [PATCH] efi: pstore: Return proper errors on UEFI failures
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org, 
	keescook@chromium.org, tony.luck@intel.com, kernel@gpiccoli.net, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 May 2024 at 18:34, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
>
> So, let's use this helper here.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Queued up, thanks.

> ---
>  drivers/firmware/efi/efi-pstore.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 833cbb995dd3..194fdbd600ad 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -136,7 +136,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
>                                      &size, record->buf);
>         if (status != EFI_SUCCESS) {
>                 kfree(record->buf);
> -               return -EIO;
> +               return efi_status_to_err(status);
>         }
>
>         /*
> @@ -181,7 +181,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
>                         return 0;
>
>                 if (status != EFI_SUCCESS)
> -                       return -EIO;
> +                       return efi_status_to_err(status);
>
>                 /* skip variables that don't concern us */
>                 if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
> @@ -219,7 +219,7 @@ static int efi_pstore_write(struct pstore_record *record)
>                                             record->size, record->psi->buf,
>                                             true);
>         efivar_unlock();
> -       return status == EFI_SUCCESS ? 0 : -EIO;
> +       return efi_status_to_err(status);
>  };
>
>  static int efi_pstore_erase(struct pstore_record *record)
> @@ -230,7 +230,7 @@ static int efi_pstore_erase(struct pstore_record *record)
>                                      PSTORE_EFI_ATTRIBUTES, 0, NULL);
>
>         if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
> -               return -EIO;
> +               return efi_status_to_err(status);
>         return 0;
>  }
>
> --
> 2.43.2
>
>

