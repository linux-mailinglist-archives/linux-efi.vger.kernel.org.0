Return-Path: <linux-efi+bounces-839-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E728862DB
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 23:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7191C21752
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F057136653;
	Thu, 21 Mar 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="ZKOJM8Vo"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DB132489
	for <linux-efi@vger.kernel.org>; Thu, 21 Mar 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058719; cv=none; b=TOdHrxXVJztHgF27BzffRzyaBmDV02hDm0442v6z7LQRki/EJRdpTbAMyYym/C1txvPI57lHGDXQ9ux1WPC6yp1b8tmVN9/D15MnU5LzDfHwkPOpFi825SF630LWGHlS1mLzsRb/YGGU19kKVefrO/ldX+rypn50CcbcaFknB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058719; c=relaxed/simple;
	bh=DK5KA86UB/oaGC52Y62IJp9I9PrxMJ4ablIA5RYgtOQ=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NMprSGDsvihwq6o1lKsHVftDwKaEwZaJJ41HJPsjaV/P4Bltb5sU8XrJ7yMHembYwd3KflGgpfWkCBi77ghN7Du67e4fYvNBDSbMUtppXW9Ia8MHl+jow01xds7Z9NaTVFg4upneMNNe6GBaxwO2gpSIIfguVQ27Y0hR8/0uvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=ZKOJM8Vo; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Thu, 21 Mar 2024 15:05:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711058715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DK5KA86UB/oaGC52Y62IJp9I9PrxMJ4ablIA5RYgtOQ=;
	b=ZKOJM8VotpBbDYm8XuJtBYiwevAM2z2vrehhCqJgHxq5DmwUcXRCXjcSjF2IhqFeapTw2L
	TGip9weeOCvnZPqeDnOEGYRhx6tK4rM8BgTbdUx28gohcqmLoaC3XCqHW9NpbKx25jWAOV
	SmSm9kE10i3Bz1s2KbzkInDUzCXUb0LJN+gH8gHCQsO1LiIJvqEFxlDd6NDMC/38FMlIsG
	jEqXALGRMamAFw4tpb4yWvOJ/jZwVX0x0wDKogaxFPL0kun/eaDhKGA3+5sF+w1JvokTQb
	WG1RVxSXoXz/S1982vdUQgzOmMuvy9WXXBksIg/m8UUutAa6Kmxt3VNvwBlEKA==
Message-ID: <20240321150510.GI8211@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, regressions@lists.linux.dev
Subject: x86_64 32-bit EFI mixed mode boot broken
References:
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="UfT2btok9F8N949I"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--UfT2btok9F8N949I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

