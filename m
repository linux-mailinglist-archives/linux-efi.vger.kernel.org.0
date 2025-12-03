Return-Path: <linux-efi+bounces-5785-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF43C9F69E
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 367BE3003BD0
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D73168FA;
	Wed,  3 Dec 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="JKUqRZvD"
X-Original-To: linux-efi@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B33168F8;
	Wed,  3 Dec 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774057; cv=none; b=dxkVXqkNblWh/qmzWvBFjp0fgaqrHgPUw7xn2T5Wi+tQUcDtXYb6De2zmP27JHBHkkAJ999bvD1b/0wM3R996+zDLWaGHoGPe8Hvv/9XXGZuFEr+XTiDAgB5QZmMmtl90IqS1U+kU3McjxVSxKsAZ8P3au7Zf/i09pBlYZESJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774057; c=relaxed/simple;
	bh=H/WIQWuL+F++EVegTtlfllwMXbPuGlR48JJCbbuyV6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpR/joA7dy43SbJfHL+jnjKzdvAbCbLNqpyc3LoYbVAZchB+5H2VTHyeti1XRtizGSlxZ6yiTY1mQYjES+EB8R8onwOA9zBhQuPH8mJR+r65HfCnOLV7lR5UZdKGMOmYXZ0BH3c5c1bhQRkFd2TOEKqsuKTYS/+pC/g/9OKFXY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=JKUqRZvD; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H/WIQWuL+F++EVegTtlfllwMXbPuGlR48JJCbbuyV6o=; b=JKUqRZvDE6idiWZ6soqKKUQHqQ
	LJw3VsdEKREWDGD61D7hk3h8S93N7sdvvotBzWUMHyuzigoeJ3wf5XgApT+YNNMbudBRPC+OgalNl
	o3ZxcIsxZ8qLQBD4s/ptz/u6O3GbR4gsiLPIPl9+UC5wNs0Ipf97PIqP/izl6IlvbOBZAWal9rQJo
	mkOd6dVI0rUfMmiiDc4Ss5aTFImUhHLqCZ9kkPpl/luCvoOlpSwaVLopvA4qJ6xlZCRZX0uR48thF
	2dUVLlwkhhvz9kIYrjChlDwxIjUpZ0YGaBPBHZAkXc39JyqJ1C5g4l7O6qNaP826R4L2bVAWpzND0
	vk1hT7Kw==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vQoKo-000000006tS-0aPE;
	Wed, 03 Dec 2025 10:00:03 -0500
Message-ID: <ed2fd8ed5d3c64e0e57e0d38fe6e3d712f22d13f.camel@surriel.com>
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
From: Rik van Riel <riel@surriel.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Borislav Petkov
	 <bp@alien8.de>, Kiryl Shutsemau <kas@kernel.org>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org, 
	osalvador@suse.de, thomas.lendacky@amd.com, michael.roth@amd.com
Date: Wed, 03 Dec 2025 10:00:03 -0500
In-Reply-To: <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
References: <20251125175753.1428857-1-prsampat@amd.com>
	 <20251125175753.1428857-3-prsampat@amd.com>
	 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
	 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
	 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
	 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
	 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-28 at 10:30 +0100, David Hildenbrand (Red Hat) wrote:
> On 11/27/25 19:12, Borislav Petkov wrote:
> >=20
> > None of that matters if you kexec the same kernels.
> >=20
> > IOW, for some reason you want to be able to kexec different
> > kernels. The
> > question is why do we care?
>=20
> kexecing the same kernel is typically used for kdump purposes.
>=20
> kexecing different kernels is used for all sorts of things=20
> (live-upgrade, grub-emu come to mind). It's quite common to kexec=20
> different kernels, or maybe I misunderstood the question here?
>=20

Even for kdump it is not unusual to use a different
kernel.

When working on kernel code, getting a proper crash
dump can really help figure out where my code went
wrong.

It helps if the kdump kernel doesn't have the same
broken code that my test kernel does :)

--=20
All Rights Reversed.

