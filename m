Return-Path: <linux-efi+bounces-3727-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1BAB9B77
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B413B1BC0A78
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E9236A79;
	Fri, 16 May 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Td64L+Yz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Td64L+Yz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703982367DA
	for <linux-efi@vger.kernel.org>; Fri, 16 May 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396269; cv=none; b=LZcvgPx3CK6rXMurXUdPzYSvc3grFqNWKXdzTldPihkljMKStY+bsagtkh+KV1nEAum6lOkjFBdDenxBcaVc8tuI7u2x0rMjtm+buvA7i2f7nrdr2msBGWm36DY+89fZ2pjto9nRtbKQstNblEdsli570dnXyF+NwVQUR23n3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396269; c=relaxed/simple;
	bh=xOt4Duow+XFLav5sv34c0GQIEM5sAOkfR7bJCGEx5ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HraCEbVtKoR9KAhbmx685bXdf+Njr9dXYcGo1yN9yC2VRITz19lE8sTraQXSi6w1xsPzY1oYd6j1dXkSe8ICt9d2pvLn6D0hRvf21lk+VITbCviCu3G0otmWBwbOexv4RkByjy5u0Bx0ZVPz5qifpiZiiuIwasOCxlCrXSwwcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Td64L+Yz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Td64L+Yz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 845E01F394;
	Fri, 16 May 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747396265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xOt4Duow+XFLav5sv34c0GQIEM5sAOkfR7bJCGEx5ng=;
	b=Td64L+Yz+NJ7heFmcdZYlfFhnIQ2s8Y0V5LyVp0S4d0WsuapnfkMMfve7DgBHdwqxNZ0DG
	fhr+prutr+p7lzJ7yParkjbqj1kyS+lV9Tlgju1uNSp0sWzyGjLxq7Cmo/E40l2I5uwdEd
	ch7lnjXzWIUq8h0Pm+SGCXo44WCyvKo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747396265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xOt4Duow+XFLav5sv34c0GQIEM5sAOkfR7bJCGEx5ng=;
	b=Td64L+Yz+NJ7heFmcdZYlfFhnIQ2s8Y0V5LyVp0S4d0WsuapnfkMMfve7DgBHdwqxNZ0DG
	fhr+prutr+p7lzJ7yParkjbqj1kyS+lV9Tlgju1uNSp0sWzyGjLxq7Cmo/E40l2I5uwdEd
	ch7lnjXzWIUq8h0Pm+SGCXo44WCyvKo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8015113977;
	Fri, 16 May 2025 11:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFZdHagmJ2j/GwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 16 May 2025 11:51:04 +0000
Message-ID: <fca54172-f6f5-4594-8d87-58f5dad56244@suse.com>
Date: Fri, 16 May 2025 13:51:03 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
 <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
 <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>
 <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Eiwknt90AMlesfECRaPJQPb0"
