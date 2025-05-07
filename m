Return-Path: <linux-efi+bounces-3620-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20087AAD7CB
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C440E1C2164E
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79A21D3DF;
	Wed,  7 May 2025 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BKe6f9Km"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322621D3C7
	for <linux-efi@vger.kernel.org>; Wed,  7 May 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602500; cv=none; b=WOQrj7BI12QoWsdwRCz+x9AJMIU2dA02xFoO14N8bdGeSa9hwTdjhFaTyUV1N4Msb7Wn3HFWT0WI+eVw1kVYpA+W3nIm32tvflh8mFunq8CXM6YFx75aDRjXewV7vC4KCkwTYlExtr+dpiZoEShKdEJOgOhy2+3YJwyL6+HoVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602500; c=relaxed/simple;
	bh=CKJ9woqhM9I9ObdtUWpH9Tkz0E+lAr1zOy114e/BsYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qL5whWvij4xzmHpT1PlGil/fM8yscM3i0CjJUvILjAQGi4wDEkX5cdtq8e31l8OTmfl5/x6jpKrRapPn/4cgcOWm7N1n66Dxf5/6Gb5RyJm3oG16Tumz5wA1FT+2xk3J/xEu33Fvcs1Io0jkMBhm1AGoF7U9d0O+PQdRI/0FOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BKe6f9Km; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B0FB3F2C8
	for <linux-efi@vger.kernel.org>; Wed,  7 May 2025 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746602495;
	bh=uVVNS9K1l5ioZli6+Y1ApU3mzdOmP0mkHrMyUz5xWvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=BKe6f9KmOPWRVSMPs5c9g/3b+LOR4d2/75gPG0S6xJRnCLFy308PHQwswd8Nb2oso
	 sAIq/9+/W0O1900qGdehU3UaeWsEeg3yWHMcI/oxY0dyevxZJtecUHb8TvKpFqU2C7
	 PcWV8vtk8PsGO9ssHbo6mYIIKjF5VYPf+BaEZJZtIEgI3t1dJXW72+1v7p7jFo77es
	 VlmIoVuoVnVSIwOfYIZKepIcrVqZx+yXxVewwRHYDJrDYEOZoFgw1wHVeGIFhebKHL
	 eTqjOSxc9Orv0rpq6mFD9DpPYfdJq2VJaODWUsKt2/FAb0wZ5HK8IkartXovmUSy/Z
	 te4bFLjhGjG/g==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso38148755e9.0
        for <linux-efi@vger.kernel.org>; Wed, 07 May 2025 00:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602494; x=1747207294;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVVNS9K1l5ioZli6+Y1ApU3mzdOmP0mkHrMyUz5xWvI=;
        b=SfAHATcQqklmq75/xhG4BbwxAROVKnJ3ejMwx6yKQCLxT+5QaY4+sUm+yhgG5HoSlF
         DpOnGZrwSOhZnngog86AqahH1SyztiQNsFzwXc1h/x6zf2+beo8P7V9THwjgD8vJLWmB
         wlpE4uejExNVf7GM7TnB5JuGzpaRz+LgWIJuhDeielQaQ8WrRFZSQQDTamrcFgWG9EXQ
         NgFu2JQTXe8B6tiA3Ai7aUiWElC0andsF3+7lMjAGQyAdSjTAGhO7USnrlfY4LxsgCln
         t214WNTVbJRQ/cytj7lGb6GeHxI/1XlDCV5m/kZRPfOEDQ9oK29zEe4uoK18j/Daquqy
         tckw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZYKfryrofxTMaesfKoG6snwqXYBlKAcFh9ufhWAdDXOLFe4zRP3RDY7B0PR5p8svu5HB6c4/lOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OFzPQE1jjBCEO/IeAqMEX8JsyISk8//d8E2jK0FES7ZNWJjt
	PMQoiDJfDmsunMC1a3NTZ/DdB1zmgPIWjHNk5Pjp7YgZ9x8PFNbVJqn8a6FlnOc/h7IA+g5UXkD
	EPU9jJffj416aQFWjHHQJChaUQFjXvDlCVnYSYaGW6HMkB24lBfFrXIDHMs8DS+5k/kD19VP4Pb
	stPKa+hfux
X-Gm-Gg: ASbGncv5XGi35oNa7f1hxtPj4so9H1QBIJawGL6bQTLn0m4vRXbFqbiLHRaFw2p//7T
	8Jd8fHEHMYzHFMt+dsW2vqk1yVJyHLkKHQYjoNsMguOaBcASU7loJieUTNJ+VNoyibjN6kcz5V7
	rHZK5ubJyxuk4gkmesGWlkXtJTLXOtuITHXQ/VFywlDAzU/S4figEqiW3bu6gVzwLsKGc0CblAX
	kgAw4QlkRAFSE3xSYGy4LXal1KSCIiSK3TUDuCt2z2Ex/5EeNladNLrmUuo7y3g+e4+jDOB/82g
	Bye36NjCwXdhUfi8YXz4+1lRiPpJDvFswjeciN4RjEDxs/h0B8Lw