SSd2ZSBiZWVuIGNoYXNpbmcgYSBwcm9ibGVtIHdpdGggMzItYml0IEVGSSBtaXhlZCBtb2RlIGJv
b3Rpbmcgb24gdHdvIGRpZmZlcmVudAooeDg2XzY0KSBJbnRlbCBCYXkgVHJhaWwgcGxhdGZvcm1z
LCB3aGVyZSB0aGUgc3lzdGVtIHJlYm9vdHMgb3IgaGFuZ3Mgc2VlbWluZ2x5CnZlcnkgZWFybHkg
c29tZXdoZXJlIGJlZm9yZSBvciBhZnRlciBsb2FkaW5nIHRoZSBrZXJuZWwuIEkndmUgbm90IGJl
ZW4gYWJsZSB0bwpnZXQgYW55IG91dHB1dCBmcm9tIHRoZSBrZXJuZWwgb3Igc3R1YiBvdmVyIGVm
aWZiIHdoZW4gdGhlIGlzc3VlIGhhcHBlbnNbMF0sIGFuZApkbyBub3QgaGF2ZSBzZXJpYWwgY29u
c29sZSBhY2Nlc3Mgb24gdGhlc2Ugc3lzdGVtcy4KCnY2LjggZmFpbHMgZm9yIG1lLCBhbmQgcHJl
c3VtYWJseSBzbyBkb2VzIGV2ZXJ5dGhpbmcgYmFjayB0byB2Ni4yLiB2Ni4xIGlzIGFibGUKdG8g
Ym9vdCBPSyBvbiB0aGVzZSBwbGF0Zm9ybXMgd2l0aCBtaXhlZCBtb2RlLCBhbmQgaXQgbG9va3Mg
bGlrZSB0aGVyZSBhcmUgYSBsb3QKb2YgY2hhbmdlcyBmcm9tIDYuMS4uNi4yIGZvciBFRkkvbWl4
ZWQgbW9kZSBib290aW5nLiBJIGRpZCBtYW5hZ2VkIHRvIGJpc2VjdCB0aGUKaXNzdWUgdG86Cgog
ICAgICAgIGNvbW1pdCBlMmFiOWVhYjMyNGNkZjI0MGRlODk3NDFlNGExYWE3OTkxOWYwMTk2CiAg
ICAgICAgQXV0aG9yOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgogICAgICAgIERh
dGU6ICAgVHVlIE5vdiAyMiAxNzoxMDowMiAyMDIyICswMTAwCgogICAgICAgICAgICB4ODYvYm9v
dC9jb21wcmVzc2VkOiBNb3ZlIDMyLWJpdCBlbnRyeXBvaW50IGNvZGUgaW50byAudGV4dCBzZWN0
aW9uCgpIb3dldmVyIEknbSBub3Qgc3VyZSBob3cgdG8gcHJvY2VlZCBmcm9tIGhlcmUsIG9yIGlm
IG15IGJpc2VjdCBpcyBhbGwgdGhhdAp1c2VmdWwgc2luY2UgdGhlIGNvbW1pdCBzZWVtcyB0byBi
ZSBpbiB0aGUgbWlkZGxlIG9mIGEgYnVuY2ggb2YgY2hhbmdlcyBJIGRvIG5vdAp1bmRlcnN0YW5k
LiBJJ3ZlIGJlZW4gdXNpbmcgc3lzdGVtZC1ib290IHRvIHRlc3QgdGhpcyAoYm90aCB0aGUgZnVs
bCBib290bG9hZGVyCmFuZCBVS0kgdy8gdGhlIHNkLWJvb3Qgc3R1YikuIElzIDMyLWJpdCBtaXhl
ZCBtb2RlIG9uIHg4Nl82NCB3b3JraW5nIGZvciBvdGhlcnM/CgpUaGFua3MsCkNsYXl0b24KCjAu
IFVzaW5nICJkZWJ1ZyBpZ25vcmVfbG9nbGV2ZWwgZWFybHljb249ZWZpZmIgZWFybHlwcmludGs9
ZWZpLGtlZXAgZWZpPWRlYnVnIgo=

--UfT2btok9F8N949I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmX8rxYACgkQSkztbX7f
lQoQ8BAAr4Pk42xwcH6V4pEKZsHd0uEeQXqyEbsHSAbSIJNXOR2jBnZ5Oh4B2PZx
r64ayktYwquqX6n2hEaJcc34WvKTOBTIld135klKeLqh6KKlejmFMNuu6Bu6vet+
efDp/M1CViR3oFKSkuxq6tWuoZV5lWsthRqPiUyrgbeuojWiDZdNUnMH83oCFuI9
h/NCnfVjFNOznfv3Iz+lSV5W1MUV5kublapClziQTeN5Y47iFD/ZaHE6eoKuyKJt
gpmB++bF8xwZcjsFbKC1VECN//tKNU6IWzh5KHGrKy36UP0h8SRh8S8YgzECpCZi
LvzSzqCT7zHCZkjc+tys0vVm7g0vmvfM51rDWSh0PWoCeFbP/dwrtbe2l3shnopw
0cK9fLDr6mK7csrgpkrWF2orjQL0shRg3wIhpiOVzJr2azAPKHKPpqMDWQtv2dqT
+XJLala1jhjluoKJPLNlBNWeZvlyKJohbF1qrnww6v4+oyoYwgrYI99Y+FUmWUEB
9GIsWUmMJsahrHXbtPneDJJtKiRhkoaNN29d1xBX0Pos2otDVEaMK7+ecP/T7MEb
zQMu+960dDTeE17Z+F/4TgQ+IT1JdEPwX3eGQIyu/FMuZt9vu23zdO7nugPTUKPH
howBlrVfoizMq7YWbOq430nr1lPKg9iAqpxbpM+misJVd7h+jA4=
=c7s7
-----END PGP SIGNATURE-----

--UfT2btok9F8N949I--

