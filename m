Return-Path: <linux-efi+bounces-2004-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B128F9A2FA8
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 23:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E78287C59
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137501F4280;
	Thu, 17 Oct 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4jG3faB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97241D63EF;
	Thu, 17 Oct 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199787; cv=none; b=sT7gdp8xUkQrIgPYJc6NlEtD7iszLclHiPDpxy0Tgdr2xvbdQltBJNG59ElF6oMgwhk/sFDjmQwh+yJZDJhGPVQLrUm66AhHHMbqzrryLjR6LTIZz6vaufjD7LyqEjna4PR9nfmNz9wwXKpHzxY8SXGBVsXXWSg+bNgBvmptRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199787; c=relaxed/simple;
	bh=e9vuOo0EoJQc1axQfI9B0Mb+dykcnQDHVZZWlsHa0Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdq/p36BqmjFiQIO+cgrB8hUWFveRr9Hp5E3t0w0+lT26Vy3FsPRJsM/xvbVyollHJ+sgVwCAhjkws1mjy7HCk/vi8zScMDDULMk+iYtsWtkOMc8A4S3I4UcvGAC/Us90IyKSkpOKws1m8B3BAt3uIcqW4avwcXPlC99KO3xUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4jG3faB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E39BC4CEC3;
	Thu, 17 Oct 2024 21:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729199786;
	bh=e9vuOo0EoJQc1axQfI9B0Mb+dykcnQDHVZZWlsHa0Tg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W4jG3faB4J2GtSwh55ZU1hOnuR7tLu8Jh2NOXR/TRFw5QtU09Yx60bW2VTx1TfgTv
	 RBHCns0empPYjm5Aiyfp379gfbsulK5nIfyYxSKez7HzGNGZWoQWFYCNkXljWy73Tx
	 uo39nTqxzDnLZE4jHGqVsgl54URuNK9UGGvutK1+V0Dk7v/ozWC+LH2ekzBSNczGdv
	 sFG39jjoKZSSZ/cDE2e8BgDZdAX9ALFy/OmB2IAIIcOBVcgc0/9mItILtI+os2BwW1
	 cHgvza6mcCITOrIwmfe4JE0xo1AbR4gpVS8EyYH9mSDm/Zpv0n/IVx8Y+wsCoyMTGx
	 030GIPIcQNYRw==
Message-ID: <31abac4eb64404494395ee6ecc7fc697e0cad0af.camel@kernel.org>
Subject: Re: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
 David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "davem@davemloft.net" <davem@davemloft.net>,  Ard Biesheuvel
 <ardb@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar
 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,  "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
 Stefan Berger <stefanb@linux.ibm.com>,  "ebiggers@kernel.org"
 <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-efi@vger.kernel.org"
 <linux-efi@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>
Date: Fri, 18 Oct 2024 00:16:22 +0300
In-Reply-To: <BF17F069-BCAE-4FA4-B956-4D7E69C2EAB6@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-4-eric.snowberg@oracle.com>
	 <30308614a1229870d205c33deba193f3d6732bef.camel@kernel.org>
	 <BF17F069-BCAE-4FA4-B956-4D7E69C2EAB6@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 20:34 +0000, Eric Snowberg wrote:
>=20
>=20
> > On Oct 17, 2024, at 10:50=E2=80=AFAM, Jarkko Sakkinen <jarkko@kernel.or=
g>
> > wrote:
> >=20
> > On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> > > +static struct asymmetric_key_id *clavis_parse_boot_param(char
> > > *kid,
> > > struct asymmetric_key_id *akid,
> > > + int
> > > akid_max_len)
> > > +{
> > > + int error, hex_len;
> > > +
> > > + if (!kid)
> > > + return 0;
> > > +
> > > + hex_len =3D strlen(kid) / 2;
> >=20
> > Hmmm... I'd consider sanity checking this:
> >=20
> > size_t len;
> >=20
> > /* ... */
> >=20
> > len =3D strlen(kid);
> > if (len % 2) {
> > pr_err("Clavis key id has invalid length %lu\n", len);
> > return 0;
> > }
> >=20
> > hex_len =3D len / 2;
> >=20
>=20
> Good catch, I will include this in the next round.=C2=A0 I have also adde=
d
> a kunit test=20
> for this as well.=C2=A0 Thanks.

I guess hex2bin() would eventually catch this issue, i.e. not an actual
bug, but I still think that you are better off doing also check here and
get an appropriate message to klog if that ever happens :-)

BR, Jarkko


