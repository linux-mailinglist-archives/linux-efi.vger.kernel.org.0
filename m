Return-Path: <linux-efi+bounces-841-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF188643B
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 01:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD421F22177
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 00:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F11387;
	Fri, 22 Mar 2024 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="QZLbi5YU"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9379382;
	Fri, 22 Mar 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066011; cv=none; b=jLuxqdy0QwmcftLC1Akl+VymmgRPWTZ8+SgzURhgf25nAh5JbmJNxV8Yahz5wEPrwQM58YI7GsRsBlDpLPiscXFWKs4m1tJKUA0kLKTuP4K3kkPHJhlPhMiHdDUbkXtDfIfku88dLZD6llWNXJK5G3FGKb51wkApSU2hxzwBHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066011; c=relaxed/simple;
	bh=sJNuvfV/Rre/UoxjQHPPLLAdGqsUE6wJx6GszC4ZmZA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdHFd4krOdBIaTmecdz7Cgo8sLM8wWn0LnF0RNUbFAbJSiccAR+289rD/Sprk6B+jvZ8XVTVKLFRemup+V6VFCDkfwWpXGOgnKPXdRaBqaT70kr0aDT4mrxrizF+4vCrYlc17n5CcLLOKVrxOv9NH75SemKt1MJ5qIWiL8zVChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=QZLbi5YU; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Thu, 21 Mar 2024 17:06:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711066006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJNuvfV/Rre/UoxjQHPPLLAdGqsUE6wJx6GszC4ZmZA=;
	b=QZLbi5YUc4TG37Pz56OmLR1DDAJWJlCstn9sWQ2Eq7+MEXdBpQuKfrAQLrU1O9REwFQolK
	OLww4pVhrwIq10k9/7pr+CIlBnuPLIKgXerVIilSujBvCxhGanoYqu6N6pogg1Slf0Io8A
	rJ/8JPIlZJMz9UrcLfqyi61B/eVEWvCWf1cOkmB28IlM8VSFLt/2AEnOzWpZu/q3j7YqRb
	Ct8g6zZxXFYShObMd+JmWD7Q47m4b0I6sF+751gW4Wqiy8ztONWJLVeSlAl0tcl1UIaTTB
	fWVN7DuZrz4W10DxWW1McCZpT3LIEJAsBDUGaSaycQYvOTnnQW/w9vOme0Tsmw==
Message-ID: <20240321170641.GK8211@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 regressions@lists.linux.dev
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
In-Reply-To: <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="N3XsRCzAXOHRROpi"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--N3XsRCzAXOHRROpi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

