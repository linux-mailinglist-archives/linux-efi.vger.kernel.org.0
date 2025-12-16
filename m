Return-Path: <linux-efi+bounces-5877-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDA4CC0579
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 01:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9444B3011424
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033B227B95;
	Tue, 16 Dec 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uud8KB6A"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A315E97;
	Tue, 16 Dec 2025 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844514; cv=none; b=L19TxetvYlNfSy19YIOcEaXyFNGY13bqWNNLvOzE9E3hAOtkFJVwt/A/iuYBFOTZopTSWlJyxRKAXN9VpE5dC7BRyMZ1LlWPzHbkY54RcjfT24fwKell3Y5fNPH8iD2LEJSwVFx91vD4oTj0EIM44VpoCORWboeoGfU8WbrmDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844514; c=relaxed/simple;
	bh=z7MdUNUaRKCiy4iD/ii8h4a2sO4D40lQOJuu8ZMUmQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRCoepjXgPXh1TW5E4dbwWItxK6VhlvUkbPAsuHnRE4aBmINnBFmR8fWhtQ7jF89qe9+PKGV6XWmO3qj1kBZhAFDpgf+AnfaFiSZWhlO8dihZoUPXe8LfZuVsrF4O+cbD4MUI4OKAXVwL7D+P/bOj9yjIhHSe8N2CzI3AzdSD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uud8KB6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898EFC4CEF5;
	Tue, 16 Dec 2025 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765844514;
	bh=z7MdUNUaRKCiy4iD/ii8h4a2sO4D40lQOJuu8ZMUmQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uud8KB6Aa9O+kjvVpEhb/RRnDZ1AX3q5MyR0beQMzjcU6yg3C2ZPUijntGDpl4DBX
	 bczgXj3m//LaoOfshv2kGIAS/E3PV+sj+NUnvieTwslTqTZF6fC02v2cQ0QI3YMIsM
	 1OP7fv+6MwXr91COlAR5qHh3CdZxjf9ExeRszHX78BNS+054yM2fcHMLGxHNl31aSN
	 AqF2KEm9f+Drd/oM6g+0X5UGXtTJvVg4dKPJcG2Y9wqHoxX8cMPOUbCZWWjZfFGaGj
	 JfMGJE7SqkAt1AJsjrAlEyl4V+1uYefx7Qr8jLpw1/+R/NCfeKMv47bnzFEgyTiDbz
	 /qkUhaSSuSVLw==
Date: Mon, 15 Dec 2025 16:21:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 17/28] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <20251216002150.GA11579@quark>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-18-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-18-ross.philipson@oracle.com>

On Mon, Dec 15, 2025 at 03:33:05PM -0800, Ross Philipson wrote:
> diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
> new file mode 100644
> index 000000000000..dd1b4cf5caf5
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sha1.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Apertus Solutions, LLC.
> + */
> +
> +#undef CONFIG_CRYPTO_LIB_SHA1_ARCH
> +#include "../../../../lib/crypto/sha1.c"

CONFIG_* options shouldn't be undefined like this.  It seems that you're
trying to build the SHA-1 code into a pre-boot environment.  This
problem was already solved in the SHA-256 code, by making
lib/crypto/sha256.c aware of __DISABLE_EXPORTS.  The SHA-1 code should
use the same solution.

- Eric

