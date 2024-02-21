Return-Path: <linux-efi+bounces-614-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B46C85DFBE
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097F0B23B9D
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59047EEE2;
	Wed, 21 Feb 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No2piR1T"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A647F48;
	Wed, 21 Feb 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525927; cv=none; b=YlSGEHUjN9bZCcTUKDjDToYcXH9LQxUCwVh2vcs188xI5JtRu35fsqHMNb8681scH7PuJKpHYTsEGuUtxXr9N0vqEWVzl8SQKReLMAlrKtP1J9m9yeBORv3z5de2R7w/UPk/CDkuziTMEDsPQXYOp27FGnmKuGIuesmiax3Huko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525927; c=relaxed/simple;
	bh=ETU59JMcllMSB/or4eosb1YfI1+Lc4q0wczytbrnDNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzgSSkKnH5CXNBd/xtzRKnGRqXQxrfxtH1dcEo830FDe8vLZEjq0Y8gS6cTSMlBpXP7OjMjNKmtjnrwJfWA9ONHB9i/Jsp7scoifSpvNe2xMIV+8Slu2VAKRttNQQub7jWFPemjadgUIx+h1hnxZBvFm3QUz6bUJV/8kDHtb+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No2piR1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160ABC433C7;
	Wed, 21 Feb 2024 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708525927;
	bh=ETU59JMcllMSB/or4eosb1YfI1+Lc4q0wczytbrnDNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=No2piR1TxZde8nJFFXemM2a3+zqfT436aGB+BMcjfAbgT7qoNeY3Ugzq2eYbu+wh7
	 +hwltOlGdL/UB4JE+TY8cLUBK8DpBP1uuFfW4MYCxZ1QEZ3+51k0b/t/2+G9iuwwDk
	 P5Itmhah8RpUWeJjtbXpSRe0mrC6qAZXUoTnutiVH1LtyKU32ARVkjr+AZNdB6o7c5
	 QG0YuXMGYeXL26sbnFcx9E0BAMmUG2NCS63m/IJZWdi/v704kE34N6ZNPx4dgUlof7
	 5a0BoTqhnE0SoLRWJs3vfmbuYmuDIJjDCT8o/3UF9qlg1ZqrsieGf1N67iw+04QylX
	 VI16bpwZCgZ/A==
Date: Wed, 21 Feb 2024 07:32:04 -0700
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Message-ID: <20240221143204.GA2773516-robh@kernel.org>
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213147.489377-4-saravanak@google.com>

On Mon, Feb 12, 2024 at 01:31:44PM -0800, Saravana Kannan wrote:
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
> diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml b/Documentation/devicetree/bindings/post-init-supplier.yaml
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
> +  property are not needed for the initialization of the device that lists this
> +  property. This property is meaningful only when pointing to direct suppliers
> +  of a device that are pointed to by other properties in the device.
> +
> +  A device can list its suppliers in devicetree using one or more of the
> +  standard devicetree bindings. By default, it would be safe to assume the
> +  supplier device can be initialized before the consumer device is initialized.
> +
> +  However, that assumption cannot be made when there are cyclic dependencies
> +  between devices. Since each device is a supplier (directly or indirectly) of
> +  the others in the cycle, there is no guaranteed safe order for initializing
> +  the devices in a cycle. We can try to initialize them in an arbitrary order
> +  and eventually successfully initialize all of them, but that doesn't always
> +  work well.
> +
> +  For example, say,
> +  * The device tree has the following cyclic dependency X -> Y -> Z -> X (where
> +    -> denotes "depends on").
> +  * But X is not needed to fully initialize Z (X might be needed only when a
> +    specific functionality is requested post initialization).
> +
> +  If all the other -> are mandatory initialization dependencies, then trying to
> +  initialize the devices in a loop (or arbitrarily) will always eventually end
> +  up with the devices being initialized in the order Z, Y and X.
> +
> +  However, if Y is an optional supplier for X (where X provides limited
> +  functionality when Y is not initialized and providing its services), then
> +  trying to initialize the devices in a loop (or arbitrarily) could end up with
> +  the devices being initialized in the following order:
> +
> +  * Z, Y and X - All devices provide full functionality
> +  * Z, X and Y - X provides partial functionality
> +  * X, Z and Y - X provides partial functionality
> +
> +  However, we always want to initialize the devices in the order Z, Y and X
> +  since that provides the full functionality without interruptions.
> +
> +  One alternate option that might be suggested is to have the driver for X
> +  notice that Y became available at a later point and adjust the functionality
> +  it provides. However, other userspace applications could have started using X
> +  with the limited functionality before Y was available and it might not be
> +  possible to transparently transition X or the users of X to full
> +  functionality while X is in use.
> +
> +  Similarly, when it comes to suspend (resume) ordering, it's unclear which
> +  device in a dependency cycle needs to be suspended/resumed first and trying
> +  arbitrary orders can result in system crashes or instability.
> +
> +  Explicitly calling out which link in a cycle needs to be broken when
> +  determining the order, simplifies things a lot, improves efficiency, makes
> +  the behavior more deterministic and maximizes the functionality that can be
> +  provided without interruption.
> +
> +  This property is used to provide this additional information between devices
> +  in a cycle by telling which supplier(s) is not needed for initializing the
> +  device that lists this property.
> +
> +  In the example above, Z would list X as a post-init-supplier and the
> +  initialization dependency would become X -> Y -> Z -/-> X. So the best order
> +  to initialize them become clear: Z, Y and then X.
> +
> +select: true

blank line

> +properties:
> +  post-init-supplier:

'supply' is already used for regulators. Let's make it 
'post-init-providers'.

Rob

