Return-Path: <linux-efi+bounces-514-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77441852147
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 23:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F261C21D86
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4C84D9F8;
	Mon, 12 Feb 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC6faghg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB14D5BA;
	Mon, 12 Feb 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776238; cv=none; b=s7QMwkGjidk5OdUyADbFYaZfU+3FKJymHC6LqWhqrwr6BKSzWhHCboEdFDcd6ia+IciBNoOoPljgMe8QcYBxYcQt73vfOZdZqxT8muc7uFBr2LIlbvL100z4VdAKlUtGgZFTTXRmtwEz0E8ifLJoONbsga6RLeKqkZsHACWG+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776238; c=relaxed/simple;
	bh=a6uWx2pOU/OPfI6mfvFI1nNygrviHWQu38BsJoU3WL8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=uiUCeyIIqZnwnOnCyUbG0hfCZBlb0WByi7P+X4GphNatEbxjh23FGkzq0TG7BIQl8p21qgxiWvAAQIgcIcszxXMlVBrsoTgpEYNu4ova0tcUbtz+NNikWPGl8eLzL1L9jrbGQbb7w7/1Pkomew1ziuM9W9h5UIe31Z4cpuQbdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC6faghg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE775C433C7;
	Mon, 12 Feb 2024 22:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707776238;
	bh=a6uWx2pOU/OPfI6mfvFI1nNygrviHWQu38BsJoU3WL8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GC6faghgqHlSd4t9ygiawwHv2PtJIEyp5bcSzDkCUjNl+Mm+vDKsDm+RO36BsT5tm
	 fQSWTsqALLFm4j4iC4IlNx8ofx/vLe+xUhHFGjCKUJwXVej8+hqmqGwDGBwpwOeQLz
	 gnADzL7yp1nZnfpwMh+7z8ey1AWKn1YkzRaZIf4HX4b9J05rBLG/tXOndFc01RsRGx
	 FNbiKz260xUKaoEOMsh2LKG8RiVvG5aSfAf68JSQTz+sFdURAIC0pPR5b5sqOzwr2j
	 8Vx9x4n6KsrsiyeVjdwbhqXJKjvBHTYfa7o6oC9Ikk5fVm8m4+mNWCXZbxF6OunRNC
	 HxaoUMrUlKILg==
Date: Mon, 12 Feb 2024 16:17:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: linux-efi@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, Frank Rowand <frowand.list@gmail.com>, 
 linux-kernel@vger.kernel.org, kernel-team@android.com, 
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 linux-acpi@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
In-Reply-To: <20240212213147.489377-4-saravanak@google.com>
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
Message-Id: <170777623558.2654155.17686339859837179281.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property


On Mon, 12 Feb 2024 13:31:44 -0800, Saravana Kannan wrote:
> The post-init-supplier property can be used to break a dependency cycle by
> marking some supplier(s) as a post device initialization supplier(s). This
> allows an OS to do a better job at ordering initialization and
> suspend/resume of the devices in a dependency cycle.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++++++
>  MAINTAINERS                                   |  13 +--
>  2 files changed, 108 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/post-init-supplier.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/post-init-supplier.example.dts'
Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/post-init-supplier.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/post-init-supplier.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240212213147.489377-4-saravanak@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


