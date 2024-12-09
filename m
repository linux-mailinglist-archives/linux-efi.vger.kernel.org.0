Return-Path: <linux-efi+bounces-2333-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F859E9D33
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42A61887B34
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7E13AA2F;
	Mon,  9 Dec 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey7evH4y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A65233151
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766115; cv=none; b=Fy8c3x/9aA8o9AN3Yug6MXSE/T4xwDH7xNCrTdtjbY7L6vzGWuFj7hwzmKSXncmu6tZO6wkXqiR+x7tSYbwTy3PBaybJhszehYeoSNuPcC8GbTPpmDoYirVgODNFa8pD0gT488qn9I5gL98H/HKqAPvMj6smBT/YylwslSuIkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766115; c=relaxed/simple;
	bh=AIDmB/kPWmHVy7R7dhSOwe3Dq7bzeTzQeMrxfzWBRqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU4Qv+SbZyQDM9+IYFVqrabtWYD2sNmuJ4lIK4gw0QqU75+R0sJSr8+99zPfNZRNJG9x6UQ6mSnjFWF4jjs5AUXGNgATo9ltrIw0lZvH/AVGYPZt49tiP66qyUFHa3oNVA6xH3z2M9Cjw6cJ6L1SBQ3qu5qpeUhup2kLOi8/DeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey7evH4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B68C4AF09
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733766114;
	bh=AIDmB/kPWmHVy7R7dhSOwe3Dq7bzeTzQeMrxfzWBRqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ey7evH4yUQTQPeRgD3h1MvX2Bj/D61r/cjki8kmK3Zam0NfG6Rv2kYZymI3jIdiXc
	 hj784EpHKOnikd8PXIGwoUuCQ8xOEHYGHQoRsOEC2NWjtDaGH21yXiQwxyxmvAX1wy
	 BAiKJgLHEHGEdauR6EmBzQHL2ITmLLFExnASHX86TKyBUpRlAkou7k8dheQwS/ixgS
	 QNYZw7eWhhzLAPbmMv78cNcJPKAEGL2fLVkyvPRW4EqR+MNZi8wVxCPNnTMBH/pKPb
	 z0BWsxf5YhNdb0P/BE4ZeXAJ4z0h3eZluoL9ss+QgsyK98BAiTGd6v3PBluJv5oeh/
	 jqxTIfMrthDYA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3778bffdso3218424e87.0
        for <linux-efi@vger.kernel.org>; Mon, 09 Dec 2024 09:41:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7IXkEmclw/5eVNWOWXpqvTpToXFGsv8CAzpWEonEJ1zONUKjW
	el/qNHjPKu/j5r4dWI5CIpaC9Ma3ZYIkk1+0H42h8Wtn0k5Tcnx4s25FiIeLVLXl4PlTDVfIUOP
	/iGeBhkHaxKldAS6r1xX4j9Epl0o=
X-Google-Smtp-Source: AGHT+IFBw4cG9/3a0lP6LoyQBxXmeF8b2ZbTe7ZuGwUS8J/pYh7VMSTrc9x2WCnTZQSrPNLDl4Qy89qXCI+/1ZfaZ6c=
X-Received: by 2002:a05:6512:3b0d:b0:53e:335b:4348 with SMTP id
 2adb3069b0e04-54024113004mr493662e87.40.1733766113197; Mon, 09 Dec 2024
 09:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
 <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com>
 <e6f802491e912b0907d2990c712210b0350db9aa.camel@HansenPartnership.com>
 <CAMj1kXE0o+ct7v+Ab9+auXnWphMXXK5b9iz3vn6nBfuhOu_QRA@mail.gmail.com> <1b7da8f615c6d632e00acaf326b9809c10088cc6.camel@HansenPartnership.com>
In-Reply-To: <1b7da8f615c6d632e00acaf326b9809c10088cc6.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Dec 2024 18:41:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG6r_pVQXUFmCkcm2exLiS=6S+YoukCvujyBkxEFXkgOA@mail.gmail.com>
Message-ID: <CAMj1kXG6r_pVQXUFmCkcm2exLiS=6S+YoukCvujyBkxEFXkgOA@mail.gmail.com>
Subject: Re: [PATCH 0/3] efivarfs: bug fixes
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 15:38, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2024-12-09 at 14:49 +0100, Ard Biesheuvel wrote:
> > On Mon, 9 Dec 2024 at 14:34, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Mon, 2024-12-09 at 10:20 +0100, Ard Biesheuvel wrote:
> > > > On Sun, 8 Dec 2024 at 19:34, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > > > Patch 1 is stand alone, but 2 depends on 3
> > > > >
> > > > > Regards,
> > > > >
> > > > > James
> > > > >
> > > > > ---
> > > > >
> > > > > James Bottomley (3):
> > > > >   efivarfs: fix error on non-existent file
> > > > >   efivarfs: fix memory leak on variable removal
> > > > >   efivarfs: fix incorrect variable creation
> > > > >
> > > >
> > > > Thanks James,
> > > >
> > > > I've queued these up now.
> > >
> > > Thanks, but I need to redo 3/3: there's a bug where if the variable
> > > is created to do a write which fails, it remains on the list even
> > > though the entry is freed.
> > >
> >
> > OK. I'm a bit out of my depth here with the VFS stuff.
> >
> > So efivarfs_create() creates the file and efivarfs_file_write()
> > writes the contents of the variables, right?
>
> Right.
>
> >  So what is the correct behavior here if the write fails? If the file
> > exists as an empty file, but might still be open, surely we cannot
> > just drop it from the list?
>
> I don't think it's a race that can be mediated in the current
> mechanism, although the efivar lock seems to do some of it.  In the
> ordinary course of filesystems it should be mediated by the dentry
> objects (any racing open/write with delete can either succeed or get an
> error).
>
> > > It also begs the question: why does this list of variables exist?
> > > All it does is cause management complexity and overhead and its
> > > only function seems to be to free the entries when the filesystem
> > > is unmounted, which could much more easily be accomplished by
> > > implementing a superblock evict_inode() callback that kfree's
> > > i_private, which would mean the entry was freed when the inode was
> > > and thus wouldn't have to be explicitly freed anywhere.
> > >
> >
> > I have no idea - this code existed before I got involved with EFI.
> >
> > However, a related issue came up here [0]: the list may get out of
> > sync after a resume from hibernate, and so it needs to be brought up
> > to date. Not having a list in the first place seems like a step in
> > the right direction, as we'd need to synchronize that with the
> > updated varstore as well.
>
> Yes, that's the same issue I was complaining about and trying to fix in
> patch 3/3.
>
> > So IIUC, you are suggesting to keep the caching behavior of the name
> > and attributes, but not keep a list at all? Would that work with the
> > needed resync above?
>
> Yes.  If we simply let the dentries behave correctly as filesystem
> objects, they'll mediate the race and if the inode gets evicted then we
> also free the entry (so we tie efivarfs entry lifetimes to the inode).
> There would still be a corner case where you could call open(O_CREAT)
> but *not* write on the file.  That would still create a zero length
> variable entry which would disappear on reboot because it would have no
> corresponding EFI variable.  This is an inevitable consequence of our
> required semantics of not creating the variable until something is
> written to it although it may be possible to flag the dentry in create
> as being not visible to others until it gets written (i.e. effectively
> open it as a deleted but open file and promote it to not deleted on a
> successful write).
>
> If you want me to look into doing the above instead of patches 2-3, I
> can.  I think patch 1 can be safely applied.
>

That would be much appreciated. I'll keep only patch #1 for now.

