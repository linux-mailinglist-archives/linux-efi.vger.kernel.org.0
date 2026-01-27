Return-Path: <linux-efi+bounces-6036-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DglMZwHeWmPugEAu9opvQ
	(envelope-from <linux-efi+bounces-6036-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jan 2026 19:44:44 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05024994B5
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jan 2026 19:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B7B3017797
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jan 2026 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49B2FFF90;
	Tue, 27 Jan 2026 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcE6snTj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84093328627
	for <linux-efi@vger.kernel.org>; Tue, 27 Jan 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539481; cv=none; b=jui8Ehnds6s2CdLWN3EHwqKvkqEbPBJ+QbTHgc+h5EHdAeq3M5p16QBU7E4K0m0xBmjWNPKQxLlJ+ri5Yr35/P32N8rav68n79KH7tlCViQwQHNfm7wVrkzr3WTv5o/u7dSAO0PjWC91JkUdhCz5UTkJLbOQq3ZIJdMjQw9SJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539481; c=relaxed/simple;
	bh=Puce/Y2uoOhkmXAnyMr90G2Ehk1ZPgymehgrzrUE1uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nz07fUuviCo3QAWun/wj5ChtFp0SJDe5XGC5D2nfQujPSFcP1SX08Fr9RpIHjJuv4PkiUVARpuvqLAlplBo6LyT42ULlcncCVD/LSk0CK7yqF2aMlOn4tLCzJ+bCMjNvhDYpIgsGkTGrdW5dccgRCVfxXO4bB9KsZ/UHfYFWtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TcE6snTj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b6f267721so5701116e87.2
        for <linux-efi@vger.kernel.org>; Tue, 27 Jan 2026 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769539477; x=1770144277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=TcE6snTjf0LbjlgOhdT887kdafzur1BTzfFyOjGYmWpTKSjkjwH+7SdGKJvIRDfxwo
         3POpqJNTgV95zBYpOHYhAewl8xlAODyLDU7xVv2W0vm0pYUiMmPb9kkmp1fFUO/4XqwZ
         SYBbDeiLxOMH7MIj25175uA4XxV9zd3lxH5os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539477; x=1770144277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=WoppH19pk86nELpVLHm1pb+htk6V83ASvXMGT0uB35K5vxSZJYxThIaBjF3IflLGm0
         TADhYax+f9ASWUp3SJhIzN8EJGzwhCtqnOHeQmZ39YByEyZal40M18ZwrI3adRgp+VTn
         G8kjKjwSWq3ZLW5N3KksnsLoQADje73jJShxAAezQW6VQpftMNDxPaExQzcc/TUpUhKz
         KOxPt1CvItNMV9uNC3WVvuIKO2vBEGb+0tziHcKhTYUUQKfKlapLb8e9gOLR1+Dzg4rx
         oijeCKW7FMp6kkL0ZtIbLQquKluKtOqNlVh/vKUZzE2k44MHN1EtFml+B6j+mxPUqrbA
         CmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6FFOZoBw7XTf3nTB42PXs70nDEYLbCLkZ1JwZHy/2iEiZ+awfz3gbGeLRrZ1WwPj6oKb17/Ma410=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YotOv4iTrK7/rA8SIYTi1UiDp6DpgT+HdXhMG6KljfVDKIza
	5scf2/N6L9WXk/XfSolMIjY4ZGuvFHwwraYpalqJGrNHp+TohNMsbCpo845TXT49VXeSAfES8I4
	HHfo9b7HWPQ==
X-Gm-Gg: AZuq6aKTiaGptzI8nbrhzhBOJtMwiFJjybgeM/riMm8AsMb0KxDsqOdOAeqNpiS4Ns9
	B3t8I00/w0YIQgQru4kIm7zp7WRXJixI7ZvIS2q12g0VJ6Pqb495XPB9u9Kmaeol6EHkPv/5lqG
	y/94gWyxYMnwRh2K/eAcSf4S0Eefinp1V5S1D1UC6N6M1nyODlFD6cvwSF+9n8r+K53RRiSUu4V
	0LKLviDr9dK0EOshyHW0GM/75MW0KDxZzUQT/0scwL9NHEzy6m+1pzC2Hg8MaluAsfxxkeWfy5t
	G7ID7iVL5Mt2ckopD6+9sPI5W9jv7hX/GA09EWczV21XP2cyr3jClc2x6Amrpzr1Ai3RwHZuXkz
	PGciRGKxdJ2681S8QZwAfcoE3ac0GMBJpzyU5EEwg9UtQ53xv5pN9AH7jF1kwtienOn5/1J06C/
	RD4utIslO98SYZCcL/+2gLfcyj3yrDgDcSZtAAsCKfTqShYvk9HoPfaXEa2C3bV6Cm
X-Received: by 2002:a05:6512:230c:b0:59d:e589:c973 with SMTP id 2adb3069b0e04-59e0403152amr1212529e87.48.1769539477401;
        Tue, 27 Jan 2026 10:44:37 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c8225bsm623901fa.18.2026.01.27.10.44.36
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:44:36 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso52279371fa.1
        for <linux-efi@vger.kernel.org>; Tue, 27 Jan 2026 10:44:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd7IPCEIfo/YcGrPJytZLOqzpCVIkLHvWdul8wcAS4NOvJwWh41hZRirBdy4wy/XNfQ+n/w0Eo50U=@vger.kernel.org
X-Received: by 2002:a05:6402:27c6:b0:64b:9d9b:f0f7 with SMTP id
 4fb4d7f45d1cf-658a60c5513mr1939607a12.33.1769539160812; Tue, 27 Jan 2026
 10:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com> <2026012715-mantra-pope-9431@gregkh>
In-Reply-To: <2026012715-mantra-pope-9431@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Jan 2026 10:39:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
X-Gm-Features: AZwV_QjTvEFSmpHcnOP1NJLVZBe5xlcj-dD5ZtjcNC__rjqudIVF0E_rBxSpQA4
Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Wu <wusamuel@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6036-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-efi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 05024994B5
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> open/removal races") from the stable backports, as it was causing issues
> on the pixel devices it got backported to.  So perhaps look there?

Hmm. That commit is obviously still upstream, do we understand why it
caused problems in the backports?

                 Linus

