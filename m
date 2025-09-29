Return-Path: <linux-efi+bounces-4955-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83CBA9C4B
	for <lists+linux-efi@lfdr.de>; Mon, 29 Sep 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D383C7132
	for <lists+linux-efi@lfdr.de>; Mon, 29 Sep 2025 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37110309F1D;
	Mon, 29 Sep 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daY9fY4I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A63093CF
	for <linux-efi@vger.kernel.org>; Mon, 29 Sep 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158889; cv=none; b=g95UQzxPEnkYGwBR4sAMnq0UaCrzDfynmBl4x+7PRTC5L/mKoXP3od1QRN1ZKU0WTQ0NTyM9LX5ZaKV4DXjXzHufSodA2l0hN+hOu3PH65GD91KGpgtdoXtQdkGzQHTpkKjnZBNQDYLdxf0nWru/qoRNUEwG7beoQIoCJH+GaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158889; c=relaxed/simple;
	bh=GZ4e21PBVjuvuXZEYwAdRZQ6R/UqoSTS/zBSuW4rgns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXSGZQttLE21XwGZwYvbinbtQ1XiJEKsv77CQG30EqmmBiSD/eW3a1kjSxDMu0HzXEaemvC5LYrbdHheGupG73NXM2e1eEAwA0689QE83cYQQ6R1NsOqgeWc5k0oF/lGad1DNrvhybR30dAGuzBXLwd7cjcq8AtxksiPYPiJ/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daY9fY4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD04EC4CEF7
	for <linux-efi@vger.kernel.org>; Mon, 29 Sep 2025 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759158888;
	bh=GZ4e21PBVjuvuXZEYwAdRZQ6R/UqoSTS/zBSuW4rgns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=daY9fY4IwErAM4+E71zcw3VQlDPTho0jN7abbAOzBU9ipGrJQP6GHHrn5HXy2Pwvf
	 jQ2yAUZpLBW1Jj6T1J9Qdtk7GTmLW/7SjDTCe+HIoJTbDjtDZWUyfA619+GER5zL75
	 qUPIgc31KUpKpk7UUU9qopFUl3l992AMGqfBKMuJCyeZH1eQBE1PpFZBQBuuJkkCiH
	 FceFpuhkJ0eHYH1TqhjSeU0LASXdo3UhconVgjmCjowJhAlF2VcHPGspt/fCBViuBE
	 tJd4axeVmSVis5iCWnvRSLY+o0pOvfaHhJ3LYfdrRKVuJ/2XGuPRd/w8nQf49hk1Sz
	 LtLGq5N8fvDFw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso6339536e87.1
        for <linux-efi@vger.kernel.org>; Mon, 29 Sep 2025 08:14:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxeLQ5W6TKCsqdmy9puefJnGdca1PEoxcENZYmTnSNG/B53Pln
	eC3gpRG3tz/AR8mIwrx+j4x7ouiJ+fKAD4ocfnkAp5V55uRR5M1CGYRSgX8+XayH8Pgbk55Gth7
	/MKtPqm/9up1Guodba423BtJs0gq0ip4=
X-Google-Smtp-Source: AGHT+IGUaZjYTFlOfxsD2ALuWOy3/rA1fXR59atQkgQYb6nVuRzSl7EX/An2oOo6sqIe6k7g+X8I5lTx6uA9aBfha7c=
X-Received: by 2002:a05:651c:23c5:10b0:372:9e15:8979 with SMTP id
 38308e7fff4ca-3729e158ca9mr5860851fa.24.1759158887057; Mon, 29 Sep 2025
 08:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916193853.410189-1-lszubowi@redhat.com>
In-Reply-To: <20250916193853.410189-1-lszubowi@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Sep 2025 17:14:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHbtLY_H2J_z=sRO1Yyt5fOJ-aS+ErQEXrbwL+qw5mG+w@mail.gmail.com>
X-Gm-Features: AS18NWBrYEdwuh7eTKuA-_TE4GSbVNyBilHoFoRoxpsnt4IrSaSr5mmDliqJEng
Message-ID: <CAMj1kXHbtLY_H2J_z=sRO1Yyt5fOJ-aS+ErQEXrbwL+qw5mG+w@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Memory protection on EfiGcdMemoryTypeMoreReliable
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 21:39, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> Check for needed memory protection changes on EFI DXE GCD memory space
> descriptors with type EfiGcdMemoryTypeMoreReliable in addition to
> EfiGcdMemoryTypeSystemMemory.
>
> This fixes a fault on entry into the decompressed kernel from the
> EFI stub that occurs when the memory allocated for the decompressed
> kernel is more reliable memory, has NX/XP set, and the kernel needs
> to use the EFI DXE protocol to adjust memory protections.
>
> The memory descriptors returned by the DXE protocol
> GetMemorySpaceDescriptor() service use a different GCD memory type
> to distinguish more reliable memory ranges from their conventional
> counterparts. This is in contrast to the EFI memory descriptors
> returned by the EFI GetMemoryMap() service which use the
> EFI_MEMORY_MORE_RELIABLE memory attributes flag to identify
> EFI_CONVENTIONAL_MEMORY type regions that have this additional
> property.
>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>

Queued up now, thanks.

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index cafc90d4caaf..0f60a12401c2 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -300,7 +300,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>                 return EFI_SUCCESS;
>
>         /*
> -        * Don't modify memory region attributes, they are
> +        * Don't modify memory region attributes, if they are
>          * already suitable, to lower the possibility to
>          * encounter firmware bugs.
>          */
> @@ -315,11 +315,13 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>                 next = desc.base_address + desc.length;
>
>                 /*
> -                * Only system memory is suitable for trampoline/kernel image placement,
> -                * so only this type of memory needs its attributes to be modified.
> +                * Only system memory and more reliable memory are suitable for
> +                * trampoline/kernel image placement. So only those memory types
> +                * may need to have attributes modified.
>                  */
>
> -               if (desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory ||
> +               if ((desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory &&
> +                    desc.gcd_memory_type != EfiGcdMemoryTypeMoreReliable) ||
>                     (desc.attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0)
>                         continue;
>
> --
> 2.51.0
>
>

