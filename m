Return-Path: <linux-efi+bounces-929-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE989BA80
	for <lists+linux-efi@lfdr.de>; Mon,  8 Apr 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008851C219A2
	for <lists+linux-efi@lfdr.de>; Mon,  8 Apr 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E838FA7;
	Mon,  8 Apr 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+qi3BU/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6D2A8DA;
	Mon,  8 Apr 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565746; cv=none; b=tSmtB8maf/npoGPE8n4GlEy+aZ+DAVOK91ABGRBlsHryDKC6Hkm2585v7MDebXDLBh1pqQj8eCDXl4eE8J/PIH4h3tWlSG/HsWuhzWlcplIkaawJXgA8ikcgO1EDFbcjXj/Ut06khVk6lVyUd3Zfa+79D8I5nBY46HkwZZei1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565746; c=relaxed/simple;
	bh=x5uAG/ltu+aXdeMkNcec1QhqHWClHSds/cSLz1O5N+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZT/fGoGwQyBaa7rWv9GNT9/qhrtLMGgiYyfgCHw05zl4mAx9jMipSp0EjxpbBuprT8zeOcYHp/e0Ui8O9GIE6rbN+vNxlVcBI+Fi6q+8nvoOpl65yJqoRZkqJ2bXpA/khmqdVQEZ/Q0UTHgJ/2pqCcMdqGYUhggYf4yEJMi9BpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+qi3BU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F0CC433B2;
	Mon,  8 Apr 2024 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712565745;
	bh=x5uAG/ltu+aXdeMkNcec1QhqHWClHSds/cSLz1O5N+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j+qi3BU/XayOJEtk+zUWGNNXQZwmsfv+7aRrjOixLWr9b8aDnkabQa9KH3L/LY6DI
	 m+NUPCrWQD+jJhcuDStJoFGhTxPISCbmLKbIMwc1bFdbxldPGeFotZRP6XX6Yyd1Sw
	 8wW/P/+K3Tm/krPTPGekFenbgHv7BnAJwy+LJocFCu1wAm/93oF6WXorKLzFVtb796
	 5Q/i+69eFIPDnCr0eBPH58O33gEBpxh53m0HOGjCTGWk4+u1OXRHXOZLCw5h7+TNm8
	 xz7Or05SIZ89ACo+2Vey5KDI9TxFEUmkyU6UxNShLs+ZjjGIyqQbPR5Gy+6aw56pgm
	 UQ1Y0TfhTn4wg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8129797fcso56246301fa.1;
        Mon, 08 Apr 2024 01:42:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHW8otahrjrLLKh9J4WLXrl0zC74rJD2KqhK2M7odqLJVeRJxSYoq81uYvwmkreoN4X50RogjkAAPpKtfjar5iOWBF1mxJYwuGWmDiSdUbwLsQarYDrhSU42isJLV2+mXWkW3wGWJAx6xQgLkQAJRx8GhC2+rkSrZSlKn6ov9RbYC+4mjaKt/vvljwuTEU33okZRTFUanGHRatLTB4iBTJ3FVCJcmvu719ajLMQw6yDozrwyVq5dy/pBQiLw==
X-Gm-Message-State: AOJu0Yy92AjzvoA49OSpu1/HpsCJ70hwuWcRj6qYl6KenfOkQU9UBiKM
	saiF0PmCf4JU9tKcqmsYG47Z5BsiS2TkK6qlVgLPTU6x4m8G9LDTy9NjNyWIy1dsuTz4ghjiHA8
	V8+sAoB9/MKS5JrMZ/6YmZQjNEOM=
X-Google-Smtp-Source: AGHT+IEEZZz1BlhQIx5HBD9lAq9n0KDHPwdJDpGGUfNMfpXy5a9hhWu2MwVcoReA5TtUW0Y7LCD+C38a7qls1lB/zag=
X-Received: by 2002:a2e:8911:0:b0:2d8:713f:817b with SMTP id
 d17-20020a2e8911000000b002d8713f817bmr4768893lji.26.1712565743595; Mon, 08
 Apr 2024 01:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712410202.git.lukas@wunner.de>
In-Reply-To: <cover.1712410202.git.lukas@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 8 Apr 2024 10:42:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsRLqdXZmRddVUZswCmiJqy8-ncgDF-ooTM2Wdi9q0Qw@mail.gmail.com>
Message-ID: <CAMj1kXHsRLqdXZmRddVUZswCmiJqy8-ncgDF-ooTM2Wdi9q0Qw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Deduplicate bin_attribute simple read() callbacks
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.com>, linux-efi@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	intel-gvt-dev@lists.freedesktop.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 15:52, Lukas Wunner <lukas@wunner.de> wrote:
>
> For my upcoming PCI device authentication v2 patches, I have the need
> to expose a simple buffer in virtual memory as a bin_attribute.
>
> It turns out we've duplicated the ->read() callback for such simple
> buffers a fair number of times across the tree.
>
> So instead of reinventing the wheel, I decided to introduce a common
> helper and eliminate all duplications I could find.
>
> I'm open to a bikeshedding discussion on the sysfs_bin_attr_simple_read()
> name. ;)
>
> Lukas Wunner (2):
>   sysfs: Add sysfs_bin_attr_simple_read() helper
>   treewide: Use sysfs_bin_attr_simple_read() helper
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/powerpc/platforms/powernv/opal.c              | 10 +-------
>  drivers/acpi/bgrt.c                                |  9 +-------
>  drivers/firmware/dmi_scan.c                        | 12 ++--------
>  drivers/firmware/efi/rci2-table.c                  | 10 +-------
>  drivers/gpu/drm/i915/gvt/firmware.c                | 26 +++++----------------
>  .../intel/int340x_thermal/int3400_thermal.c        |  9 +-------
>  fs/sysfs/file.c                                    | 27 ++++++++++++++++++++++
>  include/linux/sysfs.h                              | 15 ++++++++++++
>  init/initramfs.c                                   | 10 +-------
>  kernel/module/sysfs.c                              | 13 +----------
>  10 files changed, 56 insertions(+), 85 deletions(-)
>
> --
> 2.43.0
>

