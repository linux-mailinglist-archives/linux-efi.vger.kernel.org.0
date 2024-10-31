Return-Path: <linux-efi+bounces-2082-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0509B8355
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 20:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C35B1C236B0
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466261CB32A;
	Thu, 31 Oct 2024 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vjv/af64";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O304umbi"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1A1C9DD5;
	Thu, 31 Oct 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402719; cv=none; b=tF081hnKn4uKCu9Y16qrTStV5uUHV8i+9gz3MWiW7SiLqE4wIuFzJpIcnwIrysWV0g58/8KDiPABX34/+LR0cKwWt3pdHkR2ta1RvA1tjLWK82JGGNwHubkqRAhSH2RA8BSFIlM+PdHQ7UP92YtJGrqr22PaOoFZd2M7hSnQio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402719; c=relaxed/simple;
	bh=EH1NxSt+Pdnf7Bw+M0iBaivcvXqmL0RJLwQ2N7+oIGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hrPmeaWqxpje1usT9cD+WQCd8MBLYImk6qk1trgqo4mSodLZE3KddihgDSYKdSF2+xwR0i6ONR8sN3yf2sdOoboXaqfdvCEVB/h+THXzeY0i6LdDQBODKvUYEZzdL/G0JhMN5J/7EpYwANkWyXP7UJqYyIXGeux+rERCgFF6fyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vjv/af64; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O304umbi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730402715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ+EOPL/V+hQ49Yycx1LmMX/gDzsFgIKjYT1P4zOubs=;
	b=vjv/af64u6mEzqmtnnI2LLHwiqEAbrxeScDOJDQ+xzgfhak0wuopvAH75wdHaIGtILg7Kp
	LBDNN9rPonxWJ3T8l0/HV9iryIEYfgsBQUF7r5Zox6rqNLupQFThwE8ly2YxgrkxPa3CSg
	PQ82uXnIJ6u+kIKsgqNiA1TG0v3YV3DOtR7hk0lMhdv3ZRjXU4sIV/dr5oTriImAIGnyvn
	HebLhfFGMDQtogeuUdmDzfhYi8MAoL8vmU4sCzAIig+g6oeq8werbC0UFQDPGjt+fFl3hu
	0Fk4o8uuFPl/rHsJGYUO4vgPg5P1k3AkC4/pzZXkFGKiLPowTyt1u8E9aRU2wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730402715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ+EOPL/V+hQ49Yycx1LmMX/gDzsFgIKjYT1P4zOubs=;
	b=O304umbi8H6l/f1CHjtv+6rKM+lfYXngXWnPnxmhIZB2RBZrwBkxEAZinNpNMu0Vi+7AWR
	5tv90Kg2ggamzjAg==
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
Date: Thu, 31 Oct 2024 20:25:14 +0100
Message-ID: <87wmhoulb9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 13 2024 at 13:04, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.
>
> This patchset provides detailed documentation of DRTM, the approach used for
> adding the capbility, and relevant API/ABI documentation. In addition to the
> documentation the patch set introduces Intel TXT support as the first platform
> for Linux Secure Launch.

So this looks pretty reasonable to me by now and I'm inclined to take it
through the tip x86 tree, but that needs reviewed/acked-by's from the
crypto and TPM folks. EFI has been reviewed already.

Can we make progress on this please?

Thanks,

        tglx


