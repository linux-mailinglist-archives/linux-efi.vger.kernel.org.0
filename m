Return-Path: <linux-efi+bounces-528-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D848552A5
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 19:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0783B289FA
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31113A860;
	Wed, 14 Feb 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxwE+IaQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47657138488;
	Wed, 14 Feb 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936545; cv=none; b=G2ukOuCbhvDdLCwE+oSi6fitSLc9TJnd0SXMALr+XbPtPqFD8fTKaHYM+IwKCFe2+lEXcS+dMFfCvTiqVHND6QGizPkI//u+Fw4O+C4hktkOlnVak8Et3Fstb2knQZ6u2unMOKvIEOEWXJX3gyAfDQ6f8Tc3bjDodaR2rHWT+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936545; c=relaxed/simple;
	bh=CGCI+ays+bSdN67l7c5rVd9uV736XGKDr50F41/4vY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtNt6MvPOV6DBbww/9+KZNou5KNAH0t24SdDW0WJvMN+qmuXIkRibJPca3KqKNOIPGG9FtMwiLjWGiRDoBeUUhjkIBsLvCMTF6rES8PGQ0RP+ZvaEZb6Q3MOCtn+2YM9YY+nITMuvG5cALprwZBZGPCuVEylNekimhjIdjnrqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxwE+IaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F86C43390;
	Wed, 14 Feb 2024 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707936544;
	bh=CGCI+ays+bSdN67l7c5rVd9uV736XGKDr50F41/4vY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxwE+IaQ8XZ/UP2IumLnClE9+YUKEMSBHvYUUNAvtBcq08HnHxA6QWYXt1Uqww2/S
	 tTA/B9+a2YnT1ux0INYgiAXrHMMD2zfLsoGbTYMPMJQrKd6wdwxJJ7dhXazTxtGKt/
	 SJ0TiLDw+XiyqG3hDZttZGHh4K7HzETHhdMK0WUywKvzE2NIrR1d3zPGKWx6mwbq6Y
	 aKJFnvIPm4zystN1azztn5J3KoSlsQKwhRhShVHZihmcvxrWLyb8i52ZTWaBWNZc9a
	 b7VXpsp/1tMvMpTiYZOJoh5CEXVD21q3mL9/Fnd0Z3v/RZVUkOlf0609gS/EvTVt17
	 zJdDxn2S+pd8A==
Date: Wed, 14 Feb 2024 18:48:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
Message-ID: <20240214-stable-anytime-b51b898d87af@spud>
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xFR+xkhlg19+nOVS"
Content-Disposition: inline
In-Reply-To: <20240212213147.489377-4-saravanak@google.com>


--xFR+xkhlg19+nOVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 01:31:44PM -0800, Saravana Kannan wrote:
> The post-init-supplier property can be used to break a dependency cycle by
> marking some supplier(s) as a post device initialization supplier(s). This
> allows an OS to do a better job at ordering initialization and
> suspend/resume of the devices in a dependency cycle.
>=20
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++++++
>  MAINTAINERS                                   |  13 +--
>  2 files changed, 108 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/post-init-supplier.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml b/=
Documentation/devicetree/bindings/post-init-supplier.yaml
> new file mode 100644
> index 000000000000..aab75b667259
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020, Google LLC. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Post device initialization supplier
> +
> +maintainers:
> +  - Saravana Kannan <saravanak@google.com>
> +
> +description: |
> +  This property is used to indicate that the device(s) pointed to by the
> +  property are not needed for the initialization of the device that list=
s this
> +  property.

> This property is meaningful only when pointing to direct suppliers
> +  of a device that are pointed to by other properties in the device.

I don't think this sentence makes sense, or at least it is not easy to
parse. It implies that it can "point to" other properties too - but
that's not the case. It is only valid to "point to" these suppliers.
I'd drop this entirely.

> +
> +  A device can list its suppliers in devicetree using one or more of the
> +  standard devicetree bindings. By default, it would be safe to assume t=
he
> +  supplier device can be initialized before the consumer device is initi=
alized.

"it would be safe to assume" seems odd wording to me - I feel like the
default is stronger than "safe to assume". I'd just drop the "would be
safe to assume and replace with "is assumed".

