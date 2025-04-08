Return-Path: <linux-efi+bounces-3231-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CDA7FA2B
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203BD3B090D
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D5263C90;
	Tue,  8 Apr 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4C/7Jk2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB1218ABD
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105249; cv=none; b=SB93tvzxTxLzJ0Ir4pPOGS/+Te9G4G7b2ydQY4ig60j7PUxESmjAvBQiitATaZzqFikmPjitbWMiynGWzsy3ueR35pbEh06AEvPMFuiLvCn5eRyL8x4DT+TVZw6g8RFZUAL2KLzL3BYgK3NoqJFS9CXrD1yxaEBw1GCNu/z9PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105249; c=relaxed/simple;
	bh=I2AgDzdoUMKOEk2CC5RFBtKqtj/m1qaQHe4ocmNticI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkgSHpRwco6rRmQPeInyHPK+hivwblvUOLdtSL9dy/U/uGt3C9d9hUo3VDI/aXRtAyAKsMhEBgcZprYOP8qL1nw+9JZMScsOhsbbXLPTaF9pBW4t1h1AqbfWbsR8rxvQdW6IHQmJy+V+Spy6pkJrpKG/mcZTznYrxmNwu3wEPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4C/7Jk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29354C4CEE5
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744105249;
	bh=I2AgDzdoUMKOEk2CC5RFBtKqtj/m1qaQHe4ocmNticI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h4C/7Jk2XZVRGZfTZ7nkRmlummdd90Aqq78zhpsiJ6CubwI0DulHna9vzklfGqPsF
	 4Tn2PEeGDPzRPTmAYmLvrdZf6LNawykmb5umBacCjC84AMS8BHv9kM9g47goHJ/EQ0
	 1BLfkGyzSYmbskOeTU689sYRnWusra8hGEVizBe75+OYRXej55dmuKUVxd/usLtfh2
	 05VC+WfG8KVGeQbOw/dl3Lg9yz/u/KBpt+ZN7tQtfmHwvcacEb84ewhg/2uuq7Wn9r
	 /wLMsRmqX8Iw84DWEsltqE4zEX2QRNBvnBVsV9ImeKgEuVeAGQa0NgVA0mSYkTooc5
	 8A6yFBRjwyeiw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so6377598e87.1
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 02:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLv6d1ZNdHf8gzE3mThTPj7PGsTy9Uoo0A0kxTw16Di02/Ma9x7dJk7QZ+9miyQ33BNqgbG1r07zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3F0Nn3wpUa4326341pSNJizxMJ9fbDIX9zzAqkvgex1xAG+IM
	jo+pk/ndNFCR/rBAo+qHh9bhQiHKP81qL4+g5m2gUKvKLx/pf3Fp0xTVgfIP9kNrwwjvRDuFl/c
	Z3iaCLSVqowK0qTJy5+MN2iQq6jY=
X-Google-Smtp-Source: AGHT+IEQs9yxbBq25xJiwoySQKzD+oDp5LFNKwVqxr7W8kzjdpSblaKERlwMWIne8n6fwxnS3iJrzfWTjXKy5zfC1Vs=
X-Received: by 2002:a05:6512:39c7:b0:548:de80:5354 with SMTP id
 2adb3069b0e04-54c22786570mr4393599e87.21.1744105247537; Tue, 08 Apr 2025
 02:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408091837.407401-1-tzimmermann@suse.de> <20250408091837.407401-2-tzimmermann@suse.de>
In-Reply-To: <20250408091837.407401-2-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Apr 2025 11:40:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFTrY=8njYkbY3_skK8oJOY7-Y4wEdAPV6vUvi7hT2F7A@mail.gmail.com>
X-Gm-Features: ATxdqUHu3RoMw86iA5sS1RLFCahhZKy6DnNRtRKM8sXcthFwWJ0osc6Jycy3HPI
Message-ID: <CAMj1kXFTrY=8njYkbY3_skK8oJOY7-Y4wEdAPV6vUvi7hT2F7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Export symbol efi_mem_desc_lookup
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, linux-efi@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 11:22, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Building efidrm as module requires efi_mem_desc_lookup(). Export
> the symbol.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Feel free to take this via a DRM tree.


> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7309394b8fc98..e57bff702b5f4 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -558,6 +558,7 @@ int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>
>  extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>         __weak __alias(__efi_mem_desc_lookup);
> +EXPORT_SYMBOL_GPL(efi_mem_desc_lookup);
>
>  /*
>   * Calculate the highest address of an efi memory descriptor.
> --
> 2.49.0
>

