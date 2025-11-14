Return-Path: <linux-efi+bounces-5508-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3FEC5BFEA
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7A92344893
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130542FC877;
	Fri, 14 Nov 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoktKZZD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0529CE1
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109087; cv=none; b=k+di8lXPz0ksi1iNvntsk10kk5w1+D37mpGrg238iLryYOLd8++QO1WYV6uqb6n7jtOkvq34uqfUhTQY0NpHMsCOtlyEYFV2FyQFSlCLqnt9x7csbpQIyKUDfe58KRxyqHUeSdKW0IeeoM3xJ3Q414IY5LjWvveIu+Sj8DFHZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109087; c=relaxed/simple;
	bh=9sRdpBAr4pDaJQu+063L/ZRDghjYzUJdvKL0rCJ8ZHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeiQ0Cprfssp9jMnX4PQYFeHiBZp/I7+FkFFUxbtCUgunsR12SnEWEPqxiyqUUoYPKHHKE7f0iEiUV+D2RWHBl5N/Rjem8lFQiW0Dssg7tbiQbz1yZBD42LTGB3p2Ujuvumqs4VoP3tqxXmwkXBUIhmVdR5hQOasQHwzJxLOGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoktKZZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89124C113D0
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763109086;
	bh=9sRdpBAr4pDaJQu+063L/ZRDghjYzUJdvKL0rCJ8ZHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LoktKZZDyRF2oDG5GUkgHfu8u1iHRFVQUrtgmtb3z6OzPFt/nUwkSy2UCGAn1BLmK
	 3iPXjkEQmMjFkgM+HqO0z2/+yrcyr0IWdELCkO1pM/IBa6hD7+HEmohH/y+OurGYPU
	 7U+bW7OaNWmZ9m111HgB64Rcd+PPd96cXHdZXf+oA+g1zFWv5AR7DqolAu9xAw22+4
	 L7L0mzJySLQGDO+ZDtO4N7SRpUEjiF/NgV8IvmHO80EZUUFVze19Jok5yZ+FiCbKhH
	 7ZUIpO9nV8EcdwqjHI0P9rORy4fJSdGlTDC202HaZHSYncCuX0ky3PfTllb6aud9SX
	 00GkwnMG10sMA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5943d20f352so1882539e87.0
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 00:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHWFiP83MF7b7kBQAotk7FNclX5KUxcC54Ud23fuMx1PDWnKF4G+XPDdEVS1V7C6sLz6fRiCL4UXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8vi3UlDGRR4dv/W95m06PQgq07/PzJj3asi9e+0kB8fk2eDIa
	RIh3ct/RsCywHocr3IP0ndowtAk3qQtFi5TDALZ2v6i+wVFltpeui/KwysiS154qMG76AGvZsJN
	Pnl8G3CGwichAW3OpaKYnAyVSwrCtVC4=
X-Google-Smtp-Source: AGHT+IHzr7Xwl7I0m+u0V85alnzAW8nT8AHpkZb/Gxdntf82JYxBf88U8NTonQ+/GM+9LzXCaNrnd2wtLCgNfae0FyQ=
X-Received: by 2002:a05:6512:3e02:b0:594:34ae:1446 with SMTP id
 2adb3069b0e04-5958424f6a9mr738219e87.41.1763109084959; Fri, 14 Nov 2025
 00:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015160816.525825-1-tzimmermann@suse.de>
In-Reply-To: <20251015160816.525825-1-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Nov 2025 09:31:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF62pEMUJAM12HnF7qMt5xhZaZXpPoMdebMUKCfoAYisQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmiovAl4gWxXpIwmfqjjRg_to99axyg_4XeQaLxrb5VrHGw7cpY_DeO3qU
Message-ID: <CAMj1kXF62pEMUJAM12HnF7qMt5xhZaZXpPoMdebMUKCfoAYisQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] efi: x86: Provide EDID from GOP device
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jonathan@marek.ca, javierm@redhat.com, linux-efi@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 18:08, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Add support for EFI_EDID_ACTIVE_PROTOCOL and EFI_EDID_DISCOVERED_PROTOCOL
> on x86. Refactor the GOP helpers for EDID support, then retrieve the EDID
> into x86 boot_params.
>
> Later boot code copies the EDID from the boot parameters into the global
> variable edid_info. Graphics drivers, such as efidrm, can pick up the
> information from there. In the case of efidrm, it provides the EDID to
> user-space compositors, which use it for improved QoS on the display
> output. Similar functionality is already available on old VESA systems
> with vesadrm.
>
> Tested on x86 EFI systems.
>
> Another patch is required to provide EDID on non-x86 systems via the
> generic EFI stub. The implementation can directly build upon this
> series.
>
> Thomas Zimmermann (5):
>   efi: Fix trailing whitespace in header file
>   efi/libstub: gop: Find GOP handle instead of GOP data
>   efi/libstub: gop: Initialize screen_info in helper function
>   efi/libstub: gop: Add support for reading EDID
>   efi/libstub: x86: Store EDID in boot_params
>

Hi,

Apologies for the delay. This series looks fine to me, although I
would prefer it if we could make things a bit more generic?

Everything you are adding here is arch-agnostic, except for the bit
where we use x86-specific plumbing to pass the EDID info between the
EFI stub and the core kernel.

More specifically, could we do the following:
- move struct edid_info edid_info into common code
- pass the detected EDID info block via a EFI config table instead of
boot_params
- make CONFIG_FIRMWARE_EDID depend on (X86 || EFI_STUB)

