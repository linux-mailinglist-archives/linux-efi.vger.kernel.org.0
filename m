Return-Path: <linux-efi+bounces-3807-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86151AC9E3F
	for <lists+linux-efi@lfdr.de>; Sun,  1 Jun 2025 11:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A8D17192C
	for <lists+linux-efi@lfdr.de>; Sun,  1 Jun 2025 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952119DF4D;
	Sun,  1 Jun 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gJKAYSlX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551931537C6;
	Sun,  1 Jun 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770792; cv=none; b=E4u+9dAeNyxpGbPpioExslDC9+wE9cCG24kqDOV4kjDzfonBDZnc/RInwKGmA1MuJFfFIDqNk+dzPnE7d7I/u9E971dD5i2RFEoXPqGmAncKRediSbM4krT7z8GHpldqrbgKeOTUAbQCp+l/QhSZVPtXlYtV9C38/fznENgfxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770792; c=relaxed/simple;
	bh=zhnLAjkDLdQPDGGvHLx808PY+0LFjWMMUUAJu368LkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd1jEDdZ505uVjY5B0f3Q3icyesz5yBiU8byjSTCzIdlX9DkMVfyMO/uWXtWsFjXr82kMXpPkN3xJli9aWV6WC3QtVU1B2kt7D8TOd3pwLxQ3x2ugf4900nVQDrUfGVc1QTRusjyESHVrHXf2rA4hz9FqyTK2Z8tGB61I5PFV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gJKAYSlX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2DBFA40E01B0;
	Sun,  1 Jun 2025 09:39:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fihqgO0-ENMQ; Sun,  1 Jun 2025 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748770784; bh=eeW/IR2znoSmGbeMAE4zO02Cqc0ZKtkTmQClsKZFXt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJKAYSlX3LYCmdMdqii3+t9RE7jDtbK8VuIsiqPNo/n2EgSQ9nK51nX8ZWScqjM9S
	 76D7fPWEdeobVxesdfPdegFzx1QIVs7GD+dhE4e/MYHsxVe7dG5e3B6LxJvkimIgq7
	 X+d/T2fDZYTF2tr2Lw9pG4lEBrqXkkVCYwof6GWJH8i/OnlKJ2DfZaWxDk3nHDlMBF
	 8X2o/bxJ68YCIJk/BbAZ3CG7tI944XNTmrKWFtdTuApOHzOyrLluCNbDMb2pVIerqZ
	 pFu28B6PUUQWy7/gm1TvS9uEDXVItmhTYoDssLD+5lTmHqXOFRv6JkhgKCfCWtCPdF
	 t22Hll3/oGsdyNSUFQcyJ4p2gtGeVU+vnFslnRIdIhHhFwetdH5jg5w9pii2HmPXO4
	 Pb44WR+IBi5qH3OObpupWpJdUP/5Rm2LzwVYHitZBwx6bbN64RtoHKZho+o9hvkkJE
	 LVimQz7zuLKK1V/5pH5IfvQeylvDftUCQmvLgFV8wpUIA5riPXD7zvYVKBvrLY+7Nv
	 wyCm4gmtSq0WeVJf+Di/ORFmAQ+QZnvPtMJKdl/KYWtkj5DxOZ8wMfKDnEwU3aKoSz
	 OkGXtTYBNpP4ob1SJ7VdzEsFNmSX3ZSVxC7K0UNKLbDHeCpBZlR6D4iA8ZpkhX4n4/
	 9FV4X5tI2rArDjestPRFv//o=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9A8240E015D;
	Sun,  1 Jun 2025 09:39:35 +0000 (UTC)
Date: Sun, 1 Jun 2025 11:39:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 20/21] x86/boot: Revert "Reject absolute
 references in .head.text"
Message-ID: <20250601093935.GCaDwf17sb5j7a99Qq@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-43-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-43-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:55PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> This reverts commit faf0ed487415f76fe4acf7980ce360901f5e1698.

Let's make that pretty:

faf0ed487415 ("x86/boot: Reject absolute references in .head.text")

Other than that, I guess the changes look ok modulo the comments I've made.

You could send a new version once the dust settles so that Tom and I can run
them on everything.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

