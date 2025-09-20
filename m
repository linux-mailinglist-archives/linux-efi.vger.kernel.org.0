Return-Path: <linux-efi+bounces-4921-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E0B8CCE4
	for <lists+linux-efi@lfdr.de>; Sat, 20 Sep 2025 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB94517C82C
	for <lists+linux-efi@lfdr.de>; Sat, 20 Sep 2025 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C052D0C68;
	Sat, 20 Sep 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gF7BFj7s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455A2248B8
	for <linux-efi@vger.kernel.org>; Sat, 20 Sep 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385610; cv=none; b=I2lRRF1l405z03eVfzvXpOfnabW3iHz73CTrlMxV6t99ZxSZ7PNW5U/pm7Jspy+ijZAvpVNeOgb4UOUyskszFjtkr/8QI6NoFKl68cKujBqAktOrtDgxUS1nrFKuZ3eImwMoV+W0qakA/+Ng37i+BUqolzAUZ64WR3BDQ3LtFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385610; c=relaxed/simple;
	bh=mNO5F5NJlTITJbrMxJ3wyu2jz7VIBwYhTqCKBzbt4xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMW8d1/HMTKJHX9wK/1JK2ZZfAV5pudn5jb2Ndt8KRHEa+2Ily52Jp22Cb31ULn7/vH2u2Bt8h9+2aX5N8ZzQ/Hi3hN/AsLI3OdkZjrt1qJvGozFDpOH3sM7AHJyYeWtK+BzEHGLuOBazrZmTvlZpcNUMYevSvZ9TsBoc0tkeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gF7BFj7s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2350899a40so402024366b.3
        for <linux-efi@vger.kernel.org>; Sat, 20 Sep 2025 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758385607; x=1758990407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvLRCncIiqRrC6qT6Y0+vbtoZaqXeTLbbsZoYra2n2s=;
        b=gF7BFj7sOv/VqXY+/xuahlh6nSPkoA57qcYvzlRygbgTDQB0zpTeG6kSEMyn5K3Skt
         QhPUjm18PTTAnaN0fddwPfp0vx6EqqzAVpTVGst7XpeZRQXxoFO8aslfjehbjOBiNgS0
         nas2kfYKlT6krlS1MKWeVERsGzlqNiJtB7sdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758385607; x=1758990407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvLRCncIiqRrC6qT6Y0+vbtoZaqXeTLbbsZoYra2n2s=;
        b=loc7k4B93JEg0wP+vQ2jgN5g9YFIzhspsORnbNy3I8PKpaAi1p7PWCELjNlwGEXXRV
         4OPkhNV8pyQ0O7sJCuQPiCqzrHQd+6wbPvF1OAduWiFrIE3GFZcAOMHkSASsJj74gEJz
         bd3rV0DiBGTZCcrnx9t5lUvTBjyMtHgEpFXsDtBUO7/5L/AA8ipLo+w02d1LDmUcrFZv
         OprBaMlYqKbNWIUtQsXuOKGBGHBbB9ZZFQJ/E/fa5j7m7rPzr9HjV2h8tsk4klkolaaa
         xwUnarWHhV6ENfGfpRaoAVh9LaFTxlxZRIWcnrO4CKHac1/FhImeEnyRuVloJMSPUdjg
         5xvw==
X-Forwarded-Encrypted: i=1; AJvYcCWFi3z/paw167b8VrooywDWkpu0hTRpk6dUedr1G+oKxwGk+OtNmbXLahx+e79K1zc2AcVpyZ3VNWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHc3vwe41dRBmSZZ6JjUx1iK+t6cUD820yvaDa+mK+vqeLupe
	XsqFogk93dGQsZ6hkj7C24Q74qH9fwQGUE4fhb9uPQORFv+yjZYoop5aV+8Ofy07RSXjLyz8Gt2
	MUiVt8AY=
