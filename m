Return-Path: <linux-efi+bounces-5206-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB691C17770
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 01:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B24E466D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0827472;
	Wed, 29 Oct 2025 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YbZoaS4q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C403C17
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696298; cv=none; b=oJKw+72YFJSXY8NK+jjPp7wUkeZZWphT5S9RCWcEQg02mUNTo+gvkqyUTnQFB5PNuRKONSB+LuZcsipjOpmTC6Kf5F1HPhovuX84EDu0MJ3Rkz3Hh2/ICaJPSzlU1RnI1zzObwVXndYuWri3JObYcTVW+RGzXsinxXFrvdp7WIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696298; c=relaxed/simple;
	bh=qF3NtATOlOxjmKjh31CoJ8+W1noziSRiCQPVNghpJQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjyCkBZyWqbTZ6ksGgZOqze9gNlrKLAUtV2ppr5oGfLqmh2N/UBEXZjSoCskEzZJwAUvVXM8UvEZPrM2BQgeRZsVFu5Ry2VxK+ViJEhS6t3cVObiPu+YUJVooieRpEt1laGh3bva8ylo1tVZMQICDu2nR4OOpN+UsnOTJWrzp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YbZoaS4q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34029cee97fso1595587a91.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696296; x=1762301096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BerLOcBoWrV1cLwn2WvSsreg5PxA+PLtgWK6veAyVuE=;
        b=YbZoaS4qDsxU9JuqQ4+3At4yH/xb+t49dYMx4ISzdT10Oyh4a4LL8Xoth4UBNpPzur
         itM56A7SQV0GUZ5w8xvciREEGwmWVcktk+WNgGo5xRpvGisMiQFBUmzHNigbgsdLltuz
         +febz2p4RQxz1twT/85RYbInr8Qcj/hdKgsarSl4+IMbNiaHEfL/ickls/wMnIg+xzsa
         4IPwCpYWb2isD1NXOYAbyvihlOi0GryBRt5RCIxfsk2RtMvDS6iHlBhho9ytJKF38Y/X
         R2VWfvi+gGlciUOT1SsgwNss364GzmiITVWZ5HYuAohyrQ6dwaDR9zKMuNdpsLjDsniV
         i9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696296; x=1762301096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BerLOcBoWrV1cLwn2WvSsreg5PxA+PLtgWK6veAyVuE=;
        b=ZLJJn1MrnQhfXuViUMyJJ2Dzs4RxFobWkCQJJ8xpazEpmLu0qdnpl/eWAmqvhGtHmQ
         VeIfokETYrlLreNt9RPwJpxjXpCHIzCbIh06oxMA9YEcmfJHEwkuFqJzeqnyhxYctIcn
         oQsiKe937pl1PsMTCd61vj2kVVE0Ajzanej8zdfvhEAMW/EYuwE7llWqXJLmy0o6p5T0
         Wuix1D2g+CnntoYPOo/Dacv6ZTyPdRO2A5980SPAxJl8B9ConjRadGc8H3LvoXpJ7+DM
         ykyLO9obHlURaBytJ6XJP2e3x6IeouYAh24OCyZLE7g+NUFVVYVeGxFbNchzNpzzH4Th
         58KA==
X-Forwarded-Encrypted: i=1; AJvYcCWXvKjtujGYuJfH9q0QVgwLgC/yXRQU6zL5rIRcueiYEaQjJ4izX5zZwX7wEqxTxBy4U9/c0+Jz+rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKoeCRhERMJuYmiwVwtp/WHUFnsU9ANOXAY2RSozyatIEPgZ5
	jM0Yzu/8wddODIu3ZjSDj67iAeFOGsGTuNM9c7TLzgaH90KpsQHUMgDStU7ObM+ygHxJgUwsUUf
	IAr9TZXh321ITfSepikS4syVAV1/cBHLScFZQWlWn
X-Gm-Gg: ASbGncsLtnLJx3huWkGn9Txx+9lMNQBrhLB1SNeqAr0sq+5djuAf7pHv4VP0a/H7rfj
	F6RDXAmXCQO+VcnQU6QQE+vfEFAKV8YKvuiZH4IQB1qfihiUmZbCu2nw/R7lpioQJKkCKU/uI2U
	HvQ1oHMV8Bg7OLhp4AdaXpcjmUFm2589EpUZ+dgIIEMQJsjqi9bq0JhzbpExX6ASJKz++81ksUQ
	mV4MsONho6C62ZmDAHuGAHJkE5IK0saZvilUTK8WSN3TuyK/YOewZ9Zn5xW4gbDu7ORhYE=
X-Google-Smtp-Source: AGHT+IF9Sg8XTJhY1XF+gNJzXx33YCPJNPvD397jHY3K37ysFCuyvsRKOtkLfk2UKLtdow89RUSTsoGqlzXNXJIH+YE=
X-Received: by 2002:a17:90b:3147:b0:33e:1ae2:a4a7 with SMTP id
 98e67ed59e1d1-3403a2604b4mr1039988a91.12.1761696296385; Tue, 28 Oct 2025
 17:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-50-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-50-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:04:44 -0400
X-Gm-Features: AWmQ_blrbvCvNMESns84vcg9Bs91_mExO5kolf7cbCdCoz5ngCaqmvIG7Oeo_oM
Message-ID: <CAHC9VhQH--uP=fWo0MsH5=BojV2qG=qy7A9tHTVOnLYOxKbV5Q@mail.gmail.com>
Subject: Re: [PATCH v2 49/50] kill securityfs_recursive_remove()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> it's an unused alias for securityfs_remove()
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/security.h | 2 --
>  1 file changed, 2 deletions(-)

That's annoying.  Another case of
let-me-know-if-this-patchset-dies-so-I-can-take-this-patch-regardless.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

