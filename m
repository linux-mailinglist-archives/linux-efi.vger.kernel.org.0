Return-Path: <linux-efi+bounces-5299-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBCC258A5
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 15:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75CF84F7AD3
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3C26ED45;
	Fri, 31 Oct 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrAAjOSj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EC264FB5;
	Fri, 31 Oct 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920380; cv=none; b=cYUlwKLGV7eSyR5ehrpOnu58r+4z7o6q7+ItSyua0XjRrrMbLkBZSZ2nZu5TgL8K0v1XfYRe2GYrnk2kjDRDzj88YcFT9nQAy1lm/eZseNX+b8tNWyipRchMQYP167lp1nq8GngTpYI6hzq6go5JIBDPqC1gmIEqHhqmMkgdQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920380; c=relaxed/simple;
	bh=wQRM2UW1sxJDdwZLeEi1RxmRJHRzAbI62WHDRiedhPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbRB3rIEfyH4Ty73Y/xQamVXUrWHkoITa/E+PVlvkxHrsBd8Z5zNeoo58MinArUvHYNl36rl9clEnyQ6FFLFzOA2gMHgpPO5BBvQDhqdpUjD5JbgKlc2eXIujBZiTvd0DQaR5iYxkK6ApOgYMqdvYIV2g4P4OzJ048GJ34xraCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrAAjOSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED79CC4CEE7;
	Fri, 31 Oct 2025 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761920379;
	bh=wQRM2UW1sxJDdwZLeEi1RxmRJHRzAbI62WHDRiedhPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrAAjOSjBkZe4zpf5QmgKavPL9WvxlesH3gkZY9NRpwaO4Sl9vp7aZvQrv6mdt4Lz
	 C3dZ55WLMKRt4oz9fvAMstDv3HRyPTs6j5FomyPWf4v+AWGAvNBzn0s7+XKodUh8To
	 cmV/zX6HSwdqd0IfmkH6VUrrP9lPCDzHgDodV8J+tryGszK7q4cOZkgc30+D9MciKA
	 CIyLCquPo2IcDlXIgW3YYNU4+7XzGP2qM6qpB2yB3Z/x7JpLC/r6Uw5Kt1vP6FULgg
	 TrNO5OGGfVGTYGRZD6ktrdF4864r0FzSQx8DILLzbPa54mprix6cOzL3Bp4lO9jJTp
	 zTwuR+hBESN7g==
Date: Fri, 31 Oct 2025 14:19:34 +0000
From: Conor Dooley <conor@kernel.org>
To: adriana <adriana@arista.com>
Cc: ilias.apalodimas@linaro.org, ardb@kernel.org, trini@konsulko.com,
	robh@kernel.org, krzk@kernel.org, jdelvare@suse.com,
	frowand.list@gmail.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, vasilykh@arista.com,
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/1] DMI: Scan for DMI table from DTS info
Message-ID: <20251031-veteran-muskiness-657bce541e9b@spud>
References: <20251031101009.704759-1-adriana@arista.com>
 <20251031115917.713105-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eRy3XHTEy/x7sBgO"
Content-Disposition: inline
In-Reply-To: <20251031115917.713105-1-adriana@arista.com>


--eRy3XHTEy/x7sBgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 04:59:16AM -0700, adriana wrote:
> Some bootloaders like U-boot, particularly for the ARM architecture,
> provide SMBIOS/DMI tables at a specific memory address. However, these
> systems often do not boot using a full UEFI environment, which means the
> kernel's standard EFI DMI scanner cannot find these tables.
>=20
> This series adds support for the kernel to find these tables by
> reading the associated property from the Device Tree /chosen node. The
> bootloader can specify the physical addresses using the property
> "smbios3-entrypoint".
>=20
> This patch implements the driver logic in dmi_scan.c.
>=20
> Changes in v5:
>   - Removed linux,smbios3-entrypoint.yaml file and the first patch.
>   - Renamed property to "smbios3-entrypoint".

Please stop sending new versions as a reply to the old one.

>=20
> Changes in v4:
>   - Renamed linux,smbios3-table.yaml file, removed mention of ARM/ARM64
>     (Patch 1/2).
>   - Drop the second definition of dmi_scan_from_dt() and fold checking
>     for CONFIG_OF (Patch 2/2).
>   - Drop unnecessary goto on the success case (Patch 2/2).
>   - Replace magic number for entrypoint size with SMBIOS3_ENTRY_POINT_SIZE
>     definition (Patch 2/2).
>=20
> Changes in v3:
>   - Removed linux,smbios-table property, only keep the SMBIOSv3 property
>     (Patch 1/2).
>   - Search DT for linux,smbios3-table only, removed the code searching
>     for the previous property (Patch 2/2).
>=20
> Changes in v2:
>   - Add missing Device Tree binding documentation (Patch 1/2).
>   - Split the original patch into a 2-part series (binding + driver).
>   - (No functional changes to the driver code in patch 2/2).
>=20
> adriana (1):
>   drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT
>=20
>  drivers/firmware/dmi_scan.c | 54 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>=20
> --=20
> 2.51.0
>=20
>=20

--eRy3XHTEy/x7sBgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQTFcgAKCRB4tDGHoIJi
0rvgAP9JqlWc2Y8wCDOgMKeJ5vX8s68KGDcO0PP+uUxQcpFxHQD+KHg+AKxl8432
Ha3PPNXRFNREA2IRIHbbPY9749MaAw0=
=AvI9
-----END PGP SIGNATURE-----

--eRy3XHTEy/x7sBgO--

