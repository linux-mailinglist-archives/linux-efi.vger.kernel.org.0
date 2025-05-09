Return-Path: <linux-efi+bounces-3645-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE594AB0802
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C11B6790D
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30F221DA8;
	Fri,  9 May 2025 02:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTkXVan5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8910F2;
	Fri,  9 May 2025 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746758483; cv=none; b=H96aF/c7NXbw+Mghd7JMLcGRwDlrs0uTQAPyI80aJfI4vrHvtKNNOYQw1r4/iYnxGUQ20/xG7iaV7DuGueobQoJuBt/Ol267bKI7d9CgKLDAQpv5AbAm96ABoJXAv0NqSmm0/Y0jIHFXrbnfJP7efW+y3mfjaohRBi503k5TPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746758483; c=relaxed/simple;
	bh=QCt7W9cQubdkOh1wzz0DSW4wGR4LXBXeyzwonSK7vwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezYaXuXAklgdmRcZ2EsS9oJu4jMP5MWrhqhMszDdakVBgXjbg1SkW2gh2HoH/44yOe0rBF2ebtpJfs5sy3+iyz+3WQR3NJ3S7f0aEjVbZtZTdmOE6ZIbh8I/ebINIca/r6QVA1j8+3VSG9GSeq2pHaahhVcCUOVLxxCvBxFXuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTkXVan5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e70a9c6bdso26585925ad.3;
        Thu, 08 May 2025 19:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746758481; x=1747363281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFS6mbwVeD+XxwjTe2L6G5xAyvfPHlOmCcGIREdnkRY=;
        b=LTkXVan5wASFMkgedm1oq4CSqd2veMO7GHLjvMumV3fjiJDrEnSccdhssbSHwJ0Psf
         PPr63wh4BkWOeMRettjLGiWQB5WzXJDbVBYEnVSZqiBN7xmbVbBENY3i5tVUGik+IvhG
         U89PD5E+vwna9Cn/DD5UOaUVvxzerUQSK8YBRA6B5ws6KSPFpb2NXrxg+58uvlSArVWh
         s1f3xvTsgGLAW2Vaf3Kp0HY8DzUmJj4z2+lFMxuqDBqbFg23KY9XoyD93/a2tuQOIm3O
         YHxACf7gXDux6yAYmypNYCV5ywPb03xkBRfLqybj7KMK11w8zBakM88/1UC7G58neQyI
         zaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746758481; x=1747363281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFS6mbwVeD+XxwjTe2L6G5xAyvfPHlOmCcGIREdnkRY=;
        b=VBVkxGDZ1kgYPH7hGEgZQKYqE2GRz8Zflcutn6p8r3efX53IhjNnwjQia3N9AFPZVn
         HH5cFxbZMlYScm27XOcDxXrGB0pqQ06BE5FfGMSOjm01z69b1ZXGUxNv5MAjm9Mrc0L2
         NInbIAAlIz/MS/RNviAE+IcyXWyB30/QdMO7D7hadNNKkGX6GUadK0Mf4FN2Sg3jNnNQ
         WoJ2ehTlSKqxqUnQ4nf+GIBE57a9MnYCLJ8fGdgNOzz2dZ0pwKPI/3TVo5u4BvatJzRH
         uEO2cIaCNi1IhkUg5JPbzvsHpUjkxHMgj9dpioqzPqCJm2YpIULOuJGH8hUfNK0CiFRi
         VI4g==
X-Forwarded-Encrypted: i=1; AJvYcCUb9I7hDAqokECR26aOQvB2sub+rTIxU6AAmHh13kd7aLsR1HJtvP3/kcF0HZ2gUxDOW84Yvxa8TipcOqJivIujR1ofdYJR@vger.kernel.org, AJvYcCWHTt3BX6lYtQjKTWTxvGwA3qgirZX126vhoBpkrCX0lJtTj+6+3vqMezVPSVgON1VjiU09WlEh+oZrke90@vger.kernel.org, AJvYcCWkR4/dy5z/u/TdKcoW7XVJYQnFRWeAh2EJPVTSK/2zmRoZAwBjmfO2ZlrBFyw0L+YicVewqkNVZyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxIHtT1AShRlGIPFn68xLK2yI4BJhixiGEn4n3fgpaGstaMO2
	D7rAoQrLcBmxdxV7L6EgkpR0tEmQrdJ0yNMEdK3ECjoZgmlCoe99
