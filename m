Return-Path: <linux-efi+bounces-2328-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C979E9926
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B63280E06
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301A1B043D;
	Mon,  9 Dec 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="m7wbyXyL";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nanCGP+y"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3112F1A239E
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755135; cv=none; b=oPo6zJdKbUwy8XBOkte+Fso5t3lWOPIz/dSm5eC35NtULNxePMQd4aDf76VrfUyyQZOy1ffIX+6iIHNIvyPRQ+7jJH0JYnkh8iJm4G2gqcTzv9LHH77/FDElSBLtqozOpUiXSBx3nglpFQnU0ei0H5Q1UlO3WQFpgUUS205Xeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755135; c=relaxed/simple;
	bh=9HziiM4tnmlo53jQIgxKTlV/cx0aMWvqidYdmaaFVr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQ4Cxgcah9c+tSuwGxbENvi0DxAVaibbHv87yXtq04kTqX2c2P+FKHv88qGZaQOCNRebjq57mSVAeJBpu3U/Kk7z0XhBvGUfGzWNR+VMtGBO58vGDeRbhdNAUyRRWdm1qjPuBh5LIteZfUSD2AjMXtvFMy5j2uYh8yu2Om/Y8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=m7wbyXyL; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nanCGP+y; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733755132;
	bh=9HziiM4tnmlo53jQIgxKTlV/cx0aMWvqidYdmaaFVr8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=m7wbyXyLRLIGigmplE7hcYUDdcVSsghGLhd6XOgO5ON/mZhl/v+IIErgefajvybbi
	 ZfxXh1XkiUPFRQC17EhsuMMhc6fX5eXWBAKiuSMEiYyrm1pDUrRQRvIg2KQ4Xy4b3y
	 AihNc5KcVwts2pcoHaDaQ8VRTbV28B6JSX1dNBTU=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 11EAD128B0CC;
	Mon, 09 Dec 2024 09:38:52 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pyAF-wRq-qmu; Mon,  9 Dec 2024 09:38:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733755131;
	bh=9HziiM4tnmlo53jQIgxKTlV/cx0aMWvqidYdmaaFVr8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nanCGP+ySLz9pPiskvjhwTppB63OrS7TMizHbzpedShA/kATNm4Y0O+o6iTyUUinp
	 bCEQp7THTkiO5RyVEECOugnDofFN/vAm+7ehyG71T0cwK5OkrV3PDaYdapnKk83vy1
	 k1jvUKwFIy0WjnZLnHhvsVpkyK9HizkN16WEV4BI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7ECA6128B0CB;
	Mon, 09 Dec 2024 09:38:51 -0500 (EST)
Message-ID: <1b7da8f615c6d632e00acaf326b9809c10088cc6.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] efivarfs: bug fixes
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 09 Dec 2024 09:38:49 -0500
In-Reply-To: <CAMj1kXE0o+ct7v+Ab9+auXnWphMXXK5b9iz3vn6nBfuhOu_QRA@mail.gmail.com>
References: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com>
	 <e6f802491e912b0907d2990c712210b0350db9aa.camel@HansenPartnership.com>
	 <CAMj1kXE0o+ct7v+Ab9+auXnWphMXXK5b9iz3vn6nBfuhOu_QRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-09 at 14:49 +0100, Ard Biesheuvel wrote:
> On Mon, 9 Dec 2024 at 14:34, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Mon, 2024-12-09 at 10:20 +0100, Ard Biesheuvel wrote:
> > > On Sun, 8 Dec 2024 at 19:34, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > > > Patch 1 is stand alone, but 2 depends on 3
> > > > 
> > > > Regards,
> > > > 
> > > > James
> > > > 
> > > > ---
> > > > 
> > > > James Bottomley (3):
> > > >   efivarfs: fix error on non-existent file
> > > >   efivarfs: fix memory leak on variable removal
> > > >   efivarfs: fix incorrect variable creation
> > > > 
> > > 
> > > Thanks James,
> > > 
> > > I've queued these up now.
> > 
> > Thanks, but I need to redo 3/3: there's a bug where if the variable
> > is created to do a write which fails, it remains on the list even
> > though the entry is freed.
> > 
> 
> OK. I'm a bit out of my depth here with the VFS stuff.
> 
> So efivarfs_create() creates the file and efivarfs_file_write()
> writes the contents of the variables, right?

Right.

>  So what is the correct behavior here if the write fails? If the file
> exists as an empty file, but might still be open, surely we cannot
> just drop it from the list?

I don't think it's a race that can be mediated in the current
mechanism, although the efivar lock seems to do some of it.  In the
ordinary course of filesystems it should be mediated by the dentry
objects (any racing open/write with delete can either succeed or get an
error).

> > It also begs the question: why does this list of variables exist? 
> > All it does is cause management complexity and overhead and its
> > only function seems to be to free the entries when the filesystem
> > is unmounted, which could much more easily be accomplished by
> > implementing a superblock evict_inode() callback that kfree's
> > i_private, which would mean the entry was freed when the inode was
> > and thus wouldn't have to be explicitly freed anywhere.
> > 
> 
> I have no idea - this code existed before I got involved with EFI.
> 
> However, a related issue came up here [0]: the list may get out of
> sync after a resume from hibernate, and so it needs to be brought up
> to date. Not having a list in the first place seems like a step in
> the right direction, as we'd need to synchronize that with the
> updated varstore as well.

Yes, that's the same issue I was complaining about and trying to fix in
patch 3/3.

> So IIUC, you are suggesting to keep the caching behavior of the name
> and attributes, but not keep a list at all? Would that work with the
> needed resync above?

Yes.  If we simply let the dentries behave correctly as filesystem
objects, they'll mediate the race and if the inode gets evicted then we
also free the entry (so we tie efivarfs entry lifetimes to the inode).
There would still be a corner case where you could call open(O_CREAT)
but *not* write on the file.  That would still create a zero length
variable entry which would disappear on reboot because it would have no
corresponding EFI variable.  This is an inevitable consequence of our
required semantics of not creating the variable until something is
written to it although it may be possible to flag the dentry in create
as being not visible to others until it gets written (i.e. effectively
open it as a deleted but open file and promote it to not deleted on a
successful write).

If you want me to look into doing the above instead of patches 2-3, I
can.  I think patch 1 can be safely applied.

Regards,

James


