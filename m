Return-Path: <linux-efi+bounces-565-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9FC8562DC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933271C22A60
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9112C528;
	Thu, 15 Feb 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO0FWMqC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673012BF1A;
	Thu, 15 Feb 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999304; cv=none; b=GLWGKXncGgg5TM85K3fgq2ojqdtlEATDZzeVQxrhHWml+ZMPOo6ECwGsT2jipcwDBU7f8Q4Vk7r2OsD3BqPN+LQpCPLTyM+6DmrbuOJPHvCMGRVkOhvpUvIu9+NQ3EkvnPer55s/ArlhkUOpSI7loPjdYfRGdeG4ivmBx3a1pIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999304; c=relaxed/simple;
	bh=Tc4wU/g4DNNNgLDbCy7W8tZFgPFKKiWVxcYU/F/xr8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN8575LXjHewLKRmk18NlsY0HHiVjvUKXmAe8KaH6jFOJIOYZ/OsMIl+BoVCgHnwtu/TugCd5CcHzId1QEbI/sKN7esmrJwiqKGoGr6K4eazQj8d6TF/ED0iR7VX0VqO6Wbh+vhYAHihTIXindCB9aaKZRjmQgp0Uun2eSNeuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO0FWMqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F088C433F1;
	Thu, 15 Feb 2024 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707999304;
	bh=Tc4wU/g4DNNNgLDbCy7W8tZFgPFKKiWVxcYU/F/xr8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eO0FWMqCB2BusAQ9eQ5J2xVkma03slzKOOIFhkwXV+IxmMFHdTwoqZClnXM0Gq4Rb
	 PVrqeuWx+yhZxJjNo0fcRBv4UZUjOmiowW1CEmb9iAXgm9c7qBGt5mql7oWD4AxvQ0
	 yXFu8D3vnZusYA9DKdyeGMEf+e4hRGdoQyp9/ATE7oTJDLZmCJG4GB+7Eos1eiKEhk
	 TD4jECewqUj5UCHQdigME+9v2wwfp/5pCX13zlpnFKD7DAt0x3bfnbZElpq8V7Kj78
	 I6siofaI2HfZatrCKjnvrL6ZLOtSE4UnwIWWrxZTAOxzp3uCKJmfQI7TGv1jehmKmk
	 pfxp63kskas1Q==
Date: Thu, 15 Feb 2024 12:14:58 +0000
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
Message-ID: <20240215-unstirred-rearrange-d619a2524a63@spud>
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud>
 <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xcQKf6dpNeH1W3O+"
Content-Disposition: inline
In-Reply-To: <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>


--xcQKf6dpNeH1W3O+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 03:32:31PM -0800, Saravana Kannan wrote:
> Hi Conon,
>=20
> On Wed, Feb 14, 2024 at 10:49=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Mon, Feb 12, 2024 at 01:31:44PM -0800, Saravana Kannan wrote:
> > > The post-init-supplier property can be used to break a dependency cyc=
le by
> > > marking some supplier(s) as a post device initialization supplier(s).=
 This
> > > allows an OS to do a better job at ordering initialization and
> > > suspend/resume of the devices in a dependency cycle.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |  13 +--
> > >  2 files changed, 108 insertions(+), 6 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/post-init-suppl=
ier.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/post-init-supplier.yam=
l b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > > new file mode 100644
> > > index 000000000000..aab75b667259
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > > @@ -0,0 +1,101 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (c) 2020, Google LLC. All rights reserved.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Post device initialization supplier
> > > +
> > > +maintainers:
> > > +  - Saravana Kannan <saravanak@google.com>
> > > +
> > > +description: |
> > > +  This property is used to indicate that the device(s) pointed to by=
 the
> > > +  property are not needed for the initialization of the device that =
lists this
> > > +  property.
> >
> > > This property is meaningful only when pointing to direct suppliers
> > > +  of a device that are pointed to by other properties in the device.
> >
> > I don't think this sentence makes sense, or at least it is not easy to
> > parse. It implies that it can "point to" other properties too
>=20
> I don't see how this sentence implies this.

