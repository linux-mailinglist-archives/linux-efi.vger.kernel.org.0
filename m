Return-Path: <linux-efi+bounces-5256-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE7C20496
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F0E403A48
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37410244694;
	Thu, 30 Oct 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo4w8M+z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283F2557A
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831365; cv=none; b=e4hMNj4vw+0IuMJyNDLPNpv/AKMKndkhNZWFVrx3qU/vXSbYcA7QPBOX/HAHAGwSJjz3cyOWzt8ErDv+4IH/iKsY7d2W0CVHdCT6R/f5WH49w0sTjO5vEGsPBmj5nyMLmIrsxdyNkXH1TFQvJt3tYUlB9Ju9PvsxHyG4jeuLhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831365; c=relaxed/simple;
	bh=946tCSyfwkcJEZIYbJYPYmAWxgbWBFpGqs507Chemqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTZvCTJ0A8/CP5KH5q5MZs3XO6dGIG2lAR/xxsyyILLPEDlsQ6Ux6undvBdDyHQbhARyzQ4P8OVvhaU/IID1RJwnhatLa6L6sRXb04P2yedtgvlI9xNWh4A57oVAEHq2Omv9up2W/whioEPdzMP14+hjo/N6+wO6ckWCSUbaBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo4w8M+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF4C116C6
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761831364;
	bh=946tCSyfwkcJEZIYbJYPYmAWxgbWBFpGqs507Chemqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mo4w8M+zoG7x4VSKBHFBlkcNbJr8yuOPcibcxBBGoKKL/xxYP6SoTzLLo4MNs3B3W
	 LXBRGiqiBcuymn4pvOVdEzE+RhAUAEeSzEzaMVgkWQfQdcCqM8chFRdyPlB8uyQjhI
	 Sy04DC7qmGww/ewmG6nPtqVrjY2mNjujRFnNwL7bqfm0FwXXsFy8N/4MjZzNCTEKM6
	 AH9cxSZFPyaoQjhLwB8gKrOvY8VBqCrViJzhsfAiHRlbe8Pd48ohtXcde5WYc+J+Ks
	 xtnvYufRNIqRkyzqUNQQ8FGGMaRxPzAYxs8fhTOpNjbPwsbTzNyqAjyH/iSW6qfl8l
	 9rr9LsibKVXjw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a17d470dfso2742801fa.3
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 06:36:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqRWHBBJjvfUZ0DUlwuUIeScnKI9O4YHz8ivLD81AfDGra0InuLcgudjGXp2T1W8wzkxQxl0Wjdoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOARsZvpwCTq0ip+MaaR5Xe7EoPBHJ8gmWAsn51Gzo3EgrEpT
	72qKZU6Xn7awhNIJ44u6JU0qGWjahcf/+xKyjwIGb4kQBrERIGHVqdaWOyrYvx+g10n61zfEJnj
	aW2DJw9WVW4yTGVsQnualhoC4SKnL0yo=
X-Google-Smtp-Source: AGHT+IHPsQ63GACF+WTAXoqOco8sKMg1RRh6aHz0Br4Fnz15qbhOtOELzGrlJEWp65H1oXl/2WnpIpMcc/ndPgk67GM=
X-Received: by 2002:a2e:9e56:0:b0:376:30c5:66ef with SMTP id
 38308e7fff4ca-37a1094a526mr7884761fa.16.1761831362808; Thu, 30 Oct 2025
 06:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk> <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV> <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com> <20251029193755.GU2441659@ZenIV>
In-Reply-To: <20251029193755.GU2441659@ZenIV>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Oct 2025 14:35:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
X-Gm-Features: AWmQ_bm2LrdVSSm_iuRDZ6ti_gfIvNqTw5CQZuyqzyGspRRRkaM_-X7LCT9AH9Q
Message-ID: <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
Subject: Re: [PATCH v2 22/50] convert efivarfs
To: Al Viro <viro@zeniv.linux.org.uk>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 20:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Oct 29, 2025 at 02:57:51PM -0400, James Bottomley wrote:
>
> > I think this all looks OK.  The reason for the convolution is that
> > simple_start/done_creating() didn't exist when I did the conversion ...
> > although if they had, I'm not sure I'd have thought of reworking
> > efivarfs_create_dentry to use them.  I tried to update some redundant
> > bits, but it wasn't the focus of what I was trying to fix.
> >
> > So I think the cleanup works and looks nice.
> >
> > >
> > > Relying on the -EEXIST return value to detect duplicates, and
> > > combining the two callbacks seem like neat optimizations to me, so
> > >
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > but I have to confess I am slightly out of my depth when it comes to
> > > VFS stuff.
> >
> > Yes, ack too.
>
>         Umm...  FWIW, I've got a few more followups on top of that (see
> #untested.efivarfs, current head at 36051c773015).  Not sure what would
> be the best way to deal with that stuff - I hope to get the main series
> stabilized and merged in the coming window.  Right now I'm collecting
> feedback (acked-by, etc.), and there's a couple of outright bugfixes
> in front of the series, so I'd expect at least a rebase to -rc4...
>

I pulled your code and tried to test it. It works fine for the
ordinary case, but only now I realized that commit

commit 0e4f9483959b785f65a36120bb0e4cf1407e492c
Author: Christian Brauner <brauner@kernel.org>
Date:   Mon Mar 31 14:42:12 2025 +0200

    efivarfs: support freeze/thaw

actually broke James's implementation of the post-resume sync with the
underlying variable store.

So I wonder what the point is of all this complexity if it does not
work for the use case where it is the most important, i.e., resume
from hibernation, where the system goes through an ordinary cold boot
and so the EFI variable store may have gotten out of sync with the
hibernated kernel's view of it.

If no freeze/thaw support in the suspend/resume path is forthcoming,
would it be better to just revert that change? That would badly
conflict with your changes, though, so I'd like to resolve this before
going further down this path.


I did need to apply a fixup to get the revert to compile:

--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -412,8 +412,7 @@
 {
        unsigned long size;
        struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
-       struct qstr qstr = { .name = name, .len = len };
-       struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
+       struct dentry *dentry = try_lookup_noperm(&QSTR_LEN(name,
len), ectx->sb->s_root);
        struct inode *inode;
        struct efivar_entry *entry;
        int err;

