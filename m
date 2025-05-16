Return-Path: <linux-efi+bounces-3725-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14BAB9B0B
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B56C7A62A1
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7872367C4;
	Fri, 16 May 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L4CDeVWn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADF22F743
	for <linux-efi@vger.kernel.org>; Fri, 16 May 2025 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394973; cv=none; b=sfnifbOKgW4Qx3+pLme79rI1WZu3nYIUJCiJMHaNkj2sxwwMOfi+Vo5FiA+MesBHaYzmj7gaUsR3Sh7LAgPRdnGV+wCNgtocxjPcLQTMO7OANlpVaYEsJKGFxYR9jf8+M5tMxgm6wGNuTk6+8wUHMsU3cjyybYToZAai9EVEzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394973; c=relaxed/simple;
	bh=lx3ZnbJ8D1Vx/zYL8QEh2/tlJsc2zjevswU0UTmTozU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpWBLKWn1E65eN0MzZsvH4kXw2PTxXFe22tOp3czN7A/KKTP9HcBdV5JwU1Uo/dRc2wJ4/o9DCySZclSLJLBPQt7R0SBfkUUl7XyZZ+uUzG0XUl8mm+lm9eZ3pnJQxP8CsmZ9/x+02NY1I0ivT3uyhWhZVTwNAHbUa4cFOhzyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L4CDeVWn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so3076332a12.3
        for <linux-efi@vger.kernel.org>; Fri, 16 May 2025 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747394969; x=1747999769; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lx3ZnbJ8D1Vx/zYL8QEh2/tlJsc2zjevswU0UTmTozU=;
        b=L4CDeVWnOYtqbfjKzecosFmsnejreH6AJMkKA84YjpZ4TUCflcBUftsjq+hLcluZRx
         In9l8LV6/J/F2tZB20h6THPu3V/SRlGdcmRDlLNzHoZ3+0LaVN6SAP2PVLeqLnKzHOIy
         tsXHe7IAh8qTMIUhrQoCAicmws9CIbw5+EEJE/A0EsLobjNz97QP4uZtGGKwALD2ce8D
         6Ptew5umdi1koHQIPo7HSlPkYa9Vn3yZS5PqJU/kPk/5uCITu7CTh41lOMszWTeY5oG2
         hb154mmMFTPlbLhVCrz0sAYmhQaK+PUNovnGo0BA/odkMYaPQarF+XkBmQCtsEeujb1n
         7Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747394969; x=1747999769;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx3ZnbJ8D1Vx/zYL8QEh2/tlJsc2zjevswU0UTmTozU=;
        b=tBFp9hpcEBTYXMtJ5dBX1vf9SLLPLM4P4X9PqJ3WpCSM7dHK/AKpOnz7cIE7mMVvBs
         8GQsH0I0uVKRZxhKhZsfq2v/ZXyoyhoE3GGgv7f5Hru/qMklUxNXmdw+RyqMzN3+X/Nn
         1Ubz0UmmRIj4lWBacn+9vJV6ueZWWDwlhhaFjKpK6NJ6XIV9nWCQ4wQ643yytiKcX3CN
         Tyb/p6MGCBNf1HtlW4ESKygo14LCWPmYwC8o5plNGUuuFgLDNsFiPtFCaSyuPj8M9ajr
         NP+NzdROWHMvwLRRqPgDN/708HFsTm65oquWuz8agMDOZ1dIQSx9LWpb7Fbs7nK/yQlD
         Zv0g==
X-Forwarded-Encrypted: i=1; AJvYcCWC8Ce1Pn+Dvo9n04Ta/vQzxX4LL1minZQ+O7S3BoBYDmGO/pIy6tHODiB1Za3Clwd8deUoT2yHYyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+j5usf6xscCa5jGp7Aq3gN+5ja7ojGisCQ2IFnoQ74+ZZ19q
	ZMzZR/loLHnpjuOxZaxhK7XmMJoObxU8wW+UXye2GIbtb0nm6dM1HcHdvvBa17QsiAI=
X-Gm-Gg: ASbGncsaMKP1G6o5sXtNegoL1FK4Ea0xsBsGCEeNXtrFrBZL5SUd1dOREqFcFmDkpvw
	6jh6jyh+/4SCSeRCzwwWs1D7MRAQ8LOvvZd7Fg2wQtmnYL7NJmm0H75037Gxtm1B1gzA0wKzZib
	iZKd6w1Mf+hpG8sRrEciucHSD9OT1P56vVZBV+ZbKOdsCpJNCuYESzWklcdTRJUQQ0mmGXfUgnd
	imJ3uXK5vnIQtgaWuHLghq/UTdXUZCWHzA/f/vXc0brpFyF6dtkCDyRVjONJom4AtRwgrfHZVv0
	KTu/BZVbQ/ip8jRWN2FOcSuzWDmftbhCAgy2bE0f0xuLYCnd7nISgg/tuojZQG2cOMfu9eYteLN
	nJV6N5IbAXsGLQgpdlsg75COd0CFsZyM+yFDW9zT33PP8yJK8c24wbOOtAbXaNJy1unHUlcIUZo
	kRO8FfnTQfsLk=