> +
> +  However, that assumption cannot be made when there are cyclic dependen=
cies
> +  between devices. Since each device is a supplier (directly or indirect=
ly) of
> +  the others in the cycle, there is no guaranteed safe order for initial=
izing
> +  the devices in a cycle. We can try to initialize them in an arbitrary =
order
> +  and eventually successfully initialize all of them, but that doesn't a=
lways
> +  work well.
> +
> +  For example, say,
> +  * The device tree has the following cyclic dependency X -> Y -> Z -> X=
 (where
> +    -> denotes "depends on").
> +  * But X is not needed to fully initialize Z (X might be needed only wh=
en a
> +    specific functionality is requested post initialization).
> +
> +  If all the other -> are mandatory initialization dependencies, then tr=
ying to
> +  initialize the devices in a loop (or arbitrarily) will always eventual=
ly end
> +  up with the devices being initialized in the order Z, Y and X.
> +
> +  However, if Y is an optional supplier for X (where X provides limited
> +  functionality when Y is not initialized and providing its services), t=
hen
> +  trying to initialize the devices in a loop (or arbitrarily) could end =
up with
> +  the devices being initialized in the following order:
> +
> +  * Z, Y and X - All devices provide full functionality
> +  * Z, X and Y - X provides partial functionality
> +  * X, Z and Y - X provides partial functionality
> +
> +  However, we always want to initialize the devices in the order Z, Y an=
d X
> +  since that provides the full functionality without interruptions.
> +
> +  One alternate option that might be suggested is to have the driver for=
 X
> +  notice that Y became available at a later point and adjust the functio=
nality
> +  it provides. However, other userspace applications could have started =
using X
> +  with the limited functionality before Y was available and it might not=
 be
> +  possible to transparently transition X or the users of X to full
> +  functionality while X is in use.
> +
> +  Similarly, when it comes to suspend (resume) ordering, it's unclear wh=
ich
> +  device in a dependency cycle needs to be suspended/resumed first and t=
rying
> +  arbitrary orders can result in system crashes or instability.
> +
> +  Explicitly calling out which link in a cycle needs to be broken when
> +  determining the order, simplifies things a lot, improves efficiency, m=
akes
> +  the behavior more deterministic and maximizes the functionality that c=
an be
> +  provided without interruption.
> +
> +  This property is used to provide this additional information between d=
evices
> +  in a cycle by telling which supplier(s) is not needed for initializing=
 the
> +  device that lists this property.
> +
> +  In the example above, Z would list X as a post-init-supplier and the
> +  initialization dependency would become X -> Y -> Z -/-> X. So the best=
 order
> +  to initialize them become clear: Z, Y and then X.

Otherwise, I think this is a great description, describing the use case
well :)

> +
> +select: true
> +properties:
> +  post-init-supplier:
> +    # One or more suppliers can be marked as post initialization supplier
> +    description:
> +      List of phandles to suppliers that are not needed for initializing=
 or
> +      resuming this device.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +      items:
> +        maxItems: 1

Rob's bot rightfully complains here about invalid syntax. What you
actually want to enforce here is any number of device phandles, but
these phandles all contain only the label and no indices etc, right?

> +
> +examples:
> +  - |
> +    gcc: clock-controller@1000 {
> +        compatible =3D "vendor,soc4-gcc", "vendor,soc1-gcc";
> +        reg =3D <0x1000 0x80>;
> +        clocks =3D <&dispcc 0x1>

This clearly was never tested, Rob's bot warnings aside. You're missing
a ; at EOL here and with the other clock below.=20

Cheers,
Conor.

> +        #clock-cells =3D <1>;
> +        post-init-supplier =3D <&dispcc>;
> +    };
> +    dispcc: clock-controller@2000 {
> +        compatible =3D "vendor,soc4-dispcc", "vendor,soc1-dispcc";
> +        reg =3D <0x2000 0x80>;
> +        clocks =3D <&gcc 0xdd>
> +        #clock-cells =3D <1>;
> +    };

--xFR+xkhlg19+nOVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0LGwAKCRB4tDGHoIJi
0pU/AP93C04kIYnkbEXW1OLHWZ7dAqt6T3xeM0PBndtH5wGHMQEAgIOFjmmWMsIQ
yFU5JXHBJmUbzI9DltuGAst0sbo7Hgw=
=daBO
-----END PGP SIGNATURE-----

--xFR+xkhlg19+nOVS--

