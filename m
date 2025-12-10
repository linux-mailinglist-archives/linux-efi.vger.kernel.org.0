Return-Path: <linux-efi+bounces-5832-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 649AFCB3247
	for <lists+linux-efi@lfdr.de>; Wed, 10 Dec 2025 15:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529DB305DCE0
	for <lists+linux-efi@lfdr.de>; Wed, 10 Dec 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3DA325716;
	Wed, 10 Dec 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXJgZksj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912F20322;
	Wed, 10 Dec 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376937; cv=none; b=f/W+6mz8TCP4cUMfRvrhBzYlfNJ8MWIC093grX/9qQPRzcJhRhSG/kmBp6gl6WvoZYbvpRwE6nDbDnMVRnvzarYgzqcmCTRbarz3MakeRSafeNR494lyIXUDdF3g1hquju94Af8KJijQj6iNWIAKHAK8BJUXcbuajSXiMyqvzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376937; c=relaxed/simple;
	bh=rs7Zm6Eb/PerDF++V1IWbmjjyxCKVx6NvRgn6xqSwyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJmFaUZKhMfNF+WaPaqK1kDlBMI/zsupYrshuIDfodxDuev5Zb1FtYVTLpRmsbxbL09PbX0eGd3X7jVwLSgqi/BV5cvjB/SVd15QryW6RCELUvvHzEVZaqtcjD5Tyc8YJGiHoja3jnXD3+amUjiSocB/RHqlpvJxxULr8A/zGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXJgZksj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FAC4CEF1;
	Wed, 10 Dec 2025 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765376936;
	bh=rs7Zm6Eb/PerDF++V1IWbmjjyxCKVx6NvRgn6xqSwyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXJgZksjYvt7/XUU2cBx52SDmjJzLtrixnIv4BAJSvqj2XU84yM418/G8vSsStGcw
	 jMg6Dns9dmfATITxLqLLuuaVuWPVEA1h4cFl2MsqTsXsOYmoKtf3U0rVi73w1hAZWr
	 3pFFtPEPyod6VUIWlrrH2oG8Kay3Q1Zo/Rkr16l6z9N1bp9Iry1hYc5u2wwy/lhq9R
	 MpvWeDu+7Hpweb2Ie7b8b6Gxb13IcN/r93gR4HsVIi8Ug3qfizzDn3ZTK5v/pvdYXz
	 UYknXDVZpA990jNLFdQ8tLvx8lBOFLySTTru5PNV5xxeFtMNgtzTCf32k9VIgjnjd+
	 fuoRAqWU3ryVA==
Date: Wed, 10 Dec 2025 06:28:56 -0800
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Val Packett <val@packett.cool>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-hardening@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	oliver.sang@intel.com
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars
 ops
Message-ID: <202512100627.8B2915C87@keescook>
References: <20251203042850.14210-1-val@packett.cool>
 <202512101632.a94de49b-lkp@intel.com>
 <CAMj1kXGfTNQcX-hoAy63PNU_-eb03LJLYmQGXvBB3SsGM+e1hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGfTNQcX-hoAy63PNU_-eb03LJLYmQGXvBB3SsGM+e1hA@mail.gmail.com>

On Wed, Dec 10, 2025 at 06:13:17PM +0900, Ard Biesheuvel wrote:
> On Wed, 10 Dec 2025 at 17:41, kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_kernel/locking/rwsem.c:#__down_write_trylock" on:
> >
> > commit: 6f473fefec79a8ba24013a5676a93934ee5ac922 ("[PATCH] efi: pstore: Support late setup with TEE-backed efivars ops")
> > url: https://github.com/intel-lab-lkp/linux/commits/Val-Packett/efi-pstore-Support-late-setup-with-TEE-backed-efivars-ops/20251203-123406
> > base: https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/pstore
> > patch link: https://lore.kernel.org/all/20251203042850.14210-1-val@packett.cool/
> > patch subject: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
> >
> > in testcase: boot
> >
> > config: i386-randconfig-015-20251207
> > compiler: clang-20
> > test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +---------------------------------------------------------+------------+------------+
> > |                                                         | b692553573 | 6f473fefec |
> > +---------------------------------------------------------+------------+------------+
> > | WARNING:at_kernel/locking/rwsem.c:#__down_write_trylock | 0          | 18         |
> > | EIP:__down_write_trylock                                | 0          | 18         |
> > | WARNING:at_kernel/locking/rwsem.c:#up_write             | 0          | 18         |
> > | EIP:up_write                                            | 0          | 18         |
> > +---------------------------------------------------------+------------+------------+
> >
> 
> This seems to be a non-EFI boot, in which case the notifier chain is
> never initialized.
> 
> Kees, can you drop this from your branch so we can get it fixed? I
> also had some review feedback that hasn't been taken into account yet.

I didn't take it -- this appears to be patch-based 0day randconfig. (I'd
rather it went via EFI anyway, too.)

-Kees

-- 
Kees Cook

