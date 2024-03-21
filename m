Return-Path: <linux-efi+bounces-838-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758F8862A9
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 22:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286C01C2162D
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5413443D;
	Thu, 21 Mar 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="aq6RYuwj"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85A288AE
	for <linux-efi@vger.kernel.org>; Thu, 21 Mar 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057551; cv=none; b=sSswrKbs3uxuIiEseACZ8aJ1Y5PKJdJgjcEK0jYTfFKe7t0hT75TKgNqRxQroFJ4mKp9yBkRt885NPXaHHSyBIoEv2fxV5JY5XEZinoZaHgKZtRxbCsJ9NcYgoj6JevcR6aesnQBlcvruLIXQa23aq5TaeGMG1ZyS4CU1XaKd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057551; c=relaxed/simple;
	bh=2tQnMaOk3l5Vzdsx6KewYY3YiTVYe2pki0Ft8A9hQmU=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rVSlLuq0w00F9JfZcl2uCc5T1GtcsCK7jIfZ5s0clFVgbUa27MdWQ0e2KbqKjJSw/kJVVW8heDPtdAyegvabhXME58maKvkcyeoIYkRhK+NuuntA3m6LsJFtbqFrsVNIccSguOdFQ36Eci+o2Aq4oS8AyywlMlhnndgs6zJnjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=aq6RYuwj; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Thu, 21 Mar 2024 14:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711057545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2tQnMaOk3l5Vzdsx6KewYY3YiTVYe2pki0Ft8A9hQmU=;
	b=aq6RYuwjiDABc2QbzU7SrGGdLNatkeQEMtyhg5vtc19T0JZBy8+naYv8zN+BPL/y87W+bn
	BDFFZazipTyCrzF5/NiHCkFg2JSp8vWh+kkBKVGrMG9O1pFy20RzgLNl2HrSHDIC/0wwzo
	9Q2AvNCaX/wJiJ1isuTbjj+5omlwx2yCnOJIx9eRKabXIcRXcB7klEXJetdRjtwinVh30W
	zUaYY9BhsqOh8Oe3JTSGaEUNfcAPCNxQk2iQrSVYYesdDnEooTDazcX/+jXeJy8OwETi88
	w4+adkIasV+hQjpllfN1bRyh/XiJNhWcwhMqPKTUcGXfR5+lM+KqKJw95U6KMg==
Message-ID: <20240321144541.GD8211@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: clayton@craftyguy.net
Subject: x86_64 32-bit EFI mixed mode boot broken
References:
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="3NEYmrcHHRyyUH2K"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT


--3NEYmrcHHRyyUH2K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

