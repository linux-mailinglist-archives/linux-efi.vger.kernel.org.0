Return-Path: <linux-efi+bounces-5286-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C831C242C0
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 10:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ECA189500B
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE4329E52;
	Fri, 31 Oct 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2Yucodj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA53126AF
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903111; cv=none; b=WzW6c87l0S5FiNwzH5Q2kPUBwXnZdIq/wKwT5NSY75H/uFJQeyYontcBjw8LuhpLt+2tqbLhXfTHxN1UqRq73SXbLeaJsqMBQy5j8jxYzEaR7L4u/eK85lP/W3NSONldPLmiMcQJyV87IoGB7Gx0SnJrf5XR3YjrXHkmOaPTScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903111; c=relaxed/simple;
	bh=Ju5scJcqvKgVinWmnh8oTtH0OXNKUbGJQrfL2pV2xBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owtW8GqaP08YmtBLsWng9+UZaCDPlF3ve3xBH7H9ez7u4RBWxtJkpn8pj/RZT3/AggBHirPKuvxMF1yZAh0x5Be56M6z6XriUxRso0GFcdC9fLBFHPTtVlDUJbgdTHiW8j3wLOhMbmirO9lgBviquacKXTLRg7C/tI/gu4pzau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2Yucodj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7847ee5f59dso29810107b3.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761903108; x=1762507908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfyBZJmdoTsV5mASRVjVSK13eALqQJfbT9fGRd81eVU=;
        b=X2Yucodj23ySRgOlNARkCqiDs2q18jfJa5fCPKDwY4D00wvipJfIEtsYZN5buqaig/
         mxSuYSmPKNzUfh0aiMY19gHV60T7ZHD3EnGxRzJOqHLZE/BVpXynqfkdO+HPUaUfGHha
         Dz2Ct24OpzvejDI3oXh7IBr+w3vjd8xDj5gj/I2IJQx6hHJoj4jmZ/Dni8f1+oPoIT9M
         Dd+hKOSNz4RRzUvMuz0uDXGuqQ+p28RxeAVixHU8jbzYjkq6mEApHelXmgoDGYQiiP4V
         3S0E/aff5P52U+05k7tscgoNH8+EvJ+03hoHOZZ7PHJJDrAsnIMDYApIW/AajdCntfoi
         wxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903108; x=1762507908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfyBZJmdoTsV5mASRVjVSK13eALqQJfbT9fGRd81eVU=;
        b=Jk4Ysk50lN1BAT7JsEcsY/rBWHkEsR9kbsEsLaLpenqg7wEx7TgDdqXxFW8l1z3A8j
         fCGI+34AVHB7G34omVm+kWFfVByubWvo6M+LA4mo7+535PJomdwhEYJE1n7MU+3KJNEs
         VJASpefjf0poiTMH0RWMks2vPDmlTPF8aLYgRhj01PN4CaZBtnHIBwEsHRJW9LqLqrkP
         EtLyTFH3wJcI4EAPgI6CWSiCJozsXRv59sg4MVqhPmeIxkrycf+UpZdcvF8bOKdnaFeE
         9KZo2jWcD6hFDtkrm4t7EK5DwLt+3T0tYQor38Ojr9iUzw3e7a7UHA86hJ1mtyZAo/Dx
         dzbA==
X-Forwarded-Encrypted: i=1; AJvYcCWJAFdsB1w828tb3qrvtRdthoM228HsJFIdzTpomx1ECxUBTRvippVMsHI9qwCfyCuSvcM6f+Ot4xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCG4B9kLYKr0R4cnol3D5vmSIvV57ZPrUQJMFp+ZG0EsUigy0
	mX2u8nc/hQ/6mjliDD9vtJZMQryWjxXdMsSpEE3W/r5jerhNOCaGRAC0A7H+yUwoBXukBSr5GVA
	GKOnsRP+oHzb3At1jv9vId7VSilkaaSwcSxF5QYIMbg==
X-Gm-Gg: ASbGncuQfPfjqI3q4hsM7TCT6RlmZLJ7Rk36N2qjUP3s35jHWZDKlXLxiEhWA8plTCT
	KTFhp2GcYB1pMt6vk8t8x+Ka7S0Txqwe2u4261DVf39rloSCldzEE2mwuPDck5Qj8Tvaxlbarsm
	3ScQok2al4dIN3DxkQDN3ZxCbZrcZ5YeBlyBjXQlbrkiAV5isjSDDL2DB7U9Cnb3NgTnfcBwfw0
	qsv6D3Ve0gjaYEo6KLWZOOffJE2hDr8x79bc/rSUa8RjSsfHo7xWimBocJyAOb108rN62Ns5S77
	pKMdk6le/eo5RZkbumcQ6dGWuZzG7MCe4HO0kr0BY56RZe0PLX0=
