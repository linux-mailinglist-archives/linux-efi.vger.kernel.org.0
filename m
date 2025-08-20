Return-Path: <linux-efi+bounces-4579-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A00B2D633
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 10:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89BD5830F0
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F182D8DDF;
	Wed, 20 Aug 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbnMh56e"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B32D8DC0;
	Wed, 20 Aug 2025 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678265; cv=none; b=BTchOfRxi+raqRIFYbnoBFkATM/PnsjYibc1oHSf93NUDN5d8kwW9n1Ak4Sp4iHnen1zsO87X5hjE0tBonGXBLwmUcj6l6kx617BX/jQyhhMW+MTvk/PFLzOyQ+dnRJ4gz5cl31+JgQptp0rjAHnjowioek6wfk3gtvCdZRb7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678265; c=relaxed/simple;
	bh=/UL8r/IY6NvhVlFJ56nhpLYKbxUYOgISlF8+SOKUMgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klk1hMav25xfd/ZKTB9PXWreqq+tTSql0l+JZ7HFI5ZvETctPNxk89ORpVHt44mR8MUa8IjBdbIqJ2HNEV7H3FYb3JAS5Cxz79mHShYIjdHJ+5oq5VNqF0MoTkX+qhBS0SQmihlsopV/MGc9786YsC6A7fqIIkXOn8CKMkHQKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbnMh56e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F1EC4CEEB;
	Wed, 20 Aug 2025 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755678264;
	bh=/UL8r/IY6NvhVlFJ56nhpLYKbxUYOgISlF8+SOKUMgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbnMh56e8KeY51vJlnHAVZISzBdTJN0LpMnDGP01/N6PsJeiRuOBNdJEqqYBftNed
	 20t8gDewYmYyxKTsvLyzMfsjnofAq089lYNh6nQ3CR2ft1qPJ8g50tWqP1VlSpFaN8
	 hv208x2hK9MsoaUUDNxpuFCOtTSxBEZpRDl9IVRq6pqYaurwMixBNn2Dap3BCak86G
	 vpEYt8K90dH4mn3ZqO2q+XO3FMm5rrL3hNEPk5m6utPgeCIDPZJAVSSSHH/h38EM+M
	 FHsjOO+A9NXCwMNea9+PBpOZpICrX0MeAfBs9XeemKoTu+mXQefKikv7CjZW5vKpIZ
	 xiWbnB6p6lCCQ==
Date: Wed, 20 Aug 2025 11:24:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2 1/2] kexec: introduce is_kho_boot()
Message-ID: <aKWGMbueQBaB5Wsi@kernel.org>
References: <cover.1755643201.git.epetron@amazon.de>
 <7043f4da31390c58bb7721a3774c30998997df44.1755643201.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7043f4da31390c58bb7721a3774c30998997df44.1755643201.git.epetron@amazon.de>

On Tue, Aug 19, 2025 at 11:22:45PM +0000, Evangelos Petrongonas wrote:
> During early initialisation, after a kexec, other components, like EFI
> need to know if a KHO enabled kexec is performed. The `kho_is_enabled`
> function is not enough as in the early stages, it only reflects
> whether the cmdline has KHO enabled, not if an actual KHO FDT exists.
> 
> Extend the KHO API with `is_kho_boot()` to provide a way for components
> to check if a KHO enabled kexec is performed.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>  include/linux/kexec_handover.h |  6 ++++++
>  kernel/kexec_handover.c        | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 348844cffb13..559d13a3bc44 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -40,6 +40,7 @@ struct kho_serialization;
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
>  bool kho_is_enabled(void);
> +bool is_kho_boot(void);
>  
>  int kho_preserve_folio(struct folio *folio);
>  int kho_preserve_phys(phys_addr_t phys, size_t size);
> @@ -60,6 +61,11 @@ static inline bool kho_is_enabled(void)
>  	return false;
>  }
>  
> +static inline bool is_kho_boot(void)
> +{
> +	return false;
> +}
> +
>  static inline int kho_preserve_folio(struct folio *folio)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 69b953551677..a1a4e76e0ff1 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -925,6 +925,26 @@ static const void *kho_get_fdt(void)
>  	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
>  }
>  
> +/**
> + * is_kho_boot - check if current kernel was booted via KHO-enabled
> + * kexec
> + *
> + * This function checks if the current kernel was loaded through a kexec
> + * operation with KHO enabled, by verifying both that KHO is enabled via
> + * cmdline AND that a valid KHO FDT was passed.
> + *
> + * Note: This function returns reliable results only after
> + * kho_populate() has been called during early boot. Before that,
> + * it may return false even if KHO data is present.
> + *
> + * Return: true if booted via KHO-enabled kexec, false otherwise
> + */
> +bool is_kho_boot(void)
> +{
> +	return !!kho_get_fdt() && kho_enable;

Let's drop '&& kho_enable' and presume that a kernel that booted with KHO
FDT goes through KHO revival.

With that change feel free to add

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> +}
> +EXPORT_SYMBOL_GPL(is_kho_boot);
> +
>  /**
>   * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
>   * @name: the name of the sub FDT passed to kho_add_subtree().
> -- 
> 2.47.3

-- 
Sincerely yours,
Mike.

