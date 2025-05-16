Return-Path: <linux-efi+bounces-3723-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BAAB9A5F
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 12:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34AB4E08B7
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900623507E;
	Fri, 16 May 2025 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IURTkVMI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727E21B9E2
	for <linux-efi@vger.kernel.org>; Fri, 16 May 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392148; cv=none; b=iF2HY6NRSdrjlR/rK2i5NcfWNn3lnK7Ko8U7EZsrCeUEB0+ucHvWrm7HR/KcPdnPkbmL7/nuOyHfGKG+03A4wfIOPFWfEZ8nKZaoOLy1Dk/MSdIWG035B39MuzHee8nhFxWxFAHfBKFgUs7zBwtRqRq3P6M2lDzqY2YFG6o7aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392148; c=relaxed/simple;
	bh=Hc8t9atv4fpFog7hirL8DOXDeOQFYClBoxp14PBEVKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+HqKwj9slRXCiX8q6NkBY+FwTWgCHD0TcnDKhMt5aqIDlLW+8G4NyGVJdoy94ucC9D64z1mX7b4tzGS0lYs20OFimtkVCT5sA6Mag97BhgrmDM/NFiZU2p1+t8oR+RiOzwRknfnRXc/kyCwyXLcIxKMumcK6LmF93Y0aPl61xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IURTkVMI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a35da8bd67so501397f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 16 May 2025 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747392144; x=1747996944; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hc8t9atv4fpFog7hirL8DOXDeOQFYClBoxp14PBEVKE=;
        b=IURTkVMIHE8CufrklxhGJJmveZD9GQKB4U91Xn5cKASTF/ujEPMAH3wQ8N3xaa9zaG
         qvw5iFDwgWWUtdWPVperJdRPHRDCTK+XWZFy53iEKC06z318eeuxEimcqNfvwCobuKJg
         r8Q2mdbAUHEu8Rs/sVeea6aXUQTtrskO3fEHZjq64QfuZdSvTe2gEgLd7GdwYuYDTCbC
         44E2BL44cA3pEGQffRs3qJ/0ZvL5ickJTpD8HcGUL+DTnQwsla8EBfRjM5Dd857Hswdl
         xIC/pzzAczK9F71p+88SpK5I0p25vbC2y2yLUTJlIthMkir9XQ3kiXY9uM8cOpd9+o8n
         0ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747392144; x=1747996944;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc8t9atv4fpFog7hirL8DOXDeOQFYClBoxp14PBEVKE=;
        b=T24dSeUY55Ut6mg5ZaKU4vQirSbmCaD+SLi5s0DZs97kWFOWq/DlVizpbposbWPYoB
         4muAq6iWlQbJzcJUUuF3c4sB/Dl8qSw8yBmPre51eIaVsf/lrDvX2XWv0iQ4PFKEDeD8
         kfOaqiVgYQEj74GZ1yBTVvIIFFxRgXnclscFZx/gLg6HLXbpwMwhb4yo/So6t2hl5h4P
         s9jkeHIbwh/p6ZQ8wP8+bvAy2auDxw+hJOSJeb5XLIt0mypMPU4VvU65HsE0iplgYZZc
         0CQycARMMJBzTxPgw12ZN7/H81LFXOWabLX4EJx/del+BwZGmx7FvnYkBBtOkPsW7Ylb
         Hkrg==
X-Forwarded-Encrypted: i=1; AJvYcCWV5iEuKbp7w8ul7GetjYq1PFLm2QtFp6jndFZyuESwImt8sioNydPxYUSNEfreXarmwOYAekxhRpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVquNK5OmyQ6lYsxJIZwehBXj5ApvtBLietEsDPLrU2wcRBipW
	ZLXU2nBmGj1DHgALdyI/7l0ALz4DEc2M0BIx6NKg4RFR9WbMrmyqLH4fjEJ/HGtHsYM=
X-Gm-Gg: ASbGncsB01WBu511N5VSf9DueIt/b5UwxYopisiLIssWqTYHXG2knHhTrSM6/6xiXUK
	MVOc4uqA7GJcQ7mnFgjnE9IUwYqBVGGnGYQLj7J59CYQm4v0dfuMnSUjc/qwNWJIUMQ6Lizcqud
	79/l5un8zaJyIfUCFoDkeFFMimgv0LZhpxrrt0d/ykm11EoyCG2tJGLNDEduExOJm22E4eqvHoD
	E4nTBtcdjj7oO2EGM2LGqYfwNgvwjQoE60VcNmWQ5BAqm3kzojoPgZAg1001iZmC7Tq0+ZVzMiF
	mzvGI9hw6Xekdv8caF2VF0HIBqzcUl3LMq3S5C664/l53PWOaIkRyjoxDdHpNjOI4t195eKhEwv
	OFgwh5UqHmBuLKNxLrD/CllA3gvgtWXLSSD7x3KGvrHhmuCIVZsSQJ4oogANFllqO7MqezxgWCJ
	DK
X-Google-Smtp-Source: AGHT+IGzDF2pGCAsvZ8sCjnKAYFrxAilZcpoyAUFibDM9GZPAumjW+h5LuQj3I8QuNtrS85uIQNJaw==
X-Received: by 2002:adf:f048:0:b0:3a3:5cca:a55e with SMTP id ffacd0b85a97d-3a35ffd28edmr1340240f8f.41.1747392144031;
        Fri, 16 May 2025 03:42:24 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f338070csm100087585e9.15.2025.05.16.03.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 03:42:23 -0700 (PDT)
