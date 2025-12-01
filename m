Return-Path: <linux-efi+bounces-5730-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD7C96D69
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 12:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC8F3A178E
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3B3064AA;
	Mon,  1 Dec 2025 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gP9VUsXS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6943306B04;
	Mon,  1 Dec 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587556; cv=none; b=uHhgRfpDAFF8jHpSiBdE2oS/xvtnDYWJslsFyyXkMrYKtVh2kSuR5GJ7zJ5DXCHSDWpZBZTRbL3yIn5UvRJPJZZXUMxnKhZP3lRb6QxJwJT5HzYsUfjkX2p3q3YT5SemAZFjR2LAjaALmaUyBlj6yCzWgfENgYVgi8QjE/x4A4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587556; c=relaxed/simple;
	bh=phmzIpBqpXh+LZUfQtrgGSMUFTvgvGJD0n/G/m/avGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bURxEFXUu1KLDQoX17H8k0oALlZWgWdcf5lYQhJmL57n3pjwfUspNVdzY4JhuKWfLPQ9OTdOE2yDmO5ycpdDNdkVTptzS9mzo5D2iI+6ExcW3mZdHsR7KeU728hDXhRd2OnOGOXK3AoXmuvkd6NymhHKWrcrJdnOpPbAgln1P3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gP9VUsXS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 339A340E022E;
	Mon,  1 Dec 2025 11:12:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iOkj0-JSgieD; Mon,  1 Dec 2025 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764587544; bh=0UHKkc3PYHzcTPMCzzBKKTlGyj3Kl2+QZFHne2yPGnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gP9VUsXSoNCY00dtFmwYA9HsNrANGcswDmKCrRIU9qSspIrUZWELqs7g59To6Gj8E
	 JRE8Ane9jRS0HU2HRw9mD6B3USUo1Rsrq7TcHmVI5jNXQyJlAWZCp5bpd6k3csnN08
	 cghKWIeD8umUKPhZVb4Hzl53eafkD6F5RsSEEj5eDadB8+Ol+xu6dGVjo7rSQKpIK/
	 38GMaxu6wTu4trOwuElHJmaa4AbCiTSjmKqQUpCwm7R5AJe/VFC4oovYZALDTXy4eI
	 rz3AIfBJtNkrq2P7FETAVMdBSWLJWOdV+6ko2zvw52nCs354uHkr8SGB+Ang0LksTK
	 pXvwu1u/kUPHMsAP8WMWLaJGKOwrQbi1M423ZfCEgNtEXgtQNhitqlK1TiwsRziQiN
	 +V3blEKOsmdeqgWlW0g2h1aOnYkmnPxyn94pVGSpu5iclhPRXysalhmDxKawVhfisZ
	 hywMlP2MqmUhQnIxywj1bbTmPLcBL88YaQmmYmMuaOjViVa7crTeFjcRSg80za9PUf
	 XD+Wly45URx1w1qksPtSCa8zxLqWQgdiO5mAlRYWMjEONeewSOOGB4a3M0k0r5Y+Rn
	 hL2as5hcOoxCGgaMfcOqBXZtFHl1tZiV0iFgXNqaDAK+w+Fp0xvEQVYtDgPG8uPmAK
	 8catoz1wBm6cQyMQOWs7AQzw=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7C54E40E01A5;
	Mon,  1 Dec 2025 11:12:08 +0000 (UTC)
Date: Mon, 1 Dec 2025 12:12:01 +0100
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
Message-ID: <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>

On Mon, Dec 01, 2025 at 10:18:37AM +0100, David Hildenbrand (Red Hat) wrote:
> Makes sense to me, especially for confidential VMs where we pass such
> kernel-managed data from the old to the new kernel.

It shouldn't matter, right?

I think the question is whether the kernel should agree to the software
contract (/eyeroll) to keep the kernel ABI compatible wrt kexec.

And I don't think we have agreed to that AFAIK.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

