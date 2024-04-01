Return-Path: <linux-efi+bounces-913-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A14894774
	for <lists+linux-efi@lfdr.de>; Tue,  2 Apr 2024 00:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639B4B213DD
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3DC2E822;
	Mon,  1 Apr 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="uB9hx2Ns"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4056B78
	for <linux-efi@vger.kernel.org>; Mon,  1 Apr 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011489; cv=none; b=jHYL4M3nLQwUJcLTdT7qIQFMPs4qsyMpeBMBLonzuFWVdgvOhDjWKkW8I3t2gadYivxvZtZyI5y32npsZ77BQgL9uh7BTBx+xZv11OQfVv5Lj1mTYz2PCXBt6lWz/198D6dpM22cKk9VHJDOalX+iJpiees/qr/JcyUG4PSJS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011489; c=relaxed/simple;
	bh=IqTxP6MAaADfSiLtLnKmzpDhHoIeGwlP4HGHqpHgvI8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNDY/JLVzELR4ZUxLoUMwT7gd9qwBRu/uxiZJ/c/EM6v6fVhQhXLmiZtpqx2cbwgIj6oHFa4d9CoHtOV2GWqk00/OJEFrqZbFbkgsoWE9SdFH0PkXerI6sV3CluYUvuk8jD5IgvhKaO+/s+ZeGcEjTLsbb56PAagAlAXGJqdjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=uB9hx2Ns; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Mon, 1 Apr 2024 15:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1712011484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqTxP6MAaADfSiLtLnKmzpDhHoIeGwlP4HGHqpHgvI8=;
	b=uB9hx2Nsrh2B0sXIAks4hvNgr/u3SN138VrofuuR6Hb8oXJkIe4jeanOBdCBfGT5a3DKPG
	g9ef+VcEC8kq0Q5gRuIjxzkXzUhRMCsLSA/LQI2291QTN6U5iRce5o/FUljGj0OvggCmAE
	Qs32lO7g7/YSNqSLtOsRbuP8puFR5DxSTQb2LULaMmcD9u+294NDIrmgv/ccJh/30wusJQ
	1/tLF07MMr5qJEKJKjkKME5W46QDJhU6XhyZ/PiUIOv0NNaVUp4C7t+Z6Koy0fl5ExBZJ5
	ULk0ve2q+gQmp9yXvCVl0HU1jc5o5SHSvsXRsTbc1oFUEwlruLJiJspQ6o68xg==
Message-ID: <20240401154436.GB26633@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 regressions@lists.linux.dev
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
In-Reply-To: <CAMj1kXGyKdoLZ9t9_X4diiy9GsqxJ_NkHsm_t+cAJBxhHW7mAA@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <a3aae375-5582-46e4-866b-6a81641998af@redhat.com>
 <CAMj1kXGrWGGv-aXabsn1oRwwMy-Ck1nz85QkEMqQ8LdQxyeBKQ@mail.gmail.com>
 <749b1cea4fd9e8d8debadc51cf3c0374d9878ae9@craftyguy.net>
 <CAMj1kXGyKdoLZ9t9_X4diiy9GsqxJ_NkHsm_t+cAJBxhHW7mAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="fpZYhPLy/yUVa6iM"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--fpZYhPLy/yUVa6iM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

