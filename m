Return-Path: <linux-efi+bounces-5913-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB39CD4EFF
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 09:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70E103007206
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602830BBA0;
	Mon, 22 Dec 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+xFP6nK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEEE24E4C3;
	Mon, 22 Dec 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391221; cv=none; b=F06rvlsd7dlVrGb3lJSDzjf12pxQ8OOhz0Ya43LvH4s/8lZ8gwxzeyFRUZBHdrMtyOkXnq7QxZK3L9/iYugfUgumhaQiRS250+zIB2MkSnpqGP8wXGOhoZbsv1FhLKOK098B8wV/3xIukgLLCIgWlGMoP5lspCTGS6wfYJdHsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391221; c=relaxed/simple;
	bh=+LZc9sH1FCeBixh1w4vXv6wQcF1lRDxb/ilDg7ghLhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FicflmfnslndAfEfzgzlfNV4/asrqRLbzcsWrKPBCLPrHXfGOO9wqGOsxhY+mNOr0NTWOwGjVr+2T7U4yjfrXRjlT5YAK0vkeq0kVSZprrwguJlWdwPjHIk42s30I7XYpkvxakGekqC6l5pRLVDJols1HqIynXcffQm9cXv3Yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+xFP6nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD91EC4CEF1;
	Mon, 22 Dec 2025 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766391220;
	bh=+LZc9sH1FCeBixh1w4vXv6wQcF1lRDxb/ilDg7ghLhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+xFP6nK0qe53POnY7jjyszn3iOUZuinw6ZqS6AJsoqWcuZII35RkzQ7YGVYI1xeK
	 LQE264oNB8kS+JJ5I3UO561Y3JAxbMY/Zf5Vi3PjC7YxsXnP/dPk+0tWsSiMPcd732
	 /olnqcnrwQ6tECTPRewTAgLaNLMGayFaJi8zIzSAmQAG8ZzZuW+5VQmFraNq2XDYE/
	 oHRotrUO1oKqgjF1gSLrHo2x7YcBsUUyGzXES/pEXpIT/lxGg6TJ2AStLzGOzjSvRE
	 0JTBn7ixNl1imKBUIDCPicOnAe5qbaF4/hzD6C1QAZidh6OB6uCAWY6P8ZjyYQddYh
	 oX2BxKQQyK2+g==
Date: Mon, 22 Dec 2025 09:13:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 tony.luck@intel.com, bp@alien8.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com, Michael.Zhao2@arm.com,
 linux-efi@vger.kernel.org
Subject: Re: [PATCH 03/12] ras: add estatus vendor handling and processing
Message-ID: <20251222091334.5cb8465f@foz.lan>
In-Reply-To: <20251219181226.2859763-1-ahmed.tiba@arm.com>
References: <euhams5heiuaawxq4e5ty7iijuvwt5gvdx3flsm4npligjeulq@lv3cwekyb2o2>
	<20251219181226.2859763-1-ahmed.tiba@arm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Fri, 19 Dec 2025 18:11:54 +0000
Ahmed Tiba <ahmed.tiba@arm.com> escreveu:

> On Fri, Dec 19, 2025 at 04:30:40PM +0100, Mauro Carvalho Chehab wrote:
> >On Fri, Dec 19, 2025 at 02:49:02PM +0000, Ahmed Tiba wrote: =20
> >>
> >> On Wed, Dec 18, 2025 at 05:04:53PM +0100, Mauro Carvalho Chehab wrote:
> >> =20
> >> >> Teach the estatus core how to walk CPER records and expose the vend=
or
> >> >> record notification path. This adds the section iteration helpers,
> >> >> the logging helpers that mirror the GHES behaviour, and the deferred
> >> >> work used to hand vendor GUIDs to interested drivers. No users swit=
ch
> >> >> over yet; this simply moves the common logic out of GHES so the next
> >> >> patches can wire it up.
> >> >>
> >> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com> =20
> >> >
> >> >...
> >> > =20
> >> >> +static bool estatus_handle_arm_hw_error(estatus_generic_data *gdat=
a, int sev, bool sync) =20
> >> >
> >> > Huh?
> >> >
> >> > This is a CPER record from GHES. Why are you moving CPER code out
> >> > of ghes.c, placing in a file named estatus.c? Doesn't make much
> >> > sense on my eyes...
> >> >
> >> > Same applies to to other GHES CPER record types. =20
> >>
> >> GHES still fills in the CPER record, but the parsing and logging logic=
 is
> >> shared with the new DeviceTree provider so I pulled those helpers into=
 the
> >> estatus core. =20
> >
> > I see, but this is not really estatus core. Instead, it is part of GHES=
 CPER
> > handling logic, which is defined at ACPI and UEFI specs. moving it to e=
status
> > sounds odd, at least on my eyes.
> >=20
> > Perhaps I'm failing to see where at ACPI/UEFI specs how CPER would be
> > integrated with an OpenFirmware approach to handle CPER without GHES.
> > Care to point to the relevant specs, if any? =20
>=20
> ACPI/APEI (via GHES) defines how CPER records are discovered and notified=
 on ACPI systems,
