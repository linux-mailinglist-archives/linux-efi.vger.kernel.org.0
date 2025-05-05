Return-Path: <linux-efi+bounces-3608-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0421AA9E65
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3FC17D496
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124552741BD;
	Mon,  5 May 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9RkCZna"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5860270548;
	Mon,  5 May 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481873; cv=none; b=iFedVNfokuiM0UcUuJWjz+fYx+9YmH8oW2LtYlqf0ANRuIrG4Is4Mg4SZnMhxboVg/cNkt4cIbnm8Q1y2doEl4WMi8iym974NjYIFO5OUBN3G61uN3ccCtVbLhXiQDIr0Qm/ZfYPS7GcUeQY7NZ1tB0AThM1liaxQ7GntEIrnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481873; c=relaxed/simple;
	bh=z4R7X8NfYX5hDrh1J/HVIY12VY/C0E5aFU27jZJFrTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phHC0GD/6pqBZUVfMuWbGluKHaDreivhYjtYhcPCQJNwSh83qO38eld5eXw5sgZlnhR2eYRaH8hMmMyVzRcY4HiNiYoSpj02xkrczGh8KKlki60l6n0ibpjBXA8Vws3koYMhc1vkhGFMHgezYlUO83rmh9UGYXL71PcmtPQvUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9RkCZna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9434C4CEE4;
	Mon,  5 May 2025 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746481872;
	bh=z4R7X8NfYX5hDrh1J/HVIY12VY/C0E5aFU27jZJFrTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9RkCZnaKUc2feurIgFuQLxNUMoJaYGpMP6FoaBfg0UAjpWkWPqKHD/sro/Swp71M
	 5WxiThPRqaSttKx0kzpd9CPrHk6PTDVfNwX+NwPTAsQxd7V4Lw9uZYc3BG/dfMyahR
	 jNqzOUBDa491ZeUJe9qBWOKw5x1WG7Azxbx1K6iluaHoGMqOiq0sL8CUgeNKvotGQy
	 wV2bAaJ7OVfY1cfrWEYSjPGMs8VndjJoVx18UINMe5FbblPd8cYvJ5vv6Uhb/9+0vW
	 c6eeJshbpzqQydrHaaovHmBsbgL+Xg4cIPCtcEyD/OwTlgEuWvggYMILUM2RmpeJHl
	 bwfWSATdcqayQ==
Date: Mon, 5 May 2025 23:51:07 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
Message-ID: <aBkyy3J9GHiDryEV@gmail.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com>
 <aBdwwR52hI37bW9a@gmail.com>
 <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
 <aBkogDfWB14qkY4g@gmail.com>
 <CAHk-=wjVfjzxBeR9ypA6Y5dRbyKpZvQO8nsAPcFRAABW8QVzTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjVfjzxBeR9ypA6Y5dRbyKpZvQO8nsAPcFRAABW8QVzTw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> >  - PGDIR_SHIFT: (inlined 156 times)
> 
> Several of those are actually of the form
> 
>    #define PGDIR_SIZE      (1UL << PGDIR_SHIFT)
> 
> so you artificially see PGDIR_SHIFT as the important part, even though
> it's often a different constant entirely that just gets generated
> using it.

Yeah, I only examined the first level use.

Here's the stats for PGDIR_SIZE:

     31  ffffffff844cde5c <stat__pgtable_l5_enabled_PGDIR_SIZE>
    157  ffffffff844cdea0 <stat__pgtable_l5_enabled_PGDIR_SHIFT> # total: includes PGDIR_SIZE

Ie. only about 19% of PGDIR_SHIFT use is PGDIR_SIZE.

> >  - PTRS_PER_P4D: (inlined 46 times)
> >    This too could be implemented via a precomputed constant percpu
> >    value (per_cpu__x86_PTRS_PER_P4D), eliminating a branch,
> >    or via an ALTERNATIVE() immediate constant.
> 
> Again, we do have that, although the 64-bit constant is a bit wasteful.

Adds 4 bytes to the size of the MOVQ. Not the end of the world, but I 
suspect for x86-specific values that flag off a CPU-feature flag (which 
is the case here) we can use the ALTERNATIVE_CONST_U32() trick and have 
it all in a single place.

> The reason runtime-const does a 64-bit constant is that the actual 
> performance-critical cases were for big constants (TASK_SIZE) and for 
> pointers (hash table pointers).

I remembered that we had something in this area, but I grepped for 
'alternative.*const' which found nothing, while runtime_const uses its 
own simple text-patching method a.k.a. runtime_const_fixup(). :-)

Thanks,

	Ingo