X-Gm-Gg: ASbGncurgEMXlwTmHge01bHmMbgjf72HhWEoMQ2TPGqIiePAYKYl4KIWMB3ErwXFvn+
	rps0ig7TtQOTlw6hK/sbbmWryieFsgt7bskyJM6UH0hVq1BluX0kmWWvcFUSG1SK9N4QFsLeYOV
	94QBJoqA0SQ/Dv7B12VqLkV5LPTJFolvT3x9DoGj/iwpfnYkShvnwfU46YkfXCWpwUODGRLmUZP
	cgeQZSaJLn7hNPWOwRVoN+jl0bN3sQIlw6+9mEdcvDHY3PwKhMt2Kni2Vqzlbx2D/wjXxyc+l5z
	gBoEtGH3zUHAN9sEnE4esSDvg9SN1Trke/Jn693INXbTg3bf3Fa/84Lr0czqekGmJVAzIZXSb2t
	vdl9E7Ix6/64TCxo=
X-Google-Smtp-Source: AGHT+IGyYqp1wunfFzEOreidx8NjAbn3wqVn2CCrv5Sg8a4MZvMn88hnCC6hGU4WQ+NrUM+4SB//iQ==
X-Received: by 2002:a17:902:f682:b0:224:a79:5fe9 with SMTP id d9443c01a7336-22fc8b59bd0mr22926965ad.30.1746758481075;
        Thu, 08 May 2025 19:41:21 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544fc1sm7111905ad.46.2025.05.08.19.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 19:41:20 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: paul@paul-moore.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	chrisw@osdl.org,
	greg@kroah.com,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	wufan@linux.microsoft.com,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Fri,  9 May 2025 10:41:12 +0800
Message-Id: <20250509024112.362527-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CAHC9VhScmdZLz7W=FN+mfWjf5LB7jbTJm5g-iy35hvvMgbKRfQ@mail.gmail.com>
References: <CAHC9VhScmdZLz7W=FN+mfWjf5LB7jbTJm5g-iy35hvvMgbKRfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 8 May 2025 18:55:30 -0700, Fan Wu <wufan@kernel.org> wrote:
> On Thu, May 8, 2025 at 7:11 AM <alexjlzheng@gmail.com> wrote:
> >
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> >
> > Consider the following execution flow:
> >
> >   Thread 0: securityfs_create_dir("A")
> >   Thread 1: cd /sys/kernel/security/A           <- we hold 'A'
> >   Thread 0: securityfs_remove(dentry)           <- 'A' don't go away
> >   Thread 0: securityfs_create_dir("A")          <- Failed: File exists!
> >
> > Although the LSM module will not be dynamically added or deleted after
> > the kernel is started, it may dynamically add or delete pseudo files
> > for status export or function configuration in userspace according to
> > different status, which we are not prohibited from doing so.
> >
> > In addition, securityfs_recursive_remove() avoids this problem by calling
> > __d_drop() directly. As a non-recursive version, it is somewhat strange
> > that securityfs_remove() does not clean up the deleted dentry.
> >
> > Fix this by adding d_delete() in securityfs_remove().
> >
> > Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> > changelog:
> > v3: Modify the commit message to avoid readers mistakenly thinking that the LSM is being dynamically loaded
> > v2: https://lore.kernel.org/all/20250507111204.2585739-1-alexjlzheng@tencent.com/
> > v1: https://lore.kernel.org/all/20250425092548.6828-1-alexjlzheng@tencent.com/
> > ---
> >  security/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/inode.c b/security/inode.c
> > index da3ab44c8e57..d99baf26350a 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
> >                         simple_rmdir(dir, dentry);
> >                 else
> >                         simple_unlink(dir, dentry);
> > +               d_delete(dentry);
> >                 dput(dentry);
> >         }
> >         inode_unlock(dir);
> > --
> > 2.49.0
> >
> >
> 
> Since this could impact efi_secret_unlink(), I would suggest adding linux-efi.

Thank you for your reply. :)

Did you mean cc to linux-efi?

thanks,
Jinliang Zheng.

> 
> -Fan

