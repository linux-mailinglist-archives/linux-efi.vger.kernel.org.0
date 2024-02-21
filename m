Return-Path: <linux-efi+bounces-620-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C149985E755
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489591F22DC6
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F5785C69;
	Wed, 21 Feb 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOHByhzS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2783A06;
	Wed, 21 Feb 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544060; cv=none; b=S7k5iRBS7gPr6FFc3bzUGJk/eoF3i8IeTlXKrJCzorkmeEVGsCONjzf3HOM0YADUNEmUqL9eX2J85cHzEWFmzHRWVU1sikUI892iwZE6DNLZrjHF2X9GqrFhx4iRa3I5n1tLDuAm5jOgrNgt7vx2a33AmnSgGZaEWUwRMw2GBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544060; c=relaxed/simple;
	bh=sXa5dPwz8bX/os8/Ajvudq3p1HLKGVCbEjjsuMeVa5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgN2jxUv2y3RGSZUFhjKr9GsFWctXdEzFahrIZjxyaWGDfWlZSFaWtSDSUMX8Wic/sfUxRzIicwD0U9CjSozM/URmtgenTW47PJuy5NeS4ZF2wYclis378iLMkf1p99InnjzgG/DxG94fhym2Kc7y4KMLLvdgg3KYMMX6aQglIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOHByhzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA81FC433C7;
	Wed, 21 Feb 2024 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544059;
	bh=sXa5dPwz8bX/os8/Ajvudq3p1HLKGVCbEjjsuMeVa5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOHByhzScvU/U0TCoTIQTNO5d3/UV2yM9PwLvGTv35mTJpxaGtM+G+RdDlJL53puo
	 QYfMCCRjV8YrCpDvU+bdh8Wb24/aAvFRyea6WmIceRG17LO/LlsquvUkVKk39XtJXD
	 YVt37gKZGq5efvojR20BnMmOS4eDcPTx/ZRYSgtVeceR+gkDoioXuDmixB0OAWf4vz
	 t0rMDee6yY5N4h42osps466yGwZywfH9RyZiMsNpPnk7rugdSBWh9h1uqgwXVlKYOm
	 nKXarH0nNjLI4ltp9t2LtGgcZ4xOuF1JY2DoELiDNTgtedT2t4RSVwFXnuKtw/aaZ7
	 4SO24rSgbzwtw==
Date: Wed, 21 Feb 2024 19:34:12 +0000
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
Message-ID: <20240221-emblaze-ripeness-7ad4e41343fa@spud>
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud>
 <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
 <20240215-unstirred-rearrange-d619a2524a63@spud>
 <CAGETcx8EBta8dUSELUJ6_ibZABnnhSYX0VEGa8s-CbHFYuskkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pLmCPIAdI0+mCq/J"
Content-Disposition: inline
In-Reply-To: <CAGETcx8EBta8dUSELUJ6_ibZABnnhSYX0VEGa8s-CbHFYuskkQ@mail.gmail.com>


--pLmCPIAdI0+mCq/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 08:13:31PM -0800, Saravana Kannan wrote:
> I made that fix and now I'm getting this:
> $ make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/post-init-suppliers.yaml
>   DTEX    Documentation/devicetree/bindings/post-init-suppliers.example.dts
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-suppliers.yaml:
> 'oneOf' conditional failed, one must be fixed:
>         'unevaluatedProperties' is a required property
>         'additionalProperties' is a required property
>         hint: Either unevaluatedProperties or additionalProperties
> must be present
>         from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /mnt/android/linus-tree/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml:
> ignoring, error in schema: properties
> /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-suppliers.yaml:
> ignoring, error in schema:
> /mnt/android/linus-tree/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml:
> ignoring, error in schema: allOf: 0: then: properties: pinmux
> /mnt/android/linus-tree/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml:
> ignoring, error in schema: properties: lantiq,data-rate-bps
> /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-supplier.yaml:
> ignoring, error in schema:
> /mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml:
> ignoring, error in schema: properties: honeywell,pmax-pascal
> /mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:
> ignoring, error in schema: properties: honeywell,pmax-pascal

>   DTC_CHK Documentation/devicetree/bindings/post-init-suppliers.example.dtb
> Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> /example-0/clock-controller@1000: failed to match any schema with
> compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
> Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> /example-0/clock-controller@1000: failed to match any schema with
> compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
> Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> /example-0/clock-controller@2000: failed to match any schema with
> compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
> Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> /example-0/clock-controller@2000: failed to match any schema with
> compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']

FWIW, I don't see these or the other errors you see above. You really
need to get yourself a newer version of dt-schema, or else avoid
working on this using whatever castrated system google provides you with!

> But I guess the "oneOf" error is because the yaml is being treated as
> a description of a DT node and not a schema?

The oneOf is due to missing "additionalProperties: true" - As far as I
understand you need that regardless of whether this is going into
dt-schema or the kernel.

--pLmCPIAdI0+mCq/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZQNAAKCRB4tDGHoIJi
0g3HAQDpIe4M9otvSpLROV6Ux41ghNaHIm5e1Qhx4Q295ZxF3QEAodiz/FUXPees
zSZSMDf2CLnO5KDtqoIy8tOHjOqzMw0=
=9UjH
-----END PGP SIGNATURE-----

--pLmCPIAdI0+mCq/J--