X-Gm-Gg: ASbGncsnES37e4Qzx9OXw4EPTwn2m5/J+tVdoXhJ+Byd8kv6bNomQjY2PZagFQ0mnjv
	ITWG/WN9Wj0EvOv/Xjq/DqxbZSDPV8rW5/e+xH84ZHP+1rUv5SHvo7VbTmCLrQcBeeQ4IYsKUwg
	pjWJp+xC/9Ri8Utruh0qrhCuLfVc8R3z1sLPgScxpePbcix/rVI0WREBg0s2v/SnpsrgdD5LLkB
	3AyeOxT4PRw4uiqcWe3uaz52cpcVY3RUZ1M7fSbk59kgjj7AlRFkfh85GPW6s3QNO44PGPgn57o
	0UWd55yYi325G/uyizPzaAHMMdWq64xEM6tGBhlbxzcrqnoG+s/kVfBGhrQwkUkrFZkCYdw61Vh
	vC5gcOFmCqYYsgWsbnEiXVCaXFMJFgCHjxG1P958PZ3yNSXNI+E+JZpHsAKFgZ97knFHk6VFS
X-Google-Smtp-Source: AGHT+IG2cTqhaNZqkyW5Vzf56/SM87jE4ezR8QKKvFrvi2SpYp5KOMrO6OlTR8/JvNZNhVqKfu/SNA==
X-Received: by 2002:a17:906:c155:b0:b04:b435:fc6b with SMTP id a640c23a62f3a-b24f6e93047mr690822866b.60.1758385606873;
        Sat, 20 Sep 2025 09:26:46 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52fesm248348166b.59.2025.09.20.09.26.44
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 09:26:44 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07883a5feeso600156166b.1
        for <linux-efi@vger.kernel.org>; Sat, 20 Sep 2025 09:26:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHdXmwoDa3MtNCtmyYr7mEZezxaCZDWI4Ybp9ROMbB0OEEbBOFEynbJ9MV6qRiKgLQjN0Fe34YSQ4=@vger.kernel.org
X-Received: by 2002:a17:907:1c89:b0:b1d:285d:155c with SMTP id
 a640c23a62f3a-b24ed88702cmr706169166b.7.1758385604052; Sat, 20 Sep 2025
 09:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV>
In-Reply-To: <20250920074156.GK39973@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Sep 2025 09:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXPnY9vWFC87sHudSDYY+wpfTrs-uxd7DBypeE+15Y0g@mail.gmail.com>
X-Gm-Features: AS18NWCBuRxfjxFE7tKBAQqhhkva7pQWM9EJwSLVmis6atYjgiGA5eqHrxKhjLE
Message-ID: <CAHk-=wiXPnY9vWFC87sHudSDYY+wpfTrs-uxd7DBypeE+15Y0g@mail.gmail.com>
Subject: Re: [PATCHES][RFC] the meat of tree-in-dcache series
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Sept 2025 at 00:42, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The branch is -rc5-based; it lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.persistency

I reacted to the "d_make_persistent() + dput()" pattern, and wondered
if it should just use the refcount that the caller has, but it does
look like that alternate approach would just result in a
"d_make_persistent(dget()))" pattern instead.

And I guess you already get the lock for d_make_persistent(), so it's
better to do the dget while having it - but arguably that is also true
for the dput().

I think you did pick the right model, with d_make_persistent() taking
a ref, and d_make_discardable() releasing it, but this series did make
me think that the refcounting on the caller side is a bit odd.

Because some places would clearly want a "d_make_persistent_and_put()"
function. But probably not worth the extra interface.

Anyway, apart from that I only had one reaction: I think
d_make_discardable() should have a

        WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT))

because without that I think it can mistakenly be used as some kind of
"dput that always takes the dentry lock", which seems bad.

Or was that intentional for some reason?

Talking about WARN_ON() - please don't add new BUG_ON() cases. I
realize that those will never trigger, but *if* they were to trigger,
some of them would do so during early boot and be a pain for people to
ever even report to us.

BUG_ON() really should be shunned. I think it makes sense to you and
for automated testing, but it really is absolutely *horrendously* bad
for the case where the code hits actual users.

                 Linus

