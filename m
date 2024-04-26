Return-Path: <linux-efi+bounces-987-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C975F8B36B2
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031B91C21AE0
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65451145321;
	Fri, 26 Apr 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc1YRiUI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7113F01A;
	Fri, 26 Apr 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132125; cv=none; b=eDCtvgUMPCLX8wJ+fg1Ctf/rhHziIxwjIBIUlqe8rq/JlzzGvB3GYWnU+kDcU1zy9fFvhPdFHyoLiuCCKNfiz6V3uzYqGcIh82yA3v0/4x0QxYJ8n7AveSckS/oRdGM5iRPLMW9VFLFoFuNdCbCXC9ga2PejgFuqr6fFIir0twI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132125; c=relaxed/simple;
	bh=BQU2RBaoh+BYwZJxNG6MuOnWNxfKhQAz+I7OuG0h14w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=m/K94qL7bGs6x8V2YGDudxV38rQ5erCnfZyYTua//mttwk5/J43gL2+yPfjBAXgw/IcgZeGxSybbEMySW/EkHSEe8ec/wBm4jx+r5q642hqWnQobP7phNR5HmvqtB18kZyYpe4fKCsVInWrLLVPGdtIEOqdp7CKNaTwwkKtqHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc1YRiUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A52FC113CD;
	Fri, 26 Apr 2024 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714132124;
	bh=BQU2RBaoh+BYwZJxNG6MuOnWNxfKhQAz+I7OuG0h14w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jc1YRiUIsXBhWYGOKSR6jgCIgv+XlHiiqtK6/NnzcjiE8IS2t/qU1yHVH09olJebX
	 54DVzrcVs3eUA5hJ+/iTF+XPguh0JX9e/hRqrKfcYQVGVFH3uaJV12w77B9NRcd5an
	 hIEs/GOl3RQ6TvACc65HcYj3tMLTDG4JHCcBjMjf6WNHHinEvUa6KbOqay0bk6+Bhf
	 S/tvWke82H46+jMgWm8z3bkmrIWm0ZOFtQoDSc4LwGS3QOXkn3tsqwi1fLED//9kMH
	 0+1UkXw0uVqjWgDoeoDMKwZjwskjo3NbBiQZ9GhopmswJk0259hzGXhdrHPn6fGDtP
	 D8g2D3JJOAL1g==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 14:48:39 +0300
Message-Id: <D0U14GGWT2AW.XRFW7MB1QZFV@kernel.org>
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
>  Documentation/ABI/testing/sysfs-firmware-efi | 12 ++++++++++++
>  drivers/firmware/efi/efi.c                   | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation=
/ABI/testing/sysfs-firmware-efi
> index 5e4d0b27cdfe..caaff27cc73e 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-efi
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -36,3 +36,15 @@ Description:	Displays the content of the Runtime Confi=
guration Interface
>  		Table version 2 on Dell EMC PowerEdge systems in binary format
>  Users:		It is used by Dell EMC OpenManage Server Administrator tool to
>  		populate BIOS setup page.
> +
> +What:		/sys/firmware/efi/tpm_log

*Conditional* suggestion: s/tpm_log/tpm_event_log/

I.e. if we want this better to use the most popular name.

> +Date:		April 2024
> +Contact:	Mikko Rapeli <mikko.rapeli@linaro.org>
> +Description:	If EFI firmware supports TPM device and measurements were d=
one
> +		then a TPM event log has very likely been generated and provided
> +		to the kernel. This serves as indicator for userspace to load
> +		TPM drivers and to start related service early in the boot sequence,
> +		e.g. initramfs, where full bus probes and device scans are not yet
> +		done.
> +Users:		systemd will use this interface to support TPM drivers as module=
s also
> +		for early initramfs
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4fcda50acfa4..94773e8b8806 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -162,6 +162,13 @@ static ssize_t fw_platform_size_show(struct kobject =
*kobj,
>  	return sprintf(buf, "%d\n", efi_enabled(EFI_64BIT) ? 64 : 32);
>  }
> =20
> +static ssize_t tpm_log_show(struct kobject *kobj,
> +				     struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "TPMEventLog=3D0x%lx", efi.tpm_log);

It is also asymmetric with the log message as we can see here. Why you
want to put that prefix and not just print the number? Why hex and not
just %lu?


> +}
> +static struct kobj_attribute efi_attr_tpm_log =3D __ATTR_RO_MODE(tpm_log=
, 0400);
> +
>  extern __weak struct kobj_attribute efi_attr_fw_vendor;
>  extern __weak struct kobj_attribute efi_attr_runtime;
>  extern __weak struct kobj_attribute efi_attr_config_table;
> @@ -459,6 +466,12 @@ static int __init efisubsys_init(void)
>  		platform_device_register_simple("efi_secret", 0, NULL, 0);
>  #endif
> =20
> +	if (efi.tpm_log !=3D EFI_INVALID_TABLE_ADDR) {
> +		error =3D sysfs_create_file(efi_kobj, &efi_attr_tpm_log.attr);
> +		if (error)
> +			pr_err("sysfs create file failed with error %d.\n", error);
> +	}

s/err/warn/

Why "sys create file" and not "sys_create_file"?

> +
>  	return 0;
> =20
>  err_remove_group:

BR, Jarkko

