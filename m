Return-Path: <linux-efi+bounces-434-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6883DED1
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199FD1C228D8
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F191D559;
	Fri, 26 Jan 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLR039hR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2A1FA5;
	Fri, 26 Jan 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286933; cv=none; b=UwUJSC3Wrjj5X7lCR/ktVxAWB18LWzjgcFjgCp3ljG0prJhwF0yWJjejmxddi4IBoj6tR1uUsrGGnFV375oAVoZy9UuIwlWUEx8s7AnLCO5lpbKxMSlFnOEQhY+zXaVXRzjjpRXu+fw8ryfRKUBYGNmhUg3IM2/PKvBJj6nlsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286933; c=relaxed/simple;
	bh=NOF1deFw6/MnompaK7Qwsz2yIZshBKDuGidSylU4mvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/9GnDwekocQUQLTgUADr/a84S5Ct3Jz/lQkcvWRGrI8X9/w8y/yPNkjjp12xukofp6UTlaiQZLNbEGDajoGTRMUsSQqTdDh6MUoyIJzJ3e7Zf9gojFG49kXfxRVfFuxthgHhPe6Hs6HEAI6eds8UuybRzrR+oO6A+hJTMk07es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLR039hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCDBC433F1;
	Fri, 26 Jan 2024 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286933;
	bh=NOF1deFw6/MnompaK7Qwsz2yIZshBKDuGidSylU4mvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lLR039hRCl5LHMAdU4iHaG2rJHot35KuU4k2LEjcS9+kfjd9qUZvvhExz83ViFt5t
	 vrEbTns4PQGmQgOhHiBJ8MysmzDgh06tsPiC4gWWnC5/eJmjXTvI5XZcYdND0C9c0o
	 WlIaL4EL14uiskiBTZpLwJqKz9OLQ4Vv9HQB7B1WfVjn7tZjN5kBvjIHcQHio+4PWd
	 XjNi8Iqk6k6tniwax+9qysCaVPkmxk7o4OCPBnzLkMH9mg0g4A+J0wmmVp/uNlq6um
	 njuVcc37HAWNEVMTyjhmSHPlgh7vwPF26aBK0rGdN/OJI7IM6gql/R7ppHwvOpGX+M
	 J2aZeVBGpXMpA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51028acdcf0so651431e87.0;
        Fri, 26 Jan 2024 08:35:33 -0800 (PST)
X-Gm-Message-State: AOJu0YyuaRR8Rt8nhf/Z5hk601rlW9ydwwKf9r6QPGFgiBTef6U9Pa2N
	kjxmbX6sTepGmo2C19D6hOMRHtjTXU8bmZiyN8/jlev4RY8S89TnI1I0O1W8c+Qr549v1VfPHy7
	/UMo4enhNt+0FArGTpo3vHRGJass=
X-Google-Smtp-Source: AGHT+IHd5NK3UNGhnlerJ7NTJvk/RLrCPdja5LS9GU0p15nCRFH5tBqK/zAY+QSL6JS8yS5XJ5OkkbAaH6B3Gzk7y6k=
X-Received: by 2002:ac2:5970:0:b0:50e:b265:be94 with SMTP id
 h16-20020ac25970000000b0050eb265be94mr830442lfp.118.1706286931498; Fri, 26
 Jan 2024 08:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123202743.1591165-1-timschumi@gmx.de> <20240126162524.52051-1-timschumi@gmx.de>
In-Reply-To: <20240126162524.52051-1-timschumi@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Jan 2024 17:35:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGOzk4OnsxL8T7Finx8RzNu23SriY7QokAvKD=BkEvpjw@mail.gmail.com>
Message-ID: <CAMj1kXGOzk4OnsxL8T7Finx8RzNu23SriY7QokAvKD=BkEvpjw@mail.gmail.com>
Subject: Re: [PATCH v3] efivarfs: Request at most 512 bytes for variable names
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-efi@vger.kernel.org, jk@ozlabs.org, mjg59@srcf.ucam.org, 
	pjones@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 17:25, Tim Schumacher <timschumi@gmx.de> wrote:
>
> This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
> where a call to `GetNextVariableName` with a buffer size larger than 512
> bytes will always return `EFI_INVALID_PARAMETER`.
>
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> Made a patch with just the size change (and a comment / error message
> for good measure) as requested. I just hope that I don't have to come
> back in a month to find out that there is a machine that only accepts up
> to (e.g.) 256 bytes.
>

How about we add

static int varname_max_size = 512;
module_param(varname_max_size, int, 0644);
MODULE_PARM_DESC(varname_max_size,
                "Set the maximum number of bytes to expect for variable names");

and use varname_max_size to initialize the malloc and the input argument?


> One thing that I just recently noticed is that properly processing
> variables above 512 bytes in size is currently meaningless anyways,
> since the VFS layer only allows file name sizes of up to 255 bytes,
> and 512 bytes of UCS2 will end up being at least 256 bytes of
> UTF-8.
>

Interesting. Let's add this to the commit log - it makes the case much
stronger, given that it proves that it is impossible for anyone to be
relying on the current maximum being over 512 bytes.

> If path creation errors are decoupled from the iteration process then
> one could at least skip those entries, but the efivarfs implementation
> seems to be in no shape to handle that currently.
> ---
> Changes since v1 ("efivarfs: Iterate variables with increasing name buffer sizes"):
>
> - Redid the logic to start with the current limit of 1024 and continuously
>   halve it until we get a successful result.
> - Added a warning line in case we find anything that is bigger than the limit.
> - Removed an outdated (or never accurate?) comment about a specification-imposed
>   length limit.
>
> Changes since v2 ("efivarfs: Halve name buffer size until first successful response"):
>
> - Removed all the complicated logic, only keeping the new limit, the
>   comment change, and the error message in case a big variable is found.
> ---
>  fs/efivarfs/vars.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
> index 9e4f47808bd5..3f6385f2a4e5 100644
> --- a/fs/efivarfs/vars.c
> +++ b/fs/efivarfs/vars.c
> @@ -372,7 +372,7 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
>  int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
>                 void *data, bool duplicates, struct list_head *head)
>  {
> -       unsigned long variable_name_size = 1024;
> +       unsigned long variable_name_size = 512;
>         efi_char16_t *variable_name;
>         efi_status_t status;
>         efi_guid_t vendor_guid;
> @@ -389,12 +389,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
>                 goto free;
>
>         /*
> -        * Per EFI spec, the maximum storage allocated for both
> -        * the variable name and variable data is 1024 bytes.
> +        * A small set of old UEFI implementations reject sizes
> +        * above a certain threshold, the lowest seen in the wild
> +        * is 512.
>          */
>
>         do {
> -               variable_name_size = 1024;
> +               variable_name_size = 512;
>
>                 status = efivar_get_next_variable(&variable_name_size,
>                                                   variable_name,
> @@ -431,6 +432,11 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
>                         break;
>                 case EFI_NOT_FOUND:
>                         break;
> +               case EFI_BUFFER_TOO_SMALL:
> +                       printk(KERN_WARNING "efivars: Assumed maximum name size to be 512, got name of size %lu\n",
> +                              variable_name_size);
> +                       status = EFI_NOT_FOUND;
> +                       break;
>                 default:
>                         printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
>                                 status);
> --
> 2.43.0
>

