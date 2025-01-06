Return-Path: <linux-efi+bounces-2506-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C5A01E4D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 04:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963567A113F
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 03:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839F19004B;
	Mon,  6 Jan 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IaFudVQo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE214B94B
	for <linux-efi@vger.kernel.org>; Mon,  6 Jan 2025 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134864; cv=none; b=aePU5MzprB4sKmUakwyMMuZvddkCMssKluvKEOtS/rgHSIb9jB98kKRX5Ru1Vjxz3eXFdW2zTf/Gz2iF3VfYEsEPse7/1vfYxU8b1dvzbK6fpMTpjf8mFU6QU9X5pP6tNcSFyIP1PF/TsN36dSZTc5W3sqPly+xYvUaDocjfTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134864; c=relaxed/simple;
	bh=8DUGcNzptq1qMBNMQD/ZKivSEc24A77W165dn0Ba4IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLJaxXp8Mxn2BjOBmd54MJ4wLxq76BoAFFcachVOg328OKGbgoaxfSG9zfRUvyJkPGsqf0EGBhb8gVqL4Da4C+mrURZp9Z/rmRI0eoDjsF4/dR64/GZcuG9G8WbgskYyKKfbsQwvkgZ0izLUMFDbuAQXwNMQj/VFObcxOLJN6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IaFudVQo; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so15205473276.2
        for <linux-efi@vger.kernel.org>; Sun, 05 Jan 2025 19:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736134861; x=1736739661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t4+KmeeCy/tpHdFuGwkBi9hlofz3W6ub54t1sWW4xg=;
        b=IaFudVQomY0CGTZMZZ/QWrq6Sxqdqpm8GxZBVG+GIAiBifgYOd9fPWagXG2CXSdfas
         3lnuAQL6fToxzerwOnK1TRsR+WNAKOyHlqcSnd2+TUwJWRhG0aemZlXxHTm4d3fPcOQU
         tdPG9Wyxv/XD/cshVQI2noPBDU4p/jsM5oWw3w/bdsi2mKZoo3KRywnTt4Oz+za+wRg/
         f0dQL0CFKMpgocwyckUtuXrACgIinI6++o8nVlL4U3XyXoiE5tAigHQdslEyGXctJ88g
         kfAdZdjpvGI72RTTzJ6QPza6imRyPS43OAiqvDM9BKxVTaIuXFrCvE5QjlqXozXyGw3I
         QUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736134861; x=1736739661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t4+KmeeCy/tpHdFuGwkBi9hlofz3W6ub54t1sWW4xg=;
        b=gaTXVbsMtT/ITAMt59GCoqiKlWdhLqOyf2CLsgX9xSMYb3UoD/HfBqWvOAm4ZGp5KA
         lpL6Jjd5dPGiKTeLpiGrjw1wsLq5z3AqQ3jcH/cre5RfejUffKXmu0SkbLZm/UNuNRFp
         C98nA5k+GOPoJTT6K5SRtkos4lVZ5ws4ERsfYpvlTvhitIFE1iBWT5f2mj7DuSXe0gBT
         PhPg0D7+3UIxHNfHJHVNcM+hrSHtqhX18M7/rX6D5m2fdlsmdjuiO/jrNdlL1rSAU20p
         cKXcvofhLnblgfTEV/dv6kkGOPOE2OkD73qL+nH7GS0af9jK3ZT2Z4op0a76zUmjPDKR
         XovQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzHXrN61e/A8oojCzdv9PccuCqSdI6u0q5nutN54O1n1cHLeguDjur2c8dfy0fG0nSUhjBoE2Wy/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3VF5bOysAIzqWRunm1uYK9zlmelCAnoGURB0eCIHm6bplb+M
	Ug2H3D+Yn8AKDliDK71cm8kpKqHtRrewE73lH+6NndKT5Pch/oAGRXdLtgvHy9q6idBPdzrNZdx
	kdYFrESzBFrXJLgzwn1h2yIGzblsy3aLpBvtP
X-Gm-Gg: ASbGnctuVFiOxlFNP+PosQ3JtK61AtGs2BKftI00cDN+9S0/V4yQg29gtplKv697LEP
	QEmOzMDnatjr/aMgfhIwpWrzZj2BX+m0XEqgB
X-Google-Smtp-Source: AGHT+IGV5iWI1X9jzlMyykT81bJsVn3tu5hbb0dX48snfbYwM4zQ6K8WfYhBMKhfP8y7t6HQ8jUgFUo/mnKTQ27HptU=
X-Received: by 2002:a05:690c:62c6:b0:6ef:59ef:f194 with SMTP id
 00721157ae682-6f3f80de678mr365800587b3.4.1736134861363; Sun, 05 Jan 2025
 19:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
In-Reply-To: <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 5 Jan 2025 22:40:50 -0500
Message-ID: <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, James Morris <jmorris@namei.org>, 
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

On Fri, Jan 3, 2025 at 11:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Regardless, back to Clavis ... reading quickly through the cover
> letter again, I do somewhat wonder if this isn't better integrated
> into the keyring proper; have you talked to both David and Jarkko
> about this?

I realize I should probably expand on my thinking a bit, especially
since my comment a while regarding LSMs dedicated to enforcing access
control on keys is what was given as a reason for making Clavis a LSM.

I still stand by my comment from over a year ago that I see no reason
why we couldn't support a LSM that enforces access controls on
keyrings/keys.  What gives me pause with the Clavis LSM is that so
much of Clavis is resident in the keyrings themselves, e.g. Clavis
policy ACLs and authorization keys, that it really feels like it
should be part of the keys subsystem and not a LSM.  Yes, existing
LSMs do have LSM specific data that resides outside of the LSM and in
an object's subsystem, but that is usually limited to security
identifiers and similar things, not the LSM's security policy.

That's my current thinking, and why I asked about locating Clavis in
the keys subsystem directly (although I still think better keyring
granularity and a shift towards usage based keyrings is the better
option).  If David and Jarkko are opposed to integrating Clavis into
the keys subsystem we can consider this as a LSM, I'm just not sure
it's the best first option.  Does that make sense?

--=20
paul-moore.com

