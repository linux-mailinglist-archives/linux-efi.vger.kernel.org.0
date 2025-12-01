Return-Path: <linux-efi+bounces-5743-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B15C98CF2
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 20:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00CC04E29C4
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F1239E9B;
	Mon,  1 Dec 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hFHgP5aT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DD21C17D;
	Mon,  1 Dec 2025 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616262; cv=none; b=NSeluxAeIiNYMMMavMZc5EtjgYak9u/nZe+QLxipiWHEzPNAIRUPAats8Px9Xy5LgUHiyeECWHudOv4Rc9XMB/FYW8giCKzso/T6qf+uLFMR9sxlxI2w6baItynG5SfT+v84wZ/ZMy5W/TB6VilLTIsfrG6bnuZYIiiFhCngZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616262; c=relaxed/simple;
	bh=JLHuEcPs9WDKmUX71yKWwrgVB32IBQmDy5LFT8tzAkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9S0AvCJ1Do9EW/Z10/QIb8B5qCTIRzV85qwH70ViJfj+4WzSnfFdvF+h/6vgdXOTPqNIiofHG/N7ovtDtcPSO9SoElJEu9fOtXpST1PPxxwe38rxc9kxWpTR5Sg06OEfXLnZFuYXjgzO6IJKWIlkti2CWyx0oQZW0WSUdqKXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hFHgP5aT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4085540E0250;
	Mon,  1 Dec 2025 19:10:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rJExDO_Sw0EC; Mon,  1 Dec 2025 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764616253; bh=CDLSW0ULC7fV+/6nJr9bGCnAS0M4/BaP2qnQFeyHNgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFHgP5aTyr+63EucuqjMPTsgEkr476XAmWkB7ouwdOpeO6lD+EHfTGjKk1oju7Xax
	 /nSihwUqydhbEZ2lilnJI90sx5ngOfaOMwYtUUsPdyPRnWcU0LCqHmZzAYPUjf48+p
	 ISt/5Uw1MNnAZ5+79krRIN8jzhPSTHD96Pn3lHUm1BvlH1vusAA6Ao6T2fJbKN5c7m
	 LnPp7beJ4qz9Ac/KY0R9BL9Up61PocDHWM/DBbEopy09bEb9I4Jo0Vy4hWpQU2moYk
	 ZgqFx2/XJ5VSDbYzI8a8UbX6IglDw6bhvPe7Neaas78ulrI/3z2BjG/q3eXfR7mZl4
	 i7hoXwSmJ8BV6n0v52C43eqFB0wFn/zIl/ZkNTxjkUVZ7BfPFflD6XvWMfTVM6Tfpi
	 5pn1whpqQoa1KOaUSzkWPNyeh2t3ACZBsAcKfUXjk8FsWhDO+lfJ5SJtLUYkXRCZZ7
	 czxDndKDjPgDzpRUMnVtiU9dW5lTa45WY95WmvQinLUEIpK/Rh4qN3H3H75CpP+EXN
	 T7Zr6VD7Xb6xpwFXWSuHo2Gxpxt7iPfgCxYS9eVKfzhUWw5SmSFhxcpZ/ojwUAQceG
	 H8W0Hyc63Zs/fj/leMn5TSP3RW9xbSZa4US5ond2t7MKRAaQOiqrjlzU3evr3FqF7K
	 9lBL64wAn/0+3O6jcZFfvD/k=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7350840E01A5;
	Mon,  1 Dec 2025 19:10:37 +0000 (UTC)
Date: Mon, 1 Dec 2025 20:10:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, "Pratik R. Sampat" <prsampat@amd.com>,
	linux-mm@kvack.org, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	akpm@linux-foundation.org, osalvador@suse.de,
	thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
References: <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
 <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>

On Mon, Dec 01, 2025 at 07:32:38PM +0100, David Hildenbrand (Red Hat) wrote:
> I think we are in agreement: from what I recall, this software contract used to be
> rather simple and stable.

Ok, please point me to the *explicit* document in our tree which says: "we
won't break the kernel and support kexec with any kernel version"?

Something ala Documentation/process/stable-api-nonsense.rst

Which says things like:

"Assuming that we had a stable kernel source interface for the kernel,
a binary interface would naturally happen too, right?  Wrong."

Which I read as a "no" to the kexec question too.

IOW, it is not about whether it works or not - it is about enforcing that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

