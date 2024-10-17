Return-Path: <linux-efi+bounces-1996-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449849A2831
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768741C210D2
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65E1DED66;
	Thu, 17 Oct 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjxN4sV+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A607D3F4;
	Thu, 17 Oct 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181606; cv=none; b=ruqgCl0xbA3C1uZI6mSIWCNYkJEScWdx+UgSLGCZEv+S37d12JbNkN4XrsHmXzlRyrGUPkNV+YEOzwTiG/TCWoqLNPLvTeB+Q7FMn9pDOahw/4KTUkM/mkZboouOsJCYKzpS1bWgJ9LzrUmDEFIBCJMFq0+8Q3DzTPb3tV9W0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181606; c=relaxed/simple;
	bh=Atfx+EEwD5PviIJJshPQ38p2Tw36JPd3Cb1Z5XYVGQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiEcBIWhrPd7sK9+85q20W4pAVaIioXaswjQGzfSvlvlinj/CG67IY1u8fRyh0GxlbPTL91c4VwAThgCba+4l4CiCOOA3AbIN4bvtWP6P3fZdc/3wet3JcynVYhAhoN35BlHoLtg70GwHIVcj7BbIl50007nhD/t8RXpe8u9xqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjxN4sV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B72C4CEC3;
	Thu, 17 Oct 2024 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181605;
	bh=Atfx+EEwD5PviIJJshPQ38p2Tw36JPd3Cb1Z5XYVGQI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qjxN4sV+DMkBXqcJ5ZVwKnXlJs6TE41hxAoqyL5hcwGHxKZy3J08hQWOUnW3AQjbC
	 GfgAD/r/YDGXlusZF6oIfsApdgIp6vlYHtF4DGfBTTtHdzffQpU9lyFL+ukOUbvOmX
	 WBJ9yNUx4JRcmAEVW8QFBNjMWD1miPSx08Kd4XyCk9Gp0Gi0G8dpGn2qhLWrH0uAWU
	 uFmDIVUGSSHFEHW5gWw0CIOCS7wF9a2PtfdbybD0D1jGcw4+aaHUCk2J3DrXr/U8ig
	 B/frW90/JePA+VfvQ8WCVyJN6j0ivQorzCbdyA7OvGDRXj0RbEc6iwDHLFQtGseek2
	 4k6Q244ZvcwKg==
Message-ID: <213ec040cf30ad8af6ea9706b10ced8219f6e3aa.camel@kernel.org>
Subject: Re: [RFC PATCH v3 01/13] certs: Remove
 CONFIG_INTEGRITY_PLATFORM_KEYRING check
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
Date: Thu, 17 Oct 2024 19:13:21 +0300
In-Reply-To: <20241017155516.2582369-2-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-2-eric.snowberg@oracle.com>
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
> Remove the CONFIG_INTEGRITY_PLATFORM_KEYRING ifdef check so this
> pattern does not need to be repeated with new code.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> =C2=A0certs/system_keyring.c | 6 ------
> =C2=A01 file changed, 6 deletions(-)
>=20
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..e344cee10d28 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,9 +24,7 @@ static struct key *secondary_trusted_keys;
> =C2=A0#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> =C2=A0static struct key *machine_trusted_keys;
> =C2=A0#endif
> -#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> =C2=A0static struct key *platform_trusted_keys;
> -#endif
> =C2=A0
> =C2=A0extern __initconst const u8 system_certificate_list[];
> =C2=A0extern __initconst const unsigned long system_certificate_list_size=
;
> @@ -345,11 +343,7 @@ int verify_pkcs7_message_sig(const void *data,
> size_t len,
> =C2=A0		trusted_keys =3D builtin_trusted_keys;
> =C2=A0#endif
> =C2=A0	} else if (trusted_keys =3D=3D VERIFY_USE_PLATFORM_KEYRING) {
> -#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> =C2=A0		trusted_keys =3D platform_trusted_keys;
> -#else
> -		trusted_keys =3D NULL;
> -#endif
> =C2=A0		if (!trusted_keys) {
> =C2=A0			ret =3D -ENOKEY;
> =C2=A0			pr_devel("PKCS#7 platform keyring is not
> available\n");

Just to check with the argument that any commit should bring the Git
tree to another "good state". Why this was flagged? What would be the
collateral damage if only this commit was picked and put to a pull
request? No intentions to do that, this more like forming a better
understanding what is at stake here.

I.e. I get that you need this for subsequent commits but I think the
commit message should also have like explanation why this is a legit
change otherwise.

I mean, less flagging better if it does not cause harm is already
great without higher level goals.

BR, Jarkko



