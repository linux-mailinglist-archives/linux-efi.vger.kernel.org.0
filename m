Return-Path: <linux-efi+bounces-855-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0A8870C5
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3544D1C22FCF
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603859B43;
	Fri, 22 Mar 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="edP+l9Ib"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA35674C
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124352; cv=none; b=XzOgxzD+GxmerjgHAUT+3S6NZ3HX7sjT4J89xzuZ4jRSxG+e86mW6so0128Q3+HekC7fkiK7WPQEPf5nV+eXMCPswJEgNwcY+j6Vje16xvPXytYPJppjWl64lhthnLrKNrq3FJ82lLzlWlqXISqO02Dux1xQ+aTLbYD2HOAmhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124352; c=relaxed/simple;
	bh=pRMg/t6wZBrXTf4eCE43zA/56qnnDkoAuBkVWGZYyic=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzCb/7atnhpn9CHwa/3ST4WIhW67y1qWM2RrdTI2uPzZTEKpRISjB4nTfHBfRXbXg98/InKi41eAIJba/o8n0Xj0rcZEztdlLeNYVcRRWRiLwBwcfGGaBosoBVOiD+MSQFyl34+2T+8KPcjBbz4isPROOpA/unMrQOCF9QX69YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=edP+l9Ib; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Fri, 22 Mar 2024 09:18:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711124343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRMg/t6wZBrXTf4eCE43zA/56qnnDkoAuBkVWGZYyic=;
	b=edP+l9Ibbgtc8Vbzfc5iQXpNnl9xNH2sqO08Nd8rF5tjabh8YwZbbmW70v7KjHidoXTAno
	g5swq3UNoo/f6CmlgcUi2bAFjtysd78faP1RclxupYnCEk1FHB6jEqujqj/VyCkqmbVo2M
	1QUbmbapLgxR74iNQjks8qqm+i/mll1tiXQ7Ra0FqVkHctBVnhhLSDGxmFZ/k3W6ISqGS1
	qYmYgSL7tdGdvnM2F+jAD6tWX6pugCyAsfSag1CgktnXmkGNzCutSCtQfAlHpC3qfy54dY
	wPyIYErSIfnJFRS2i5gFX1s03OECTRnvuinP+qBLUMgf8Eoqs1s71F2ZB+daJg==
Message-ID: <20240322091857.GM8211@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 regressions@lists.linux.dev
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
In-Reply-To: <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net>
 <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="ZDwzZQYzZVCy0qwd"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--ZDwzZQYzZVCy0qwd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

