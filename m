Return-Path: <linux-efi+bounces-5833-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDECB6431
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353EB301818A
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD72D6E4F;
	Thu, 11 Dec 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W08HE6zF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468052D663D
	for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765465243; cv=none; b=RJDtFRcXxBxhnIREW+c7e9rRfsa+OJnKyFTldT0Yyg2oVmbCqhGWZkHWpfZssWNmAa+CSLysR/Fbr67zXwu+7+P+yisPT/BPbXEYlWcKzA+SoWuXKq1G5xjFHgqJ7XR3iSQ3/OBgcF+v3YQ2c55gQLms2LD3LYbUFafxK6rexs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765465243; c=relaxed/simple;
	bh=1UKwlxIH8EBWmveD91rtbw1zk2GIpitHurcNBZbqQuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfJISRuqW1qWHFDAetcJ0eC0FVL3WcZiSYNohuMj37YOBs44hguhZnFLXwds8wufr6hB6Eu0sW8ASpN7c/p98/6RQ2aPqutXScDnVxs5RoxxHNw+sZD+QDHpJA9L82gJ4PiS2zOjkurAG2jxmt5r32h2zrZCOx+AhM7jZHUxVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W08HE6zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C45BC113D0;
	Thu, 11 Dec 2025 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765465242;
	bh=1UKwlxIH8EBWmveD91rtbw1zk2GIpitHurcNBZbqQuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W08HE6zFvXO+PVqKaVp7ZkX9LNSXoX9450L9UGj6FRlcSh0on0DbWkBLhnFnC16bE
	 1PD0JvylznwzYRvG7RQEQt8sib6yWVX6ZmjlBsquojwFKPY1PHR0EBILC3+Tz+jBrA
	 Zfwb6/v6FNDPQXf+2ijOYFWznkqkjVCMjQemkP6bLzjClmnA2V6sSm/9rqqoJeIOJf
	 gn3d20uNKlgruxNJME5t7Oa/TmhC27MgOL9kImAOqUzTJ+RCKterH1D/1LRf5MobqP
	 QiWe3/EuwPkuaSXL/2sgX8ojiyhJl3XcysZ7+AN/WzhcNbH+PLWCW2CKqpBRum9XHV
	 zw8UlwIKYEUzQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68BE0F4007F;
	Thu, 11 Dec 2025 10:00:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Dec 2025 10:00:41 -0500
X-ME-Sender: <xms:mdw6aSugYlLqhSFkC_QL4fuLRQqmZ90svCc9oTbpJhrhGUJ6AtlLnw>
    <xme:mdw6aU-EWNGVM0EUDYx23Jq7XrilUUJZPAMufw0aXg-hjt1xly1ADemtvftHioOVW
    PByc53jmXauMiVmyCXBYiBWjZl_MCyWxsAcxuVgYQNanNjwLFyjRpw>
X-ME-Received: <xmr:mdw6aZ1l2C5xAY3Sb3Ckw3OVTcBSdDd6LfXPha-3Kop8yxNxmoKVNy_LTEx5Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhrshgrmhhprghtsegrmhgurdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtg
    hpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhu
    thhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:mdw6aac5m85COt5GDXcf5N8EgK4MjN867SZwm-7FGk0WnsWXqo-q-A>
    <xmx:mdw6aVcXsQE9PW1Q1fegSLWpVyQGH5vmnHpLx94yZhgTHhHXr1MHcQ>
    <xmx:mdw6aQ3VMhcz6Op6EKFKWQ0mqr87xCJGOgAKBgERyCSAWjxXXih6Sg>
    <xmx:mdw6aV72QgkHsEO7IT7gcnA5QiMWjq-EO2SCHqbap8KRc3x-tuqtHw>
    <xmx:mdw6aXImq48CZQ54RUKyN9zjcudJV7yG6FOlFG0mX5jIUp-c3aE8gsY6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 10:00:40 -0500 (EST)
Date: Thu, 11 Dec 2025 15:00:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org, osalvador@suse.de, 
	thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <uc6yz23havsg2cdgtk3fgku7xr4gj2ykse7lxitcs4eh2fw4vo@hyavdm3ovdfh>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <ac479414-e0fa-49be-8a30-8f9c0e7b7d32@kernel.org>
 <73a69c03-feda-4c56-9db1-30ec489066fb@amd.com>
 <938a7948-7882-41a3-926b-3d2a8d07620d@kernel.org>
 <89fde0fd-57c4-4146-82fc-a4c1a56e74ec@amd.com>
 <a7ac1f74-32a6-41d1-82da-b338c127fb2e@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ac1f74-32a6-41d1-82da-b338c127fb2e@amd.com>

On Tue, Dec 09, 2025 at 03:36:09PM -0600, Pratik R. Sampat wrote:
> > Agreed, I think Kiryl was hinting at pre-allocated bitmaps as well.
> > 
> > Since, the overhead to do this upfront is fairly minimal, that should
> > certainly simplify things and have very little to no meddling with the
> > original EFI struct.
> > 
> 
> Taking another look at this suggestion, I think there may be more to it
> than I previously thought. Parsing e820 tables to know what the range
> are for allocating the bitmap to cover hotplug may be difficult. For e.g
> 
> [ 0.000000] efi: mem110: [Unaccepted <snip>]
> range=[0x0000000100000000-0x000000017fffffff] (2048MB)
> [ 0.000000] efi: mem111: [Reserved   <snip>]
> range=[0x000000fd00000000-0x000000ffffffffff] (12288MB)
> 
> Parsing of the ACPI SRAT seems to be the one that gives us useful ranges
> to base the upfront bitmap allocation on. e.g.
> ...
> [    0.018357] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x17fffffff]
> [    0.018781] ACPI: SRAT: Node 0 PXM 0 [mem 0x180000000-0x2ffffffff]
> hotplug
> This is also where max_possible_pfn gets updated to reflect this range.

Do I understand correctly that EFI memory map doesn't mention hot plug
range at all, but SRAT does?

That's a mess. I thought, all hotpluggable range supposed to be declared
in the memory map.

I wounder if it is what BIOS provides, or is it result of EFI memmap
cleanup by kernel? I see we are doing bunch of them, like in
efi_remove_e820_mmio().

> One potential solution could be to parse the SRAT during unaccepted
> memory bitmap allocation in the EFI stub. However, this would fragment
> the implementation by duplicating the SRAT parsing. Alternatively, we
> could keep the current approach of dynamically allocating the bitmap on
> hotplug or I could also replace the entire memblock_reserved unaccepted
> table like Kiryl suggested if we must absolutely avoid changing the
> unaccepted structure?

Other possible option would be to accept all memory on hotplug and don't
touch the bitmap at all. It might be not that bad: it doesn't block boot.
We can think of a better solution later, if needed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

