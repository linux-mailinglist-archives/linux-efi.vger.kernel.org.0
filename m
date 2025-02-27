Return-Path: <linux-efi+bounces-2858-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C17DA48B70
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 23:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F893B27C6
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E983C274273;
	Thu, 27 Feb 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="On8udIuW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1C272905
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694955; cv=none; b=DezWa0rfrBEWGkxQ2grqwLKL2Om9xRxW0pm94+ZMXA5KVEgLF79oIHRzSMrr9acVRy4KGjI+sAAkBBWHT347wHfKgxWRSfzLppzSAQVMP3RDctIMsVkayhnzQO85S6LpRNZzl8DBu3cucpM4LLNGQt/tzQI6W03QqOGnx3O/gTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694955; c=relaxed/simple;
	bh=Le3t4kyiotBAGEeTNlkwGJJUb6SlwUJPq/9Ayw35DTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLSabvQDoUD0TB5tPoouEiVkEsD6SA8tWWm3fYPLx8pQsSTp0yji0fmHQA30Ia5I+vY65FK0QCnO7ufUCETI9RzysXK2+hkVNsSc8o082xA5TQuqUqVaqoswhOodhYoIUEJAUCMaGNZ15aNpi5yRzOlNfQSADrimjt+QNhAKVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=On8udIuW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f4b266d333so11604637b3.2
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740694953; x=1741299753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScakE+ivXVszoVLy+xVwqAkmsKVwP1/+ubR/2bsYhJk=;
        b=On8udIuWbca6dQrFAq6FYI9z1Rs+p3fyKu5wcC7uJ6XcJyM4o6VP2km9c3pkTD3cTP
         722I+VKEQtfPHd1MJlkEPa+4iJ4c0JbrMEa5f7ojlzB/DAotMlRJ5J+atJZCPqyx5ACM
         /pVS6qXjVHQ8IOuNEmA75zGVS6hD1Qy80pxvKkTquK1q7mtOXo/5BIJVD2xkY78i5gDr
         8MzlxWWjG5q5lDZG5wkL+94XpEhKVh++Lx2j31iAg934zMXNXwQEJOl7WVyERRfbRXov
         I5G+NURaWU0MHbRFlzheUtF+iZGWOrOJlpoXhuMlE7HAJusnJUeS+pCEiXWkngqyTza/
         TyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694953; x=1741299753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScakE+ivXVszoVLy+xVwqAkmsKVwP1/+ubR/2bsYhJk=;
        b=w7OU4u+nkHM3t9PcFUK+uhgbzsDzIz0y+X3eULc4+ng8/rMXhHPrW554RRprGlngX3
         /CfX3OjS0Qoi7lv67Q1xQCp2Xz3XaRMROIBHTVug40jU1Z6MBp/oABuMRk4fL7wLWr/N
         MKMZxgD9d7bRG8QDGR2MZItBBUrvkL/SVhDQtD9ppS/1advXXVmcKPejHkBrfaRd126W
         2+YlQqXW8TIPjR1rpxcfxMV2Pvgfjk/gu+CHQmk91hYI76jAt+AJBKP/TiwJKiJiZdu5
         mGjRfDoU26LDtIF/+IbWoxHr4j8ZkHqywQmBPVFRskmuT6kegU9p9x5p983nlA0QzXlm
         n7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMbK8+Ky7mqTeXte1lqu55eCsz74aU44gYp3VEAi7/eFpmCsSDROBE3OPd929rs7VAKNNbryVeL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRErz2vBNo79R0TYxbYDxkSqeCRjEOis5wYRaVEBm/XAam+Ct
	NrzThLZFFyGSHJ+d6HO8l+/8Wo0UPuWvJ+cEgP0nUpGNhmReBQd+N0+Jkdlo9n9NhiH9+uUaSwm
	l8yslnQyUUFCLSou1NLiFPHhqtepBvONe9POu
X-Gm-Gg: ASbGnct4yIrdKC+GcT80y455S1OrUqywqghE7DV5zfc4jxkMAqaa9f6bHn6lp2q7Wgn
	N0QIWRuFg3J8jnNRmgJzP4BSENpzgZxqWavKGEYq6AbnBdhl/TBan3MnpBr/c/4HLyHVvwUfmDB
	EyLigQrXA=
X-Google-Smtp-Source: AGHT+IGKPvb6uJOvINeQsM+iSOmGVr/Q+rN9nHiUXllkoj79N4+6rGnhZ88M/fTJmoa1TMKM7/1/9ZyZ0+zbdTUHg4o=
X-Received: by 2002:a05:690c:4b8c:b0:6fd:3f9e:b7d6 with SMTP id
 00721157ae682-6fd4a074751mr20138727b3.19.1740694952817; Thu, 27 Feb 2025
 14:22:32 -0800 (PST)
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
In-Reply-To: <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Feb 2025 17:22:22 -0500
X-Gm-Features: AQ5f1JpGHD9sDTEfCNGPaQVwEKRNBeWrx8Lfv7PT8-K9hixoVfU0bPOCCzjhhe8
Message-ID: <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, David Howells <dhowells@redhat.com>, 
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

On Thu, Feb 27, 2025 at 3:41=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2025-01-06 at 17:15 +0000, Eric Snowberg wrote:
> > > On Jan 5, 2025, at 8:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> =
wrote:
> > > On Fri, Jan 3, 2025 at 11:48=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > Regardless, back to Clavis ... reading quickly through the cover
> > > > letter again, I do somewhat wonder if this isn't better integrated
> > > > into the keyring proper; have you talked to both David and Jarkko
> > > > about this?
> > >
> > > I realize I should probably expand on my thinking a bit, especially
> > > since my comment a while regarding LSMs dedicated to enforcing access
> > > control on keys is what was given as a reason for making Clavis a LSM=
.
> > >
> > > I still stand by my comment from over a year ago that I see no reason
> > > why we couldn't support a LSM that enforces access controls on
> > > keyrings/keys.  What gives me pause with the Clavis LSM is that so
> > > much of Clavis is resident in the keyrings themselves, e.g. Clavis
> > > policy ACLs and authorization keys, that it really feels like it
> > > should be part of the keys subsystem and not a LSM.  Yes, existing
> > > LSMs do have LSM specific data that resides outside of the LSM and in
> > > an object's subsystem, but that is usually limited to security
> > > identifiers and similar things, not the LSM's security policy.
>
> Hi Jarkko, David,
>
> Both Paul's and my main concerns with this patch set is storing policy in=
 the
> keyring.  We would appreciate your chiming in here about storing key poli=
cy in
> the keyring itself.

I'd still also like to see some discussion about moving towards the
addition of keyrings oriented towards usage instead of limiting
ourselves to keyrings that are oriented on the source of the keys.
Perhaps I'm missing some important detail which makes this
impractical, but it seems like an obvious improvement to me and would
go a long way towards solving some of the problems that we typically
see with kernel keys.

--=20
paul-moore.com

