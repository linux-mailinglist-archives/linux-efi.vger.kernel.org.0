Return-Path: <linux-efi+bounces-1558-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE6957297
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E411F23489
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC111684B9;
	Mon, 19 Aug 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuqOU689"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE512EBE1;
	Mon, 19 Aug 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090413; cv=none; b=oVqZodERt5UBgUNY94+5xHHLOr3yViCE5wnYJKU4+SRnyF1C4bS79T8rCbCAb8Bk38v12KpVuSwQrr4DQXEhvHdoJKo2/LnQPGrwXKAyHqDoEfjNV2aM7gse4cApat905PzBcKVfoniygMjmkPQWRm5CjhGh0+D4YFCRDW8+gwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090413; c=relaxed/simple;
	bh=H63fgBnwUhY8U7vA2KcfCcuURAdHX2PDPRe0AZv8kzo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gya/F0ssE9L+OD/ydwKPWnrB4X1A99rYpPAekClcufRl3x/xTPMTY+BW3sQnWj+5Ui09igv+vp6T1Q0olHUZ63QWOJKehQNwaz+iC4gEFAFLIXryMZfl3MUoFqwa/SQ4VAGEnCwjlZsqLcYPuLO6OWWlp3qbvZfIon2oc3qtxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuqOU689; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08217C32782;
	Mon, 19 Aug 2024 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090412;
	bh=H63fgBnwUhY8U7vA2KcfCcuURAdHX2PDPRe0AZv8kzo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GuqOU689tiiBYPTumtsM+ZV1/ns0/lSWP+MrZFbn6NzJGHuBivjIMKP6f4nzWeyPf
	 TwHVr8yGhlBx+3WT0k2OKZa4ujdkBoHWRmvCsGdnxjjMAkzYQBRDI7CGLTI9YnljOx
	 mVow0Pe2Psavkt9XO7MOoXsBZFTPjFK9uUk/VcE1Rsx+LBm0l/IbY6fGd9vRgiignz
	 PKnkPsSmzTQzxc1Q20HdEk//qtF/LnJdu647BWeIqP5nR1RY73LJUonJUR+wAaEeVq
	 SUq0rTkrPGD8RYZy8hhl4J6yaiu3msntnStXLz2SylfCefh0gdnaBJEn8pGfYP8Aja
	 UT99ES95zNpQA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Aug 2024 21:00:08 +0300
Message-Id: <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Jan Hendrik Farr"
 <kernel@jfarr.cc>, "Philipp Rudo" <prudo@redhat.com>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Eric Biederman" <ebiederm@xmission.com>, "Baoquan
 He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip
 unusable memory
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Pingfan Liu" <piliu@redhat.com>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <20240819145417.23367-2-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-2-piliu@redhat.com>

On Mon Aug 19, 2024 at 5:53 PM EEST, Pingfan Liu wrote:
> efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> but the current implement can not ensure the selected target locates
> inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> EFI_RUNTIME_SERVICES_* etc.
>
> Fix the issue by checking md->type.

If it is a fix shouldn't this have a fixes tag?

>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> To: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmwar=
e/efi/libstub/randomalloc.c
> index c41e7b2091cdd..7304e767688f2 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
>  		efi_memory_desc_t *md =3D (void *)map->map + map_offset;
>  		unsigned long slots;
> =20

I'd add this inline comment:

/* Skip "unconventional" memory: */

> +		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +			continue;
>  		slots =3D get_entry_num_slots(md, size, ilog2(align), alloc_min,
>  					    alloc_max);
>  		MD_NUM_SLOTS(md) =3D slots;
> @@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
>  		efi_physical_addr_t target;
>  		unsigned long pages;
> =20
> +		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +			continue;
> +
>  		if (total_mirrored_slots > 0 &&
>  		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>  			continue;

BR, Jarkko

