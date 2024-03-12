Return-Path: <linux-efi+bounces-810-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91856879757
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 16:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC411F229C8
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DF7C091;
	Tue, 12 Mar 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Lmwl5P"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25E7BB04;
	Tue, 12 Mar 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256732; cv=none; b=sJTii9dSzgt4yIIUMSXp2l1Whs6rjG6zOpP1KvNu44QLs/Qqc6MDICUGX7FttjVyg1lx+pqExYl7bQkQ0DJjA5m6ruOy0nHL2jzOwzpq+v602Q/E5nll8oNbkyP87dBIRAqoToTLg5R5EoyVZuqwIVI2eiXJbgJMS2hsTFdsKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256732; c=relaxed/simple;
	bh=e9D3nRiUkzwoDNU1WO9Mvab1qnoYPq79dDij4jjwu3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DIV1v4BikQ5votpyOmv7W3jlNrfUs21j4+mxn8oVwlcjEa9B0D6SS+sJkuZr0j9LSNX4Iwndn/6iAwnufkGX3P49vH3Ig0jOV9gnf/8dIF+wDYkZ6DGCTgdy31H7YEcdxmu1uIGkbqqo69Y0PC8KTH3aaFQyLGMEpcOroJMCwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Lmwl5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74728C433F1;
	Tue, 12 Mar 2024 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710256731;
	bh=e9D3nRiUkzwoDNU1WO9Mvab1qnoYPq79dDij4jjwu3k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=h1Lmwl5P+pE/kbBOvKdZOZM25nEbfDfgOnhEj7uMpL3lrvqSkVH9DeyjsZEf7DTHn
	 hE+C1iPnYAEHMQA1AkgjHn1CDxlvyhvh92FjY/rUU57Pura7j3mc/fwaDBHM0YxPTJ
	 EuoUD49zHXeU5FjxnjVBGrnmBZIibE94K4SxGOVFkYeERZITcH2CIZ7Ggl+fqv6eoh
	 IeaxrCO5fembgp1vdfcOdBpTepENLylh42LBlMDfzVapAhKGludQ50rVeZJO1++Zzs
	 ezP/6E7bAq6njdK/Y/+nWz0kYO4KifZtj2dwllKvMBdw9TGXv7C5OxDFZpWF+4z+48
	 mk2gdGgwHJZMw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 17:18:45 +0200
Message-Id: <CZRVET5930A0.3KM5Q2BAH05LT@kernel.org>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 "David Howells" <dhowells@redhat.com>, "David Woodhouse"
 <dwmw2@infradead.org>, "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
 "Ard Biesheuvel" <ardb@kernel.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>,
 "serge@hallyn.com" <serge@hallyn.com>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>, "roberto.sassu@huawei.com"
 <roberto.sassu@huawei.com>, "dmitry.kasatkin@gmail.com"
 <dmitry.kasatkin@gmail.com>, "mic@digikod.net" <mic@digikod.net>,
 "casey@schaufler-ca.com" <casey@schaufler-ca.com>, "stefanb@linux.ibm.com"
 <stefanb@linux.ibm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-efi@vger.kernel.org"
 <linux-efi@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system
 key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Snowberg" <eric.snowberg@oracle.com>
X-Mailer: aerc 0.17.0
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
 <CZR5W1VPAVJC.2VZOSD53YNT9I@kernel.org>
 <77AE4DEA-9474-44A1-88DC-852523C36797@oracle.com>
In-Reply-To: <77AE4DEA-9474-44A1-88DC-852523C36797@oracle.com>

On Mon Mar 11, 2024 at 11:31 PM EET, Eric Snowberg wrote:
>
>
> > On Mar 11, 2024, at 1:18=E2=80=AFPM, Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
> >=20
> > On Mon Mar 11, 2024 at 6:11 PM EET, Eric Snowberg wrote:
> >> + return -1;
> >=20
> > Missed this one: why a magic number?
>
> Good point, I'll change this to return -ENOKEY.  Thanks.

Either that or a boolean function, which ever fits to the overall
flow better... The upside of error code is less branching in the call
sites. The upside of boolean is that caller exactly knows all the
values that ever should come out as a result.

Your choice ofc.

BR, Jarkko

