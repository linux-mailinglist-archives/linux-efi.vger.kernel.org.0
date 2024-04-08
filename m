Return-Path: <linux-efi+bounces-931-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAB89BDD1
	for <lists+linux-efi@lfdr.de>; Mon,  8 Apr 2024 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E682DB22153
	for <lists+linux-efi@lfdr.de>; Mon,  8 Apr 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE72E64CE8;
	Mon,  8 Apr 2024 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KDdYgPfc"
X-Original-To: linux-efi@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C43524AF;
	Mon,  8 Apr 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574724; cv=none; b=k964G3MECkIiSKN5VOY0NlMUMBGHuyjdAuEyU7eoucQOGJJDeq8b15qlpTXRxijTFAtyOdSREKd1A0cbtj/HNCb+wXfvJAUh0ZtpwTqi2E5yobSDlq73NhP3mewYoq5KH2l0f5FkV8JhHjfqHPliiLM/HJHIrr/2kkm/C7aHoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574724; c=relaxed/simple;
	bh=/qHdiMaIekzpF2hh/Wzjj4H9Q+/t8SpERCHBTT65Khw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMFRCIUMJhfaN1uWX0SJ8At0/EaClwm+QeqDM/2di4ApyJ6eKy5trlvKAKAMP7Az97/FxkIJRDp+EfX2ibeTFNP7q+CLyWojaFzRgin4ALvF5jg5FWoQW0DqNqLUOmOm/MYHDdHlpGNL0q44U5NKtUHS2AaynMqfMDDkq8GwsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=KDdYgPfc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712574719;
	bh=Gy2IffhRM6JRRrukWvLRqJnwzreji6m9bj34GwffDNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KDdYgPfcoO4Xwkc9vPoJtb5pfxHOMMswqVXzEkb/jhRhZbDZDKl2m5brlJJmmnDdl
	 0Kkk/GINLb1FttDTi7KiDUakFnGXKeHNjAMNPprZXB820lvKPVgL6e3YNFLJgM8X6r
	 /Bt/2va9Kh+M5yTqqWdLcOsVJQBS6422N6PmXhpKT+4uMtLMWfFRYFOGVJ1PDbgp5W
	 aBLla90cOIxiStLjk7j/zyOvU4VMGviSwd/s0Htc/v191CCU4vuhkXFJ/ldbpaMBn+
	 vCiuYLbrxjHnMPxLxfiOeuQ7etxHECiSkN+/1wB6saocLq7ZwqZ+iE0iUd4YlxCv7i
	 ww2jBxf3AqLhg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCmdB2lhKz4wcF;
	Mon,  8 Apr 2024 21:11:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, Jean Delvare
 <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang
 <zhi.wang.linux@gmail.com>, intel-gvt-dev@lists.freedesktop.org, Daniel
 Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Luis
 Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] treewide: Use sysfs_bin_attr_simple_read() helper
In-Reply-To: <92ee0a0e83a5a3f3474845db6c8575297698933a.1712410202.git.lukas@wunner.de>
References: <cover.1712410202.git.lukas@wunner.de>
 <92ee0a0e83a5a3f3474845db6c8575297698933a.1712410202.git.lukas@wunner.de>
Date: Mon, 08 Apr 2024 21:11:57 +1000
Message-ID: <87jzl8az2a.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Wunner <lukas@wunner.de> writes:
> Deduplicate ->read() callbacks of bin_attributes which are backed by a
> simple buffer in memory:
>
> Use the newly introduced sysfs_bin_attr_simple_read() helper instead,
> either by referencing it directly or by declaring such bin_attributes
> with BIN_ATTR_SIMPLE_RO() or BIN_ATTR_SIMPLE_ADMIN_RO().
>
> Aside from a reduction of LoC, this shaves off a few bytes from vmlinux
> (304 bytes on an x86_64 allyesconfig).
>
> No functional change intended.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  arch/powerpc/platforms/powernv/opal.c              | 10 +--------
>  drivers/acpi/bgrt.c                                |  9 +-------
>  drivers/firmware/dmi_scan.c                        | 12 ++--------
>  drivers/firmware/efi/rci2-table.c                  | 10 +--------
>  drivers/gpu/drm/i915/gvt/firmware.c                | 26 +++++-----------------
>  .../intel/int340x_thermal/int3400_thermal.c        |  9 +-------
>  init/initramfs.c                                   | 10 +--------
>  kernel/module/sysfs.c                              | 13 +----------
>  8 files changed, 14 insertions(+), 85 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 45dd77e..5d0f35b 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -792,14 +792,6 @@ static int __init opal_sysfs_init(void)
>  	return 0;
>  }
>  
> -static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
> -				struct bin_attribute *bin_attr, char *buf,
> -				loff_t off, size_t count)
> -{
> -	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
> -				       bin_attr->size);
> -}
> -
>  static int opal_add_one_export(struct kobject *parent, const char *export_name,
>  			       struct device_node *np, const char *prop_name)
>  {
> @@ -826,7 +818,7 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
>  	sysfs_bin_attr_init(attr);
>  	attr->attr.name = name;
>  	attr->attr.mode = 0400;
> -	attr->read = export_attr_read;
> +	attr->read = sysfs_bin_attr_simple_read;
>  	attr->private = __va(vals[0]);
>  	attr->size = vals[1];

I gave it a quick boot and checked I could still read the attributes,
everything seems fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

