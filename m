Return-Path: <linux-efi+bounces-3646-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF83AB080D
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 04:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE244E31CB
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 02:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA221CFFD;
	Fri,  9 May 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfTjq4zK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413133EC;
	Fri,  9 May 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746758749; cv=none; b=iXv0vfMymAt4DPpSXgcPUX7LBpHezrKGfEf0rOkFi6KUp/nTpG5t3lsyWtMgeg60x3DDNph8+7TsIjJXHNsrgthk+5syolI2bvqCq9OX7jacQxF0SPwZBU95/9JHafMD01/brFkAPUzpmKHuTFALXmWywupW+uWdmNK+863KLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746758749; c=relaxed/simple;
	bh=QCt7W9cQubdkOh1wzz0DSW4wGR4LXBXeyzwonSK7vwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT/kGKZi7mNYGcQcKJtnacYV9Pc6zpZsjFQkvOJxmRMH/uY1rYnohqlAxHeQGbiizMHZ26wnHuoIKEV1NdXRKRwkYR8+2RDqkVOGbkrSXT1EaCNXHFh5OkmXJz7Xje0eTLLXBdWkz6IKyS/G+7elCkBYqwKuEOuruDUsIG/NGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfTjq4zK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74019695377so1298437b3a.3;
        Thu, 08 May 2025 19:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746758748; x=1747363548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFS6mbwVeD+XxwjTe2L6G5xAyvfPHlOmCcGIREdnkRY=;
        b=QfTjq4zKyBqeIIyvd/EaUuKlcSjsbB7mji2XCZYzX84nL2Vx5YDZzWz/K8MU7Uf5WJ
         xKEXJWZzIgGSxkbnWfUJ8d/2eN5ijONlYPududbp76hMZUTugMW7Zs6L+odgjkqnRdCk
         BGcH6cPJYQCnAl8v+a8cuMAttr55tPw8av1p3rxca4EWVriI0leec2UzxTRZxKoLsFU1
         KUgm77cM/m6pyfXNfIs0g2j9srRbB5fL5F4z/3vyLhduR/lIGTITcGbJ4s8PTuJuX6bt
         sPyhziOEcIs6i5obNOuWrTsqZZTEodmtDevb1A7AqMOfbDmR69WSwT9GW+dL28SoAGqm
         /Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746758748; x=1747363548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFS6mbwVeD+XxwjTe2L6G5xAyvfPHlOmCcGIREdnkRY=;
        b=bv1K7LQw5maonWyJNWSZNys0kKa2kinTtQ3/hAOxF4DlcGHS6Hfxq7jIjDTh1Jmx31
         7mkEc3KzfPC3hx5fZvEhJAaJAtMxuZS3C19w0FrB8ruMtmBdSBg0oE9YxlDOpuJuJ2Kc
         suGL0WHu57UPfOVSW2v6KznNjq0qmSKlfPVY3WbgbmRlSBg8CKPcVF2wgn6VHtVgU65b
         vu4OTPlG/uQFc6qMSbtirYjw28hUBaxnn05qx9OqVgYq6hGFkCqJBitB4j3SS4YwQRsq
         1UgvHIwCUrydXoJ74FLWBJeiXAFaLK13BHKbIWl/ltEwsAru2UMOd4Y8T7+RU5Eg2dzo
         BeBA==
X-Forwarded-Encrypted: i=1; AJvYcCVIPmi4wxBcQtJTf7EwEQOXEDdLkWtoTHTmZOXqlORulXIoCDhhg09PGJ49xvYH+EmngA7Q0Zyb7BxJgARp@vger.kernel.org, AJvYcCVWg3NL9zA7mvHeiHp+JXEbJigcxE5+UJ1OiR/mjhZp0lMnPfD9IMYvCnAbqQfvKazhrQBH+s5oMTV9ZO8HvG+Ysdn8x+cj@vger.kernel.org, AJvYcCVxNbK7PqPjrym+0wzSTfbdH/t5ISStVKhTrHpRov5bPKJ2nmwUo6bw/U9h3uxJBH8Keu4Ikk89yE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLtoX3TCPNjOJvwj+uUbAk3BuY/vmEn+G3A96n0YVKRj2ED1U
	RRj+4y3rVXiUoDVhmxheeLz1JGGcD3fkA418geb0KvSuCJDAfOtQ
X-Gm-Gg: ASbGncs8AA8AAyV42F8ZIozCjp7ms41yRHUr9D/J7rp824IQmKcCrbFFpHgTrwfv6vm
	Hcr6xfx2zcZFP7qC4gjw3TyjE8jjuaEX+798mvk5uSTXWBxE2JmJ73viHN7NIFEp1jmomwJ5fGg
	6ZIBW5S8Ocoq5OAQji3EAh06z5AltV0XA7xwaUFe/DucRhTCpaiqAlIKgUZKEREge8YPbMIpdgp
	fPpVqeDnq8PdOWdfMPIZTfrNjSq9lCFV4M+vvtqAM/RR86lytOq1Cz5A1CSJd2OdlgesgG2okP3
	Xw9P492gIdvB26jTZMmsSGQi4RlGqnwpRtcd+6ooHR/PA8Cyht1kkYoa5h+MC7aAoZ9JQsFSqPz
	Ou0E=
X-Google-Smtp-Source: AGHT+IEUVrYysCgJR3AWSOW4YGeY4h7f7UFx3jN2Vg1lkgbAWVswe0YqJKwqbpPKq8gyz9rTI69HwQ==
X-Received: by 2002:a05:6a20:438f:b0:1f5:619a:8f75 with SMTP id adf61e73a8af0-215ababd87amr2530322637.2.1746758747592;
        Thu, 08 May 2025 19:45:47 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0d007sm786835b3a.96.2025.05.08.19.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 19:45:47 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: wufan@kernel.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	chrisw@osdl.org,
	greg@kroah.com,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Fri,  9 May 2025 10:45:39 +0800
Message-Id: <20250509024539.364945-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CAKtyLkGK3JH7amgskrjMyUz1KZeVtAO_4bA_8iuBYvykgHRsRQ@mail.gmail.com>
References: <CAKtyLkGK3JH7amgskrjMyUz1KZeVtAO_4bA_8iuBYvykgHRsRQ@mail.gmail.com>
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

