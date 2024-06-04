Return-Path: <linux-efi+bounces-1131-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB028FBB1C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F496B284CE
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA0414A0A2;
	Tue,  4 Jun 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7u7MCms"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797D84A33;
	Tue,  4 Jun 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523968; cv=none; b=P4Rg4Lrp7uFgohTVsY0aPi2AsDLtoRzvZvZU42aS41Z9G7/iF2hmTgrI7nNT2IFRXJW5bgiSVIfBbLhCokr3zZF6q+EKU5Eia6bk0XyLVKkQPbWKSKRN2a1AFs5oDLrEU0OkO6TIlzFEYFEt5FhqsPo3sEdAtCM01bdHo8b8qsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523968; c=relaxed/simple;
	bh=Jjiyu40/RbXKcJ/N6MhGcs1AIS0xncpQQ2rPMAjh6EY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=bXii+VrtWhUxMESKqRxTRlzDFDJ+MKMkvkDOTRB2jAwPfkw0KwG3Irk7A7WrGGg4nDxp0qNsKgi3q7TB7Sn2eBbrD6zrtQTIF+j6PyvX7+E+mjZKWWS9JywvZFd9huOFjok3V5uoGu5UYJUNJBioO8XiaJsHrpNoE6kb0/nIlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7u7MCms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9F3C2BBFC;
	Tue,  4 Jun 2024 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523967;
	bh=Jjiyu40/RbXKcJ/N6MhGcs1AIS0xncpQQ2rPMAjh6EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7u7MCmsa10awgQf1KcWyVu4v7GTvrU8UqDF2Horg1lWXWQOh0qv5COXe0+3d12AC
	 Sh/F9ormB/wcV8pt8GRTnIi3qSW6q4atAC7THvfIIcu9Gt1OB6KNwDYVHWnfFFdKvu
	 6BdtSBNB08M8RbZysMzVt2wbrdayEpnoHH02qqrWxQFcuCWbHXHDXtusNQunjqE7QJ
	 2ORxcwrXkUygM8TfubBm7MyaqYbw4u2S6kMhrbRxnyMM+B6uh8f+z6lFn6TwwesPDG
	 C2R+tQeOXvlkq5jRYX5jYiWxLA5vCGcfUyYVbSGKPl0r92Bdf+GD/PRKe4D1j0OFyY
	 29ZIEyqzZteYQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 20:59:20 +0300
Message-Id: <D1RFFIVMEENQ.3RXXNAGNWBE1O@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Snowberg" <eric.snowberg@oracle.com>,
 <linux-security-module@vger.kernel.org>
Cc: <dhowells@redhat.com>, <dwmw2@infradead.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
 <dmitry.kasatkin@gmail.com>, <mic@digikod.net>, <casey@schaufler-ca.com>,
 <stefanb@linux.ibm.com>, <ebiggers@kernel.org>, <rdunlap@infradead.org>,
 <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/8] Clavis LSM
X-Mailer: aerc 0.17.0
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>

On Fri May 31, 2024 at 3:39 AM EEST, Eric Snowberg wrote:
> Introduce a new LSM called Clavis (Latin word meaning key).  The motivati=
on
> behind this LSM is to provide access control for system keys.  Before spe=
nding
> more time on this LSM, I am sending this as an RFC to start a discussion =
to see
> if the current direction taken has a possibility of being accepted in the
> future.
>
> Today the kernel has the following system keyrings: .builtin_trusted_keyr=
ing,
> .secondary_trusted_keyring, and the .machine.  It also has the .platform
> keyring which has limited capabilities; it can only be used to verify a k=
ernel
> for kexec.

Would be nice to have a reminder of applications for secondary keyrings
use cases of today [1]. It is not entirely clear for me, given that I
need personally just the builtin and machine keyring. This is not the
same as saying that it would not be useful, but it would clarity to
scope it a bit in the current state of the art.

>
> Today the kernel also tracks key usage for verification done with any of =
these
> keys. Current verification usage includes: VERIFYING_MODULE_SIGNATURE,
> VERIFYING_FIRMWARE_SIGNATURE, VERIFYING_KEXEC_PE_SIGNATURE,
> VERIFYING_KEY_SIGNATURE, VERIFYING_KEY_SELF_SIGNATURE, and
> VERIFYING_UNSPECIFIED_SIGNATURE. After these usage types were originally
> introduced, most additions have typically used the
> VERIFYING_UNSPECIFIED_SIGNATURE.

Since there are so many why not just format them as a list here?

Maybe start the whole cover letter with exactly two lists:

1. All possible keyrings that are below described as "system keys",
   and their purpose and scope (briefly).
2. The above verification methods and exact same level of detail
   for each.

There's so much text here that maybe even subsections like:

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

<Those two lists>

Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

<Motivation behind Clavis>

Solution
=3D=3D=3D=3D=3D=3D=3D=3D

<Mechanics of Clavis>

Would make reviewing this heck a lot easier as you can then focus in one
of these three parts. And I guess I have a brain of a goldfish ;-)

[1] https://lore.kernel.org/all/20160407085915.29311.7484.stgit@warthog.pro=
cyon.org.uk/

BR, Jarkko

