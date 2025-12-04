Return-Path: <linux-efi+bounces-5805-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C66CA5B27
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 00:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8664F3141E90
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F92C237E;
	Thu,  4 Dec 2025 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhRqa8Z3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3217A2E8;
	Thu,  4 Dec 2025 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764891368; cv=none; b=pwqZglK07XBzRfxYggda0EFCDDVuRwycvzqvWi7pg02KZyZJglTEXgcMo2pKjFbr9M6nGc8Zc+LXS49BmDXXHWLJCZH0LvQr7ZH0lrZqOef7JMjLytWw29yYS/pdOdRbwT1jgkwl77FrUn6p47sdTK42abCmJIAFOpQ7wN8oF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764891368; c=relaxed/simple;
	bh=vEFVMwXj0lb+m0V04SQmg1RCYw7+L+EZrawwV/I0unk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSgn2CpyNThBXzEG/DUU4YDwUGXlj5VUrp4jHVpW5ZaJnwpE07oxor/tdavMxd2aSthiXzI8gSQLhqiJ6wPzGDX2s7YZkbTLuSAy9G8/gdoPo+P0ggjPw0LSI/wmhozrgdi/XtWTRSyoJJ6q9vVBxOxRkFoZn9gv2NvKur8iP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhRqa8Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6609FC4CEFB;
	Thu,  4 Dec 2025 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764891368;
	bh=vEFVMwXj0lb+m0V04SQmg1RCYw7+L+EZrawwV/I0unk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhRqa8Z3xAOTiJZ3GBhTb6YZ2CEJVisi15c+G6PaoR85LyTpKNJbYAbl7AgIKF5Ao
	 3/vjc3C42ttKJIAzMBi2JiWb0mM4p1cMZR4vZtgfU0b11Jevdm1pl/xH8t9dVOs9ki
	 cuLVsPKn6PFOrZGolTGtVhqMCkbbgrrC4MvWnpatVEfGXe6DHl4/76Ae1U5DK6lIio
	 SX1VywW7mlo0znEWprjrp6qK/G8Uc1LloSUsX8FB/VzGe4hH/wQ62Ka8IsXROyK+3w
	 myoik1oU1ozXaE8I94ydL9gBDnk1yqwrA3KXDG6ZsebLvwxRzGaAYxFeG5ic2QpoNS
	 YO3fsiyx9AlhA==
Date: Thu, 4 Dec 2025 15:36:08 -0800
From: Kees Cook <kees@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars
 ops
Message-ID: <202512041535.AA6065A38@keescook>
References: <20251203042850.14210-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203042850.14210-1-val@packett.cool>

On Wed, Dec 03, 2025 at 01:28:29AM -0300, Val Packett wrote:
> On some platforms, EFI variable services only become available when an
> appropriate TEE driver is initialized such as qseecom, gsmi or stmm.
> 
> This would work fine when efi_pstore was built as a module and loaded
> late by userspace, but with CONFIG_EFI_VARS_PSTORE=y this driver would
> quit due to non-writable efivars before the necessary driver had any
> chance to load.
> 
> Listen to efivar_ops_nh notifications and retry the initialization when
> writable EFI variable ops become available.
> 
> Signed-off-by: Val Packett <val@packett.cool>

This seems fine to me, though I defer to Ard, who knows the EFI bits way
better than I do. :)

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

