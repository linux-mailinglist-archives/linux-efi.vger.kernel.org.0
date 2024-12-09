Return-Path: <linux-efi+bounces-2326-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E189E9730
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D30D28322B
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348A23314B;
	Mon,  9 Dec 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g+JqctuI";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g+JqctuI"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11277233129
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751294; cv=none; b=CHb7kA1vyBh7tIKiv1bkg0DyblOz/yS2HbjfPnK2BapBd9aGRAZXEd1Q/T/bweouC0jZyaXLZb9FdDwpIRPSEKfEN5fWlMSEO09rlzsc5a4ATkgKfZhncn/zv6gBI69vR/x+VOAzVyiQncLyaHE7SIHyWhW0C3Z9qflj1e75ILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751294; c=relaxed/simple;
	bh=sV55A1M1tiyI8MwBx2ggkYmUgPzemIb8BwoLHOvlphA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nCRPwpOdxmVJBzqBRxojXP1vYhUHMo+8qJf79jrL4RLJ86GgaRaaCdGse9jdJCOKPoRdlrMoGk1zsRRSbgLM417/nNLKu0Qbx8MzaGtyO/1BMkkQcHKBoZtz8SijCbtPUPSMLJz72se2/8NuKbvQTZU5JHpg5VQYeIDQWJwABwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=g+JqctuI; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=g+JqctuI; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733751291;
	bh=sV55A1M1tiyI8MwBx2ggkYmUgPzemIb8BwoLHOvlphA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g+JqctuISIHSsl+wtE2Rqb9PUaO8nJD3u7USLR+OJLs2qfxjKQVxCSITW7C4Rqf0/
	 qamdBdLlxh5nCfqhNOwnaE+b3NtQ/1CcCB/JjzeBegMnxs4WNdwbyPpyHHg3UCnNAo
	 BsAfspoz3igCEIWh9HcRomx9pMy5STEQIGfSb1ZY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 40AA9128B0D5;
	Mon, 09 Dec 2024 08:34:51 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Q3B41qtudvu2; Mon,  9 Dec 2024 08:34:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733751291;
	bh=sV55A1M1tiyI8MwBx2ggkYmUgPzemIb8BwoLHOvlphA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g+JqctuISIHSsl+wtE2Rqb9PUaO8nJD3u7USLR+OJLs2qfxjKQVxCSITW7C4Rqf0/
	 qamdBdLlxh5nCfqhNOwnaE+b3NtQ/1CcCB/JjzeBegMnxs4WNdwbyPpyHHg3UCnNAo
	 BsAfspoz3igCEIWh9HcRomx9pMy5STEQIGfSb1ZY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AF881128B0D4;
	Mon, 09 Dec 2024 08:34:50 -0500 (EST)
Message-ID: <e6f802491e912b0907d2990c712210b0350db9aa.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] efivarfs: bug fixes
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 09 Dec 2024 08:34:48 -0500
In-Reply-To: <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com>
References: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-09 at 10:20 +0100, Ard Biesheuvel wrote:
> On Sun, 8 Dec 2024 at 19:34, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > Patch 1 is stand alone, but 2 depends on 3
> > 
> > Regards,
> > 
> > James
> > 
> > ---
> > 
> > James Bottomley (3):
> >   efivarfs: fix error on non-existent file
> >   efivarfs: fix memory leak on variable removal
> >   efivarfs: fix incorrect variable creation
> > 
> 
> Thanks James,
> 
> I've queued these up now.

Thanks, but I need to redo 3/3: there's a bug where if the variable is
created to do a write which fails, it remains on the list even though
the entry is freed.

It also begs the question: why does this list of variables exist?  All
it does is cause management complexity and overhead and its only
function seems to be to free the entries when the filesystem is
unmounted, which could much more easily be accomplished by implementing
a superblock evict_inode() callback that kfree's i_private, which would
mean the entry was freed when the inode was and thus wouldn't have to
be explicitly freed anywhere.

Regards,

James


