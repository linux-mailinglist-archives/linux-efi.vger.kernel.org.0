Return-Path: <linux-efi+bounces-504-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A985042C
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 12:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F381F240B8
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4973D560;
	Sat, 10 Feb 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qucSb+pY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00623D55A;
	Sat, 10 Feb 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564593; cv=none; b=AAv9pnU8JM4ShVIETa8X+npszwiFm3d/XNPlS/3scXoMyk+vYsxpnaDbJsGu+9wsLhQ3U1da/vyqwKNioJfwV5gS+qWTwrd7J2D2ZD/W4LGy+xXlplD2ghzYQAYW1HjSk45qhQSBohb7oXZk+bAld3fRyWubZwvVAp7H0Sp6YeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564593; c=relaxed/simple;
	bh=V7/xsHrNll/p9LOmntS6P/UbHtp6CG2rRaw2C+prrh0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JxC/PdRxpr2YHMvDpRmWJTHLT5Oq04jBPUqgi1jCe17RLYN25WFqsJAyyvKKqXqXz/VdMD6RuarAdZImrJxWrwY7cTddIOb/vTXgkT0RQJWqUQKEl/V5KzhiKYVk2TF8+PH1Ut3virheFvlNv3NiFw1cowxegq5C2aG1oBl0DFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qucSb+pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CA6C43390;
	Sat, 10 Feb 2024 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564593;
	bh=V7/xsHrNll/p9LOmntS6P/UbHtp6CG2rRaw2C+prrh0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qucSb+pYrPD+oUekwIxOw7002LPguyTtJw/W1gs9klHgzi7x2S0R4V8TjwIzbuQxV
	 af7X9OEnajY6vCYpzRaJtXPg8KPq6wliQAPxXpKXss2ZKbODHkyGTMrAXOZQ0R8H2u
	 oSDMHNG4yl7DSnJLqDHp9v/+5Y9KxGAXHPxDjo1bLwkx9Pu30AAoiJ4qE8trTqWryB
	 XmQYte+10z267NpeMaLrYIExhXl3ciaf7F3rLexW71skPue1KMFOd6GYlsVIpNjaM+
	 szHoLpwkgdJ9OQt9+CK/Eju56alfmlP87IR6l5Xk8XEylOD3Be6Bm7oG2fu0gNc7JP
	 Tn6N5fUdUH8sg==
Date: Sat, 10 Feb 2024 11:29:51 +0000
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
Cc: linux-kernel@vger.kernel.org, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Len Brown <lenb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com, 
 linux-efi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240210030549.4048795-4-saravanak@google.com>
References: <20240210030549.4048795-1-saravanak@google.com>
 <20240210030549.4048795-4-saravanak@google.com>
Message-Id: <170756458599.4188768.15835380781477026047.robh@kernel.org>
Subject: Re: [PATCH v1 3/4] dt-bindings: Add post-init-supplier property


On Fri, 09 Feb 2024 19:05:46 -0800, Saravana Kannan wrote:
> The post-init-supplier property can be used to break a dependency cycle by
> marking some supplier(s) as a post device initialization supplier(s). This
> allows the kernel to do a better job at ordering initialization and
> suspend/resume of the devices in a dependency cycle.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../bindings/post-init-supplier.yaml          | 99 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/post-init-supplier.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/post-init-supplier.yaml: properties:post-init-supplier:minItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/post-init-supplier.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Error: Documentation/devicetree/bindings/post-init-supplier.example.dts:22.13-14 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/post-init-supplier.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240210030549.4048795-4-saravanak@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


