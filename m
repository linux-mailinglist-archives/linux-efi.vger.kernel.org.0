Return-Path: <linux-efi+bounces-2636-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B6AA1260F
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026351671DA
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D997080B;
	Wed, 15 Jan 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Z855/GzH";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Z855/GzH"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4341C6C;
	Wed, 15 Jan 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951643; cv=none; b=tvAQYZl0N/jIDSrqQ2DYbKlKHhqK5R7WSHE2rcYaFt5YIxKkLgWTfvZTNzaAf09m0SMiasDYhORZ9Y+rCrpUw/UiXkTO5M4pd+Sk95PVATU/t3ojp6fHboFHNDvwu0Svb3LIBveqFxW4WSaHHKou/TESb3yRqjiearQuum76QqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951643; c=relaxed/simple;
	bh=KF1QKRfwKX151N3i5TLiAndTN6awwnxv8Ge/05gM7Lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nbsd/5817PaYUF5cFyrTVK8k0ZUIvKyFUdctPXaHvQNIb4dfgMdHrnPOu1ztHfmvRMaDZiclOXg3BZzbHCfOpOjwGLdHGzKahE9URecyQPrmxRV1TnMZLTosFu+IMUmdDZ9Wes50SvFSLjIaz8k3VTNylOOyfjbc68no8CcvCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Z855/GzH; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Z855/GzH; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736951640;
	bh=KF1QKRfwKX151N3i5TLiAndTN6awwnxv8Ge/05gM7Lo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Z855/GzHwvPY1kD4vi0o/ZwUtRVwrEZf1Ju8lfdcgcLlaBj2Jp6Q6XRupi71TBwOz
	 sCIRfv2YKvPnlu8/XmUQ7bCfXsgZT69yvSmRzqFTBgAl1GgXK2J7AcGmh7I0yYa7AD
	 rP7NkKpZ7whFRNq1sLmhf+/yEcOwcon+iM9c2M3M=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D67D712873E0;
	Wed, 15 Jan 2025 09:34:00 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gRoKM-JdsTVT; Wed, 15 Jan 2025 09:34:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736951640;
	bh=KF1QKRfwKX151N3i5TLiAndTN6awwnxv8Ge/05gM7Lo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Z855/GzHwvPY1kD4vi0o/ZwUtRVwrEZf1Ju8lfdcgcLlaBj2Jp6Q6XRupi71TBwOz
	 sCIRfv2YKvPnlu8/XmUQ7bCfXsgZT69yvSmRzqFTBgAl1GgXK2J7AcGmh7I0yYa7AD
	 rP7NkKpZ7whFRNq1sLmhf+/yEcOwcon+iM9c2M3M=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0074C12873BB;
	Wed, 15 Jan 2025 09:33:59 -0500 (EST)
Message-ID: <28105c4069a81c017b501551df7aa67aba743241.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH] efivarfs: Introduce efivarfs refresh remount
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Weizhao Ouyang <o451686892@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
  Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Tim
 Schumacher <timschumi@gmx.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Date: Wed, 15 Jan 2025 09:33:58 -0500
In-Reply-To: <20250115141458.9182-1-o451686892@gmail.com>
References: <20250115141458.9182-1-o451686892@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-01-15 at 22:14 +0800, Weizhao Ouyang wrote:
> Currently, when setting efi variables through the runtime service,
> efivarfs cannot sync variable updates properly. Introduce efivarfs
> refresh remount to support efivarfs information updates from other
> sources.

What other sources could there possibly be?  While the Linux kernel has
sole possession of the EFI RT interface after ExitBootServices has been
called, nothing else should be able to update the variables except
efivarfs.  This is a guarantee from UEFI so why do you think we can't
rely on it?

Regards,

James


