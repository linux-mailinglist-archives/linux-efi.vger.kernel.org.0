Return-Path: <linux-efi+bounces-641-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56485F0EA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 06:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1361B23B77
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 05:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295679D0;
	Thu, 22 Feb 2024 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB8rzZ4p"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316781C14;
	Thu, 22 Feb 2024 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579435; cv=none; b=bWDmnyqPkDbgDXx+xo8pTageheI4sjQrHQN6/PYtljFGb+zYGH5tod38K3y9gkaDp712S7GRR+IjnU3hKFVWQPOgAIpGh+o5FHHqj9RLLh+CDg0XBcx17LNf2fqNlzj+E/H0bH6gnasdo7nwWaAJwTY6f189c1eMCDlZzEwPI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579435; c=relaxed/simple;
	bh=oOyXXaM42M394k31mWSYzMIXwBXz0g5QPtbRtGpl334=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=D390IxaMACaRWYtQIzjoPT9spfRXsz3DuMeWwC3sw12eGnz+NR7eE+hLVYw9BxHY1bV3sRm0557yP3rDCceSy2YeNVLyYsdR/7NRW9udvwfru5mV1YI74oaOAnkTSsDtQ9rArJH9JGYMC2QVFWEoW9tOBew1DFGoQJ+CeyM0LL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB8rzZ4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7139FC433C7;
	Thu, 22 Feb 2024 05:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708579434;
	bh=oOyXXaM42M394k31mWSYzMIXwBXz0g5QPtbRtGpl334=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MB8rzZ4poIEv2PIzSdjhgHgCztPjWnhjitgxz8CtVroogptmQCCuzJtbFiVkaehdg
	 6I18tQogN516AL62cVl2MJ45tpxcO9AiQ1Zh1SqBv4VZiW1ItAL2G3zBJNbsPTV1Ed
	 L2UzQKuQqO9VA6UD4T8kh8aFvGZ6OQ5bs1eEXpeooCiRK9O4zBf4pFX2t/51eWv0Cg
	 SnAbAg9ZPXD4YiGpw9WlTh/OpI2VdMd3qWeaDn6UnmYQ6BzQy6yfHhrjOYB/Eka7oQ
	 BNWQ5RaGgLd7bIYKbHS0igveRzcrkDQ+/+X74wLSBJWEsd6uAVzHRcGq0mniE7d0xU
	 2leHNkHaKiJjA==
Date: Wed, 21 Feb 2024 22:23:53 -0700
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
Cc: Len Brown <lenb@kernel.org>, kernel-team@android.com, 
 devicetree@vger.kernel.org, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
 linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20240222034624.2970024-4-saravanak@google.com>
References: <20240222034624.2970024-1-saravanak@google.com>
 <20240222034624.2970024-4-saravanak@google.com>
Message-Id: <170857943207.1269080.12494800385688440904.robh@kernel.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: Add post-init-providers property


On Wed, 21 Feb 2024 19:46:21 -0800, Saravana Kannan wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240222034624.2970024-4-saravanak@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


