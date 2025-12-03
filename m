Return-Path: <linux-efi+bounces-5787-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F54C9FD55
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 856EF300ACC9
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194432ABC7;
	Wed,  3 Dec 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="crSCjQ2S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF7328634;
	Wed,  3 Dec 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777571; cv=none; b=cLIM4lXbXqtaee7NRNOw70sKq7PwlTiLF5gISHcqMAvSBbYY8JWDfmcugn9Om3Xoa3lxSf70+tajqrav9TuKyqbJjwKG9P1MvHnrfiiKiGfeUmHSAw6RW1hqxKUXe5QyEPKYB6uKVLl+psQazaYYYhAGhdqS14fdXIiGC/pGF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777571; c=relaxed/simple;
	bh=+dMlgfhc1y2JgHqa/1Ixp3iQdNQ6nOCRMLFaKiiDH7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZGJY5CN/0jU/yx9M3iXRA7Zy29EbdVd5i87jU14gwZpoktUI5xj8Y07UUFy/1VyQrKIEIHEFs7wGgmIeLzMG30179b5XN+PnWBGYXeRvxZeSyo06g/e3+WUaxtAhjkQn+bfIt//JvOT9kgS9HAr14q12AbmHDGKH9bwBlhLdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=crSCjQ2S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 22B0D40E01C5;
	Wed,  3 Dec 2025 15:59:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Jm55s75WWJiM; Wed,  3 Dec 2025 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764777560; bh=5A837UYz/VXEyuk8nnXqBwp73570xZNtO/JfT35421A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crSCjQ2S+J5/iynhJFk9UKihxfc38IfS+Fw+h6iRq/8LXSIwi0PZJv90R4g8/MXGW
	 r1ElmDKHkg1pX+OL1QKumUlyGktBGz40dSSxRhkFBLj1hpWXkgd0tPY3EeSvi2Ffe9
	 R3JRQPSIIRI0DANEw+Up2ZSazhClnbnkhEvRkFjwYJbUlH2gJfbG9kvBfPXjzaUoLK
	 RhDCGgQilS7jERyuWw9D4yM7BMjgs23Ye5kGOeTnUa1EGDCxkXBvUXZtrfkAoBNubc
	 N505u3BhpJqlSR0GY0AL4khjQaOyO5Ea4hjoOOOG7j8GH1+w8PUeQtbmg2Vr/IVVyp
	 1/BXb8LWqonyqZuD7Esuq8mevHplKYNoKJT06Zx/p9Hb658j7QxfrHqYYLjeQ6SrMN
	 6Z60gQPxB274MQBcIMxuX3BBMX0lhZo0oMKeFDOD1fyoWeGAnB7ROl7b3YQAdjF8sv
	 +D10Y9nVLzwhtMg/imH01R63OYEUQ4ZsprkebseeDMOADdpNbVFA1J7zwSlE+Xgd98
	 +eWs+zJITIYNjpKW7NPZJdc0PhBJ/sT4mzgw8BzGPs8d+b7yBPGvj9iMK7CW9eqcZy
	 Zw66QQpJ0prNo05BiJ95trN9iDyyqRDq/ZSmJlY02J9oZ4zgA3tYkV14xYeUuZKFZv
	 DPfpr37J1otrYUf6UajKmiXo=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C409040E0191;
	Wed,  3 Dec 2025 15:59:02 +0000 (UTC)
Date: Wed, 3 Dec 2025 16:58:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, ardb@kernel.org,
	"Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org,
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	akpm@linux-foundation.org, osalvador@suse.de,
	thomas.lendacky@amd.com, michael.roth@amd.com,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <20251203155855.GCaTBeP8fQDLx3T0X8@fat_crate.local>
References: <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
 <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
 <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
 <dcccdc4b-b7d7-47c4-b1b1-a6c70edb20fa@kernel.org>
 <20251201202507.GFaS35o7WtLJOM0_jh@fat_crate.local>
 <420865fb-34cc-43a8-820c-b15b5f24a27c@kernel.org>
 <etd7r45wmnuoftpckrzkzithr443ru6akgwqjgzw2vgmzqi7cs@camfecdmef74>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <etd7r45wmnuoftpckrzkzithr443ru6akgwqjgzw2vgmzqi7cs@camfecdmef74>

On Wed, Dec 03, 2025 at 02:46:23PM +0000, Kiryl Shutsemau wrote:
> There is also the #1 Kernel Rule: "we do not break users."

Do I need to point you to that too:

Documentation/process/stable-api-nonsense.rst

?

> Booting a different version of the kernel is a core functionality of
> kexec. It is widely used to deploy new kernels or revert to older ones.
> Breaking this functionality is a show-stopper for most, if not all,
> hyperscalers.
> 
> This specific change may not be a show-stopper as CoCo deployment is not
> widespread enough to be noticed yet.
> 
> The notion that nobody promised that you can kexec into a different kernel
> is absurd. It is used everywhere.

Dude, can you please stop handwaving and say what you really wanna say: you
want different kernels to kexec. And it has worked so far but nothing
guarantees that. And we should all agree on some strategy going forward and
enforce it.

I don't care if different kernels can kexec or not. If I need to kexec, then
I simply build the same kernel.

So I'd take a patch which breaks that and when the submitter gets stopped by
you or someone else, I'll go tell him: "well, actually, I can't take your
patch because Kiryl said so but that's his opinion."

Do you see how absurd this is?!

Geez, I'm tired of typing the same shit over and over again on this thread.

Feel free to propose to make kexec'ing different kernels a rule and let's all
discuss it but let's stop this nonsense of what worked and so on. The kernel
gets complicated constantly, grows things here and there and without such
a rule, are you going to sit around and guard that kexec works?

Pfff.

> I am not involved in the deployment of CoCo VMs, but I don't believe it
> is specifically about CoCo or the kexec ABI. I think it is more about
> the boot protocol. Kexec is one way to boot the kernel.
> 
> Should we consider the EFI configuration tables format as part of the
> boot protocol?

You're basically proving my point: this needs to be discussed and agreed upon.
It doesn't matter if it used to work implicitly in the past.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

