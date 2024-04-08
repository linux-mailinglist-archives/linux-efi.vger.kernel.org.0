Return-Path: <linux-efi+bounces-932-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C089C7AF
	for <lists+linux-efi@lfdr.de>; Mon,  8 Apr 2024 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D0C1F23387
	for <lists+linux-efi@lfdr.de>; Mon,  8 Apr 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9C13F435;
	Mon,  8 Apr 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPVzIBvT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CD13F42A;
	Mon,  8 Apr 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588494; cv=none; b=uRoqqWANLNavbl5vmJnsCI4xn5XWcY4D5QYlTYtBKee6s8H4U6lakBSySHofUzWXb4l8a5c1DZh7NevtJfL8iJDzHTUxGPz/OhMui4vbheLZfMah4cCeRzo/tXAOPsbuHWNcrjaUtDl4On02G5sBnG4plBv6lJpcDBLscpEvzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588494; c=relaxed/simple;
	bh=EITVdlJtkrnylLXhed9Pr1DfYAyVTQ3XvaUDh63E534=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjGRrwHk++ZbrkhTgH5dXtENpfRHmOQgJczDQVc15iA567JVW7k1W6MUUOXs7yZhxnNGzTX9gfmFXSqeiqb/RfO03pubmr21C5vGhsPv+wymsdlr54E51D1WxkfwCXhutiACQjLNfRk4LWGJ4pRpG7g74ENrtKCkg1UVyI74PrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPVzIBvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB446C433F1;
	Mon,  8 Apr 2024 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712588493;
	bh=EITVdlJtkrnylLXhed9Pr1DfYAyVTQ3XvaUDh63E534=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iPVzIBvT/iSK03mJ74WyCdtfwrYQ0FIvhL5K8YMXOWzUcxtAW1X9DNCrqtBiFjfyi
	 tl90sPwPpZ5rbnlWkWlrmucbJbApIpssRcLEk4bwAVt6FxwLnhmycj60p3s5ZulGuY
	 Oi6kb5XzN6oeZLDaCEoYGMUGaCwA36s9aVa2vFCs+0r3L2ACNZZS6RJMIMK7lmGxXl
	 LZaKWREq5eaTZ8dEmqubeluPfq1pepZhLI9FVjpANsP8XqyeISOYtrQC8gZ/KN/t0I
	 J4RLdMza2ntow+e8CC8hAcBjXsrybDusTaZepo397svH4xSl9ToXUzq+mYubuhRT/b
	 17pKAxdggeVsA==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea1572136eso453455a34.1;
        Mon, 08 Apr 2024 08:01:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3+0lUuKg3hHhe5fIqYbB6u665OvDnFDviXdUd7KWwdn3iXbLFY6hEeIr3VKPT+6KhtijdC/aMEQixQJR8e62LzYen9GjggTwawKLEhn9SqELjylZL57kGQkpxmjD/8n7Z+WFUBW8H2HCWTBOLjc+YqFVDm55FTv5XdDPgzEIaiLOjT+XnmOtAolUMwTh7zUKraa7MV0+2yxafcRNvULKVG6VwrLZivXIW1gexeQtwi62weIsFjgZCMyHHVQ==
X-Gm-Message-State: AOJu0YzUFgJuG5OoHcgg+C7cG0jOPGlDiSTYqqsmM17PI9Otqcm2Gp8w
	0xKNpdaFYwl5HKE7Dz+tIuFRrDijMGKw9nsfRzmQji05ws/GVvDn/2lcM2jA+e5CupL+fHBJ80z
	yHjpuw6lyNGtgRjHxBoAg7xnjuYg=
X-Google-Smtp-Source: AGHT+IE7BjvtTOsOgPqYkXR1Qq+KOOG/nJtiEyKbfNUuvRcPpCIK8D3B6ZYbWXxS6qJ87RK9Jxd6UH195uv+p6a4TTw=
X-Received: by 2002:a05:6808:603:b0:3c5:f534:e2c7 with SMTP id
 y3-20020a056808060300b003c5f534e2c7mr2839026oih.1.1712588493105; Mon, 08 Apr
 2024 08:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712410202.git.lukas@wunner.de>
In-Reply-To: <cover.1712410202.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 17:01:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOHCSp8-8EZjuGAOR0QSH3CcvokG3uBGAKFFpTrkqQRA@mail.gmail.com>
Message-ID: <CAJZ5v0hOHCSp8-8EZjuGAOR0QSH3CcvokG3uBGAKFFpTrkqQRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Deduplicate bin_attribute simple read() callbacks
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	intel-gvt-dev@lists.freedesktop.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 3:52=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrote=
:
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
>  arch/powerpc/platforms/powernv/opal.c              | 10 +-------
>  drivers/acpi/bgrt.c                                |  9 +-------
>  drivers/firmware/dmi_scan.c                        | 12 ++--------
>  drivers/firmware/efi/rci2-table.c                  | 10 +-------
>  drivers/gpu/drm/i915/gvt/firmware.c                | 26 +++++-----------=
-----
>  .../intel/int340x_thermal/int3400_thermal.c        |  9 +-------
>  fs/sysfs/file.c                                    | 27 ++++++++++++++++=
++++++
>  include/linux/sysfs.h                              | 15 ++++++++++++
>  init/initramfs.c                                   | 10 +-------
>  kernel/module/sysfs.c                              | 13 +----------
>  10 files changed, 56 insertions(+), 85 deletions(-)
>
> --

For the series

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

