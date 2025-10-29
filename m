Return-Path: <linux-efi+bounces-5208-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A1C177B8
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 01:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB39C3B7171
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A91E0E14;
	Wed, 29 Oct 2025 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="evHEHdUk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC881DE4E0
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696643; cv=none; b=s2J6EiK5cknawVUcsBGYzOxCJ6Y3CuT7WFWaSHsjzMRga+e5ejVaiQ2r8uyGaf4aO/5JQsfb9lndZcKia3YXvCHQFGmqk9MuZOmN6uAUuDTLPcirF2fBQhu2kqFB7f17Q03AwdOP6BqHoMSzowItA0YcbJ7OLKznWA09jUXWAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696643; c=relaxed/simple;
	bh=QloRiWksfwupmAUdBgNLV/svbMoFmzJRlSMrdXPaxnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnXh9BfdK3QyPNvuTvtRGUpLWB2uHsJuiE6/ZHr80qaXuo5BSw1M+2JoCQwglSEgM/TcdepVoVKuMZuZ5QYy58JZkAmm3C6Rl82L4/bIUxKSrXuWMPjct0JRrhpJVB2o6ATVUaMq85Xj5W+Mb5f3gpAmU2gj4f71U25gW6ADAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=evHEHdUk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34029cd0cbdso1857673a91.3
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696642; x=1762301442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=evHEHdUkGc41clD3/HvS6TCsRDFkA9q6MEZ+Ee8ikmU90EW0nwK1uXakOJknKdIEYw
         UPOMfeEvBNhKrHjLjHr7xIYCpdId2KHIvvTrAsza0xQeogPNi8UwwvqaI96FT8ITZ8vQ
         uzFC0R7kneeJXGfF8/cqcxLa3ozJQN2E70B69L9NShTl9bB++pcLxc0q3bhCZ6JHhbk2
         c7LXeRcZcT65SzKjp7o+Ph+jEW+BDN8aORwZ2Q6/pPfvCmUIvEEXu+nEyBOVi1hFu8Rr
         SUBY5Gz0grZxmej8kpSYf3nSsLE60De2XMA1fzyVirRng1clt1tCPFYnLsbjXnIXjkwS
         8jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696642; x=1762301442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=MLDtfDL20uEQZQNsIVm808Tbtoedf1pIV2pHxrrqs5badI5Rby/kfwelGHbV6QIY2p
         f+kbJ1Q3Zu82EmS8hmvqRYHbIiBefkLp7ffmNstTP43hzXoGLYRZuqBUUR3RUYFEfoIW
         jSJRPwQW/eR5sxFVNVfNMKIQnXkuvJNA+dvUampuHpZZHEcfRDPdBh8m8lZmZ31FKFwI
         Vnn0/GH2CruTjoHlffExI/eFLXxpd0VcLjjrO3c/1VcLOa/JMQ66UtP0Jp1EjCC1BuT2
         6tfsvYSmve12z1b03gCUDmKjXj8n1MaetWLF9daDjAw+YPOePQ1SYMzVpTVt9kEDh5mT
         mbiw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2Abx9qcUhqYrVeFgxwQ8wJLmcTbPdu+7giCjgDjFLL96ShrkLZjq69hbJAEmrVQY7ca3WVkdGJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08xlbYoCLo+dyqGngDmIJHzzXslepiAp68heQ6LALgaURRM9H
	Utt7FA1I64NOtIlwKR+Ux0k8oecJNRtPwBPQ9V24qVCqInCHqmLingR0mumQ3RMExukwp3N8vuW
	gWPVXmcWAXZs0W0pzvO76+jexB8wjscxT3fUjcxIv
X-Gm-Gg: ASbGncvGiPLesloo5nnxibKOkuhVn0UT57K30ImS1mxQCGCcWbi0a0eSJ3Ihi+DisRS
	Ab7A4dguduhQ8hIuLtoLQdNTgCLV8IVV+qoj1rrEPYB/nDNVloaRCYMvTNPVz0AdmDc8GMUUZsw
	oXtYLkBmR06n2kV1jffbH7IRhylJZK9p/HY+p/24xI5WHres7S03XXcE9pXjt7pOb7IrIRE+Wpt
	mAc0jxLBPc6YSSwcBAnPhZjF6y68DjXszLMadamnllX8DPuol+215IXPiCy
X-Google-Smtp-Source: AGHT+IGhjs8q4GiygXwr6DCqhQXMqWhNs5oaPfnq5KAn4id0agHe+xmdqRLWlZPNOFZ/N+dUgAnaM8QQHq+RXzkh3rE=
X-Received: by 2002:a17:90b:4c8c:b0:32e:d600:4fdb with SMTP id
 98e67ed59e1d1-3403a2a1014mr987268a91.18.1761696641654; Tue, 28 Oct 2025
 17:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-49-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-49-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:10:29 -0400
X-Gm-Features: AWmQ_bnyVa46lrJnSEC4p7b8a6-fhgKBPo6xvMl8XVNnPJL6uMjYjs2dxSO45Ps
Message-ID: <CAHC9VhRX6kqFbbKuOoKOLLve6c+7TN3=fXHrtXyj=osfNYd+2A@mail.gmail.com>
Subject: Re: [PATCH v2 48/50] convert securityfs
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
> securityfs uses simple_recursive_removal(), but does not bother to mark
> dentries persistent.  This is the only place where it still happens; get
> rid of that irregularity.
>
> * use simple_{start,done}_creating() and d_make_persitent(); kill_litter_=
super()
> use was already gone, since we empty the filesystem instance before it ge=
ts
> shut down.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/inode.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Much cleaner now.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