X-Spam-Flag: NO
X-Spam-Score: -6.20
X-Spam-Level: 
X-Spamd-Result: default: False [-6.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	HAS_ATTACHMENT(0.00)[]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Eiwknt90AMlesfECRaPJQPb0
Content-Type: multipart/mixed; boundary="------------68JC13EZd5QsMl6N6ccONFcG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
Message-ID: <fca54172-f6f5-4594-8d87-58f5dad56244@suse.com>
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
 <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
 <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>
 <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>
In-Reply-To: <fbpq5hjdymw7hdzulssd5b4xarb4tqroi3kmhspkcbrd2f73gq@rptxof477v3c>

--------------68JC13EZd5QsMl6N6ccONFcG
Content-Type: multipart/mixed; boundary="------------0B2S5anz4hVBPPnXx0xcTl63"

--------------0B2S5anz4hVBPPnXx0xcTl63
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDUuMjUgMTM6NDcsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gRnJp
LCBNYXkgMTYsIDIwMjUgYXQgMDE6Mjk6MjdQTSArMDIwMCwgSsO8cmdlbiBHcm/DnyB3cm90
ZToNCj4+IE9uIDE2LjA1LjI1IDEzOjA5LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+
Pj4gT24gRnJpLCBNYXkgMTYsIDIwMjUgYXQgMTI6NDI6MjFQTSArMDIwMCwgSsO8cmdlbiBH
cm/DnyB3cm90ZToNCj4+Pj4gT24gMTYuMDUuMjUgMTE6MTUsIEtpcmlsbCBBLiBTaHV0ZW1v
diB3cm90ZToNCj4+Pj4+IEJvdGggSW50ZWwgYW5kIEFNRCBDUFVzIHN1cHBvcnQgNS1sZXZl
bCBwYWdpbmcsIHdoaWNoIGlzIGV4cGVjdGVkIHRvDQo+Pj4+PiBiZWNvbWUgbW9yZSB3aWRl
bHkgYWRvcHRlZCBpbiB0aGUgZnV0dXJlLg0KPj4+Pj4NCj4+Pj4+IFJlbW92ZSBDT05GSUdf
WDg2XzVMRVZFTCBhbmQgaWZkZWZmZXJ5IGZvciBpdCB0byBtYWtlIGl0IG1vcmUgcmVhZGFi
bGUuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxr
aXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPj4+Pj4gU3VnZ2VzdGVkLWJ5OiBC
b3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAgIERv
Y3VtZW50YXRpb24vYXJjaC94ODYvY3B1aW5mby5yc3QgICAgICAgICAgICB8ICA4ICsrKy0t
LS0NCj4+Pj4+ICAgICAuLi4vYXJjaC94ODYveDg2XzY0LzVsZXZlbC1wYWdpbmcucnN0ICAg
ICAgICAgfCAgOSAtLS0tLS0tLQ0KPj4+Pj4gICAgIGFyY2gveDg2L0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDIyICstLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+
ICAgICBhcmNoL3g4Ni9LY29uZmlnLmNwdWZlYXR1cmVzICAgICAgICAgICAgICAgICAgfCAg
NCAtLS0tDQo+Pj4+PiAgICAgYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL3BndGFibGVfNjQu
YyAgICAgICAgIHwgMTEgKystLS0tLS0tLQ0KPj4+Pj4gICAgIGFyY2gveDg2L2Jvb3QvaGVh
ZGVyLlMgICAgICAgICAgICAgICAgICAgICAgICB8ICA0IC0tLS0NCj4+Pj4+ICAgICBhcmNo
L3g4Ni9ib290L3N0YXJ0dXAvbWFwX2tlcm5lbC5jICAgICAgICAgICAgfCAgNSArLS0tLQ0K
Pj4+Pj4gICAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhZ2VfNjQuaCAgICAgICAgICAgICAg
ICB8ICAyIC0tDQo+Pj4+PiAgICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFnZV82NF90eXBl
cy5oICAgICAgICAgIHwgIDcgLS0tLS0tDQo+Pj4+PiAgICAgYXJjaC94ODYvaW5jbHVkZS9h
c20vcGd0YWJsZV82NF90eXBlcy5oICAgICAgIHwgMTggLS0tLS0tLS0tLS0tLS0tDQo+Pj4+
PiAgICAgYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMgICAgICAgICAgICAgICAgIHwg
IDIgKy0NCj4+Pj4+ICAgICBhcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiAtLQ0KPj4+Pj4gICAgIGFyY2gveDg2L2tlcm5lbC9oZWFkXzY0LlMg
ICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+Pj4+PiAgICAgYXJjaC94ODYvbW0vaW5p
dC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgLS0tLQ0KPj4+Pj4gICAgIGFy
Y2gveDg2L21tL3BndGFibGUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+
Pj4+PiAgICAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtNWx2bC5jICAgICAg
IHwgIDIgKy0NCj4+Pj4+ICAgICAxNiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA5NCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gVGhlcmUgYXJlIHNvbWUgaW5zdGFuY2Vz
IG9mOg0KPj4+Pg0KPj4+PiAjaWYgQ09ORklHX1BHVEFCTEVfTEVWRUxTID49IDUNCj4+Pj4N
Cj4+Pj4gaW4gNjQtYml0LW9ubHkgY29kZSB1bmRlciBhcmNoL3g4Niwgd2hpY2ggY291bGQg
YmUgc2ltcGxpZmllZCwgdG9vLg0KPj4+Pg0KPj4+PiBUaGV5IGFyZSBzdGlsbCBjb3JyZWN0
LCBidXQgSSB3YW50ZWQgdG8gaGludCBhdCBmdXJ0aGVyIGNvZGUgcmVtb3ZhbHMNCj4+Pj4g
YmVpbmcgcG9zc2libGUuDQo+Pj4NCj4+PiBPa2F5LCBmYWlyIGVub3VnaC4gRml4dXAgaXMg
YmVsb3cuDQo+Pj4NCj4+PiBEaWQgSSBtaXNzIGFueXRoaW5nIGVsc2U/DQo+Pg0KPj4gWWVz
Lg0KPj4NCj4+IE9uZSBtb3JlIGluc3RhbmNlIGluIGFyY2gveDg2L3hlbi9tbXVfcHYuYywN
Cj4gDQo+IEFoLiBSaWdodC4NCj4gDQo+PiBvbmUgaW4gYXJjaC94ODYvaW5jbHVkZS9hc20v
cGFyYXZpcnQuaCwNCj4+IG9uZSBpbiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90
eXBlcy5oLA0KPj4gb25lIGluIGFyY2gveDg2L2tlcm5lbC9wYXJhdmlydC5jDQo+IA0KPiBI
bS4gSXMgcGFyYXZpcnQgNjQtYml0IG9ubHk/DQo+IA0KDQpDT05GSUdfUEFSQVZJUlRfWFhM
IGlzLg0KDQoNCkp1ZXJnZW4NCg==
--------------0B2S5anz4hVBPPnXx0xcTl63
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------0B2S5anz4hVBPPnXx0xcTl63--

--------------68JC13EZd5QsMl6N6ccONFcG--

--------------Eiwknt90AMlesfECRaPJQPb0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgnJqgFAwAAAAAACgkQsN6d1ii/Ey/3
JAf9FsFA467/bRP8XoWPvLsIRm6H2DV8fpJ72ah6bYS5gVADZpx3ALYGg7nTdYhDnFqS4tUKEHx+
yOTukLyB9/x9xvr1rcsaWsudujuQbebwRwSJ7Lcf+m+01yWS6CufnaZPgIwhY25V+whheouGUp7K
ENyR80EGaaduV0lAkS6K3WWIV9uJZLM6TtBd8ir/DP4AIaxZlh51j/iQgiRyH5QrRVOdj1pIJ2j5
SRFESbzQD+hCQf7Tpyys8w+bIMkT3IGkkSEfw9XvIa7eEzsFbodp4pL+DBAROAhAGJGJH8l/9UpF
h7GAWylMtPWGG4GmtdURQRe8R6StYPfAVWcERQJKHw==
=QWCy
-----END PGP SIGNATURE-----

--------------Eiwknt90AMlesfECRaPJQPb0--

