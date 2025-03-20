Return-Path: <linux-efi+bounces-3050-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D92A6AFF1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 22:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143FB98415E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B1221F0F;
	Thu, 20 Mar 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A8xoPFKR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AA215171
	for <linux-efi@vger.kernel.org>; Thu, 20 Mar 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506614; cv=none; b=Xy8zKyTUCrGsxSzt4eqQD3deMeRcHz92iOoap7v3tYTPlniPVyA3vaYq3FjJf+uxhbGLv+3HLKIAqKda6b1fWLd2cp1aiumb8odq6C8efferFrgZtRgUAPj0FbQOZUU9o83JvRDN+ZWbykKmQilqLFj+2Pe+vN2bzgu7M5+VT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506614; c=relaxed/simple;
	bh=7T7mCRUv80WJKGWdZte/WL6i1IdpqsfOrUhZIxZ6UZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUkm6EBELkniq4iGP5OqYb2Kpnd0zuMGFNPHBVChZVQmSdykF9ulHsGoxITwXU4xFLB891Gh6gA//gMBnrBPW+g7x9M7xUhsrH1JDGggjDtb9BeDnOPJLHwkCxHWhiXp6jU5Ln9DhGM58POhhGhIJhPLFJ1o2TnX2Z0r6JWpOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A8xoPFKR; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so1209868276.3
        for <linux-efi@vger.kernel.org>; Thu, 20 Mar 2025 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742506612; x=1743111412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyZVutv4Kbo86NuPvlmJO48TrYySdnlCPpx5adkmTKs=;
        b=A8xoPFKRuuU0iDFj+64CmEKGuRy7UI+o8numXiGZBrB1qZaQig54zyNUWIs48zcaNW
         qDzdwjiFBuFJ4w/m8HqkIC4DeyZFl+N9MGDI9mzLJo6/MfwFr0dJUBshs7SxZBa22ZUs
         gnWjQMYbo8qV7Ob4Gy3b7oFEQNcDHw98qdAgHLgPlMANHfZti0uDEnVommBDn79yz6Dc
         NNHl7zw6zX0RlLuDpBXzaYLXAiZIusFopRY8Up/GVj35kvkyFo3klhMawZqxBmjdrbM9
         sUVNCcJH2BBRu5nNveg7N0wNarnO1zmSR34fe0yOMQlHlTFcgqlj8vB157tekDh7RRiP
         a7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506612; x=1743111412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyZVutv4Kbo86NuPvlmJO48TrYySdnlCPpx5adkmTKs=;
        b=wMi1kBdKQ9ueXS+1LGjzrWEsnydq1rsyAtVUvm0ECWROXveKT/PLk9oQJnFwfM34Bq
         XORZXPquKiDV2DlRRCx0W0bs8c81OrLNaI8hS6Jn8yft+oaZZCYA2cCHvKyHb+PBMk/V
         mgKqYVYJ1lqzn+f7nnpXsvJDakB9+1b5UXb/iiFNnpvPCnOvlXT0lP4GaRMLC4WrvNe1
         qf1MjpCxOiX++BjduiP+p1bTga9Y5MSEpUnWbtCnuM9HG32uSwl+qQYYtPCCwE6F+cfa
         VwSkGQa923Zkcciql+VBfOat4bOezcGumrRCfylSNskL9k1Br7KB7sa7t+hNW3JAGkpt
         AH3g==
X-Forwarded-Encrypted: i=1; AJvYcCU/f4ZIVpfk4nUJU+Rp1VFN2qfO9H+IKzESjfTuzw+wZbQVmdLCtare1Kk8n0tN+cK1hPPkHs0Ycn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDaebY8Rmujw7Swhv66ds11yu8aXF7QZZXXgArGjtKjp71Jko
	y2fOMGhkDxHS96+P2ar66XoZMwDxIQVFdaDBnsLLK47oTzJ4X6ejXDAtIQBatsWgBJ+8aeKR7QS
	gpg52q+C/dGgPeVH2aZxjhVPcxQJd29mp2if6