T24gU3VuLCAyNCBNYXIgMjAyNCAyMjo1Mzo0NyArMDIwMCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4gPiBJIHB1c2hlZCBhbm90
aGVyIGJyYW5jaAo+ID4gPgo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9hcmRiL2xpbnV4LmdpdC9sb2cvP2g9ZWZpLWNsYXl0b24tMwo+ID4gPgo+
ID4gPiB3aGljaCBoYXMgYSBwcm9wZXIgZml4IGZvciB0aGUgaXNzdWUgdGhhdCB5b3UgZm91bmQu
Cj4gPiA+Cj4gPiA+IEFzIGl0IHR1cm5zIG91dCwgdGhlIGNvbXBhdCBtaXhlZCBtb2RlICh3aXRo
IGhhbmRvdmVyIHByb3RvY29sKSB3YXMKPiA+ID4KPiA+ID4gYnJva2VuIGZyb20gdGhlIGJlZ2lu
bmluZywgYW5kIHRoZSBjaGFuZ2UgeW91IGlkZW50aWZpZWQganVzdCBoYXBwZW5lZAo+ID4gPgo+
ID4gPiB0byB0cmlnZ2VyIGl0IG9uIHlvdXIgaGFyZHdhcmUuCj4gPgo+ID4KPiA+IFRlc3RlZCBh
bmQgZml4ZXMgYm9vdGluZyBvbiBteSBCYXkgVHJhaWwgdGFibGV0IGFuZCBOVUMuIFRoYW5rcyBm
b3IgZml4aW5nIHRoaXMhCj4gPgo+ID4gVGVzdGVkLWJ5OiBDbGF5dG9uIENyYWZ0IDxjbGF5dG9u
QGNyYWZ0eWd1eS5uZXQ+CgpTby4uLiBtYXliZSBteSB0ZXN0aW5nIHdhc24ndCBhcyB0aG9yb3Vn
aCBhcyBJIHRob3VnaHQsIE9SIEkgYW0gZXhwZXJpZW5jaW5nIGFuCnVucmVsYXRlZCBwcm9ibGVt
LiBJbiBhbnkgY2FzZSwgSSdtIGhhdmluZyBzb21lIGRpZmZpY3VsdHkgZmlndXJpbmcgb3V0IHdo
YXQgdG8KYmxhbWUuIFdoZW4gdXNpbmcgdGhpcyBwYXRjaCBvbiB0aGUgNi42IExUUzoKCjEpIGtl
cm5lbCBzZWVtcyB0byBwYW5pYyByaWdodCBhZnRlciBkaXNwbGF5aW5nIGBkaXNhYmxpbmcgYm9v
dGNvbiBbZWZpZmIwXWAuIEkKZGV0ZXJtaW5lZCB0aGF0IGl0J3MgcGFuaWNraW5nIGJ5IHNldHRp
bmcgYHBhbmljPS0xYCBhbmQgc2VlaW5nIGl0IHJlYm9vdCBhZnRlcgpzaG93aW5nIHRoYXQgbWVz
c2FnZS4gSSBjYW4gd29yayBhcm91bmQgaXQgYnkgc2V0dGluZyBga2VlcF9ib290Y29uYCwgYnV0
IHRoYXQncwpub3QgaWRlYWwuCgoyKSBrZXJuZWwgY29tcGxhaW5zIGFib3V0IG5vIHJvb3QgKGZy
b20gaW5pdHJkKS4gSSBjYW4gd29yayBhcm91bmQgdGhpcyBieQpwYXNzaW5nIGBpbml0cmQ9bXkt
aW5pdHJhbWZzYCBvbiB0aGUga2VybmVsIGNtZGxpbmUuCgpJIGhhdmVuJ3QgdHJpZWQgYW55IG5l
d2VyIGtlcm5lbHMgeWV0LiBUaGUgc2Vjb25kIGlzc3VlIGFib3ZlIG1ha2VzIG1lIHdvbmRlciBp
Zgp5b3VyIHBhdGNoIHJlbGF0ZWQgdG8gYXJncyBtaWdodCBiZSB0byBibGFtZSwgYnV0IEknbSBu
b3Qgc3VyZS4gQW55IGhlbHAgcG9raW5nCmFyb3VuZCBmdXJ0aGVyIHdvdWxkIGJlIGdyZWF0bHkg
YXBwcmVjaWF0ZWQgOikKCi1DbGF5dG9uCg==

--fpZYhPLy/yUVa6iM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmYLONQACgkQSkztbX7f
lQreeA/+ISYhfctY3E26tF3E1urqhF/W1EHFZCPlKqRbdj894UQ8jOThbzq+E73y
dXvGu/dLCEooVJi8/ueTCzyUQBDDJe9uiZnpvCLs929NJ07yBaN/cz4kIPH+AaLi
LaFUDuPgiJrBlBF5FAtx0NBCQCIg3m7R8drPg8ToAjR/wbsOOcFw1qtbBKni6UGZ
b7f3LMiUkLHCx/39+G/uD+HR5Enel6BG/Tg/kWC2g/aFiyn4vec7CpuEa09NbPZG
MzZyj4wxc2FCKATcqy7imGGiVLetveKtXHgdRnYHo26OyMPTdPALyREFKHdbfPcD
urGj7434ruzxKLdk85YgHQx2OEbFWVxeK2FN0zplToP1RUPKN6Uf1cPDXDhHc0gm
SGVOzAyue63XMT0JaVh3YccQwK0u9KKk8nZr//9tFQ1ye9auunRRZKC4MAcKb6Qk
Qb5YyQ2vGi3gSaY4e/ObeXecHpdexjC/GkVZSG1JF5rUilg6Z5x7dXkyMARcutev
b9Z6UsJ4HmjfohV3rlwnXd+F2SrpGJgyAqNvkWXde3eGvoqxlqZ994S7smYXpQ0a
ZLzeK9h1JHZkGKkDZx5fyJ1awAOd3WgBQpuGPbtKMNP+bQyi99Rra5jVFSb6V5WO
X/YYAytXarwsDITd1UdtJjWuRNRJvbzBNkLAu3kukjuSAJbKlQE=
=3hLn
-----END PGP SIGNATURE-----

--fpZYhPLy/yUVa6iM--