X-Google-Smtp-Source: AGHT+IHUXyVsv1xttXUXWNxCD1WVA2GLAyUyvDKqRxK9+9DWGO+hc2LBjxThaESjuf5EKHMzEneqlQ==
X-Received: by 2002:a05:6402:3509:b0:601:7a58:4afa with SMTP id 4fb4d7f45d1cf-6017a584f89mr1269265a12.14.1747394969419;
        Fri, 16 May 2025 04:29:29 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d4f1c7esm1296321a12.14.2025.05.16.04.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 04:29:29 -0700 (PDT)
Message-ID: <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>
Date: Fri, 16 May 2025 13:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
In-Reply-To: <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CymqGH96G71Tbf8XGvvggu1f"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CymqGH96G71Tbf8XGvvggu1f
Content-Type: multipart/mixed; boundary="------------17wFTfAy0AWdHiCoJoEwcMnN";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <51d78ee7-4b68-425b-bccb-d123d7210305@suse.com>
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
 <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
In-Reply-To: <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>

--------------17wFTfAy0AWdHiCoJoEwcMnN
Content-Type: multipart/mixed; boundary="------------jf3AJhHNZgwVQ7NlRDjQicxJ"

--------------jf3AJhHNZgwVQ7NlRDjQicxJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDUuMjUgMTM6MDksIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gRnJp
LCBNYXkgMTYsIDIwMjUgYXQgMTI6NDI6MjFQTSArMDIwMCwgSsO8cmdlbiBHcm/DnyB3cm90
ZToNCj4+IE9uIDE2LjA1LjI1IDExOjE1LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+
Pj4gQm90aCBJbnRlbCBhbmQgQU1EIENQVXMgc3VwcG9ydCA1LWxldmVsIHBhZ2luZywgd2hp
Y2ggaXMgZXhwZWN0ZWQgdG8NCj4+PiBiZWNvbWUgbW9yZSB3aWRlbHkgYWRvcHRlZCBpbiB0
aGUgZnV0dXJlLg0KPj4+DQo+Pj4gUmVtb3ZlIENPTkZJR19YODZfNUxFVkVMIGFuZCBpZmRl
ZmZlcnkgZm9yIGl0IHRvIG1ha2UgaXQgbW9yZSByZWFkYWJsZS4NCj4+Pg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4Lmlu
dGVsLmNvbT4NCj4+PiBTdWdnZXN0ZWQtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPg0KPj4+IC0tLQ0KPj4+ICAgIERvY3VtZW50YXRpb24vYXJjaC94ODYvY3B1aW5mby5y
c3QgICAgICAgICAgICB8ICA4ICsrKy0tLS0NCj4+PiAgICAuLi4vYXJjaC94ODYveDg2XzY0
LzVsZXZlbC1wYWdpbmcucnN0ICAgICAgICAgfCAgOSAtLS0tLS0tLQ0KPj4+ICAgIGFyY2gv
eDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIyICstLS0tLS0t
LS0tLS0tLS0tLS0NCj4+PiAgICBhcmNoL3g4Ni9LY29uZmlnLmNwdWZlYXR1cmVzICAgICAg
ICAgICAgICAgICAgfCAgNCAtLS0tDQo+Pj4gICAgYXJjaC94ODYvYm9vdC9jb21wcmVzc2Vk
L3BndGFibGVfNjQuYyAgICAgICAgIHwgMTEgKystLS0tLS0tLQ0KPj4+ICAgIGFyY2gveDg2
L2Jvb3QvaGVhZGVyLlMgICAgICAgICAgICAgICAgICAgICAgICB8ICA0IC0tLS0NCj4+PiAg
ICBhcmNoL3g4Ni9ib290L3N0YXJ0dXAvbWFwX2tlcm5lbC5jICAgICAgICAgICAgfCAgNSAr
LS0tLQ0KPj4+ICAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhZ2VfNjQuaCAgICAgICAgICAg
ICAgICB8ICAyIC0tDQo+Pj4gICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFnZV82NF90eXBl
cy5oICAgICAgICAgIHwgIDcgLS0tLS0tDQo+Pj4gICAgYXJjaC94ODYvaW5jbHVkZS9hc20v
cGd0YWJsZV82NF90eXBlcy5oICAgICAgIHwgMTggLS0tLS0tLS0tLS0tLS0tDQo+Pj4gICAg
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMgICAgICAgICAgICAgICAgIHwgIDIgKy0N
Cj4+PiAgICBhcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMgICAgICAgICAgICAgICAgICAgICAg
fCAgMiAtLQ0KPj4+ICAgIGFyY2gveDg2L2tlcm5lbC9oZWFkXzY0LlMgICAgICAgICAgICAg
ICAgICAgICB8ICAyIC0tDQo+Pj4gICAgYXJjaC94ODYvbW0vaW5pdC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDQgLS0tLQ0KPj4+ICAgIGFyY2gveDg2L21tL3BndGFibGUu
YyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+Pj4gICAgZHJpdmVycy9maXJt
d2FyZS9lZmkvbGlic3R1Yi94ODYtNWx2bC5jICAgICAgIHwgIDIgKy0NCj4+PiAgICAxNiBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA5NCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBUaGVyZSBhcmUgc29tZSBpbnN0YW5jZXMgb2Y6DQo+Pg0KPj4gI2lmIENPTkZJR19QR1RB
QkxFX0xFVkVMUyA+PSA1DQo+Pg0KPj4gaW4gNjQtYml0LW9ubHkgY29kZSB1bmRlciBhcmNo
L3g4Niwgd2hpY2ggY291bGQgYmUgc2ltcGxpZmllZCwgdG9vLg0KPj4NCj4+IFRoZXkgYXJl
IHN0aWxsIGNvcnJlY3QsIGJ1dCBJIHdhbnRlZCB0byBoaW50IGF0IGZ1cnRoZXIgY29kZSBy
ZW1vdmFscw0KPj4gYmVpbmcgcG9zc2libGUuDQo+IA0KPiBPa2F5LCBmYWlyIGVub3VnaC4g
Rml4dXAgaXMgYmVsb3cuDQo+IA0KPiBEaWQgSSBtaXNzIGFueXRoaW5nIGVsc2U/DQoNClll
cy4NCg0KT25lIG1vcmUgaW5zdGFuY2UgaW4gYXJjaC94ODYveGVuL21tdV9wdi5jLA0Kb25l
IGluIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmgsDQpvbmUgaW4gYXJjaC94ODYv
aW5jbHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaCwNCm9uZSBpbiBhcmNoL3g4Ni9rZXJuZWwv
cGFyYXZpcnQuYw0KDQoNCkp1ZXJnZW4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMgYi9hcmNoL3g4Ni9lbnRyeS92c3lzY2Fs
bC92c3lzY2FsbF82NC5jDQo+IGluZGV4IDJmYjdkNTNjZjMzMy4uYzkxMDNhNmZhMDZlIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF82NC5jDQo+
ICsrKyBiL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMNCj4gQEAgLTM0
MSw5ICszNDEsNyBAQCB2b2lkIF9faW5pdCBzZXRfdnN5c2NhbGxfcGd0YWJsZV91c2VyX2Jp
dHMocGdkX3QgKnJvb3QpDQo+ICAgCXBnZCA9IHBnZF9vZmZzZXRfcGdkKHJvb3QsIFZTWVND
QUxMX0FERFIpOw0KPiAgIAlzZXRfcGdkKHBnZCwgX19wZ2QocGdkX3ZhbCgqcGdkKSB8IF9Q
QUdFX1VTRVIpKTsNCj4gICAJcDRkID0gcDRkX29mZnNldChwZ2QsIFZTWVNDQUxMX0FERFIp
Ow0KPiAtI2lmIENPTkZJR19QR1RBQkxFX0xFVkVMUyA+PSA1DQo+ICAgCXNldF9wNGQocDRk
LCBfX3A0ZChwNGRfdmFsKCpwNGQpIHwgX1BBR0VfVVNFUikpOw0KPiAtI2VuZGlmDQo+ICAg
CXB1ZCA9IHB1ZF9vZmZzZXQocDRkLCBWU1lTQ0FMTF9BRERSKTsNCj4gICAJc2V0X3B1ZChw
dWQsIF9fcHVkKHB1ZF92YWwoKnB1ZCkgfCBfUEFHRV9VU0VSKSk7DQo+ICAgCXBtZCA9IHBt
ZF9vZmZzZXQocHVkLCBWU1lTQ0FMTF9BRERSKTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFi
bGVfNjQuaA0KPiBpbmRleCBiODlmOGYxMTk0YTkuLmYwNmU1ZDZhMjc0NyAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oDQo+ICsrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaA0KPiBAQCAtNDEsMTEgKzQxLDkgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHN5bmNfaW5pdGlhbF9wYWdlX3RhYmxlKHZvaWQpIHsgfQ0KPiAg
IAlwcl9lcnIoIiVzOiVkOiBiYWQgcHVkICVwKCUwMTZseClcbiIsCQlcDQo+ICAgCSAgICAg
ICBfX0ZJTEVfXywgX19MSU5FX18sICYoZSksIHB1ZF92YWwoZSkpDQo+ICAgDQo+IC0jaWYg
Q09ORklHX1BHVEFCTEVfTEVWRUxTID49IDUNCj4gICAjZGVmaW5lIHA0ZF9FUlJPUihlKQkJ
CQkJXA0KPiAgIAlwcl9lcnIoIiVzOiVkOiBiYWQgcDRkICVwKCUwMTZseClcbiIsCQlcDQo+
ICAgCSAgICAgICBfX0ZJTEVfXywgX19MSU5FX18sICYoZSksIHA0ZF92YWwoZSkpDQo+IC0j
ZW5kaWYNCj4gICANCj4gICAjZGVmaW5lIHBnZF9FUlJPUihlKQkJCQkJXA0KPiAgIAlwcl9l
cnIoIiVzOiVkOiBiYWQgcGdkICVwKCUwMTZseClcbiIsCQlcDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni94ZW4vbW11X3B2LmMgYi9hcmNoL3g4Ni94ZW4vbW11X3B2LmMNCj4gaW5kZXgg
Mzg5NzFjNmRjZDRiLi42MWM1MmJiODBlMzMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3hl
bi9tbXVfcHYuYw0KPiArKysgYi9hcmNoL3g4Ni94ZW4vbW11X3B2LmMNCj4gQEAgLTU3OCw3
ICs1NzgsNiBAQCBzdGF0aWMgdm9pZCB4ZW5fc2V0X3A0ZChwNGRfdCAqcHRyLCBwNGRfdCB2
YWwpDQo+ICAgCXhlbl9tY19pc3N1ZShYRU5fTEFaWV9NTVUpOw0KPiAgIH0NCj4gICANCj4g
LSNpZiBDT05GSUdfUEdUQUJMRV9MRVZFTFMgPj0gNQ0KPiAgIF9fdmlzaWJsZSBwNGR2YWxf
dCB4ZW5fcDRkX3ZhbChwNGRfdCBwNGQpDQo+ICAgew0KPiAgIAlyZXR1cm4gcHRlX21mbl90
b19wZm4ocDRkLnA0ZCk7DQo+IEBAIC01OTIsNyArNTkxLDYgQEAgX192aXNpYmxlIHA0ZF90
IHhlbl9tYWtlX3A0ZChwNGR2YWxfdCBwNGQpDQo+ICAgCXJldHVybiBuYXRpdmVfbWFrZV9w
NGQocDRkKTsNCj4gICB9DQo+ICAgUFZfQ0FMTEVFX1NBVkVfUkVHU19USFVOSyh4ZW5fbWFr
ZV9wNGQpOw0KPiAtI2VuZGlmICAvKiBDT05GSUdfUEdUQUJMRV9MRVZFTFMgPj0gNSAqLw0K
PiAgIA0KPiAgIHN0YXRpYyB2b2lkIHhlbl9wbWRfd2FsayhzdHJ1Y3QgbW1fc3RydWN0ICpt
bSwgcG1kX3QgKnBtZCwNCj4gICAJCQkgdm9pZCAoKmZ1bmMpKHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tLCBzdHJ1Y3QgcGFnZSAqLA0KDQo=
--------------jf3AJhHNZgwVQ7NlRDjQicxJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------jf3AJhHNZgwVQ7NlRDjQicxJ--

--------------17wFTfAy0AWdHiCoJoEwcMnN--

--------------CymqGH96G71Tbf8XGvvggu1f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgnIZcFAwAAAAAACgkQsN6d1ii/Ey/y
zwf7BFJ4W28gPYT5FHV9wh0oB+P5okg8UnrhivxTgFygu6CqB9ji5nasoe3G4krsjX/CCLtjSC/f
IAollkJWwBZIj2VkJuAmz4l3vLE8o9sEcCwjIkH+s+GlomymvkwCYL+dGYwyKPYWqMnBbqWtxAEN
COtY7a9ra1W4QwCZNW9CZVUPNWZAV+HMaFvZa+F7IX0Q68isTzN+Uul4qDwQ8yxpET7TAZ+qHLgt
orlALsS+ey2CiwEcQa0XYM80Oq+ykPmfbo7oOvHMzl9aIeOKbmZY0do0ncxOtHgkK5VJYFwxKjOO
yNooVzCjsiGGazPSD65Id+BRUf8NceN2hTt23H89wQ==
=sZ4W
-----END PGP SIGNATURE-----

--------------CymqGH96G71Tbf8XGvvggu1f--

