Return-Path: <linux-efi+bounces-6061-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yACjApNJfWlZRQIAu9opvQ
	(envelope-from <linux-efi+bounces-6061-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 01:15:15 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9BBF8B4
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 01:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CDD0300EC81
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679572D8766;
	Sat, 31 Jan 2026 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VL7UTlDC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8F2BEC5A
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818511; cv=none; b=lQXXEvlaRiRGO0dHBjU/1gMmgEnI2ItoaiBdYXaeQY1tV7BTlNxDAINvs3ZjeFoX/MYwYps51N2556QfwROUddB5IIvkOi7/rXM6HHK5seOGCvJsSDTx5g59BcFJS35og3zyY9pP5ecx2EaZOdj9JhFWFlWLhH7KA9WNWgg/H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818511; c=relaxed/simple;
	bh=w7+B8N3XRoFg3Of/Fw9iyPoy/mghU2Qrl0CPBbBgDGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foWAod1NT8HGDh4Egz744nj6efnca1uQ9Tk1nlO4DIq8PPPs2O7CSqMDfdM0prL88gzKGXoonQo3oRfqWkGL2CZ3EFrRE01hsjRNOVOUPofWlyguW37JZ4bULlxFPX/K6I0FFRWmvJsUMj3tQjMFrSS+U/SkZbBPc3SnMgIf6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VL7UTlDC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8845cb5862so413403166b.3
        for <linux-efi@vger.kernel.org>; Fri, 30 Jan 2026 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769818505; x=1770423305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=VL7UTlDChcJa2PjZiznhPkBQ74jppyCs6t1eZZ+ZriJNhsFTdKenuCsI0e2iJuz+HY
         ZpfC4O+qJz9WVU/HzqY4q4DpaadaAYI5nA6gHHgjOZkoz18Ox8tOXoeAd5M/TZxcKSZs
         OupLGt/VcAOOflV/9RiYm+75G2NAxYO26YIRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818505; x=1770423305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=ONlsnkHXBg2CFBr4S7Ik54r8t1IifLY7TPE0W4pRhAgUuB8BqtAwSSd7PBeO77MSa1
         7Vfk8ZKmNnlAewepdCy6PKo4xzDxnLSvjBu7pet8SyGJeSVmwRvg/0YLaJoGSyweFFGR
         KNB8VL1XqFCL/XTeBGjJvVmI9eKb1SRuz4Iulkfa0yUDC60puTa4hkWa7mKlnfUxACD6
         rPmFB4tIaa7sfM47kstKbCZEbuPatGgG2nieaRocCy7C0ZRvvisywFMFgPNvRGP57pA3
         Fu48ka+ndqBjpDhbCqFdwtoxNclJEjySxtLSQtdfIYE072bDyWo+rTKwp5hX1pfzYqB6
         8fVg==
X-Forwarded-Encrypted: i=1; AJvYcCWvEMJlZkU92aDvcdH4GfOatWcNt6IBALL07GNTF089d4TFdaVxtl75jSANNDR+NvIbCj0orbcQ7ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwww8fagaS7Wg2ASaWA88GrNx75HYZJpa0PXMwlOxxxI38eiPW
	a+r43uojIrwkIUmsAmp7j6IjLdq+yRG8MbqVzlDurEdiqPqGjjiYxQ7IIRO3nBthuWM/Dzq9wEr
	PV0ajGW8=
X-Gm-Gg: AZuq6aL5mHKBbfwWPz17HBydCiXlaL+sf/6MKG1Fcii+882jPohYK3XVftGb4fdeOBx
	CBJeDCKkQdKoLUNgCeqKtD9dVEni3PmdcR289SBg82DApM3+RH7JKxoJDKleJyFIrH8HJB/+Oz8
	W/cR6jnbJ2cHoFOUlSqLqOa7SmKQt2jLBOWxG+94vELKn1wqyuc54AkTTamTvPcEJ4sVAO9E/aj
	0MhLvQKwSVm4NDcObYhwv9ofZvXVgwFpmGln5BkFmFEhN7U4usiwqESgJPzmzG0z462wNLK6PGI
	1jZQXLAIdeZtPiWk34GmjZif7uiSCz/fCKGWNtCSagiYikfUgoeXxHYAp4QenkxBosP0tMJEYa1
	3F1AxRUWYdXDoT2wyjD2al+Jta0VmcCcU/j8hSxnnvbPkTfigv7Q0sks9WcjNnhrD1Q9r+PYvsU
	d+kN8Peto6mR+n8LsahXVcHaBBRbUfr3bBM72zYVHr7b1Xmn5z5X4S9YhZA484
X-Received: by 2002:a17:907:785:b0:b87:d186:19e3 with SMTP id a640c23a62f3a-b8dff6d1b65mr316124866b.43.1769818505538;
        Fri, 30 Jan 2026 16:15:05 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed584sm505273366b.61.2026.01.30.16.15.04
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 16:15:04 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso4635799a12.0
        for <linux-efi@vger.kernel.org>; Fri, 30 Jan 2026 16:15:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8zl5/Zdj+26nwOgshKnmJFSDYFkBqLeXTkWw65BLFl5IaM3nWCJYWzUh+368HD9TvIyDKhhgDZs0=@vger.kernel.org
X-Received: by 2002:a05:6402:1d54:b0:64b:4f44:60ef with SMTP id
 4fb4d7f45d1cf-658de593957mr2779765a12.27.1769818504441; Fri, 30 Jan 2026
 16:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 16:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
X-Gm-Features: AZwV_QjK3epqif7-e_sBGUc-n0f418Z3nV80PkvQC8yX5DIdQ4ynfWKt9EE0KMI
Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6061-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-efi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 65D9BBF8B4
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 15:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So we have something that does O_NDELAY opens of ep0 *and* does not retry on
> EAGAIN?
>
> How lovely...

Actually, I think that is pretty normal behavior.

Generally, O_NDELAY and friends should *NOT* turn locks into trylocks
- because user space has no sane way to deal with kernel lock issues,
and user space simply shouldn't care.

So O_NDELAY should be about avoiding IO, not about avoiding perfectly
normal locks.

Of course, that horrendous driver locking is broken, since it holds
the lock over IO, so that driver basically conflates IO and locking,
and that's arguably the fundamental problem here.

But I suspect that for this case, we should just pass in zero to
ffs_mutex_lock() on open, and say that the O_NONBLOCK flag is purely
about the subsequent IO, not about the open() itself.

That is, after all, how the driver used to work.

                Linus