Because, to me, it reads as if you can put extra stuff in here that will
be ignored if not "pointed to" by another property. The word
"meaningful" is what implies that you can.

> But open to suggestions on
> how to reword it. I don't want to drop this line entirely though
> because I'm trying to make it clear that this doesn't make a device
> (that's not previously a supplier) into a supplier. It only down
> grades an existing supplier to a post device initialization supplier.

If you wanna keep it, I would just go for what you said in this
response - that this property does not make devices into suppliers and
is only to mark existing suppliers as post-init. I think that rules out
putting other devices in there.

> > - but
> > that's not the case. It is only valid to "point to" these suppliers.
> > I'd drop this entirely.
>=20
> >
> > > +
> > > +  A device can list its suppliers in devicetree using one or more of=
 the
> > > +  standard devicetree bindings. By default, it would be safe to assu=
me the
> > > +  supplier device can be initialized before the consumer device is i=
nitialized.
> >
> > "it would be safe to assume" seems odd wording to me - I feel like the
> > default is stronger than "safe to assume". I'd just drop the "would be
> > safe to assume and replace with "is assumed".
>=20
> Sounds good.
>=20
> >
> > > +
> > > +  However, that assumption cannot be made when there are cyclic depe=
ndencies
> > > +  between devices. Since each device is a supplier (directly or indi=
rectly) of
> > > +  the others in the cycle, there is no guaranteed safe order for ini=
tializing
> > > +  the devices in a cycle. We can try to initialize them in an arbitr=
ary order
> > > +  and eventually successfully initialize all of them, but that doesn=
't always
> > > +  work well.
> > > +
> > > +  For example, say,
> > > +  * The device tree has the following cyclic dependency X -> Y -> Z =
-> X (where
> > > +    -> denotes "depends on").
> > > +  * But X is not needed to fully initialize Z (X might be needed onl=
y when a
> > > +    specific functionality is requested post initialization).
> > > +
> > > +  If all the other -> are mandatory initialization dependencies, the=
n trying to
> > > +  initialize the devices in a loop (or arbitrarily) will always even=
tually end
> > > +  up with the devices being initialized in the order Z, Y and X.
> > > +
> > > +  However, if Y is an optional supplier for X (where X provides limi=
ted
> > > +  functionality when Y is not initialized and providing its services=
), then
> > > +  trying to initialize the devices in a loop (or arbitrarily) could =
end up with
> > > +  the devices being initialized in the following order:
> > > +
> > > +  * Z, Y and X - All devices provide full functionality
> > > +  * Z, X and Y - X provides partial functionality
> > > +  * X, Z and Y - X provides partial functionality
> > > +
> > > +  However, we always want to initialize the devices in the order Z, =
Y and X
> > > +  since that provides the full functionality without interruptions.
> > > +
> > > +  One alternate option that might be suggested is to have the driver=
 for X
> > > +  notice that Y became available at a later point and adjust the fun=
ctionality
> > > +  it provides. However, other userspace applications could have star=
ted using X
> > > +  with the limited functionality before Y was available and it might=
 not be
> > > +  possible to transparently transition X or the users of X to full
> > > +  functionality while X is in use.
> > > +
> > > +  Similarly, when it comes to suspend (resume) ordering, it's unclea=
r which
> > > +  device in a dependency cycle needs to be suspended/resumed first a=
nd trying
> > > +  arbitrary orders can result in system crashes or instability.
> > > +
> > > +  Explicitly calling out which link in a cycle needs to be broken wh=
en
> > > +  determining the order, simplifies things a lot, improves efficienc=
y, makes
> > > +  the behavior more deterministic and maximizes the functionality th=
at can be
> > > +  provided without interruption.
> > > +
> > > +  This property is used to provide this additional information betwe=
en devices
> > > +  in a cycle by telling which supplier(s) is not needed for initiali=
zing the
> > > +  device that lists this property.
> > > +
> > > +  In the example above, Z would list X as a post-init-supplier and t=
he
> > > +  initialization dependency would become X -> Y -> Z -/-> X. So the =
best order
> > > +  to initialize them become clear: Z, Y and then X.
> >
> > Otherwise, I think this is a great description, describing the use case
> > well :)
>=20
> Thanks! I always spend more time writing documentation and commit text
> than the time I spend writing code.
>=20
> >
> > > +
> > > +select: true
> > > +properties:
> > > +  post-init-supplier:
>=20
> [Merging your other email here]
>=20
> > Also, this should likely be pluralised, to match "clocks" "resets"
> > "interrupts" etc.
>=20
> Good point. Done.
>=20
> > > +    # One or more suppliers can be marked as post initialization sup=
plier
> > > +    description:
> > > +      List of phandles to suppliers that are not needed for initiali=
zing or
> > > +      resuming this device.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +      items:
> > > +        maxItems: 1
> >
> > Rob's bot rightfully complains here about invalid syntax.
>=20
> I added these two lines based on Rob's feedback. Is the indentation
> that's wrong?

