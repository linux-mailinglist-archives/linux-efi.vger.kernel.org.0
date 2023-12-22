Return-Path: <linux-efi+bounces-281-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10B81C778
	for <lists+linux-efi@lfdr.de>; Fri, 22 Dec 2023 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356D92877F9
	for <lists+linux-efi@lfdr.de>; Fri, 22 Dec 2023 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C829417742;
	Fri, 22 Dec 2023 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfWIjSbE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A401773B;
	Fri, 22 Dec 2023 09:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F06DC433CA;
	Fri, 22 Dec 2023 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703238164;
	bh=7RmHdQoletX/b0qPhsGLfyMmFMKBCRd2Wc8JbINWqps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UfWIjSbEPH7YTC2oqh4cAUJ2aaxJw/z9E2lGx9kB0XO2HyLjCno06NhVU+tEL56YT
	 BwnwLpgoQ0XMq3aOqGzlH8+7F3sWadUlpkCw7xIbRNAnByBKdIBgj+pGeyMRElCx/U
	 //cmNH+e4onP+O0G4jaDMfuN9Oax9lcLzLniNjCHL7Qlyeui8eHqHo7DMweOpjLd+x
	 AMMCIu3ddU6a7UFAlHcYgoUPz3AW5rDllwxh9H59dOOwbAcRL7HWfNaQjzWugX0ItB
	 HC0egglhgB3CdYo4tGnmLYh77UPw8/YjBhAnP2nBjfYHf7Ev3hM9CVRG3R4w2fhBh1
	 q5V/ekYnXxeyg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso2063296e87.0;
        Fri, 22 Dec 2023 01:42:44 -0800 (PST)
X-Gm-Message-State: AOJu0Yxszl5h38vsOQxEAfa7qFnYGAGXdcD3gNl50rILGUi7CPNWeX4T
	nlZqMc3rsDmCaVCZ52moNxHy4z5vsQlgSKa37eU=
X-Google-Smtp-Source: AGHT+IHPIMkwbYVVkuXAjssVTQxAowXhAEl/ZZ7VcmfGFRxhL0TCmaWNMgtlylhUApH6gi43r8gGwx2Pat8xOBY+n1A=
X-Received: by 2002:a19:5e53:0:b0:50e:51a6:ec22 with SMTP id
 z19-20020a195e53000000b0050e51a6ec22mr488029lfi.8.1703238162483; Fri, 22 Dec
 2023 01:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222061923.10170-1-rdunlap@infradead.org>
In-Reply-To: <20231222061923.10170-1-rdunlap@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Dec 2023 10:42:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH_zVrMEUQFFPsJ-0ugbptUWa-t02W7w8+zQrCgxMJU0A@mail.gmail.com>
Message-ID: <CAMj1kXH_zVrMEUQFFPsJ-0ugbptUWa-t02W7w8+zQrCgxMJU0A@mail.gmail.com>
Subject: Re: [PATCH] efi: memmap: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 07:19, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct all kernel-doc notation to repair warnings that are
> reported by scripts/kernel-doc:
>
> memmap.c:38: warning: No description found for return value of '__efi_memmap_init'
> memmap.c:82: warning: No description found for return value of 'efi_memmap_init_early'
> memmap.c:132: warning: Function parameter or member 'addr' not described in 'efi_memmap_init_late'
> memmap.c:132: warning: Excess function parameter 'phys_addr' description in 'efi_memmap_init_late'
> memmap.c:132: warning: No description found for return value of 'efi_memmap_init_late'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org

Thanks, queued in efi/next.


> ---
>  drivers/firmware/efi/memmap.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff -- a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -32,7 +32,7 @@
>   * space isn't setup.  Once the kernel is fully booted we can fallback
>   * to the more robust memremap*() API.
>   *
> - * Returns zero on success, a negative error code on failure.
> + * Returns: zero on success, a negative error code on failure.
>   */
>  int __init __efi_memmap_init(struct efi_memory_map_data *data)
>  {
> @@ -77,6 +77,8 @@ int __init __efi_memmap_init(struct efi_
>   *
>   * Use early_memremap() to map the passed in EFI memory map and assign
>   * it to efi.memmap.
> + *
> + * Returns: zero on success, a negative error code on failure.
>   */
>  int __init efi_memmap_init_early(struct efi_memory_map_data *data)
>  {
> @@ -107,7 +109,7 @@ void __init efi_memmap_unmap(void)
>
>  /**
>   * efi_memmap_init_late - Map efi.memmap with memremap()
> - * @phys_addr: Physical address of the new EFI memory map
> + * @addr: Physical address of the new EFI memory map
>   * @size: Size in bytes of the new EFI memory map
>   *
>   * Setup a mapping of the EFI memory map using ioremap_cache(). This
> @@ -126,7 +128,7 @@ void __init efi_memmap_unmap(void)
>   * runtime so that things like efi_mem_desc_lookup() and
>   * efi_mem_attributes() always work.
>   *
> - * Returns zero on success, a negative error code on failure.
> + * Returns: zero on success, a negative error code on failure.
>   */
>  int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
>  {

