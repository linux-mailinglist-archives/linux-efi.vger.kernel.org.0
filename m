Return-Path: <linux-efi+bounces-2118-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D846E9BA0BA
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 15:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A7AB2155D
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913A19DF53;
	Sat,  2 Nov 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQql5lkZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665C33C9;
	Sat,  2 Nov 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557575; cv=none; b=XAgXcWNLEcuw0OfUYPHFfR2ebom7K9RiMBZ4kisNtH7C/ViEPQ8sz78nUAseVdqZvo+oQluqHaE7Y6hVbOu4gbHulUmSx5n2StwMih3iuWDUFmJ9JMQQGlILfhzE8gvaGzcz78D5O5iQgN0j0ebk1ldceNsuTwHyITv6Q+KCM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557575; c=relaxed/simple;
	bh=ExNNc/F5UO1JUVBaiGGCw7c3A43cKS2+lAROsZ10LyM=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BmzwIf0iq1houyB6eBjr22OlgZfGFKoM3yJrLQ3Fu2MrAfbHQe4E1yNjUk7NlFCOb1HKc28Yh2hIi0f+CwzXI+quJPlTZazhx+O1jmy/SxLYcezxcp3YU9cu4+w2fCBka1IHqG8yWnuMKCPHTOEr04KbHNP2xGiUMIkxMSQGvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQql5lkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96244C4CEC3;
	Sat,  2 Nov 2024 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730557575;
	bh=ExNNc/F5UO1JUVBaiGGCw7c3A43cKS2+lAROsZ10LyM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nQql5lkZBVmH0d0x+iIN7RERdTxT1VWSNVDUNv8yOm6lxykCMTQaPSKL5ooahHWEh
	 DO9hUBWiL2XXmRcF4qcJrSyqSn820XiBXUyRoquxsj06Jf5S3nT+QnhKRH1C5c1QNk
	 5d/EMzCmbjKgYG22kTOvkdAe8PzSJyR1A3g3QlSiCBgmWbf4rbwR/qvhlGdIiVYILZ
	 yfxj71bHnf6z4NylyUUnbCfNLq2keFTDaldLkSYRJPh/DjVYvFa7QuH9yDiLp6xnlC
	 26LHKjYvVl1haIY3dk69tsRCmHKdkgl142SBypxM+Vii5DYnKUHfQ+VWQbLC3lXaI9
	 NL3thq++CmtUg==
Content-Type: multipart/mixed;
 boundary=73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 16:26:11 +0200
Message-Id: <D5BRGKZLI186.20G9U85Q2XRPP@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 16/20] tpm: Make locality requests return consistent
 values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-17-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-17-ross.philipson@oracle.com>

--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Content-Type: multipart/alternative;
 boundary=7188c54ccba4660edec87ffb8413ca5ac7c0fcf2c19a242a478fa4dddcf0

--7188c54ccba4660edec87ffb8413ca5ac7c0fcf2c19a242a478fa4dddcf0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The function tpm_tis_request_locality() is expected to return the localit=
y
> value that was requested, or a negative error code upon failure. If it is=
 called
> while locality_count of struct tis_data is non-zero, no actual locality r=
equest
> will be sent. Because the ret variable is initially set to 0, the
> locality_count will still get increased, and the function will return 0. =
For a
> caller, this would indicate that locality 0 was successfully requested an=
d not
> the state changes just mentioned.
>
> Additionally, the function __tpm_tis_request_locality() provides inconsis=
tent
> error codes. It will provide either a failed IO write or a -1 should it h=
ave
> timed out waiting for locality request to succeed.
>
> This commit changes __tpm_tis_request_locality() to return valid negative=
 error
> codes to reflect the reason it fails. It then adjusts the return value ch=
eck in
> tpm_tis_request_locality() to check for a non-negative return value befor=
e
> incrementing locality_cout. In addition, the initial value of the ret val=
ue is
> set to a negative error to ensure the check does not pass if
> __tpm_tis_request_locality() is not called.

Tweaked version attached with cruft removed and story cleared.

BR, Jarkko

--7188c54ccba4660edec87ffb8413ca5ac7c0fcf2c19a242a478fa4dddcf0--

--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-tpm-Support-multiple-localities-in-tpm_tis_request_l.patch
Content-Type: text/x-patch; charset=utf-8;
 name=0001-tpm-Support-multiple-localities-in-tpm_tis_request_l.patch

RnJvbSBmZDMwN2ZkYTU3OGUwNGU0ZGVmYjZlMGZmNDdmOGZlMjhhOTk5ZDRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiRGFuaWVsIFAuIFNtaXRoIiA8ZHBzbWl0aEBhcGVydHVzc29s
dXRpb25zLmNvbT4KRGF0ZTogRnJpLCAxMyBTZXAgMjAyNCAxMzowNToxMyAtMDcwMApTdWJqZWN0
OiBbUEFUQ0hdIHRwbTogU3VwcG9ydCBtdWx0aXBsZSBsb2NhbGl0aWVzIGluCiB0cG1fdGlzX3Jl
cXVlc3RfbG9jYWxpdHkoKQoKVmFsaWRhdGUgdGhhdCB0aGUgaW5wdXQgbG9jYWxpdHkgaXMgd2l0
aGluIHRoZSBjb3JyZWN0IHJhbmdlLCBhcyBzcGVjaWZpZWQKYnkgVENHIHN0YW5kYXJkcywgYW5k
IGluY3JlYXNlIHRoZSBsb2NhbGl0eSBjb3VudCBhbHNvIGZvciB0aGUgcG9zaXRpdmUKcmV0dXJu
IHZhbHVlcy4KClNpZ25lZC1vZmYtYnk6IERhbmllbCBQLiBTbWl0aCA8ZHBzbWl0aEBhcGVydHVz
c29sdXRpb25zLmNvbT4KU2lnbmVkLW9mZi1ieTogUm9zcyBQaGlsaXBzb24gPHJvc3MucGhpbGlw
c29uQG9yYWNsZS5jb20+ClNpZ25lZC1vZmYtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtl
cm5lbC5vcmc+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDUgKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYwppbmRleCAzNTE3ZGI3MTA0MjMuLjc1ZmI1OWRmNzVhMyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jCkBAIC0yMzQsMTAgKzIzNCwxMyBAQCBzdGF0aWMgaW50IHRwbV90aXNf
cmVxdWVzdF9sb2NhbGl0eShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIGludCBsKQogCXN0cnVjdCB0
cG1fdGlzX2RhdGEgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoJmNoaXAtPmRldik7CiAJaW50IHJl
dCA9IDA7CiAKKwlpZiAobCA8IDAgfHwgbCA+IFRQTV9NQVhfTE9DQUxJVFkpCisJCXJldHVybiAt
RUlOVkFMOworCiAJbXV0ZXhfbG9jaygmcHJpdi0+bG9jYWxpdHlfY291bnRfbXV0ZXgpOwogCWlm
IChwcml2LT5sb2NhbGl0eV9jb3VudCA9PSAwKQogCQlyZXQgPSBfX3RwbV90aXNfcmVxdWVzdF9s
b2NhbGl0eShjaGlwLCBsKTsKLQlpZiAoIXJldCkKKwlpZiAocmV0ID49IDApCiAJCXByaXYtPmxv
Y2FsaXR5X2NvdW50Kys7CiAJbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NhbGl0eV9jb3VudF9tdXRl
eCk7CiAJcmV0dXJuIHJldDsKLS0gCjIuNDcuMAoK
--73fbcc7443089f1f7b2921e0e46f067c613c6e102287c1eb614874387539--

