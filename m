Return-Path: <linux-efi+bounces-4396-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D38B07F9C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B617689C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB229B772;
	Wed, 16 Jul 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xv3we7Yu"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225A296141;
	Wed, 16 Jul 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701367; cv=none; b=ghq0jVYcv7i0wHK1R8GyBmda36RIeSjcFxcR6kVAZfuB89u3oc2pRFwc9CKyUw+Lm/9aLpy9AQ/BDoexmvykaTKuOZAih2/+ljF+BurpkPWlRBomcEZ6hehROWMFdc3zAKksL0Uj4cp3vgAt/NMQM8JHXUW23HpdI68F6UQx8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701367; c=relaxed/simple;
	bh=c236qv4fi2S1BQktSI+b1jq0ameaanhtvAO7pdQAco8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtFiCLka5wppw/e8SOHoEAtgmjjNsHkZcLdJnJBxjGGOsK9yIEWsUHuDAxNObhilfXGv8MaZYk8db7dP+A4IlsRGeNzJBlqjjpgV7dgWIKsRjmU/n/00838imvsNhkv3Dv9LK6iO6p+24iHBp8mDnZAHTjM8tHht+OJzctTbQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xv3we7Yu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 6CF71211580C; Wed, 16 Jul 2025 14:29:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CF71211580C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752701365;
	bh=RKMf9p6mMMkwdxaPqp/9o52yYa90tQ4MT8vHSN4XKqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xv3we7Yu04gJW7e793PKMmN2O6k8jbfZJGq1B0M9haILknTHBAWjxZYo+NXhezHCT
	 wJRqurr8rn6gUePsfo5ytND/Fjyumb09+KPqM1Z+MfMjEvbUVmC1x4xlXX8FE5ET1a
	 p0BqCuhqfVhz8SMmR7rKsWrQmu0B1yDPXPWjp9Uo=
Date: Wed, 16 Jul 2025 14:29:25 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] Secure Boot lock down
Message-ID: <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Ping?

On Thu, Jun 26, 2025 at 03:10:37PM -0700, Hamza Mahfooz wrote:
> All major distros have had carried a version of this patch-set
> out of tree for sometime now, but with a bunch of magic (typically
> sprinkled in setup_arch()). Though we can avoid those architecture
> specific quirks if we call efi_get_secureboot_mode() from
> efisubsys_init() and that allows us to have a generic solution.
> 
> Hamza Mahfooz (2):
>   security: introduce security_lock_kernel_down()
>   efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
> 
>  drivers/firmware/efi/Kconfig  | 10 ++++++++++
>  drivers/firmware/efi/efi.c    |  9 +++++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  8 ++++++++
>  security/lockdown/lockdown.c  |  1 +
>  security/security.c           | 15 +++++++++++++++
>  6 files changed, 44 insertions(+)
> 
> -- 
> 2.49.0

