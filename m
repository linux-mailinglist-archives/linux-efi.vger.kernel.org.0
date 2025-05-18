Return-Path: <linux-efi+bounces-3754-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ADFABB08F
	for <lists+linux-efi@lfdr.de>; Sun, 18 May 2025 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A06176B53
	for <lists+linux-efi@lfdr.de>; Sun, 18 May 2025 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4D21CFFF;
	Sun, 18 May 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1bdDZCh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0321CC70;
	Sun, 18 May 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747579358; cv=none; b=YNkmUv2vfep/IE43ZVDQNCElQW/Nv5No4BvdSQq3psdxCWb9PuISBZb0zIH63EDcfYLiYOU5IHsJuSN45NnvTAi3AoxmPJUCZq2ceuaB8PKQkvIc3hCBFTF9Bqcevj0bcuSVhjKD6mHD8JOturnXylHgcQPd5/e/15eNrdAiogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747579358; c=relaxed/simple;
	bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1PO2xylGll94R/nHkgM/fczSfgeBTBNCUPWXd+AIM14ale7NIk1t3FbzhOR1IIuzM8dLLnZMamAhvP7JUocLFXGIPlls+RUyTAAMERX6iyUlcN9E8zgDzkjackaLw8PImIFER/bM7X4RuREbty72vgdZiNPxLtMUry3Nq68AXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1bdDZCh; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-600210e4219so4856566a12.0;
        Sun, 18 May 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747579355; x=1748184155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
        b=G1bdDZChhUwF2sG9iVs+z/F/5uX1r5kqzCa7/RAF39YNgFr5Ju19V4F5od73pYxw9b
         BY02mHbrtNRrItX4s7d5HHt21X5GO7w0dGd0oFV4JsXRWqoKnfOXFT2n4+OIZ3/5gbCG
         9Iiw4s5LFnnzd/grzoN3S1fVp1g22VkE6PYr8iQMx1cYb1ILwS+4Rq1cSUQfD8OLWmak
         4Ofuow556uEVs6Q4e1+N73AXzIGpy0XL/vmEYJXHIh2bj/e5IhIrooh/eK8c4UgkTXvp
         3tny1iEy17VP7QnRNC02oyWoTXvpGWgImMKilKUr1dUJ2wWw5uPNpOcPFw940WBbdEkM
         9osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747579355; x=1748184155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
        b=nin/U/PbR07oLePzhN5mU1XPjJzfQirSLbesBbenRDJW8Yuytunp/9qv+ZISA+m2Ew
         ouL2eibE6WEZYRdczmsGk27KCbT4dj5Ssk6l23ATji+jZsWnaPXZMu1JUHSUhzhx1BJk
         x3B6Jkesw9KjG1JLXDYzWoJD/A70EUzNAPEFmauQhNy94o1KBwUH/rE3+VLGqzv19oXP
         wduSum7t1M0Drn6UKaPqTPksCi5VhUyUi69tI3uClmcVevmxhcrC9HcPqyzqInZIdU6f
         tgouh7XnL/WtKFY8+G4oOEgfaRXkRr1aSVow+ZsZuj7PRGzXZ2jGmNe5OO3pO1ArqzXe
         zlbA==
X-Forwarded-Encrypted: i=1; AJvYcCUh2XN1qysNgyScsPKSIauxItG+OjnwyUF6MxxkJJQArbtl5liifIBrhB1Z8SZI3rqcoBEMXyGisciMemYOWRYD@vger.kernel.org, AJvYcCUvxjxEtd8Ee7FW3gBVRIomRPyyRb1PPLIWD0YsHO3zUCace1c7VmBD7ttWP/+dG9I5Uv9L048kpDYs@vger.kernel.org, AJvYcCWlKabIPOI1wx0FzIypnjsbACZh61xYgoJ0dIaH8BOfRE7d3srJYYnZdAk75FEO45eiYyy4GzUo0DdK4RQ=@vger.kernel.org, AJvYcCWvb5nL4+qmLv/R1MX0s1Iu780VInluxfwoFhRCB73KDmZ2uT7M8b39soNgYgzVFe71atoX8Dd7t7MD@vger.kernel.org, AJvYcCXo6NiD6uHdxET/tatyKdf2JNLfyv4FGvG2YDNByGQeI7pJeC5Fzt4DjOfmziZWndt9t1Yt/THi/owtdYEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyloTETXRsazmoivtTNjujBtDMpUd8mAcgNnnqaglx7Je3E9OAv
	9NkWBPOj/k7uPJZ+ZFxpK2ubJ9csWwgE5JkZmjbToO86vyO9d93Po2vd+KwVEInsnNuUANZhNLL
	xB6ToQTn8bXJF8h+wR+UCm/ZK8sucRCE=
X-Gm-Gg: ASbGncsERKVSxQ7BRt1dL5UuEoye3hAsbwQCqzfuJK37N2XywRz6nAyJ3yXt+x3fopY
	uCS9Jwda/RA+hMqNTBFfRRW8MZOlvpk7AUctjf+fTsltsN1E5y1mYAh86zvYi3fbPd5I1BlwmLY
	WwjXhLa2+++fVdn02RiPR27gmAWMphhQ==
X-Google-Smtp-Source: AGHT+IHB++m0GR0lO5TfW8cZq+R6bSxHcLUjm6jGofGJAl2FV1P4JdhTYEzSIBs2qV2FvWjm0WoY9STztiddXe/xN+k=
X-Received: by 2002:a17:907:7d8d:b0:ad5:4998:9f1a with SMTP id
 a640c23a62f3a-ad549a7e5e8mr600457266b.5.1747579354599; Sun, 18 May 2025
 07:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
 <9b18e8e3-f3e2-48d4-839a-56e1d8f62657@intel.com> <03d0db6b-628e-4a5e-8e71-852233b83f60@apertussolutions.com>
 <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
In-Reply-To: <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
From: Mike <mikewallacesmith90@gmail.com>
Date: Sun, 18 May 2025 09:42:23 -0500
X-Gm-Features: AX0GCFuU42_TMoi_HKtSGmNW7XrkC1FL6iyDZjOSvOw7NwM1rf6CdCYLar4WcGI
Message-ID: <CAAyYeYjp0v2PYt1owTdOpQD8_NjakquyXbUr5M1a_OWLEKHQ0A@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Rich Persaud <persaur@gmail.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com, 
	Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com, 
	"Mowka, Mateusz" <mateusz.mowka@intel.com>, Ning Sun <ning.sun@intel.com>, 
	tboot-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 7:57=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 4/28/25 17:04, Daniel P. Smith wrote:
> >> OK, but why do this in Linux as opposed to tboot? Right now, much of t=
he
> >> TXT magic is done outside of the kernel. Why do it *IN* the kernel?
> >
> > There was a patch set submitted to tboot to add AMD support. It was
> > rejected as tboot is solely focused on Intel TXT implementation.
> >
> > This meant I either had to go the route of yet another standalone loade=
r
> > kernel or do it in the kernel. Doing it as an external loader would hav=
e
> > required a new set of touchpoints, like the one you are highlighting. A=
t
> > which point, I am sure I would have gotten the question of why I didn't
> > do it in the kernel.

Will this cause any patent infringement issues in Linux [1]?

1. https://patents.google.com/patent/US9075995B2