X-Google-Smtp-Source: AGHT+IEj9iIFsZIJy7VYK8k+eD82W99U6thDDvr3Il/rycdxbwYPZw7iXiAb8sYHSRlB0te//hksUCovkbAvYVNVBnU=
X-Received: by 2002:a05:690c:4b89:b0:786:5499:6340 with SMTP id
 00721157ae682-786549968camr624657b3.21.1761903108203; Fri, 31 Oct 2025
 02:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022114527.618908-1-adriana@arista.com> <20251031084101.701159-1-adriana@arista.com>
 <20251031084101.701159-3-adriana@arista.com>
In-Reply-To: <20251031084101.701159-3-adriana@arista.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Oct 2025 11:31:11 +0200
X-Gm-Features: AWmQ_bmWyYlCW0A93XcRB_MwyaKSsdQLSr0mMsiasbGEhlTJwVwCdJ2Jtv0fY24
Message-ID: <CAC_iWjKEK6ardoCS9YUArhU-5UJfdb8cCGiiH=Ly=KkXTh=hvg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: firmware: dmi_scan: Add support for
 reading SMBIOS from DT
To: adriana <adriana@arista.com>
Cc: ardb@kernel.org, trini@konsulko.com, robh@kernel.org, krzk@kernel.org, 
	jdelvare@suse.com, frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Adriana,

On Fri, 31 Oct 2025 at 10:41, adriana <adriana@arista.com> wrote:
>
> From: Adriana Nicolae <adriana@arista.com>

We'll need a description of why the change is needed here.

[...]

>
>  #ifndef SMBIOS_ENTRY_POINT_SCAN_START
>  #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
> @@ -670,6 +673,54 @@ static int __init dmi_smbios3_present(const u8 *buf)
>         return 1;
>  }
>
> +#if IS_ENABLED(CONFIG_OF)
> +/**
> + * dmi_scan_from_dt - Find and parse DMI/SMBIOS tables from the Device Tree
> + *
> + * Checks if the bootloader has passed SMBIOS table addresses via the /chosen
> + * node in the Device Tree. This follows the standard kernel DT bindings and
> + * assumes a fixed 32-byte mapping for the entry point.
> + * Returns true if a valid table is found and successfully parsed.
> + */
> +static bool __init dmi_scan_from_dt(void)
> +{
> +       struct device_node *chosen;
> +       const __be64 *prop;
> +       char buf[32];
> +       void __iomem *p;
> +       bool dmi_available = false;
> +       u64 addr;
> +       int len;
> +
> +       chosen = of_find_node_by_path("/chosen");
> +       if (!chosen)
> +               return false;
> +
> +       prop = of_get_property(chosen, "linux,smbios3-table", &len);
> +       if (prop && len >= sizeof(u64)) {
> +               addr = be64_to_cpup(prop);
> +
> +               p = dmi_early_remap(addr, 32);

Please put '32' into a define that explains what it is

> +               if (p == NULL)

I think if (!p) is preferred

> +                       goto out;
> +
> +               memcpy_fromio(buf, p, sizeof(buf));
> +               dmi_early_unmap(p, 32);
> +
> +               if (!dmi_smbios3_present(buf)) {
> +                       dmi_available = true;
> +                       goto out;
> +               }
> +       }
> +
> +out:
> +       of_node_put(chosen);
> +       return dmi_available;
> +}
> +#else
> +static bool __init dmi_scan_from_dt(void) { return false; }
> +#endif /* IS_ENABLED(CONFIG_OF) */
> +
>  static void __init dmi_scan_machine(void)
>  {
>         char __iomem *p, *q;
> @@ -718,6 +769,13 @@ static void __init dmi_scan_machine(void)
>                         dmi_available = 1;
>                         return;
>                 }
> +       } else if (IS_ENABLED(CONFIG_OF) && dmi_scan_from_dt()) {

Can you fold the IS_ENABLED() in dmi_scan_from_dt() please?

> +               /*
[...]

Thanks
/Ilias