SSd2ZSBiZWVuIGNoYXNpbmcgYSBwcm9ibGVtIHdpdGggMzItYml0IEVGSSBtaXhlZCBtb2RlIGJv
b3Rpbmcgb24gdHdvIGRpZmZlcmVudAooeDg2XzY0KSBJbnRlbCBCYXkgVHJhaWwgcGxhdGZvcm1z
LCB3aGVyZSB0aGUgc3lzdGVtIHJlYm9vdHMgb3IgaGFuZ3Mgc2VlbWluZ2x5CnZlcnkgZWFybHkg
c29tZXdoZXJlIGJlZm9yZSBvciBhZnRlciBsb2FkaW5nIHRoZSBrZXJuZWwuIEkndmUgbm90IGJl
ZW4gYWJsZSB0bwpnZXQgYW55IG91dHB1dCBmcm9tIHRoZSBrZXJuZWwgb3Igc3R1YiBvdmVyIGVm
aWZiIHdoZW4gdGhlIGlzc3VlIGhhcHBlbnNbMF0sIGFuZApkbyBub3QgaGF2ZSBzZXJpYWwgY29u
c29sZSBhY2Nlc3Mgb24gdGhlc2Ugc3lzdGVtcy4gCgp2Ni44IGZhaWxzIGZvciBtZSwgYW5kIHBy
ZXN1bWFibHkgc28gZG9lcyBldmVyeXRoaW5nIGJhY2sgdG8gdjYuMi4gdjYuMSBpcyBhYmxlCnRv
IGJvb3QgT0sgb24gdGhlc2UgcGxhdGZvcm1zIHdpdGggbWl4ZWQgbW9kZSwgYW5kIGl0IGxvb2tz
IGxpa2UgdGhlcmUgYXJlIGEgbG90Cm9mIGNoYW5nZXMgZnJvbSA2LjEuLjYuMiBmb3IgRUZJL21p
eGVkIG1vZGUgYm9vdGluZy4gSSBkaWQgbWFuYWdlZCB0byBiaXNlY3QgdGhlCmlzc3VlIHRvOiAK
CiAgICAgICAgY29tbWl0IGUyYWI5ZWFiMzI0Y2RmMjQwZGU4OTc0MWU0YTFhYTc5OTE5ZjAxOTYK
ICAgICAgICBBdXRob3I6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+CiAgICAgICAg
RGF0ZTogICBUdWUgTm92IDIyIDE3OjEwOjAyIDIwMjIgKzAxMDAKICAgICAgICAKICAgICAgICAg
ICAgeDg2L2Jvb3QvY29tcHJlc3NlZDogTW92ZSAzMi1iaXQgZW50cnlwb2ludCBjb2RlIGludG8g
LnRleHQgc2VjdGlvbgoKSG93ZXZlciBJJ20gbm90IHN1cmUgaG93IHRvIHByb2NlZWQgZnJvbSBo
ZXJlLCBvciBpZiBteSBiaXNlY3QgaXMgYWxsIHRoYXQKdXNlZnVsIHNpbmNlIHRoZSBjb21taXQg
c2VlbXMgdG8gYmUgaW4gdGhlIG1pZGRsZSBvZiBhIGJ1bmNoIG9mIGNoYW5nZXMgSSBkbyBub3QK
dW5kZXJzdGFuZC4gSSd2ZSBiZWVuIHVzaW5nIHN5c3RlbWQtYm9vdCB0byB0ZXN0IHRoaXMgKGJv
dGggdGhlIGZ1bGwgYm9vdGxvYWRlcgphbmQgVUtJIHcvIHRoZSBzZC1ib290IHN0dWIpLiBJcyAz
Mi1iaXQgbWl4ZWQgbW9kZSBvbiB4ODZfNjQgd29ya2luZyBmb3Igb3RoZXJzPwoKVGhhbmtzLApD
bGF5dG9uCgowLiBVc2luZyAiZGVidWcgaWdub3JlX2xvZ2xldmVsIGVhcmx5Y29uPWVmaWZiIGVh
cmx5cHJpbnRrPWVmaSxrZWVwIGVmaT1kZWJ1ZyIK

--3NEYmrcHHRyyUH2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkdOrrjmBP3eB7DeWSkztbX7flQoFAmX8qoUACgkQSkztbX7f
lQrlnA//arshnPdEcrjUori6388jGpQ5VwbulT42f421zbOOATnXjmK3d2cQ3Pds
3cr/mwkmFg+zS8sh/kUH+TnNcvlQjaHOwi1sbEBVJrZ6qHfBQY56/kDUWQIzYbU1
1lpR9j8eP+X9WFNC9oE3WQK6kvky4sSHD+WAmnG7iYeuqSZwSLcFDivZR/27rH73
DyHpBFDOQWZdoIjg0IN0CcNf80JH6cWcNmNwFD5PUmfr2t952C7JM4zD1Omp9Cse
HyQsaco2HwL+HWbIQpuRDYGbA+vLm9k9zR1hHP6yQhscHOkwp7ETE+MdKlQufkJC
EeMyeKhxWLMLvRa/tDK9aK9bQsYzHWIhGWpyUfHWfaxkcpspeAGPGuHzhZMt2c0H
hgm2D5LJRzqM69YfYi8IDzfoj4k9SyHDylewEsTvMHirWK6trr7exKALLwNLNdwa
nJP5mdP3iyJ/9WGSRAbrnEBWnDi/nrDk659LCrZwUqFtJX8ljnLp4dyJ5znwYiv+
3Mr+o1ThRUvr3t4gB0Rg3MNO8tQNnnbfFSFm+MD1ClQUHKVzgS36XUoe+dLpIub6
eHdMSGpvVKZJz4TJfdjqIPkpUgyEPdD6H2FuLWnDD3oLb6cXEAGoSl/qaYc1V+dn
mQntqxW0dBwh4j/2AcWUvORHrjMa6Cv/CZAUUy6bQy03UHxaAmM=
=kCJm
-----END PGP SIGNATURE-----

--3NEYmrcHHRyyUH2K--