X-Received: by 2002:a05:600c:8414:b0:43d:7413:cb3e with SMTP id 5b1f17b1804b1-441d44bc65dmr14233875e9.1.1746602494121;
        Wed, 07 May 2025 00:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoJ30zNqAeLb94sb4B+QOVmofAE49i+gdW0NJecOa6XdH5XJLR4CdZYMqUjkXpobjaUj8zQw==
X-Received: by 2002:a05:600c:8414:b0:43d:7413:cb3e with SMTP id 5b1f17b1804b1-441d44bc65dmr14233525e9.1.1746602493659;
        Wed, 07 May 2025 00:21:33 -0700 (PDT)
Received: from gollum (151-243-191-194.pool.dsl-net.ch. [194.191.243.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43d6f2fsm20496645e9.22.2025.05.07.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:21:33 -0700 (PDT)
Date: Wed, 7 May 2025 09:21:29 +0200
From: Juerg Haefliger <juerg.haefliger@canonical.com>
To: Johan Hovold <johan@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Ricardo Salveti <ricardo@foundries.io>, Marc Zyngier <maz@kernel.org>,
 linux-efi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: UEFI EBS() failures on Lenovo T14s
Message-ID: <20250507092129.2ef56913@gollum>
In-Reply-To: <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
	<CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
	<Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
	<CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
	<CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>
	<Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t6+A9NYapYO6ac5qH4NgA+z";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/t6+A9NYapYO6ac5qH4NgA+z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2024 15:46:12 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Thu, Nov 28, 2024 at 12:05:09PM +0100, Ard Biesheuvel wrote:
>=20
> > If you're happy to experiment more, you could try and register a
> > notification for EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES using
> > CreateEventEx(), and see if it gets called when ExitBootServices() is
> > called. That would at least help narrow it down. =20
>=20
> Thanks for the suggestion.
>=20
> I see the notify function being called when I signal it as well as on
> each ExitBootServices().
>=20
> With an efi_printk() in the callback ExitBootServices() fails as
> expected, but with an empty function the kernel seems to start every
> time.
>=20
> Interestingly, ExitBootServices() now succeeds also if I add back the
> CloseEvent() call. In fact, it works also if I never signal the event
> (i.e. if I just create and close the event).
>=20
> The patch below should suffice as a workaround I can carry until the
> firmware has been fixed.
>=20
> Johan
>=20
>=20
> From 1464360c7c16d1a6ce454bf88ee5815663f27283 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan+linaro@kernel.org>
> Date: Wed, 27 Nov 2024 16:05:37 +0100
> Subject: [PATCH] hack: efi/libstub: fix t14s exit_boot_services() failure
>=20
> The UEFI firmware on the Lenovo ThinkPad T14s is broken and
> ExitBootServices() often fails and prevents the kernel from starting:
>=20
> 	EFI stub: Exiting boot services...
> 	EFI stub: Exit boot services failed.
>=20
> One bootloader entry may fail to start almost consistently (once in a
> while it may start), while a second entry may always work even when the
> kernel, dtb and initramfs images are copies of the failing entry on the
> same ESP.
>=20
> This can be worked around by starting and exiting a UEFI shell from the
> bootloader or by starting the bootloader manually via the Boot Menu
> (F12) before starting the kernel.
>=20
> Notably starting the kernel automatically from the shell startup.nsh
> does not work, while calling the same script manually works.
>=20
> Experiments have revealed that allocating an event before calling
> ExitBootServices() can make the call succeed. When providing a
> notification function there apparently is no need to actually signal the
> event group and CloseEvent() could also be called directly.
>=20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 24 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |  4 ++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fir=
mware/efi/libstub/efi-stub-helper.c
> index de659f6a815f..9c9c7a1f1718 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -409,6 +409,13 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,=
 int *cmd_line_len)
>  	return (char *)cmdline_addr;
>  }
> =20
> +#define EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES \
> +	EFI_GUID(0x8be0e274, 0x3970, 0x4b44,  0x80, 0xc5, 0x1a, 0xb9, 0x50, 0x2=
f, 0x3b, 0xfc)
> +
> +static void efi_before_ebs_notify(efi_event_t event, void *context)
> +{
> +}
> +
>  /**
>   * efi_exit_boot_services() - Exit boot services
>   * @handle:	handle of the exiting image
> @@ -429,10 +436,27 @@ efi_status_t efi_exit_boot_services(void *handle, v=
oid *priv,
>  {
>  	struct efi_boot_memmap *map;
>  	efi_status_t status;
> +	efi_guid_t guid =3D EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES;
> +	efi_event_t event;
> =20
>  	if (efi_disable_pci_dma)
>  		efi_pci_disable_bridge_busmaster();
> =20
> +	status =3D efi_bs_call(create_event_ex, EFI_EVT_NOTIFY_SIGNAL,
> +			     EFI_TPL_CALLBACK, efi_before_ebs_notify, NULL,
> +			     &guid, &event);
> +	if (status =3D=3D EFI_SUCCESS) {
> +		status =3D efi_bs_call(signal_event, event);
> +		if (status !=3D EFI_SUCCESS)
> +			efi_err("%s - signal event failed: %02lx\n", __func__, status);
> +
> +		status =3D efi_bs_call(close_event, event);
> +		if (status !=3D EFI_SUCCESS)
> +			efi_err("%s - close event failed: %02lx\n", __func__, status);
> +	} else {
> +		efi_err("%s - create event ex failed: %02lx\n", __func__, status);
> +	}
> +
>  	status =3D efi_get_memory_map(&map, true);
>  	if (status !=3D EFI_SUCCESS)
>  		return status;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/ef=
i/libstub/efistub.h
> index 685098f9626f..e3f710823a29 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -272,7 +272,7 @@ union efi_boot_services {
>  		efi_status_t (__efiapi *wait_for_event)(unsigned long,
>  							efi_event_t *,
>  							unsigned long *);
> -		void *signal_event;
> +		efi_status_t (__efiapi *signal_event)(efi_event_t);
>  		efi_status_t (__efiapi *close_event)(efi_event_t);
>  		void *check_event;
>  		void *install_protocol_interface;
> @@ -322,7 +322,7 @@ union efi_boot_services {
>  		void *calculate_crc32;
>  		void (__efiapi *copy_mem)(void *, const void *, unsigned long);
>  		void (__efiapi *set_mem)(void *, unsigned long, unsigned char);
> -		void *create_event_ex;
> +		efi_status_t (__efiapi *create_event_ex)(u32, int, void *, void *, voi=
d *, efi_event_t *);
>  	};
>  	struct {
>  		efi_table_hdr_t hdr;

Johan,

FYI, we've applied this patch to Ubuntu's 6.14 kernel and it seems to break
some older x86 Macs [1]. I'm going to '#ifdef CONFIG_ARM64' these changes.

...Juerg

[1] https://bugs.launchpad.net/bugs/2105402

--Sig_/t6+A9NYapYO6ac5qH4NgA+z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmgbCfkACgkQD9OLCQum
QreQsg//RvOhwMgHbfRkqSmdAWEr+TqH7/wSc3d6eOecpHm8P2OdIdFRwV5hSXQA
WdtXyee4aMbX6NWsd/VFBF/sEofpwdTsy7nxTmn2KwGO55g2cDOaM6ODNU3MKaOy
FO7758rcnasHkPAc/2WGwnjwQAY/XSVvA/+mJXzNlxhLtD/bZzTv+xvSkktTFFmx
F+MiRjpSSKXUsSXS/Cy8UmTWHmYoBFhDq8lyGeHlrIe9HaColXpVZCWx1V7xSE9M
9MOdVuLbfzjsiEw7kc19bRwtkii3Jw3+XhzMyInuiOB9r+HKic0+kUeM7Db74hOV
SdfaiR2NIjhbvljKHkb4MeK95u93HLpMNfTmW7z7K8PDjeFGmssWgGoLCS3NJpAI
P1cSVAyPK/zTXOUYWrUgjCuMzacqg5kjyWx1dYYxGnKkUKoU4/Hj/c+3EsUx94v1
SGUnrgnCPQw3qFCkLV6V1798Qs093CPanYnbJdvgdkrlIStelk7jIwR+BIGaYXdO
OhhuA3Pw03FaIItX7mLvtBcIe51Y3vlN7cV1WHNC5efU7XVLkDb7mOzRwzCK8ioR
1RwqtermvR/vBCMr4nqv+XNlTEOc4ru88hOA7z/whf00u7sw4VKnqDsIKWEiERiS
RNbeRGOrlZ0jR82Bg8Jwv8cnzrUkTbyxRcyb0vKT8KIGkbnP43A=
=AjL+
-----END PGP SIGNATURE-----

--Sig_/t6+A9NYapYO6ac5qH4NgA+z--