T24gRnJpLCAyMiBNYXIgMjAyNCAxMzo1MjowNSArMDEwMCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPiBUaGF0IGRlcGVuZHMgb24gdGhlIGJvb3Rsb2FkZXIuIE9uZSBv
ZiB0aGUgY2hhbmdlcyBhcm91bmQgdGhhdCB0aW1lIGlzCj4gdGhlIGludHJvZHVjdGlvbiBvZiB0
aGlzIEtjb25maWcgc3ltYm9sOiBiZWZvcmUgdGhhdCwgdGhlIEVGSSBoYW5kb3Zlcgo+IHByb3Rv
Y29sIHdhcyBhbHdheXMgc3VwcG9ydGVkIGJ1dCBub3cgaXQgY2FuIGJlIGNvbXBpbGVkIG91dC4g
U28gdGhlCj4gc2FmZSBjaG9pY2UgaXMgdG8gZW5hYmxlIGl0LgoKSSBhbSB1c2luZyBzeXN0ZW1k
LWJvb3QsIGFuZCBiYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nIG9mIGl0cyBzb3VyY2UgaXQgc2Vl
bXMgdG8Kb25seSB1c2UgaGFuZG92ZXIgb24gb2xkIGtlcm5lbHMgdGhhdCBkb24ndCBzdXBwb3J0
IExJTlVYX0lOSVRSRF9NRURJQV9HVUlELgo+IAo+IEhvd2V2ZXIsIHdoaWxlIGxvb2tpbmcgbW9y
ZSBkZWVwbHkgaW50byB0aGlzLCBJIG5vdGljZWQgdGhhdCB3ZSBhcmUKPiBydW5uaW5nIHF1aXRl
IGxvdyBvd24gc3RhY2sgc3BhY2UuIE1peGVkIG1vZGUgaXMgZGlmZmVyZW50IGJlY2F1c2UgaXQK
PiBjYWxscyBpbnRvIHRoZSBib290IHNlcnZpY2VzIHVzaW5nIHRoZSBkZWNvbXByZXNzb3IncyBi
b290IHN0YWNrLAo+IHJhdGhlciB0aGFuIHVzaW5nIHRoZSBvbmUgdGhhdCB3YXMgcHJvdmlkZWQg
YnkgZmlybXdhcmUgYXQgZW50cnkuCj4gKE5vdGUgdGhhdCB0aGUgVUVGSSBzcGVjIG1hbmRhdGVz
IDEyOGsgb2Ygc3RhY2sgc3BhY2UpCj4gCj4gSW4gbXkgY2FzZSwgSSBiaXNlY3RlZCB0aGUgcmVn
cmVzc2lvbiB0bwo+IAo+IGNvbW1pdCA1YzRmZWFkYjAwMTE5ODNiYmM0NTg3YmM2MTA1NmM3YjM3
OWQ5OTY5IChIRUFEKQo+IEF1dGhvcjogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4K
PiBEYXRlOiAgIE1vbiBBdWcgNyAxODoyNzoxNiAyMDIzICswMjAwCj4gCj4gICAgIHg4Ni9kZWNv
bXByZXNzb3I6IE1vdmUgZ2xvYmFsIHN5bWJvbCByZWZlcmVuY2VzIHRvIEMgY29kZQo+IAo+IHdo
aWNoIG1vdmVzIHRoZSBib290IHN0YWNrIGludG8gYSBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbi4g
Rm9ybWVybHksCj4gd2UnZCBlbmQgdXAgYXQgdGhlIGZhciBlbmQgb2YgdGhlIGhlYXAgd2hlbiBv
dmVycnVubmluZyB0aGUgc3RhY2sgYnV0Cj4gbm93LCB3ZSBlbmQgdXAgY3Jhc2hpbmcuIE9mIGNv
dXJzZSwgb3ZlcndyaXRpbmcgdGhlIGhlYXAgY2FuIGNhdXNlCj4gcHJvYmxlbXMgb2YgaXRzIG93
biwgc28gd2UnbGwgbmVlZCB0byBidW1wIHRoaXMgaW4gYW55IGNhc2UuCj4gCj4gQ291bGQgeW91
IGdpdmUgdGhpcyBhIHRyeSBwbGVhc2U/Cj4gCj4gCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vYm9vdC5oCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYm9vdC5oCj4gQEAgLTM4LDcg
KzM4LDcgQEAKPiAgI2VuZGlmCj4gCj4gICNpZmRlZiBDT05GSUdfWDg2XzY0Cj4gLSMgZGVmaW5l
IEJPT1RfU1RBQ0tfU0laRSAgICAgICAweDQwMDAKPiArIyBkZWZpbmUgQk9PVF9TVEFDS19TSVpF
ICAgICAgIDB4MTAwMDAKPiAKPiAgLyoKPiAgICogVXNlZCBieSBkZWNvbXByZXNzb3IncyBzdGFy
dHVwXzMyKCkgdG8gYWxsb2NhdGUgcGFnZSB0YWJsZXMgZm9yIGlkZW50aXR5CgpKdXN0IGdhdmUg
dGhpcyBhIHRyeSwgb24gNi4xLjgyLCBhbmQgdGhlIHN5c3RlbSBzdGlsbCByZWJvb3RzIGFmdGVy
IHNlbGVjdGluZwp0aGUga2VybmVsIGluIHRoZSBib290bG9hZGVyLiBTbyBpdCBzZWVtcyBsaWtl
IG15IHByb2JsZW0gaXMgZGlmZmVyZW50LgoKQXMgSSBtZW50aW9uZWQgaW5pdGlhbGx5LCBJIGJp
c2VjdGVkIG15IGZhaWx1cmUgdG8gZTJhYjllYWIzMi4gRG9lcyB0aGF0IGdpdmUKYW55IGhpbnQg
YWJvdXQgd2hhdCBtaWdodCBiZSB0aGUgcHJvYmxlbT8KCi1DbGF5dG9uCg==

--ZDwzZQYzZVCy0qwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmX9r3EACgkQSkztbX7f
lQrrVw/9Fb/e4pVj5RoGppymFb9gjfxLYT21kL08bq3otfPXNTif7telFvum9WTg
9iua6RX0TYnUoJ5wj74XhoDjFyJpzqNk2dPNyMKENCcqJ+5YwZYFWUcZNqTGIttt
n94TMqowODXjZgAcUxmWqyLMgdHyK9FnoXlVGD15o060B3Px69qub/VUtnfSc8DC
DX8qsHbbarYEE0mX15Z9PynuEdz3y5f2spNFYkLJzM6/brrNOJ6jRInV3t32YMZD
oBPFg7NaarSEjTJhp051DyUaa4rZU+TgxOF8wKCgzTiGj1kTj9AtTIaeIE6uCB6R
ADNTYFjrcccCUNdFg8FXR9YxDtRbsyCN+CaziXIAC6rRWwAAk3Q0PKdJvvjJjCsY
m6F08lb+3VdFmz7WRuCAXFWVjjXVXKCRgiPxtsmYW4dKrID9hrmHU8ulJqQJuPIn
t14ex4BvOz2/mRGCJd4e13nm3lsk4DjW9JNbo1aLscED5AtrZpcjq5Um5+WS0Icn
qJzahTfWX0H8lT/xLTe9dQBf/T/LqzqRyzJjvw3ThyQe+1Fu2vXNpd2t4fLaexCs
vYtjBatMyLwAp8EP2ILpDCGyD+aMv4DWgXKjnhYqZ50TpHE0nyUa/HOrvnC25YSj
1y8JOfHH1QW3HVkEFS1oy61TaB2SA8tZDrMFvZ6O9X6FoGB4uPQ=
=QTbx
-----END PGP SIGNATURE-----

--ZDwzZQYzZVCy0qwd--

