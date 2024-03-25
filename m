Return-Path: <linux-efi+bounces-880-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1788AD38
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271F21C3721D
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BE12D772;
	Mon, 25 Mar 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="WnirDkWt"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946D1E534
	for <linux-efi@vger.kernel.org>; Mon, 25 Mar 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388365; cv=none; b=mn0b8QKIsJTqh7g4/Lq2kosDtAljti7kFMM3S+bDgZZe2zXO2DbmVDDqN/Hvh8/8fhGVYzEkopVlF9dtvmd62gz/DCtCwoqdCyfwdZIODCWnFI1xjlTcqLquVj+QYZdFhUw+2kURKOLnTKx6xmVVXqE40fbC5Lw7QDp9gKmPafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388365; c=relaxed/simple;
	bh=xyk5pfus2DJXtQQaDZ62yS48Heir0FjYUjCVVNmb/AY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5Lbew/wqdKvYZouIU7ukRjZCVadAGlH3317EIptCyvWpyHaR6vkplf+aFw9qcfs77VuBou/dcsAlqFOUjavkncccPyrCUmhwXqttQmHM8xSGcqwgsmc6YuZqKqyTBMkraeoy79ubBeLpq/iqHx4COPiCmChH6/ufzA5WQ9ENOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=WnirDkWt; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Mon, 25 Mar 2024 10:39:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711388357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyk5pfus2DJXtQQaDZ62yS48Heir0FjYUjCVVNmb/AY=;
	b=WnirDkWtyxAnKXTya31AIdOi04lf8tGiXcqjLhdWRGnQgH33fxAAsveeX2bAt2T+SckRMl
	YRynax8wElMvHiPE7Yl9tyGRecs3bHSEBUMmQZhh7vGQRSzg7zq3eQrfUxWGDhp9C6XrDL
	AxmNK/9q7FXGHG1n+m5HZBoavELS9Ca982jg5QDnwAlYGerYwSr5ajbLybsG+tb/5Wl6VW
	EbwiD7eZ29YbliXhYVqyxX1uXuCjOw5b0fVzXaXU2/hwsK7uDJ949TLqotNGsgMRcZ3Rf1
	Fj+JO1EW/MLBRkBjJ8c7MCb2DCZPdc0aef3sY9Xn3E4FaCmR7uhqiaW0P4algQ==
Message-ID: <20240325103912.GB6076@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/efistub: Add missing boot_params for mixed mode
 compat entry
In-Reply-To: <5b32b8c8-0a1b-44cf-aedf-cca1d6c83bd8@redhat.com>
References: <20240325083905.13163-2-ardb+git@google.com>
 <5b32b8c8-0a1b-44cf-aedf-cca1d6c83bd8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="/BaAd8uW2PEt6Q7E"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--/BaAd8uW2PEt6Q7E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

