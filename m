Return-Path: <linux-efi+bounces-5227-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF9C1BC9A
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 706985A2702
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21D3321D6;
	Wed, 29 Oct 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPXLDd17"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EC330312
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750433; cv=none; b=nFfmteu2Lnav4TgHl4jlPhRlKdR6MRBTB8BhN5vlMhH7qqGj6UaWoznHi+GDcqQfG9+ggyR778dIQzcioJjeoC9Hm/XY0cMaW6GCkcN3mTXyf9p9I9fqyEViyOUW/wa8fGYtYZI82ADXQypzDnD3XvIUpW7GxTPwpWDc4euHRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750433; c=relaxed/simple;
	bh=f8Fhr45tAG7sziLg9U37nK1+JBvIXcz4AelF+jGe5oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsGm7j2CgvIPppU+wqMNSB3FiF3QqN/4r8JgLmRcmJKxpZrPCYuU/mIiuih6VrwVeISn+MhUkWFTRdWTxx7SIMt8JG5Hqj0nMXBZf/A71S4BBZIt3BmUc13cLSck2JEp3bfJAKqtraESkBr5xuhJfVhjoVGjXN1zXVe/ZIAS620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPXLDd17; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330b4739538so6673a91.3
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750431; x=1762355231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IfYIDKxJGGNldyfSmZN9xBlg4Ge86/H8w7OAL6l3zA=;
        b=jPXLDd173Mmm/1ZA8/62Litwf1jppoXunEBdw455/oB0ucPgz/zgb5S9Ig21/R9A83
         zDl/M5gysr9P+fkQwOLRn8Nc93ZomVRC0bmPuHLPjeGepoBI06SWq1YE484MytHwSLlb
         4dwkHgWXlShtqjfBEVZS0uTM5g1kp4llTyzLktE6VRZ+86UnW8Fk08ywhJzo+o670TEd
         fBtgMsa0FYuUeroCTBX6EiOYZ8iHQnELdjSyCiUzabXF6mX8GH0xfMj1C18t6ZPdfKAf
         Y7WcPyRl4QKv5WXCIattR6fCUu2UoNrxf2YFU7G6nQc1uSb0v9TebfZWQzUa9NtSTICl
         hxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750431; x=1762355231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IfYIDKxJGGNldyfSmZN9xBlg4Ge86/H8w7OAL6l3zA=;
        b=PYBOvKH8/irm70Icde/nWVPapkvYLj22s54jDCVAb/e2OM9C/HhnkLFMYpScCgBmgP
         lPVz2q6/ZBzdM5oQh0d8ErYnGrByCPq8P5/OqKrZ9swR3FC9eEGJmKrytWYaueGdDMCv
         GNDZX1loH9RlJNcYYNfVu2DZmykarpwMb2xz0tSnEwV3xJad1n00sZHjyXj9IzoHFXn1
         caomiklmbGdTyAXjc2FoVSDstWjQ5rFrxzBvDRlqrAeznA/4Z0fnk/c+QqKt7DVEdwLI
         iK3QCd2uHYQD/LR0qxCo41setPlKPKYZnzdfqXbZXVU4NnG28FoGaRRR6K8Ah/C1c0sD
         qFuA==
X-Forwarded-Encrypted: i=1; AJvYcCV/e8DfTCihdxxAOLWsa+fkCqhR8uW/CIwjd/Zb080ytdTPKUShKHviqJ3raQURIhxjWHUvqF5spdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxbiYMadJSA00g0lOiBx7eHOp7CHDNAiAXpOPsMDi73pLv833
	4E9ghn66aIb6gUuQPZzQbEt9XvypoKmM6mDtgnPOzpbFBJrqJL2Tu70tl9QikwiC/vvl//2YW6p
	ya2d1M4m5qLK/2xlbk7ewjg839eKDjaE=
X-Gm-Gg: ASbGnct5jUN70xxKDJNaoxtJD0L8EcNdixJ9cAziMYP8aBw0Se377YwQYSMGJXC4dhy
	GEDEVeBO/XcbQZQOmcaTmkHmbkJ5nPlCCraLyvTKa8dxCqnpg5WAyM1+d619jI8/mY497+AgCYF
	CamU1KLdQHGqpH0ZWSx7prkF7oyvMCXwqcOs7dw8JA+KcukT4KoMY6CETFwZTyb4Kxh7etyYVlC
	T+PYZevQX9jpIIXSfp06ysmbXlMLwPpTSnfK+r+cm4AYwjA/n5jBgNBi08PvdB01NcnBIY=
X-Google-Smtp-Source: AGHT+IFVqO8ewpIAf0wvRQFGIOOwuq6fD8Gg5dHkMSFcg7AR9XFXs/odOiaOENp+NesUqtIMC2BHNrgVUxHGzL0/CTY=
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-3403a28efb0mr3676582a91.27.1761750430698; Wed, 29 Oct 2025
 08:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-36-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-36-viro@zeniv.linux.org.uk>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Oct 2025 11:06:58 -0400
X-Gm-Features: AWmQ_blCWCRSlgnSUoNEZRYW0rUX4EVkF7hJCMWu9E3EunP63rWoSyVWbO7_enY
Message-ID: <CAEjxPJ53wJEK4bzt0VMbY=G9gkzuZZA_XtrT+acwPys3p0byBA@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Tree has invariant part + two subtrees that get replaced upon each
> policy load.  Invariant parts stay for the lifetime of filesystem,
> these two subdirs - from policy load to policy load (serialized
> on lock_rename(root, ...)).
>
> All object creations are via d_alloc_name()+d_add() inside selinuxfs,
> all removals are via simple_recursive_removal().
>
> Turn those d_add() into d_make_persistent()+dput() and that's mostly it.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I took this series for a spin and didn't see any problems with the
selinux-testsuite.
Also re-based my WIP selinux namespaces patch series [1] on top, which
introduces multiple selinuxfs instances (one per selinux namespace),
and didn't see any problems.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

[1] https://lore.kernel.org/selinux/20250814132637.1659-1-stephen.smalley.w=
ork@gmail.com/

> ---
>  security/selinux/selinuxfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f088776dbbd3..eae565358db4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1205,7 +1205,8 @@ static struct dentry *sel_attach(struct dentry *par=
ent, const char *name,
>                 iput(inode);
>                 return ERR_PTR(-ENOMEM);
>         }
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
> +       dput(dentry);
>         return dentry;
>  }
>
> @@ -1934,10 +1935,11 @@ static struct dentry *sel_make_swapover_dir(struc=
t super_block *sb,
>         /* directory inodes start off with i_nlink =3D=3D 2 (for "." entr=
y) */
>         inc_nlink(inode);
>         inode_lock(sb->s_root->d_inode);
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
>         inc_nlink(sb->s_root->d_inode);
>         inode_unlock(sb->s_root->d_inode);
> -       return dentry;
> +       dput(dentry);
> +       return dentry;  // borrowed
>  }
>
>  #define NULL_FILE_NAME "null"
> @@ -2080,7 +2082,7 @@ static int sel_init_fs_context(struct fs_context *f=
c)
>  static void sel_kill_sb(struct super_block *sb)
>  {
>         selinux_fs_info_free(sb);
> -       kill_litter_super(sb);
> +       kill_anon_super(sb);
>  }
>
>  static struct file_system_type sel_fs_type =3D {
> --
> 2.47.3
>
>

