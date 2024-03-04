Return-Path: <linux-efi+bounces-712-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3F870395
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 15:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E473282A9D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9CE3FB29;
	Mon,  4 Mar 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaxBuQMZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0643FB1D;
	Mon,  4 Mar 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561210; cv=none; b=UymyO6BlxVAmrOYefayKuQsZFPaYumIp6ov87LCVNdQdNfoELLe48ClXYjm/HARc8Y3If+W6pdT/uniXOZ5bqjkIEBrfU9q0x0bynh/jcWUve+A+lRDSy1we8v3Pg718C/QD1aznE/75hBE0KvayvnEvTQ1AiJdMS+DcwRBMOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561210; c=relaxed/simple;
	bh=xPL76FHS6HJ3s8ync8Ft9aXKhFA0XZzDoh4MMW7HTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzcfRM9/oFXnyUhJvEM87IrrnrbIZjnsbx2pPoKczUcuZOjycDT5sZZ7IKw1cBUP/fuasRwZDw7l3MVpAyP38YBXomEsbZIRU1WOlmS0JT5XbK1ajpKn7d7Fx/eM9vu+NWz3rKDzM3X37dtci+eCxR6XvuS1BAbXDG2sfc6iu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaxBuQMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240FCC43143;
	Mon,  4 Mar 2024 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709561209;
	bh=xPL76FHS6HJ3s8ync8Ft9aXKhFA0XZzDoh4MMW7HTYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaxBuQMZPL708GUjbD43Ki86fiVubj9E5DaxUUAuIa+trp6r0+/5td1d5FOqNwcJv
	 O2XhNtt/0b4+UhYXHEKzU9H1xnRu5WfIrimL5iDZ/OpgPS+rHIygqh0sKDWpf+OU/6
	 cyVRdRpNqKYKdoBaN+No1tB+kHlBCLUu2l7FZ3s1su0gt7p/xzh6SeH1VQx+wVMwxh
	 HqyhMw9DcRNjMm4Lvi732rPbwGScSPlvXVMf79su3xuHEt3JjiwId8zyjeaDCG+uwI
	 7UEcTBVH7IRT84PO1G4+yvZDLSWfCHSD0zs7eGgxn7ObW9DVgeMnKX7e9M2ytZPgsR
	 xHTxhadBnE7Zw==
Date: Mon, 4 Mar 2024 08:06:47 -0600
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add post-init-providers binding to improve
 suspend/resume stability
Message-ID: <20240304140647.GA148861-robh@kernel.org>
References: <20240222034624.2970024-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222034624.2970024-1-saravanak@google.com>

On Wed, Feb 21, 2024 at 07:46:18PM -0800, Saravana Kannan wrote:
> This patch series adds a "post-init-providers" device tree binding that
> can be used to break dependency cycles in device tree and enforce a more
> determinstic probe/suspend/resume order. This will also improve the
> stability of global async probing and async suspend/resume and allow us
> to enable them more easily. Yet another step away from playing initcall
> chicken with probing and step towards fully async probing and
> suspend/resume.
> 
> Patch 3 (the binding documentation) provides a lot more details and
> examples.
> 
> v3->v4:
> - Fixed MAINTAINERS file to go with the file rename.
> 
> v2->v3:
> - Changes doc/code from "post-init-supplier" to "post-init-providers"
> - Fixed some wording that was ambiguous for Conor.
> - Fixed indentation, additionalProperies and white space issues in the
>   yaml syntax.
> - Fixed syntax errors in the example.
> 
> v1->v2:
> - Addressed Documentation/commit text errors pointed out by Rob
> - Reordered MAINTAINERS chunk as pointed out by Krzysztof
> 
> Saravana Kannan (4):
>   driver core: Adds flags param to fwnode_link_add()
>   driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
>   dt-bindings: Add post-init-providers property
>   of: property: fw_devlink: Add support for "post-init-providers"
>     property

Reviewed-by: Rob Herring <robh@kernel.org>

I'm assuming Greg takes this. You'll probably need to resend without the 
binding. Submit it to dtschema please.

Rob