T24gTW9uLCAyNSBNYXIgMjAyNCAxNDoxODowMSArMDEwMCBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPiB3cm90ZToKPiBIaSwKPiAKPiBPbiAzLzI1LzI0IDk6MzkgQU0sIEFyZCBC
aWVzaGV1dmVsIHdyb3RlOgo+ID4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9y
Zz4KPiA+IAo+ID4gVGhlIG5hdGl2ZSBFRkkgc3R1YiBlbnRyeSBwb2ludCBkb2VzIG5vdCB0YWtl
IGEgc3RydWN0IGJvb3RfcGFyYW1zIGZyb20KPiA+IHRoZSBib290IGxvYWRlciwgYnV0IGNyZWF0
ZXMgaXQgZnJvbSBzY3JhdGNoLCBhbmQgcG9wdWxhdGVzIG9ubHkgdGhlCj4gPiBmaWVsZHMgdGhh
dCBzdGlsbCBoYXZlIG1lYW5pbmcgaW4gdGhpcyBjb250ZXh0IChjb21tYW5kIGxpbmUsIGluaXRy
ZAo+ID4gYmFzZSBhbmQgc2l6ZSwgZXRjKQo+ID4gCj4gPiBUaGUgb3JpZ2luYWwgbWl4ZWQgbW9k
ZSBpbXBsZW1lbnRhdGlvbiB1c2VkIHRoZSBFRkkgaGFuZG92ZXIgcHJvdG9jb2wsCj4gPiB3aGVy
ZSB0aGUgYm9vdCBsb2FkZXIgKGkuZS4sIEdSVUIpIHBvcHVsYXRlcyBhIHN0cnVjdCBib290X3Bh
cmFtcyBhbmQKPiA+IHBhc3NlcyBpdCB0byBhIHNwZWNpYWwgRUZJIGVudHJ5IHBvaW50IHRoYXQg
dGFrZXMgdGhlIHN0cnVjdCBib290X3BhcmFtcwo+ID4gcG9pbnRlciBhcyB0aGUgdGhpcmQgYXJn
dW1lbnQuCj4gPiAKPiA+IFdoZW4gdGhlIG5ldyBtaXhlZCBtb2RlIGltcGxlbWVudGF0aW9uIHdh
cyBpbnRyb2R1Y2VkLCB1c2luZyBhIHNwZWNpYWwKPiA+IDMyLWJpdCBQRSBlbnRyeXBvaW50IGlu
IHRoZSA2NC1iaXQga2VybmVsLCBpdCBhZG9wdGVkIHRoZSB1c3VhbAo+ID4gcHJvdG90eXBlLCBh
bmQgcmVsaWVkIG9uIHRoZSBFRkkgc3R1YiB0byBjcmVhdGUgdGhlIHN0cnVjdCBib290X3BhcmFt
cwo+ID4gYXMgdXN1YWwuIFRoaXMgaXMgcHJlZmVycmVkIGJlY2F1c2UgaXQgbWFrZXMgdGhlIGJv
b3Rsb2FkZXIgc2lkZSBtdWNoCj4gPiBlYXNpZXIgdG8gaW1wbGVtZW50LCBhcyBpdCBkb2VzIG5v
dCBuZWVkIGFueSB4ODYtc3BlY2lmaWMga25vd2xlZGdlIG9uCj4gPiBob3cgc3RydWN0IGJvb3Rf
cGFyYW1zIGFuZCBzdHJ1Y3Qgc2V0dXBfaGVhZGVyIGFyZSBwdXQgdG9nZXRoZXIuCj4gPiAKPiA+
IEhvd2V2ZXIsIG9uZSB0aGluZyB3YXMgbWlzc2VkOiBFRkkgbWl4ZWQgbW9kZSBnb2VzIHRocm91
Z2ggc3RhcnR1cF8zMigpCj4gPiAqYmVmb3JlKiBlbnRlcmluZyB0aGUgNjQtYml0IEVGSSBzdHVi
LCB3aGljaCBpcyBkaWZmaWN1bHQgdG8gYXZvaWQgZ2l2ZW4KPiA+IHRoYXQgNjQtYml0IGV4ZWN1
dGlvbiByZXF1aXJlcyBwYWdlIHRhYmxlcywgd2hpY2ggY2FuIG9ubHkgYmUgcG9wdWxhdGVkCj4g
PiB1c2luZyAzMi1iaXQgY29kZSwgYW5kIHRoaXMgcGllY2UgaXMgd2hhdCB0aGUgbWl4ZWQgbW9k
ZSBFRkkgc3R1YiByZWxpZXMKPiA+IG9uLiBzdGFydHVwXzMyKCkgYWNjZXNzZXMgYSBjb3VwbGUg
b2Ygc3RydWN0IGJvb3RfcGFyYW1zIGZpZWxkcyB0bwo+ID4gZGVjaWRlIHdoZXJlIHRvIHBsYWNl
IHRoZSBwYWdlIHRhYmxlcy4KPiA+IAo+ID4gc3RhcnR1cF8zMigpIHR1cm5zIG91dCB0byBiZSBx
dWl0ZSB0b2xlcmFudCB0byBib2d1cyBzdHJ1Y3QgYm9vdF9wYXJhbXMsCj4gPiBnaXZlbiB0aGF0
IEVTSSB1c2VkIHRvIGNvbnRhaW4ganVuayB3aGVuIGVudGVyaW5nIHZpYSB0aGUgbmV3IG1peGVk
IG1vZGUKPiA+IHByb3RvY29sLiBPbmx5IHdoZW4gY29tbWl0Cj4gPiAKPiA+ICAgZTJhYjllYWIz
MjRjICgieDg2L2Jvb3QvY29tcHJlc3NlZDogTW92ZSAzMi1iaXQgZW50cnlwb2ludCBjb2RlIGlu
dG8gLnRleHQgc2VjdGlvbiIpCj4gPiAKPiA+IHN0YXJ0ZWQgdG8gemVybyBFU0kgZXhwbGljaXRs
eSB3aGVuIGVudGVyaW5nIHZpYSB0aGlzIGJvb3QgcGF0aCwgYm9vdAo+ID4gZmFpbHVyZXMgc3Rh
cnRlZCB0byBhcHBlYXIgb24gc29tZSBzeXN0ZW1zLCBwcmVzdW1hYmx5IG9uZXMgdGhhdCB1bm1h
cAo+ID4gcGFnZSAweDAgb3IgbWFwIGl0IHJlYWQtb25seS4KPiA+IAo+ID4gVGhlIHNvbHV0aW9u
IGlzIHRvIHBhc3MgYSBzcGVjaWFsLCB0ZW1wb3Jhcnkgc3RydWN0IGJvb3RfcGFyYW1zIHRvCj4g
PiBzdGFydHVwXzMyKCkgdmlhIEVTSSwgb25lIHRoYXQgaXMgc3VmZmljaWVudCBmb3IgZ2V0dGlu
ZyBpdCB0byBjcmVhdGUKPiA+IHRoZSBwYWdlIHRhYmxlcyBjb3JyZWN0bHkgYW5kIGlzIGRpc2Nh
cmRlZCByaWdodCBhZnRlci4gVGhpcyBtZWFucwo+ID4gc2V0dGluZyBhIG1pbmltYWwgYWxpZ25t
ZW50IG9mIDRrLCBvbmx5IHRvIGdldCB0aGUgc3RhdGljYWxseSBhbGxvY2F0ZWQKPiA+IHBhZ2Ug
dGFibGVzIGxpbmUgdXAgY29ycmVjdGx5LCBhbmQgc2V0dGluZyBpbml0X3NpemUgdG8gdGhlIGV4
ZWN1dGFibGUKPiA+IGltYWdlIHNpemUgKF9lbmQgLSBzdGFydHVwXzMyKS4gVGhpcyBlbnN1cmVz
IHRoYXQgdGhlIHBhZ2UgdGFibGVzIGFyZQo+ID4gY292ZXJlZCBieSB0aGUgc3RhdGljIGZvb3Rw
cmludCBvZiB0aGUgUEUgaW1hZ2UuCj4gPiAKPiA+IEdpdmVuIHRoYXQgRUZJIGJvb3Qgbm8gbG9u
Z2VyIGNhbGxzIHRoZSBkZWNvbXByZXNzb3IgYW5kIG5vIGxvbmdlciBwYWRzCj4gPiB0aGUgaW1h
Z2UgdG8gcGVybWl0IHRoZSBkZWNvbXByZXNzb3IgdG8gZXhlY3V0ZSBpbiBwbGFjZSwgdGhlIHNh
bWUKPiA+IHRlbXBvcmFyeSBzdHJ1Y3QgYm9vdF9wYXJhbXMgc2hvdWxkIGJlIHVzZWQgaW4gdGhl
IEVGSSBoYW5kb3ZlciBwcm90b2NvbAo+ID4gYmFzZWQgbWl4ZWQgbW9kZSBpbXBsZW1lbnRhdGlv
biBhcyB3ZWxsLCB0byBwcmV2ZW50IHRoZSBwYWdlIHRhYmxlcyBmcm9tCj4gPiBiZWluZyBwbGFj
ZWQgb3V0c2lkZSBvZiBhbGxvY2F0ZWQgbWVtb3J5Lgo+ID4gCj4gPiBDYzogSGFucyBkZSBHb2Vk
ZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KPiA+IEZpeGVzOiBlMmFiOWVhYjMyNGMgKCJ4ODYvYm9v
dC9jb21wcmVzc2VkOiBNb3ZlIDMyLWJpdCBlbnRyeXBvaW50IGNvZGUgaW50byAudGV4dCBzZWN0
aW9uIikKPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMzIxMTUw
NTEwLkdJODIxMUBjcmFmdHlndXkubmV0Lwo+ID4gUmVwb3J0ZWQtYnk6IENsYXl0b24gQ3JhZnQg
PGNsYXl0b25AY3JhZnR5Z3V5Lm5ldD4KPiA+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVs
IDxhcmRiQGtlcm5lbC5vcmc+Cj4gCj4gSSBoYXZlIGdpdmVuIHRoaXMgYSB0ZXN0IHJ1biAob24g
dG9wIG9mIDYuOS1yYzEpIG9uIG9uZSBvZiBteQo+IEJheSBUcmFpbCBtaXhlZCBtb2RlIHRhYmxl
dHMgYW5kIHRoZSB0YWJsZXQgc3RpbGwgYm9vdHMgZmluZToKCkkgZGlkIHRoZSBzYW1lIHRlc3Qg
KHdpdGggNi45LXJjMSkgb24gbXkgQmF5IFRyYWlsIHRhYmxldCAmIE5VQyB0aGF0IGZhaWxlZApw
cmV2aW91c2x5LCBhbmQgdGhpcyBmaXhlcyBib290aW5nIHdpdGggRUZJIG1peGVkIG1vZGUgb24g
dGhlbS4KClRlc3RlZC1ieTogQ2xheXRvbiBDcmFmdCA8Y2xheXRvbkBjcmFmdHlndXkubmV0PgoK
LUNsYXl0b24K

