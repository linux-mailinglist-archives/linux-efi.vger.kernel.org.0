Return-Path: <linux-efi+bounces-818-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DAB87CA92
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 10:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB23284436
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B317C64;
	Fri, 15 Mar 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdgbZVDP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48617C60
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494368; cv=none; b=EsUXn2pAdI404JltrePY7CoahXlJUQJzOAhRlxSh+M+zzqeQaGboIBA/1AiortnS6ao53A4EsbhuTGgQXjFdo7CwB30kENDeUoFrqlLvNv8WCyQZ88SVP3YtsjhQzdSqObkHcpviSRJi9folSWgaCerJwgLtGvVYzAtZzAZlFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494368; c=relaxed/simple;
	bh=o/KT3rRRZ4dl7ItNvt8BJvLFShthLlJcw0r+0QyKteQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFILfradHlD8DvFiCCFnU89c5QrGLz2Hlz4MOB2vCSaf6fot0S3ggEXqtExnRB57jVtVWwv6ucdW7y3dwxY3pGPMEOpctMhuUdQmpjA65G2GJGg6m8pux6xbotpPTpxKVZni/1GQKERQEG5yW30BZTfLR3jnixDK8D6hOpgHop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdgbZVDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4814C433C7
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 09:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710494367;
	bh=o/KT3rRRZ4dl7ItNvt8BJvLFShthLlJcw0r+0QyKteQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UdgbZVDPDceev5X9WOTsa2WIquThCwi/h7d1dqUfW2UrFC9qESj9KBFBTvF1HUTKc
	 MpfI8vb178kFMT2fya/lwrOqEiwojrs7n21CXS8zSNLUWa8YKtqYO7CBEm3P2f4cKh
	 tk9xUfEddCjFCGBfjc24ofoG84l75IryGIR3YqMkNCq8QKpyDfAmDho4UyqNUrV2Jz
	 PFJm/d6x8l0Vm96pB5OKn11UUW3VQKUfCAVxeTcZcxGWAE6l3WyZAfmSuXL4/Z4eAG
	 rSBdXQW1OgK5s0TYSRZwtFHxgLHklxlQ143MJtlmp/ZgVj44V/4SWm9AJ428NJWTgj
	 hvAJEdpMhWi7g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131316693cso2447109e87.0
        for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 02:19:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzgKNKEgz0Tg3Pk4KFLlyXJGtHyAcOQeUsdtZQC0lXnPTxYW37H
	0HN7Z487pT/bV0dFolWstHT4aNP80BLIbWZlnFAzKMBt4/8ZjPyRQVFd5FqugyC5LlNnVs+drEq
	LrmAUaE2mYwL7Jo3v+NAwP/+0oXY=
X-Google-Smtp-Source: AGHT+IH/919ftG3d9LBTfekrneQi8IECRS2PAkGoTCPq6l1Ud8luTUr+xqVQesfFLrKHVaMTZfE4aDRdSDEYbv7dY8c=
X-Received: by 2002:a05:6512:4844:b0:513:cbde:8764 with SMTP id
 ep4-20020a056512484400b00513cbde8764mr2899262lfb.57.1710494366062; Fri, 15
 Mar 2024 02:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315002616.422802-1-timschumi@gmx.de> <20240315002616.422802-2-timschumi@gmx.de>
In-Reply-To: <20240315002616.422802-2-timschumi@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 10:19:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFf8tmTkO+xn4PwumJ3pQQUQ7TUMtEBNBMc+HXb4ab5dQ@mail.gmail.com>
Message-ID: <CAMj1kXFf8tmTkO+xn4PwumJ3pQQUQ7TUMtEBNBMc+HXb4ab5dQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] efivarfs: Remove unused internal struct members
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 01:27, Tim Schumacher <timschumi@gmx.de> wrote:
>
> The structure was moved to the efivarfs internals in commit 2d82e6227ea1
> ("efi: vars: Move efivar caching layer into efivarfs") after previously
> being used as the data ABI for efivars until its removal in commit
> 0f5b2c69a4cb ("efi: vars: Remove deprecated 'efivars' sysfs interface").
>
> As efivarfs only uses the structure for the variable name caching layer,
> the data-related members were never in use. Remove them to avoid
> implying that efivarfs is bound by the same restrictions that efivars
> once had.
>
> Since we are changing the last copy of "struct efi_variable", document
> the former layout in the ABI documentation of /sys/firmware/efi/vars
> that is still left over.
>
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> I'm unsure if this is how documentation of removed interfaces is/should
> be handled, input on this would be greatly appreciated. Of course, the
> alternative to what I did here is to remove the documentation
> completely. If someone is running a kernel old enough to have this
> interface, then the matching kernel source will still contain said
> documentation.
> ---
>  Documentation/ABI/stable/sysfs-firmware-efi-vars | 12 ++++++++++--
>  fs/efivarfs/internal.h                           |  3 ---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>

Please just rip out the doc (but in a separate patch and cc the
Documentation maintainers)


> diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentation/ABI/stable/sysfs-firmware-efi-vars
> index 46ccd233e359..461b9139cedb 100644
> --- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
> +++ b/Documentation/ABI/stable/sysfs-firmware-efi-vars
> @@ -41,8 +41,16 @@ Description:
>                 raw_var:        A binary file that can be read to obtain
>                                 a structure that contains everything
>                                 there is to know about the variable.
> -                               For structure definition see "struct
> -                               efi_variable" in the kernel sources.
> +
> +                               The structure is defined as follows:
> +                               struct efi_variable {
> +                                       efi_char16_t VariableName[512];
> +                                       efi_guid_t VendorGuid;
> +                                       unsigned long DataSize;
> +                                       __u8 Data[1024];
> +                                       efi_status_t Status;
> +                                       __u32 Attributes;
> +                               } __attribute__((packed));
>
>                                 This file can also be written to in
>                                 order to update the value of a variable.
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index f7206158ee81..971560a01320 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -24,9 +24,6 @@ struct efivarfs_fs_info {
>  struct efi_variable {
>         efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
>         efi_guid_t    VendorGuid;
> -       unsigned long DataSize;
> -       __u8          Data[1024];
> -       efi_status_t  Status;
>         __u32         Attributes;
>  } __attribute__((packed));
>

I suppose we can drop the packed attribute too, given that this is no
longer external ABI.