T24gVGh1LCAyMSBNYXIgMjAyNCAyMzo0ODowOSArMDEwMCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPiA+IHY2LjggZmFpbHMgZm9yIG1lLCBhbmQgcHJlc3VtYWJseSBz
byBkb2VzIGV2ZXJ5dGhpbmcgYmFjayB0byB2Ni4yLiB2Ni4xIGlzIGFibGUKPiA+IHRvIGJvb3Qg
T0sgb24gdGhlc2UgcGxhdGZvcm1zIHdpdGggbWl4ZWQgbW9kZSwgYW5kIGl0IGxvb2tzIGxpa2Ug
dGhlcmUgYXJlIGEgbG90Cj4gPiBvZiBjaGFuZ2VzIGZyb20gNi4xLi42LjIgZm9yIEVGSS9taXhl
ZCBtb2RlIGJvb3RpbmcuCj4gCj4gdjYuMSBqdXN0IHJlY2VpdmVkIHNvbWUgRUZJIHJlbGF0ZWQg
YmFja3BvcnRzLCBzbyBwbGVhc2UgY2hlY2sgdGhlCj4gbGF0ZXN0IHY2LjEueSBhcyB3ZWxsLgoK
SSBqdXN0IGdhdmUgdjYuMS44MiBhIHRyeSwgYW5kIGl0IGZhaWxzIHRvIGJvb3QgZm9yIG1lLiBU
aGF0IHNlZW1zIHRvIGJlIGEKcmVncmVzc2lvbiBmcm9tIHRoZSA2LjEuMCB0aGF0IEkgdGVzdGVk
IHByZXZpb3VzbHkuCgo+IEkgdXN1YWxseSB0ZXN0IG9uIDMyLWJpdCBPVk1GIGJ1aWx0IHdpdGgg
TE9BRF9YNjRfT05fSUEzMl9FTkFCTEUsCj4gd2hpY2ggYWxsb3dzIHRoZSB1c2Ugb2YgdGhlIGNv
bXBhdCBlbnRyeSBwb2ludC4gVGhpcyBpcyBkaWZmZXJlbnQgZnJvbQo+IHRoZSBFRkkgaGFuZG92
ZXIgcHJvdG9jb2wsIGFuZCBJIGFtIG5vdCBzdXJlIHdoaWNoIG9uZSB5b3UgYXJlIHVzaW5nLgoK
SSBzaG91bGQgaGF2ZSBtZW50aW9uZWQgdGhpcyBwcmV2aW91c2x5LCBoZXJlJ3MgdGhlIEVGSS1y
ZWxhdGVkIGtjb25maWcgdGhhdCBJCmFtIHVzaW5nLiBJZiB0aGVyZSdzIGFueXRoaW5nIG1pc3Np
bmcgdGhlbiBwbGVhc2UgbGV0IG1lIGtub3c6CgogICAgICAgIENPTkZJR19FRkk9eQogICAgICAg
IENPTkZJR19FRklfRUFSTFlDT049eQogICAgICAgIENPTkZJR19FRklfRVNSVD15CiAgICAgICAg
IyBDT05GSUdfRUZJX0hBTkRPVkVSX1BST1RPQ09MIGlzIG5vdCBzZXQKICAgICAgICBDT05GSUdf
RUZJX01JWEVEPXkKICAgICAgICBDT05GSUdfRUZJX1JVTlRJTUVfV1JBUFBFUlM9eQogICAgICAg
IENPTkZJR19FRklfU1RVQj15CiAgICAgICAgQ09ORklHX0VGSV9WQVJTX1BTVE9SRT1tCiAgICAg
ICAgQ09ORklHX0VGSV9WQVJTX1BTVE9SRV9ERUZBVUxUX0RJU0FCTEU9eQoKTm90ZSB0aGF0IHRo
ZSBFRkkgaGFuZG92ZXIgcHJvdG9jb2wgc3VwcG9ydCBpcyBkaXNhYmxlZCwgSSB3YXMgdW5kZXIg
dGhlCmltcHJlc3Npb24gdGhhdCBpdCdzIG5vdCByZXF1aXJlZCBmb3IgbWl4ZWQgbW9kZS4KClBs
ZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIGFueSBtb3JlIGluZm9ybWF0aW9uIEkgY2FuIHBy
b3ZpZGUgYWJvdXQgbXkKdGVzdGluZyAvIHNldHVwLgoKLUNsYXl0b24K

--N3XsRCzAXOHRROpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmX8y5EACgkQSkztbX7f
lQqPbA//WPktNG9F+YujYiC1/7VIPC8mPvbRNdwMZA5LYSGgKDP8vRjuU+zoX8Aa
o20GByQ7LxvByv7XhzdMv7oLFRI5sFwcYJraleO+fUvJT9YluN3eN7rZNeZyUOzc
f14xiC4uXniYxnJq6L3aAf24FACKmg1ub+NPXTZtswLp06sq2oyVoN5La8K9h/4Y
pjg6lbxwM5vqoCovDDF3C9WqvmEWcyYsGFPs3ptFxTqMSYQAMjtXUl0jTjFM8ncj
VY1dK/P3Lt2AUVtaUDyAWGBXnmx5CICgkx7LjWCu9pPto0B89y2DUjQhsJ2litnB
UFQq5A2oL3GF2uv/w34LrGh97HQT+C8L6BD9D7HJrBlzz7X1bjBmeDlN9bL9iYId
JSGVGMc3UwAgeLV/mjrdB7vL6UHjMdXUlOPHz8W2OMIKC3p6iJmo5+tyRWYCSB21
DMjqA4Oy/IOTSOC6t9oxaBDJwJvjGbWVXB4AFiHIbKZ428UHkvKxPVBVMhu1TUV4
heHw/WhRpv3HDVVFwM1YRveB7Ec1ewjwRJdrydGmLWX19c6cNNFec6jsh5FavLPk
FiydB3Neubs/61cT9d4lS7ibdhyrTEkxX2cyeJEwC1CLlQDM03AwiyraUvG/323Z
+rBImKoZgRBnj+q2juHFSzYcj1UVi8i1uibWnfamUxTPoN458J8=
=HxZ7
-----END PGP SIGNATURE-----

--N3XsRCzAXOHRROpi--