X-Gm-Gg: ASbGncuPWZP2749EO2LlwtYT904o7NCYJWfgqA4matgxIaxAEU5SgG1geBThvHPEYH7
	6tkUEKRFsu0ycpsZZBC5lZni7ZHYg0531eVhfeGj3YoRjQM1/BMCRYwV3tX+M4C9VgRuBtMK+kC
	nUIzmZ3/aaOVjvM6TPnUb+6q+fYw==
X-Google-Smtp-Source: AGHT+IFJ/8y4nRYG0B8A5J8ib2VPKClvoRy8JxYCkiIoEvg+R5jg8fqFBWw5SyaibbYjeIOB5RlLC8ykklezHgslACQ=
X-Received: by 2002:a05:690c:296:b0:6fe:b88e:4d82 with SMTP id
 00721157ae682-700bacfbab5mr12941147b3.28.1742506611920; Thu, 20 Mar 2025
 14:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com> <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com> <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com> <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com> <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
In-Reply-To: <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Mar 2025 17:36:41 -0400
X-Gm-Features: AQ5f1JqQwO9cUQQ6QCKvqyhp93snLVhEFtem_HInBr_dfTdWSHM5DQ2eAF2fppc
Message-ID: <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:29=E2=80=AFPM Eric Snowberg <eric.snowberg@oracl=
e.com> wrote:
> > On Mar 6, 2025, at 7:46=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> > On March 6, 2025 5:29:36 PM Eric Snowberg <eric.snowberg@oracle.com> wr=
ote:

...

> >> Does this mean Microsoft will begin signing shims in the future withou=
t
> >> the lockdown requirement?
> >
> > That's not a question I can answer, you'll need to discuss that with th=
e UEFI SB people.
>
> Based on your previous lockdown comments, I thought you might have
> some new information.  Having lockdown enforcement has always been
> a requirement to get a shim signed by Microsoft.

I want to address two things, the first, and most important, is that
while I am currently employed by Microsoft, I do not speak for
Microsoft and the decisions and actions I take as an upstream Linux
kernel maintainer are not vetted by Microsoft in any way.  I think you
will find that many upstream kernel maintainers operate in a similar
way for a variety of very good reasons.

The second issue is that my main focus is on ensuring we have a
secure, safe, and well maintained LSM subsystem within the upstream
Linux kernel.  While I do care about downstream efforts, e.g. UEFI
Secure Boot, those efforts are largely outside the scope of the
upstream Linux kernel and not my first concern.  If the developer
groups who are focused on things like UEFI SB want to rely on
functionality within the upstream Linux kernel they should be prepared
to stand up and contribute/maintain those features or else they may go
away at some point in the future.  In very blunt terms, contribute
upstream or Lockdown dies.

However, let me be clear that I consider deprecation and removal of a
LSM to be an option of last resort.  My preference would be to find a
capable maintainer, or two, that would be willing to take on a
maintenance role for the LSM in question.  Luckily I think we may have
some people who are interested in doing so for the Lockdown LSM,
hopefully you'll see something on-list in the near future.

> The alternative "usage-oriented keyring" approach you've suggested
> wouldn't align with the threat model that lockdown aims to achieve.

That's a Lockdown problem, or more specifically a problem for the
people who are freeloading on the Lockdown LSM and expecting it to be
maintained without contributing anything meaningful.

> For
> a distro-based kernel, I don't see the value in pursuing such an approach=
.

So you've said.  I disagree, but we've already had that discussion,
let's agree to not waste any more time repeating ourselves.

> With Clavis, I attempted to develop
> an approach that would meet the lockdown threat model requirements
> while allowing the end user to control key usage as they deem fit.

As mentioned previously, the design/implementation choices you made
for Clavis means it is better suited for inclusion in the key
subsystem and not as a standalone LSM.  If you wanted to
redesign/rework Clavis to stick to the traditional LSM security blobs
perhaps that is something we could consider as a LSM, but it's
probably worth seeing if David and Jarkko have any interest in
including Clavis functionality in the key subsystem first.

--=20
paul-moore.com