--/BaAd8uW2PEt6Q7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmYBtsAACgkQSkztbX7f
lQq/Xw/9EKAdn09mv5AaJ/QrG9BizHisMk1arvM5BiL0gHd/iZ0tqdVCanuTxAzZ
wKkVcY6EN8x6rW5jPEzsw27QM7Hp6LH9O8q5uK0K43nQuRcI1ERPk39CCe9NxBfu
PftrJ7iy+kg05rWFHlzex3qTRmbma31frI7UVlJ9LhF7E8ci6CJtDuk+G9YzfBfg
zBD/+qwdcW2OdCeT612uR7p4GQ3yVAl2NjCuv+KEZ78JrSYp3jq1cIL3xPTpifzu
xS/7xhB3BhGDF9PB06sRxTiuBp02UJ4tejyUY7JdDddgcPYMTMooeOZLsduPecEq
UE+79iHq4gyY3r94A36MdpCw+Yse2srckk+xQ3boPuMkbQ7v9It3bDscpcx0X+ge
BgSJbkxayZGtWy+HKHBI1TDDHsQ6haTMVqolaNLq+fcyntBAtR8qQJJadylve875
LHlLXbU9/mTzx2SEhcrMN4yR4fSila1T+MCAaobCpJ1cgzLm/XqxSr1ka5nM3JoI
P6UD200QCThgmuM3wpVgNjkFGA9lvrKIBsgaoU347OTpPakw1tGgPHDIGkjylHAU
5rAhrFSVtxEQghn51/rjTPGXZWJzbOZI7YKM1bUJLWTixsLUygTZsmeRnX0w6kTN
b45OZCQg5vyX42UFUWME4F6/70dAn9SqNzdaQNJIVqh1qGlpM4I=
=X3E+
-----END PGP SIGNATURE-----

--/BaAd8uW2PEt6Q7E--

