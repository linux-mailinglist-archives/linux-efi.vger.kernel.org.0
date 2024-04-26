Return-Path: <linux-efi+bounces-986-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B704F8B36A0
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719B8282DF0
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5297145344;
	Fri, 26 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMU7B8Sk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79295145341;
	Fri, 26 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131713; cv=none; b=Nyuig7NrS4Gf2aWmU5rLBGGe2/qPG8jQeqXD69tyOT6A7zMH+C2ykC3UMWodCkpLCqmaM01/yck+Be0dHncSRp/wOM1TMVjra1uMf0lEAFSgfaWikbHHhB0AtTHNj1zcguqJCQg68JIFImypF70emjgpdfI7mK8vLo88/0V9hZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131713; c=relaxed/simple;
	bh=060C0eRyK2crDEUo4GFbKKDarWvNJFdiUqBTqnc9Udg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KIIuPgUu4p5tdH7GuLPUR3MDN5BPyhUHYpsHSG9IMbdmC7a23T0Zo3sI06OUsXVG6hjY1mriM+k3LvtRFDuRXpmQF8bBDU1QGTbcpBVvBbhWk2jvOeeNKgUhrSSps4m5vG+ASi4RE8Bn5DzQX/h2tuj1rxRb+u/MukiS1LL5zH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMU7B8Sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC84C113CD;
	Fri, 26 Apr 2024 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714131713;
	bh=060C0eRyK2crDEUo4GFbKKDarWvNJFdiUqBTqnc9Udg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=lMU7B8SknPTVtxDHVYvvYmHeak7SID/R2+WrjbQuJDD0dZaXJsNbun+p5KHqZ5P6D
	 iKuO9oKPAVBoYcVt2XyKj7vyPVRRV6xDMF8rZmDFk+dEQKyv0lCwHTWL8FhRkacUv3
	 ixOxDYQj4uI9Mrij6z4TEC4wYpJvdUBmF8n/oL/gkEeScLm/7OrLYP6qA79Ur9WUQ9
	 sPb9JsmvKX9nrPh02b45ZzXbou1AyGpOLV0eI/mibSVT4WmUJyQSlp7KKQprJytG0m
	 k8g1Kbuiu31UdIf8jxxFIo5leJihWoGI9zZtxTOqEuQvwHfijYTBPMAFjkay4enuQZ
	 bpPFlr/ixgNPA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 14:41:47 +0300
Message-Id: <D0U0Z7L2IWN4.IDJXDHZYHDF5@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Lennart Poettering"
 <lennart@poettering.net>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mikko Rapeli" <mikko.rapeli@linaro.org>, "Ard Biesheuvel"
 <ardb@kernel.org>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
In-Reply-To: <20240422112711.362779-1-mikko.rapeli@linaro.org>

On Mon Apr 22, 2024 at 2:27 PM EEST, Mikko Rapeli wrote:
> Userspace needs to know if TPM kernel drivers need to be loaded
> and related services started early in the boot if TPM device
> is used and available. If EFI firmware has used TPM device
> to e.g. measure binaries, then many of them also provide the TPM

What are the other uses cases? TPM settings and reset (clear), i.e.
machine owner use cases? I think "e.g." is not needed here and it
confuses a bit.

> log to kernel in addition to the actual TPM device side measurements.
> Expose availability of TPM event log to userspace via
> /sys/firmware/efi/tpm_log. If the file exists, then firmware
> provided a TPM event log to kernel, and userspace init should also
> queue TPM module loading and other early boot services for TPM support.
>
> Enables systemd to support TPM drivers as modules when rootfs is
> encrypted with the TPM device.

"Enabling systemd" is not an unambiguous sequence of events, as far
as I know.

Please describe what the changes are done to  the kernel, and how they
help to enable whatever systemd wants it. This is way too abstract to
work as "a pitch".

>
> Sample output from a arm64 qemu machine with u-boot based EFI firmware
> and swtpm:
>
> root@trs-qemuarm64:~# dmesg|grep TPMEvent
> [    0.000000] efi: TPMFinalLog=3D0xbd648040 RTPROP=3D0xbd646040 SMBIOS3.=
0=3D0xbe6ad000 TPMEventLog=3D0xbd5f9040 INITRD=3D0xbd5f7040 RNG=3D0xbd5f604=
0  MEMRESERVE=3D0xbd5f5040
> root@trs-qemuarm64:~# ls -l /sys/firmware/efi/tpm_log
> -r-------- 1 root root 4096 Apr 22 10:31 /sys/firmware/efi/tpm_log
> root@trs-qemuarm64:~# cat /sys/firmware/efi/tpm_log
> TPMEventLog=3D0xbd5f9040
> root@trs-qemuarm64:~# cat /sys/firmware/efi/systab
> SMBIOS3=3D0xbe6ad000
>
> Other similar information is currently in /sys/firmware/efi/systab but
> for new exported variables a one-variable-per-file sysfs interface
> is preferred according to comments in systab_show()
> drivers/firmware/efi/efi.c
>
> See also:
> https://github.com/systemd/systemd/pull/32314
> https://lists.freedesktop.org/archives/systemd-devel/2024-April/050206.ht=
ml
>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Lennart Poettering <lennart@poettering.net>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

I'd recommend to test this also with hardware. Easy options for ARM
are:

1. Raspberry Pi 3B+. It has broken TrustZone that allows supply your
   own payloads. OP-TEE supports this.
2. Get https://thepihut.com/products/letstrust-tpm-for-raspberry-pi.

BR, Jarkko

