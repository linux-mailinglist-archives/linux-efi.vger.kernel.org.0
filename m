Return-Path: <linux-efi+bounces-2984-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F5A60FC6
	for <lists+linux-efi@lfdr.de>; Fri, 14 Mar 2025 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE92E3BC09C
	for <lists+linux-efi@lfdr.de>; Fri, 14 Mar 2025 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3D78C9C;
	Fri, 14 Mar 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShRGV+7s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D112AF1D
	for <linux-efi@vger.kernel.org>; Fri, 14 Mar 2025 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951159; cv=none; b=aLmyW/pqNGWn84JgnUQ0AhkOLAuP/947hHGE1GM2mywi77e4Cx/3h658tNl44C8m9l2RGN+Do5c4qYhvvdNKxxyOL6qEZX7Wd6ouTurOR0T1wLgmaOMNyCi9FnB4+GeedcgwTKUv9GGpgnC1tWH7JF64yRvm7JRe7T+Sw3wjvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951159; c=relaxed/simple;
	bh=uyPXRUEywIIGjH5mLsHV9aJh575YYv57O7OmHdHUCwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxukxzx42GkbPIPXswuynUAU8aRhVtekVP2Hpecl2/pBzVth6T7nPuQP+/iJ5+nsuKXBCq3fjYzJCrR92sie+aVB5w8X1Hq0q7+h7qFbdTeUBUq+6mhwUN4XUEZQpGVGnTlCzAHhhZdWMu/wn9ucCt+2YnuXMbBbR+XI9tb6ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShRGV+7s; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so1649982276.3
        for <linux-efi@vger.kernel.org>; Fri, 14 Mar 2025 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741951157; x=1742555957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mX3flr3fDjs5f9zj5ZX2lgdbN3QeZ+oPwK27uaI5w5Y=;
        b=ShRGV+7s2kwoMm6WHx+mOYjeKHjzQJz+fbM27lH3t+ciM2d7FImxlaA/uNeXfi/Roj
         VMCyUHGDjAaQZMPiaaXYauijEK4aCfVju8gGMuwrrY9vd5Rv5P9sycrC+ZDzVCFFCrgx
         p+ZeaYAzC/kerFRRG7uOmb9kxeMEsBFQCcaIpVU1MMEIp8JPVZb0Y+XM2YQ4KKMjp1Os
         nHHIkbqfU8nUOMPko9B04/0jJQTef3GaigLp4f7WrRpRIzM96pKs65X8Btfpb4ltDFJK
         mf74kgQNvOuZAw2Iu0sFRIP8nNU/fGggZiv6yoYmkn7tO+Aqr3pqV6egBDMQu4BE/5fE
         IOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741951157; x=1742555957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX3flr3fDjs5f9zj5ZX2lgdbN3QeZ+oPwK27uaI5w5Y=;
        b=u/DbxS4ECcZHvM4coMNvTxECQ4dXkfHtoMMnOcZvCyei0eXSSqDVRlRJAhpM/XY78v
         LeNduHnJEYgR3E73DUb9As9NSfvsaovHoAvDbRxVtICGM8lFk+QFr1EBAHDAvcTybBSd
         RAUSB01JXlst44T5J5wSSm60frFS17xqCvL9XoWlcDkUgv7OfihbfQJ3yhnQXLR3nhJA
         MS8XwhTjekBqwZvNuDeFbzVm4uMAoe9fSVAE2beZ6iEIPuP4KVzncJIAviWEtQiBU0hb
         cfwdsVKKWztUmaSSbFoLIhbvBBEuBoxkNiM0aPfPxA0UjhFOLbr2SlxUFBuhanIgbMfN
         jytw==
X-Gm-Message-State: AOJu0YxGaN9LKWcIFEJhF9kOvC/pGT1XUCx7Nz40hVzyu4FM/IiCibzy
	0QUtOi7tvNPsPxOGW80ogUHTar8/ulMb44cMd/7JWUAnbeq0fIFAaw7gDtXh3TxXlKNjIkxmpim
	Bkn+C3FPEIxY8nzQ+m5jFa5XPUDp4v2U38lM6ObrqcCPOpKUlQCo=
X-Gm-Gg: ASbGnctSHk4ae6gokpDCMihLPollL7m0KwP8lf2FgbaDBEzBlrqfT+UO5wCu2/XTB0C
	dxsPasWyPBJMY9CVplyuvn6zCXKMxEdJrZGXf3roFha3aT+HJEVhpieaBopTaZyZE16/p72MhS+
	YgbXdJGaobuuY2HvLISOdp5NQ0lOM=
X-Google-Smtp-Source: AGHT+IFPcEANgjttSt3I8BJgliGPzqqKLdWZ6re30J5z3rYFCUhSwm9JsfuQF8KHwN14zbjDUiM2u/67TImz07aQavI=
X-Received: by 2002:a05:6902:2e0e:b0:e63:eea7:8f95 with SMTP id
 3f1490d57ef6-e63f65c52edmr2266819276.38.1741951156894; Fri, 14 Mar 2025
 04:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314110845.1559302-2-ardb+git@google.com>
In-Reply-To: <20250314110845.1559302-2-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Mar 2025 13:18:41 +0200
X-Gm-Features: AQ5f1JohZygpVwxxW5sM0Zk9Bi2bjdmMvVjrUt-2FI8ljsN0LwaQOM4k1_GHobY
Message-ID: <CAC_iWjJteoXnGWvJYa4PhyNR3_ozm0M1R93=UJ0bfDnZ-f9_Cg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Avoid physical address 0x0 when doing random allocation
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Ben Schneider <ben@bens.haus>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 13:08, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Ben reports spurious EFI zboot failures on a system where physical RAM
> starts at 0x0. When doing random memory allocation from the EFI stub on
> such a platform, a random seed of 0x0 (which means no entropy source is
> available) will result in the allocation to be placed at address 0x0 if
> sufficient space is available.
>
> When this allocation is subsequently passed on to the decompression
> code, the 0x0 address is mistaken for NULL and the code complains and
> gives up.
>
> So avoid address 0x0 when doing random allocation, and set the minimum
> address to the minimum alignment.
>
> Reported-by: Ben Schneider <ben@bens.haus>
> Tested-by: Ben Schneider <ben@bens.haus>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index 5a732018be36..fd80b2f3233a 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -75,6 +75,10 @@ efi_status_t efi_random_alloc(unsigned long size,
>         if (align < EFI_ALLOC_ALIGN)
>                 align = EFI_ALLOC_ALIGN;
>
> +       /* Avoid address 0x0, as it can be mistaken for NULL */
> +       if (alloc_min == 0)
> +               alloc_min = align;
> +
>         size = round_up(size, EFI_ALLOC_ALIGN);
>
>         /* count the suitable slots in each memory map entry */
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