> but there is no ACPI or UEFI-defined equivalent for OpenFirmware/DeviceTr=
ee platforms.
> UEFI standardises the CPER record format itself, not the transport or dis=
covery mechanism.
>=20
> On non-ACPI systems we still receive the same UEFI-defined CPER payload
> from firmware, but Linux needs a different, platform-specific contract
> to locate and acknowledge it. The DT binding is a Linux-side description
> of that contract rather than something defined by ACPI/UEFI.

That's where I'm failing to understand: CPER is part of UEFI spec, and
the only deliverable mechanism I'm aware of for CPER is via GHES or
GHESv2 - e.g. via ACPI.

Within the scope of https://uefi.org/specifications, I'm failing
to see any other deliverable mechanism.
=20
> >> Both providers already call into the same notifier chain and
> >> memory-pool helpers; this patch just moves the generic CPER walking ro=
utines
> >> next to the rest of the common code so the DT path doesn=E2=80=99t hav=
e to grow its
> >> own copy. If you=E2=80=99d prefer a different file layout or naming to=
 make that
> >> intent clearer, I=E2=80=99m happy to adjust. =20
>=20
> > Moving the code from ghes.c to estatus.c or to elsewhere shouldn't make=
 any
> > difference, as the DT handling logic could simply be calling the functi=
ons
> > from ghes.c (or estatus.c). I fail to see why they need to be moved. =20
>=20
> The motivation is to provide a shared implementation for non-ACPI provide=
rs,
> so that the DT path does not depend on ACPI/APEI.
>=20
> While the helpers currently live in ghes.c, they are CPER-specific and do=
 not rely on ACPI tables,
> APEI infrastructure, or GHES notification semantics. Keeping them there e=
ffectively makes GHES
> the only place those helpers can live, even though the logic itself is pr=
ovider-agnostic.

The logic is related to GHES, as this seems to be the only standardized
mechanism to report CPER records. As it is part of APEI, get_maintainers
points to the people that have been maintaining it as:

	$ ./scripts/get_maintainer.pl -f ./drivers/acpi/apei/ghes.c
	"Rafael J. Wysocki" <rafael@kernel.org> (maintainer:ACPI APEI,commit_signe=
r:6/13=3D46%)
	Tony Luck <tony.luck@intel.com> (reviewer:ACPI APEI,commit_signer:3/13=3D2=
3%)
	Borislav Petkov <bp@alien8.de> (reviewer:ACPI APEI,removed_lines:5/62=3D8%)
	Hanjun Guo <guohanjun@huawei.com> (reviewer:ACPI APEI,commit_signer:4/13=
=3D31%)
	Mauro Carvalho Chehab <mchehab@kernel.org> (reviewer:ACPI APEI,authored:1/=
13=3D8%,removed_lines:6/62=3D10%)
	Shuai Xue <xueshuai@linux.alibaba.com> (reviewer:ACPI APEI,commit_signer:5=
/13=3D38%,authored:2/13=3D15%,added_lines:56/218=3D26%,removed_lines:34/62=
=3D55%)
	Len Brown <lenb@kernel.org> (reviewer:ACPI)
	Jonathan Cameron <Jonathan.Cameron@huawei.com> (commit_signer:5/13=3D38%)
	Breno Leitao <leitao@debian.org> (authored:2/13=3D15%,added_lines:38/218=
=3D17%)
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> (authored:2/13=
=3D15%,added_lines:103/218=3D47%)
	Ankit Agrawal <ankita@nvidia.com> (authored:1/13=3D8%,removed_lines:6/62=
=3D10%)
	Jason Tian <jason@os.amperecomputing.com> (removed_lines:7/62=3D11%)
	linux-acpi@vger.kernel.org (open list:ACPI APEI)
	linux-kernel@vger.kernel.org (open list)

Moving it elsewhere would make it confusing, as the expected deliverable
mechanism for CPER is via GHES - as this is the only one defined at the
uefi.org specs.

While it might be moved to EFI and placed under cper.c,=20
get_maintainers.pl would point to:

	$ ./scripts/get_maintainer.pl -f ./drivers/firmware/efi/cper.c
	Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE=
 (EFI))
	linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
	linux-kernel@vger.kernel.org (open list)

which is not the people that have been maintaining RAS.

Placing it under a "estatus.c" file would make it completely
dissociated with UEFI/ACPI specs, as this name means nothing at
the specs.

Also, adding a new maintainer's entry won't make any sense, as the
people that currently reviews and maintains GHES/CPER records
should be kept.

> By moving the CPER parsing and logging pieces into a common location,
> both GHES and the DT provider can reuse the same implementation,
> while the ACPI-specific discovery and notification code remains under dri=
vers/acpi/apei/.
> This avoids having the DT provider reach into GHES internals or duplicate=
 CPER handling code.

As Boris mentioned on patch 00/12, we need to better understand
the high level scenario, as it is still not clear to me how a
firmware-first notification would happen without ACPI.

> If the current naming or file layout makes that separation unclear, I=E2=
=80=99m happy to adjust it.

Thanks,
Mauro