Aye, both items: and maxItems: need to lose a level of indent. That
said, its not actually restricting anything. I fixed it up locally and
you can put as many elements as you like into each phandle and it does
not care. Maybe Rob can tell what is going wrong there..

>=20
> Yeah, I'm trying to run the dts checker, but I haven't be able to get
> it to work on my end. See my email to Rob on the v1 series about this.
>=20
> $ make DT_CHECKER_FLAGS=3D-m dt_binding_check
>=20
> The best I could get out of it is a bunch of error reports on other
> files and then:
> ...
> <snip>/Documentation/devicetree/bindings/post-init-suppliers.yaml:
> ignoring, error parsing file
> ...

Yup, that is about right, although you snipped out the actual complaint.

>=20
> I also tried to use DT_SCHEMA_FILES so I can only test this one file,
> but that wasn't working either:
>=20
> $ make DT_CHECKER_FLAGS=3D-m dt_binding_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers.y=
aml
> or
> $ make DT_CHECKER_FLAGS=3D-m dt_binding_check DT_SCHEMA_FILES=3D<path to
> the .patch file>
>=20
> Results in this error early on in the output:
> ...
> usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA]
> [--list-files] [-f {parsable,standard,colored,github,auto}] [-s]
> [--no-warnings] [-v] [FILE_OR_DIR ...]
> yamllint: error: one of the arguments FILE_OR_DIR - is required
> ...
> /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-suppl=
iers.yaml:
> ignoring, error parsing file
> ...

That is part of the actual complaint:

make dt_binding_check W=3D1 -j 30 DT_SCHEMA_FILES=3Dpost-init-supplier.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/post-init-supplier.example.dts
Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: mapping va=
lues are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/=
devicetree/bindings/post-init-supplier.example.dts] Error 1
make[2]: *** Deleting file 'Documentation/devicetree/bindings/post-init-sup=
plier.example.dts'
make[2]: *** Waiting for unfinished jobs....
=2E/Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: [error=
] syntax error: mapping values are not allowed here (syntax)
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
=2E/Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: mappin=
g values are not allowed here
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/stuff/linux-dt/Documentation/devicetree/bindings/post-init-supplier.yaml: =
ignoring, error parsing file
make[1]: *** [/stuff/linux-dt/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

--xcQKf6dpNeH1W3O+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc4AQgAKCRB4tDGHoIJi
0gSWAP4g3TLGh+wY0FKsFakQFJSPifJxulfw/CU74EjFhI2VjwD/Yd/uwOIF6xqC
/+IDsVS9bjy8O9dAMTjK4jkreqXg9Ak=
=yhK8
-----END PGP SIGNATURE-----

--xcQKf6dpNeH1W3O+--

