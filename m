Return-Path: <linux-efi+bounces-817-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB387CA88
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 10:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA241C21547
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6617732;
	Fri, 15 Mar 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHhRvMUW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03867175AA;
	Fri, 15 Mar 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494233; cv=none; b=EY9I2qhtGF3GCiNCDanUVxW5bGtkYPB6En/IaGevolsewk5raTtCcoQtuII3RHH2HFa3tawpZ0XpMh6K6LoHNdgkk/cWn3xkk+l4zoeRQobzS8QxXuQnuxxXW3y0+CjLD8k3Sg4d9yAFQMZ5R6z2H3DbtBG8rD97JTh7x3FSR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494233; c=relaxed/simple;
	bh=w/EAdnTZd2O/JcwSzVr2SXDVg04KJAxDQ1+bGadkR4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enHIZ8iGXwkjy0cyAre/WrF+fuErzgi0nldZq7GzjUqT8J4iOLHJ1Vprx1VWoSTmIO00WY3/EuA1yfbGeEn0xsa4Bso1aHOSPZ5andeR5T8hRPekoyQLgeKuzc0ilOR36ERzzUWiOnZcI+F+VP1052lG+MRGmA+QH9Bs1LMS+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHhRvMUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D82BC43394;
	Fri, 15 Mar 2024 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710494232;
	bh=w/EAdnTZd2O/JcwSzVr2SXDVg04KJAxDQ1+bGadkR4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JHhRvMUW74EIlu7QM/eX98Xfd2GjiiIYlYmdse0oiWR7xhkLFzkWN8ddHltOJCwG5
	 7fYEuavhGbmOO/HMBRhSlugYLaFknOcAb7wCSjmJbq/0N59zj57+uHOEwGiv1aRQ9b
	 RNXs7idaDJfSzKSsZ9y87moSftNwJmMzy6Cor4d/4oFIqUP1plNJY35GFL75e/fuHW
	 cDEw6qAc2zzY17CYN8M564sAfVu1ie73M1b0gTjqRUSac2mC9QylPbA6Jj9ot1pye/
	 6s/VAvP6gTi19aUuP227cNTZhZoIVzlda7ANK2kylVAyXnm1iQvIg2dMrc6JwT6n87
	 hn5RWorT49Xew==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2505352e6so20911771fa.3;
        Fri, 15 Mar 2024 02:17:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnVLR8hgm0hdUWGQCPPy1C/p6gDcFbJbeJmsNjn5BX16IrjNIo/psW/83mgZ9X57Jl49vhUX+3Ke848h7N/ndkZ1zLf/eD58YKCorSbmfJ
X-Gm-Message-State: AOJu0Yz6aT2pHs2XlKkeIy+QVPRyUk+ewYzqPROman/XiEuLh5PQ+NoK
	GZ0NTiPhFLVxqdV0fIxB8yIQeVsP0wzmbD4iWhGXHnDO3HLUP9IeXyNWJ1J67FamdxbsQM8X8wW
	rmE6S7QBtgqCdCnYvr/gIpgIrwzM=
X-Google-Smtp-Source: AGHT+IHIyVHLfhfOboxgjvvwdwQMuIYw2O+imOPAoasCJ9Yc7xk9MybqlpGrsLSbnVb/d2DG4Si8FGmbE5pE6GBXOkE=
X-Received: by 2002:a2e:8806:0:b0:2d4:3c32:814d with SMTP id
 x6-20020a2e8806000000b002d43c32814dmr3049000ljh.26.1710494230930; Fri, 15 Mar
 2024 02:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315002616.422802-1-timschumi@gmx.de>
In-Reply-To: <20240315002616.422802-1-timschumi@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 10:16:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
Message-ID: <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: pstore: Request at most 512 bytes for variable names
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tim,

On Fri, 15 Mar 2024 at 01:27, Tim Schumacher <timschumi@gmx.de> wrote:
>
> Work around a quirk in a few old (2011-ish) UEFI implementations, where
> a call to `GetNextVariableName` with a buffer size larger than 512 bytes
> will always return EFI_INVALID_PARAMETER.
>
> This was already done to efivarfs in f45812cc23fb ("efivarfs: Request at
> most 512 bytes for variable names"), but the second copy of the variable
> iteration implementation was overlooked.
>
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>

Thanks for the patch. I'll take it as a fix.

As an aside, you really want to avoid EFI pstore in general, and
specifically on such old systems with quirky UEFI implementations.

> ---
> I CC'd the pstore people and linux-hardening mailing list because
> get_maintainer.pl suggested to do so. Apologies in case this was the
> incorrect decision, this is a very non-pstore-specific patch after all.
>

If any of the linux-hardening/pstore people give you grief, just send
them to me :-)

(I am part of the linux-hardening group myself, and work closely with Kees)


> I have taken the liberty of adding a TODO for the future, the actual
> refactor can follow at some point down the line.
> ---
>  drivers/firmware/efi/efi-pstore.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index e7b9ec6f8a86..f0ceb5702d21 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -135,7 +135,15 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
>         efi_status_t status;
>
>         for (;;) {
> -               varname_size = 1024;
> +               /*
> +                * A small set of old UEFI implementations reject sizes
> +                * above a certain threshold, the lowest seen in the wild
> +                * is 512.
> +                *
> +                * TODO: Commonize with the iteration implementation in
> +                *       fs/efivarfs to keep all the quirks in one place.
> +                */
> +               varname_size = 512;
>
>                 /*
>                  * If this is the first read() call in the pstore enumeration,
> --
> 2.44.0
>

