Return-Path: <linux-efi+bounces-2639-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99AA126AA
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B76118837D3
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA4212AAE2;
	Wed, 15 Jan 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xP5pba5u";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xP5pba5u"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430404085D;
	Wed, 15 Jan 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953097; cv=none; b=XrSCmsii3pBlwNlFd6L/6rw3FzBptyBX9J+9uwrGswA7hcQ00/WWEZXR7RW8i5SGRS1AU/XYtP0jBoUawpRa4k7P7erO743DbY19ry2N7OTRydKyYLVv3D7Uss/W8OmKjc2+oP2jn0yY5X4Po1dyQl82B1ixj9VOCONGNE5htlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953097; c=relaxed/simple;
	bh=vTPxvvf/rVDGudkWeskfVfRJWmJ+hZtZKBAqM/+EN7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHEKRLI3oY5RV1RloCeq7a2RfguaMWmhGNKYkmLJtGeGfhP+BXVaZ4ipLUkUJoiB/pQfalqAXw3ovAAMs/NvOTQO1qhmJFb+xzL5bgQIPQSnPsLwo1BMuqvS868SwlkjwUaOTm0j2GM9AoQDH5Pds9B9k8Uh5iTI0RglrOLnzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xP5pba5u; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xP5pba5u; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736953095;
	bh=vTPxvvf/rVDGudkWeskfVfRJWmJ+hZtZKBAqM/+EN7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xP5pba5uwsumH9A/yvhLkq96UVShtmaF19woJeo7D61V5n3zhpCaPYmUPDOIrt1bb
	 CqHYyMspucC8i10JMRMUS3KETmWaCTXMZCC/N6AlzgPjOyO8KHcPnZHxHCGGx99SbM
	 O5Tj4lBM9l1zIrzWcoYwwyOnliDjzWLalOkX5pbE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6B46E1287936;
	Wed, 15 Jan 2025 09:58:15 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 1xRtF4tROyLt; Wed, 15 Jan 2025 09:58:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736953095;
	bh=vTPxvvf/rVDGudkWeskfVfRJWmJ+hZtZKBAqM/+EN7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xP5pba5uwsumH9A/yvhLkq96UVShtmaF19woJeo7D61V5n3zhpCaPYmUPDOIrt1bb
	 CqHYyMspucC8i10JMRMUS3KETmWaCTXMZCC/N6AlzgPjOyO8KHcPnZHxHCGGx99SbM
	 O5Tj4lBM9l1zIrzWcoYwwyOnliDjzWLalOkX5pbE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 888AB128791E;
	Wed, 15 Jan 2025 09:58:14 -0500 (EST)
Message-ID: <ff67e26af366013478b0acab5e9ddd49316c605d.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH] efivarfs: Introduce efivarfs refresh remount
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jeremy Kerr <jk@ozlabs.org>, Ard
 Biesheuvel <ardb@kernel.org>, Tim Schumacher <timschumi@gmx.de>,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org
Date: Wed, 15 Jan 2025 09:58:12 -0500
In-Reply-To: <CAHk0HovnRgxrKu0uoj1x3XSB1vrTaGtMn-7iaoSR5Fs+=EYd5g@mail.gmail.com>
References: <20250115141458.9182-1-o451686892@gmail.com>
	 <28105c4069a81c017b501551df7aa67aba743241.camel@HansenPartnership.com>
	 <CAHk0HovnRgxrKu0uoj1x3XSB1vrTaGtMn-7iaoSR5Fs+=EYd5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-01-15 at 22:49 +0800, Weizhao Ouyang wrote:
> On Wed, Jan 15, 2025 at 10:34 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Wed, 2025-01-15 at 22:14 +0800, Weizhao Ouyang wrote:
> > > Currently, when setting efi variables through the runtime
> > > service, efivarfs cannot sync variable updates properly.
> > > Introduce efivarfs refresh remount to support efivarfs
> > > information updates from other sources.
> > 
> > What other sources could there possibly be?  While the Linux kernel
> > has sole possession of the EFI RT interface after ExitBootServices
> > has been called, nothing else should be able to update the
> > variables except efivarfs.  This is a guarantee from UEFI so why do
> > you think we can't rely on it?
> 
> One route that may exist is: drivers/firmware/efi/test/efi_test.c
> holds some ioctls to call runtime service.

That's not supposed to be used for anything other than direct testing
using the firmware test suite, which shouldn't impact production use of
efivarfs because it's defined to be N in Kconfig.   However, if we
suddenly decided there was a use case for production systems running
the test suite, the way forwards would be a notifier that tells
efivarfs about successful updates to variables as they occur without
having to remount.

Regards,

James


