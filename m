Return-Path: <linux-efi+bounces-2830-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67FAA462D0
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EBC177006
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A822170B;
	Wed, 26 Feb 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b="HvKK5eBr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4022.protonmail.ch (mail-4022.protonmail.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9892222AC
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580086; cv=none; b=PY9T4X/qLoi5KhCpX9jIm5uGChgdA/TU3h73KIc7fKKF+WQRwB43H2KCU7WmA8/zVf3aKSHG2zKyE27y68XhEzi/bbzk1tdFdBwLgjOcnYPLNHEeokE4td+jiP0ML42dUawKOSyWuBIITxZNjS4tnvfU8IKrGw2zopgVr462nNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580086; c=relaxed/simple;
	bh=UkzS8/j0EF+ZpsnCWDoKKd9UmMOsQt3K1CInLN7sSo8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7wceVDUNx8qw6AQlpf6wdZwh6DP5pe67dmmPUMJIpuStyeY2cRK8AYn+1A3DiQjuNqwtj+C2rTkfKzC1QsWTo69kka1RoFOMk4XHoKNBHNXBcwXmqfEx5OssHKqnZf88OyoxvFQ0dJppUCy5be7b2kU2NXQjUw1rynm87x4dus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com; spf=pass smtp.mailfrom=hughsie.com; dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b=HvKK5eBr; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hughsie.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hughsie.com;
	s=protonmail2; t=1740580075; x=1740839275;
	bh=UkzS8/j0EF+ZpsnCWDoKKd9UmMOsQt3K1CInLN7sSo8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HvKK5eBra76BffNFhQLAWcXzs7gB2NcP29PgUXsHctvYPE3Lws0sBzPSrsBz3qZLe
	 pfZNFI6l4t4SXEwbaXgQX9GKUveg0VKLHf9zv0HxRfeOdErefWyWqENmCrjfU7IUh+
	 SMw5v6+pCOohFigANcncBWyHM+uUqvadcGM7HwKZlWNLLfdXxafxTrZrkrJ9K9qz+x
	 hy81VWTsk2Kf7l0rkNNvptAp3AmL19TRSyrjfiwlI7YRGwwd9RXbzVOrDIqKSWHouY
	 hfISKcczjLKuPoWMQETvEH5j5afxve2nLDKDI/ZV27Z0E0unUFilDxN7Pr9zWfjR3K
	 XMtSYCotQiL5Q==
Date: Wed, 26 Feb 2025 14:27:48 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
From: Richard Hughes <richard@hughsie.com>
Cc: linux-efi@vger.kernel.org, "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: efivarfs: fix error on write to new variable leaving remnants
Message-ID: <9ziS2HeSBUHZ8sb4nJ3yo6Jymg5oFq2sw3AAOXHFrtaa9YK8M9liyjvOCx4qMg-ga9AV2XaXTdRsA6WQykLHnF3PRq2uygywmyZ5-ItXgVM=@hughsie.com>
In-Reply-To: <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
References: <SBFUY-p4-fI9JOrQa51x141vKHs_rbFLw4q9kfPGAK8Z76PQfgYl6zM3nUjlOeIPY6PgEhqLFaSJkW0vdBVzET3MDYUBZwzmYCJuNK4TaYU=@hughsie.com> <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
Feedback-ID: 110239754:user:proton
X-Pm-Message-ID: 3acbd84e8507d2783365b36efa797d5172b222c6
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, 25 February 2025 at 12:59, James Bottomley <James.Bottomley@Han=
senPartnership.com> wrote:
> Reading the code in the fix, it looks like you were creating a file in
> EFI (which is naturally zero length), then closing it (because glib gio
> specifically has an API for this), then clearing the immutable bit and
> then writing to it to actually create a variable?

Correct.

> However, none of that dance is at all required. A newly created file
> naturally allows writing on the file descriptor you used to create it.

Yes, the original code was ported from libefivar iirc, hence why it's not e=
xactly idiomatic.

> It's only if you open it again that the entry becomes immutable. So
> your update has the correct logic: if file exists clear immutable and
> write otherwise add O_CREAT.

Agree.

> The change is rather embedded in a set of other fixes now. If we
> wanted a temporary and quickly removable work around for the current
> kernel, I think using i_size to signal whether the file is newly
> created and not written (0) or failed a write (1) and only removing the
> file if it failed a write might be a simple two line fix. That way we
> still keep the benefit of cleanup on a failed write while not impacting
> your pattern.
> Can you confirm this has that effect?

The fixup does seem to work so please feel free to add "Tested-by: Richard =
Hughes <richard@hughsie.com>" -- you can revert it after a few months if yo=
u like. It'll certainly take the pressure off, and we have a "known issue" =
we can use on the LVFS for people reporting problems: https://github.com/fw=
upd/fwupd/wiki/LVFS-Triaged-Issue:-Linux-6.14-efivarfs-regression

Thanks!

Richard.


