Return-Path: <linux-efi+bounces-5188-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F31C12F76
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 06:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CBDB4E583D
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADB29E0F8;
	Tue, 28 Oct 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HZyGKzzi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5429CB52
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629572; cv=none; b=QtV9+st8kXP36Pk0o1jUhYmhhooGZofefwT/FGpkXYxLHqPjN8t2BTFs3NgrznDFmdMcGIz+1WyClxmoSdSCiUjJ5YhE6RAvwOAp9PKfJ3zylJEHQ8GzxLyG7s2xlDVDDxE9b8PiTb9hh3A+nwC3rmzzxmk8Xx1RMBA+eRljHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629572; c=relaxed/simple;
	bh=MBBUGXoG1YUz44tfK9dC7obCvP9yR1LjZ/0B16rOeOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1dPqyzO2m9MsxhFcz0CH315t6br4zqHNyyu9hSY1Os/D/4b0BlieuVopywRzF6b6i/k/g1ZAEHEXqQeWsrn3qc3b8mVTUfZzZdrVTY7hXvJX7RugHbS+iWPRmzePgmsydwR39ZyaAlAuhEgvnl24akR39pmfBp4UJrj+ZePTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HZyGKzzi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6dbb4a209aso132428766b.1
        for <linux-efi@vger.kernel.org>; Mon, 27 Oct 2025 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629567; x=1762234367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=HZyGKzziPvNx8aZ8CpY7fv+4YkWU5YxvYP6GK17TuItuXLkObIxnxf3XyNUF083Pnj
         X17vVTbJsJBRUyenpqQUjcHbWsRoRpztfGNgSSz3ekYPAq7CrrEbODRv0GmVhmYCgXa5
         ppLIDl4RTbFzI3DuunBaFhd6tiCcEnVkR8DHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629567; x=1762234367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=FHH7Autw4KsDCAUdkhmNC6lg8AA+fAFHNZfl7aqYedFnXq6/On51xl50atJxfi79lF
         jLXSiz2omYP13RnTX/A1etMDQeS+ams8b/+G/+WDh0+tE87Fz77P32Vq03zYnnnLvqEJ
         wNvVWmQwSA66csTf46TgkLKtwZc3Wcu3Llwu9cdq0Gg577tmUCeOsVT/mf1fxeY7VRiL
         RDX0nJGnfYipQSrwq4rl+0sRMgtGhXHT2cA/7hSE7E0VXMl4oVtg5U8rAP2lxhNdpXns
         WkYm6uFttTo91uNPK5/TL+4L5MqWlQnDbL+g3GzgJlb1+TNCUjhK0P6Ekx09sdonF0DI
         j7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJyQO7giHnEq2CY+hZ27xA7K610zt0CDSikzkLOUX42GQfprZCd2hfoDW6+lRV5DYRg1XlejFbmBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMalG0dLKyBT6aLN5XPsANCVo4L/cSxYSB7E81a3fsiABAU/J
	Z48XAQglSASARplHRgkeaEcjja8znNVNKLAO2Zin/eOwObGFuS0aRzqyxaBsIdoyuzTos+5RZOP
	KKEPXJmszcQ==
X-Gm-Gg: ASbGnctAb0lod63SYTQklsje1DreSCYyTxGl8bpciV9KhKMmjHW/ggiaEP7ROy0lpFq
	lWEWCSv9qDKZzfH7LhTGJns0R+hhx24mR4Svj/pgVqH6Q5PbHualox0sVTmbW53PxE/eEJn+JrH
	EenZtJwryNfTaDBUyEy8HdpCcrP8Y7fBKqnLBqlUl6TuVF9HNKl3dT5EVtemWLjD2F4yjdClPv2
	YFtMXZ23QWxq62IgFqL0pnN3lk7bHz3Bj2eqdFC0lGppsfVkyk1HW1ggIRtN/vOgegoFapT/QvL
	lIQAQzB+IbKzevs+Zj+KRFGrg0eks+HXeqPW51cfRmdkm0W3zfG8WEzXcJ4K0/i3NQFEzW11l6j
	X+XqgxBh8tr58FWuA6AT9Otns4qxBJFfjirCYNF6Yo6fLhGOGHTxtdy0wazT85lW1HZWZZyosdR
	vIDVGWJJqDOC/0sQkgqcM/bA0yoyGrwKFCCay2EeU+/izW4iI+Z04m7q9b2IFj
X-Google-Smtp-Source: AGHT+IEHHjThVf/mZncavtKE/8s7WtfDFie8e4HNdCFPFNJko4MATABRIRwhC/nK5zdsx1jy1hlcPQ==
X-Received: by 2002:a17:907:3d46:b0:b6d:5b4c:3450 with SMTP id a640c23a62f3a-b6dba4440e7mr262289866b.1.1761629567153;
        Mon, 27 Oct 2025 22:32:47 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85369697sm1014654766b.26.2025.10.27.22.32.45
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:32:45 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so8626659a12.3
        for <linux-efi@vger.kernel.org>; Mon, 27 Oct 2025 22:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVthgdyYAKdKPOXgqNFcBXJrAOqJqtFVxz3UOo6sgA+zxRmDGNQnYyJ5fwKmg1w27eDWvsgQ9b8u24=@vger.kernel.org
X-Received: by 2002:a05:6402:5346:20b0:63c:1e15:b9fb with SMTP id
 4fb4d7f45d1cf-63ed84d11b8mr1725392a12.22.1761629565035; Mon, 27 Oct 2025
 22:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-32-viro@zeniv.linux.org.uk> <20251028015553.GM2441659@ZenIV>
In-Reply-To: <20251028015553.GM2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:32:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
X-Gm-Features: AWmQ_bkREqIMu_f1B9dwguEOjRWmmtrQM-BuU5ACiXPx-fVfEkz6aAECfx6yPOQ
Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
Subject: Re: [PATCH v2 31/50] convert autofs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 18:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, is there any reason why autofs_dir_unlink() does not update
> ctime of the parent directory?

An autofs 'rmdir' is really just an expire, isn't it? It doesn't
really change anything in the parent, and a lookup will just reinstate
the directory.

So I'd go the other way, and say that the strange thing is that it
changes mtime...

That said, exactly *because* it changes mtime, I think the real answer
is that none of this matters, and it's probably just an oversight, and
it could easily go either way.

               Linus