Message-ID: <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
Date: Fri, 16 May 2025 12:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------h992ua0zbd7j7dBeHqQzGy9A"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------h992ua0zbd7j7dBeHqQzGy9A
Content-Type: multipart/mixed; boundary="------------LcjDojQIdU6adEh2O9mhOsdr";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
Message-ID: <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>

--------------LcjDojQIdU6adEh2O9mhOsdr
Content-Type: multipart/mixed; boundary="------------Q43IOLb0wAgXa0Ac93H8yBNv"

--------------Q43IOLb0wAgXa0Ac93H8yBNv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDUuMjUgMTE6MTUsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gQm90aCBJ
bnRlbCBhbmQgQU1EIENQVXMgc3VwcG9ydCA1LWxldmVsIHBhZ2luZywgd2hpY2ggaXMgZXhw
ZWN0ZWQgdG8NCj4gYmVjb21lIG1vcmUgd2lkZWx5IGFkb3B0ZWQgaW4gdGhlIGZ1dHVyZS4N
Cj4gDQo+IFJlbW92ZSBDT05GSUdfWDg2XzVMRVZFTCBhbmQgaWZkZWZmZXJ5IGZvciBpdCB0
byBtYWtlIGl0IG1vcmUgcmVhZGFibGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwg
QS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IFN1Z2dl
c3RlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IC0tLQ0KPiAgIERv
Y3VtZW50YXRpb24vYXJjaC94ODYvY3B1aW5mby5yc3QgICAgICAgICAgICB8ICA4ICsrKy0t
LS0NCj4gICAuLi4vYXJjaC94ODYveDg2XzY0LzVsZXZlbC1wYWdpbmcucnN0ICAgICAgICAg
fCAgOSAtLS0tLS0tLQ0KPiAgIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDIyICstLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNoL3g4Ni9LY29u
ZmlnLmNwdWZlYXR1cmVzICAgICAgICAgICAgICAgICAgfCAgNCAtLS0tDQo+ICAgYXJjaC94
ODYvYm9vdC9jb21wcmVzc2VkL3BndGFibGVfNjQuYyAgICAgICAgIHwgMTEgKystLS0tLS0t
LQ0KPiAgIGFyY2gveDg2L2Jvb3QvaGVhZGVyLlMgICAgICAgICAgICAgICAgICAgICAgICB8
ICA0IC0tLS0NCj4gICBhcmNoL3g4Ni9ib290L3N0YXJ0dXAvbWFwX2tlcm5lbC5jICAgICAg
ICAgICAgfCAgNSArLS0tLQ0KPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhZ2VfNjQuaCAg
ICAgICAgICAgICAgICB8ICAyIC0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFnZV82
NF90eXBlcy5oICAgICAgICAgIHwgIDcgLS0tLS0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9h
c20vcGd0YWJsZV82NF90eXBlcy5oICAgICAgIHwgMTggLS0tLS0tLS0tLS0tLS0tDQo+ICAg
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMgICAgICAgICAgICAgICAgIHwgIDIgKy0N
Cj4gICBhcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMgICAgICAgICAgICAgICAgICAgICAgfCAg
MiAtLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9oZWFkXzY0LlMgICAgICAgICAgICAgICAgICAg
ICB8ICAyIC0tDQo+ICAgYXJjaC94ODYvbW0vaW5pdC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDQgLS0tLQ0KPiAgIGFyY2gveDg2L21tL3BndGFibGUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1
Yi94ODYtNWx2bC5jICAgICAgIHwgIDIgKy0NCj4gICAxNiBmaWxlcyBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCA5NCBkZWxldGlvbnMoLSkNCg0KVGhlcmUgYXJlIHNvbWUgaW5zdGFu
Y2VzIG9mOg0KDQojaWYgQ09ORklHX1BHVEFCTEVfTEVWRUxTID49IDUNCg0KaW4gNjQtYml0
LW9ubHkgY29kZSB1bmRlciBhcmNoL3g4Niwgd2hpY2ggY291bGQgYmUgc2ltcGxpZmllZCwg
dG9vLg0KDQpUaGV5IGFyZSBzdGlsbCBjb3JyZWN0LCBidXQgSSB3YW50ZWQgdG8gaGludCBh
dCBmdXJ0aGVyIGNvZGUgcmVtb3ZhbHMNCmJlaW5nIHBvc3NpYmxlLg0KDQoNCkp1ZXJnZW4N
Cg==
--------------Q43IOLb0wAgXa0Ac93H8yBNv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------Q43IOLb0wAgXa0Ac93H8yBNv--

--------------LcjDojQIdU6adEh2O9mhOsdr--

--------------h992ua0zbd7j7dBeHqQzGy9A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgnFo4FAwAAAAAACgkQsN6d1ii/Ey9i
3Qf/eoetVr9X2s8c2Kxx3UrBEabLIZ4kYmfDwlmoH7ZN0f1mnbE1oyNVvgVYd38Klrac4cbLMeIv
keQBD+TwZE74sk+wUcQSMfHmyx7CM/B/1tKA+7CpLFYxq7mjZjJ7fUj+15KVJyL0Td8sZDWtQhQ2
uvJwBg6wShpTbEr4WxLaeM63+Uk+XRs99MTDUWXU/oj8oxVjkspE8Rl5BqqIQAVekwqUS2vbMP5s
DCqgZBWAnIRRoojGlfQcX+NuTlXBBtMbRvGf8T6DWALAMENf/7GpKJriFVdSGqRmSwznZoGZIVxw
dChi3rKICadeAP+9p1wRipg9bGJKp3NjzhzbNmIhIQ==
=wbjB
-----END PGP SIGNATURE-----

--------------h992ua0zbd7j7dBeHqQzGy9A--

