Return-Path: <linux-efi+bounces-1997-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638079A2856
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF41C21ECA
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0F1DF253;
	Thu, 17 Oct 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRBXnamz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F31C1AA5;
	Thu, 17 Oct 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181797; cv=none; b=FST2IDHlRVQw4lz3x2Rf148yKQMraPOEFSgljJAbSbSzp99SaVTS0Vdxbv5Vj6YskuOuShTV55gZfUWpETHkWcYm2wDpLkgcIzrSGd+qAv6uArnwS3ZK7xrS6LD+8NtTzOTWfqGNJIaNpmThRv2wO3RDIAPa0tgV+7wLO5b3X3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181797; c=relaxed/simple;
	bh=hfI6iabp4PPWvqyvmjXc0F77R4JdfswrHfMqi0ZFT4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELs30T+i6WEpJorS6Mekn58o7qyBbHu4TOasPT7KOJGTXjL6eOH1D73LqsP4dzDyermN1dohQODRbGog7wVmpRA4zXB+rnQYJDUMe9yqZBHIl0rose2KRSyigFKEUvdxdetUmCyKSy4QmXkW6b84+9458fwlp0fwn8sopkB7hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRBXnamz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DA1C4CEC3;
	Thu, 17 Oct 2024 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181796;
	bh=hfI6iabp4PPWvqyvmjXc0F77R4JdfswrHfMqi0ZFT4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qRBXnamznV90WcZD8OYvzNujY++b0mmEa3C9GotNIdOfGhLfkY4EKmbWuPd87g6Lk
	 iAEJwTZ2R+ror6LuBaBvf3leOBXwKH706FsJ+kJz2GOhjY5yBzaf3Y3LbjZ10YS/c8
	 EXBydRZqjBnTYvFsIGkFsgHO74iqxcxDp6JOTdEq8/hday1otzr0EduWstW3qlE57u
	 E4+DPf3X5+voaqQUw7DanTn4gAa3tnpABW2onjyD+5ShJkaYsOktYUXKLWj6KfvnOG
	 rvLz2gmZRrWSYqv4XkFUDdx2LykVXTl68SrsRpyVryTLB+2wjllovlZj3yqhSmsyb3
	 Xx38eeNU4M1HA==
Message-ID: <cc7e23de36edb50999cfd9c8dd6acc9d5962a479.camel@kernel.org>
Subject: Re: [RFC PATCH v3 02/13] certs: Introduce ability to link to a
 system key
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Snowberg <eric.snowberg@oracle.com>, 
	linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, ardb@kernel.org, paul@paul-moore.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  dmitry.kasatkin@gmail.com, mic@digikod.net,
 casey@schaufler-ca.com,  stefanb@linux.ibm.com, ebiggers@kernel.org,
 rdunlap@infradead.org,  linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 linux-efi@vger.kernel.org,  linux-integrity@vger.kernel.org
Date: Thu, 17 Oct 2024 19:16:32 +0300
In-Reply-To: <20241017155516.2582369-3-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Introduce system_key_link(), a new function to allow a keyring to
> link
> to a key contained within one of the system keyrings (builtin,
> secondary,
> or platform). Depending on how the kernel is built, if the machine
> keyring is available, it will be checked as well, since it is linked
> to
> the secondary keyring. If the asymmetric key id matches a key within
> one
> of these system keyrings, the matching key is linked into the passed
> in
> keyring.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> =C2=A0certs/system_keyring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
30 ++++++++++++++++++++++++++++++
> =C2=A0include/keys/system_keyring.h |=C2=A0 7 ++++++-
> =C2=A02 files changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index e344cee10d28..4abee7514442 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -20,6 +20,9 @@
> =C2=A0static struct key *builtin_trusted_keys;
> =C2=A0#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> =C2=A0static struct key *secondary_trusted_keys;

/*
 * Explain system_trusted_keys (nothing too detailed, only the gist)
 */

> +#define system_trusted_keys secondary_trusted_keys
> +#else
> +#define system_trusted_keys builtin_trusted_keys
> =C2=A0#endif
> =C2=A0#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> =C2=A0static struct key *machine_trusted_keys;

We have enough these to make this quite convoluted so let's put some
helpful reminders. I would forget this in no time ;-) So if it comes
down to that, please put something because I have a goldfish memory.

BR, Jarkko

