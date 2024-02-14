Return-Path: <linux-efi+bounces-529-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65065855300
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809C51C2126C
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF09013A860;
	Wed, 14 Feb 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsxoVIFd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84B171A2;
	Wed, 14 Feb 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938037; cv=none; b=KqpnnvSA90BO7xbY+pGc7P+iKri5y0CqemOhOygojEFYA9hIGk3gdE/z1MOLztHkpGbXIDPhvf+kpFRsD+n4OlANesrIMS4UF06V+OuWR0JxGY2l/3E1b0OYJlvGvYCPvoLaN76LTOnDpkQQFYmaYWNFrWzGKRCKSChcWlOeuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938037; c=relaxed/simple;
	bh=2h5BfRmGTY9n7Y2yzZd3yjGkBXp1UeuXXBTE1xv0r8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWokXOTi4lNyMDFM1gRMmlladGyg+YOCJkNScTl1U1vP/yuef+fbOmFBz3ffpO9ImqgdlKje8j/n6tI3nGZa1DJaYtaspOHFZI+eZ4ZWhal3AswAJj+bbfOXUCG2EWpslPih1TMZsqfuZD3MN/thZfiyoj6sdYl+9z9rH+kFFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsxoVIFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE237C433F1;
	Wed, 14 Feb 2024 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707938037;
	bh=2h5BfRmGTY9n7Y2yzZd3yjGkBXp1UeuXXBTE1xv0r8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsxoVIFdP9/Lw8KV6evO4VEF4HyAEY/I+rOCxdu4bmWbTkBvKDgoY2UmPOnUoopem
	 CNNY+MpzHFcKZR8ZLUSsPLauy4eDfPpfY6hJmC6bsKtt/eqo89XuD6f5Cgp2Q7LYfm
	 YhuWALZBFeXsNbW0tKow3otbFQLUACzEhvH1bQ2LMEvBTQb4j9fM7OACPIVlTwtR5R
	 rbzR9Bit+NBb+VZ/1wKYghmOS2NzQ1rxi6lCrXnuHHellvfDh+duQgJClyJ69B74MS
	 Kw9xeC70Hv3X92OE694gc32nCpglO1Zhzi+ozyphvjSVtSmvlkjTsxlZRtTweB+dK2
	 v/p+jVLbNbT1A==
Date: Wed, 14 Feb 2024 19:13:51 +0000
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
Message-ID: <20240214-paradox-lining-387df67842eb@spud>
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ga/ylhVRuzIrSHgn"
Content-Disposition: inline
In-Reply-To: <20240214-stable-anytime-b51b898d87af@spud>


--Ga/ylhVRuzIrSHgn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 06:48:59PM +0000, Conor Dooley wrote:

> > +  post-init-supplier:
> > +    # One or more suppliers can be marked as post initialization supplier

Also, this should likely be pluralised, to match "clocks" "resets"
"interrupts" etc.

> > +    description:
> > +      List of phandles to suppliers that are not needed for initializing or
> > +      resuming this device.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +      items:
> > +        maxItems: 1


--Ga/ylhVRuzIrSHgn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0Q7wAKCRB4tDGHoIJi
0o6yAQCn+Yeqh7KiSBuQXm/qbP6ixeqfhiNoyTXK3AjFQZwSdAD/TFE1/Hw4fiFO
Wb2RRaPzNPElghkWVu6qlYuSQtgAoQg=
=55O+
-----END PGP SIGNATURE-----

--Ga/ylhVRuzIrSHgn--

