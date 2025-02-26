Return-Path: <linux-efi+bounces-2829-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF039A46043
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 14:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F473A8FCD
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DC1891A9;
	Wed, 26 Feb 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="s8eQwiR/"
X-Original-To: linux-efi@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCC13EFE3
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575363; cv=none; b=TgudnToaT6fdoCMQJNDm7SecU+vn9f3lMyteXH2IXZHJ8SRoHfj1hGc7OI0f5BENkI+UrU71p+4f4rHPblN3W1row0D6RpuvkebSBpAwVcphANym/pVEUWmB4Rp3g9lspIsGprxKXg54LJXvduAib94Ia2czRUrT/qxH4BAks+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575363; c=relaxed/simple;
	bh=uIyUSljdr0K6UKjsNEAZbjqRMbXyoWohlgLxxYRx7U0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uu++iFNS1J58wBOawaZSsaoKmQOhBbZH4xLqA3ySH8MankGFduowwPIhgXZbUiMd+pO9fiTtjEgM7Y/MDvkkhOCh44XizXiKfyT5cKGhFUNvlw4AyZyy4lWay7kqiF2iR70FdV9jO/Jtgu9DCwKKcoQIYPa3/VLHNpGLi2Wo5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=s8eQwiR/; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740575360;
	bh=uIyUSljdr0K6UKjsNEAZbjqRMbXyoWohlgLxxYRx7U0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=s8eQwiR/zshf4DGXMvOWWefMQac+jGO2rKDXNhA6u7rmWqqPZHYTC0VFwAtAtMefx
	 cy/5lWlKZdONcPuzAZwJUg78Z/urr1TnLF8K6SAvQopHnnRFPfcVBCfUsfyxjTN4Bw
	 Zkx1aPCUD5oPn6TixUL7PGZc9ZzB+rK9hSCOjebM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 565BF1C0871;
	Wed, 26 Feb 2025 08:09:20 -0500 (EST)
Message-ID: <4c60f747aaffe1b0323ec5103cdb32ab19c3b04d.camel@HansenPartnership.com>
Subject: Re: efivarfs: fix error on write to new variable leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Richard Hughes <richard@hughsie.com>, linux-efi@vger.kernel.org
Date: Wed, 26 Feb 2025 08:09:19 -0500
In-Reply-To: <CAMj1kXGsZVAWmG7NV+6fevvZy6RwEXrw2avT1EBRWjn5Kk_hvw@mail.gmail.com>
References: 
	<SBFUY-p4-fI9JOrQa51x141vKHs_rbFLw4q9kfPGAK8Z76PQfgYl6zM3nUjlOeIPY6PgEhqLFaSJkW0vdBVzET3MDYUBZwzmYCJuNK4TaYU=@hughsie.com>
	 <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
	 <CAMj1kXGsZVAWmG7NV+6fevvZy6RwEXrw2avT1EBRWjn5Kk_hvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-26 at 12:30 +0100, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2025 at 13:59, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > Reading the code in the fix, it looks like you were creating a file
> > in EFI (which is naturally zero length), then closing it (because
> > glib gio specifically has an API for this), then clearing the
> > immutable bit and then writing to it to actually create a variable?
> > 
> > However, none of that dance is at all required.  A newly created
> > file naturally allows writing on the file descriptor you used to
> > create it. It's only if you open it again that the entry becomes
> > immutable.
> 
> Should we be doing this in the first place? It makes sense for
> efivarfs to mark variables that it doesn't know about as immutable if
> they are present at boot - the original rationale here was systems
> with buggy firmware, where an inadvertent 'rm -r
> /sys/firmware/efivars/*' would brick the device.
> 
> But the fact that a newly created file becomes immutable once you
> close and reopen it seems unnecessarily strict to me.
> 
> (I am aware that this is orthogonal to the issue at hand, but it is
> something we might fix nonetheless)

Well, I've always thought it was silly ever since it was introduced:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed8b0de5a33d2a2557dce7f9429dca8cb5bc5879

The rationale it was because root could brick their system by doing rm
-fr never made any sense, since if root is going to do rm -fr they're
asking to become unbootable anyway.

All of us who have code that manipulates the variables simply added
remove immutable flag code like the above.  If it does get removed,
efivarfs will still need to respond to get/setfsxattr though to make
sure that code keeps working, so it can't be a clean revert.

Regards,

James


