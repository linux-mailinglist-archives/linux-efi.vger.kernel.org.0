Return-Path: <linux-efi+bounces-631-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F185EDEB
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 01:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66DC284F84
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 00:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DD8BE8;
	Thu, 22 Feb 2024 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXJQW0/B"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F4A35;
	Thu, 22 Feb 2024 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561386; cv=none; b=g1msZsXWupRhm2fn+JL9diatdP+tNO6L6F6rdgR8frHH2VdpVAFVvNKxjTfhu+4zHG1U8mrxRF9kzfgRcVk3TZ1rftlOeTE2ZYu+bDQOVqHP0CNRkgLtpjJG++deMrrrz2+vELfYHPDCoHjCPCKq5+IcCGMWYdWDDnHK4zjwQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561386; c=relaxed/simple;
	bh=eUWPi2XweW42m5sudJBaw7LCj+SQtvsiVFN93Jf+Jgg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=mrDBYhQ3TWYkk5GXKs5/nh0RmJhW8lLAZgS1NqWPT/hcZ4Wh4b1z493xjjIb6893odjoupEf0M/g5cFMKzCLvM8msfJ6eP9C1VikbJv0g8P2GbqqQLYpTLcD+gkAhisQVT+hgCxRokSlEtWlCj63/CXN268iR7XxlUqqq8m937E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXJQW0/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD9DC433C7;
	Thu, 22 Feb 2024 00:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708561386;
	bh=eUWPi2XweW42m5sudJBaw7LCj+SQtvsiVFN93Jf+Jgg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NXJQW0/BrFNtBUe9GuH3ljh6EoHVSUAeDxJFN3aX+8OMHd1RQwkogjQTHeTsreqC9
	 E3rAFb4R6LLLsHq8hHhJHaUbFUCM9MvkcCMR1ce4Zw8wAovi1EPYzWaTfGSZTExeTL
	 BXOIF1a6EULI5Oi5te88SXGIEAkt5DEvdgDzgOLCaNy4c+c1yLqg7OXQxO30X8J+TX
	 ZiWeL2aCSrIkBPfabz+z4dqXvTOu4zZ+8Ce6TnsJ2XvwvStfN2z4yd27pEz05TPsmm
	 cfFVRKGteQ4NGcWB7zB3LURn1nbHxG8STiKtyeSpMT+zgvp55rYAuyUv9aKJxyUA3W
	 7WW8HeDDVRxmw==
Date: Wed, 21 Feb 2024 17:23:04 -0700
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, kernel-team@android.com, 
 linux-efi@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
In-Reply-To: <20240221233026.2915061-4-saravanak@google.com>
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-4-saravanak@google.com>
Message-Id: <170856138383.540970.12743608676098316685.robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: Add post-init-providers property


On Wed, 21 Feb 2024 15:30:23 -0800, Saravana Kannan wrote:
> The post-init-providers property can be used to break a dependency cycle by
> marking some provider(s) as a post device initialization provider(s). This
> allows an OS to do a better job at ordering initialization and
> suspend/resume of the devices in a dependency cycle.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
>  MAINTAINERS                                   |  13 ++-
>  2 files changed, 112 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/post-init-providers.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@1000: failed to match any schema with compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@1000: failed to match any schema with compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@2000: failed to match any schema with compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@2000: failed to match any schema with compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/post-init-supplier.yaml
MAINTAINERS: Documentation/devicetree/bindings/post-init-supplier.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240221233026.2915061-4-saravanak@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


