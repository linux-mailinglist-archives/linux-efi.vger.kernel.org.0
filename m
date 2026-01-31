Return-Path: <linux-efi+bounces-6067-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEfeJFNkfWmtRwIAu9opvQ
	(envelope-from <linux-efi+bounces-6067-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 03:09:23 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52BC0388
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 03:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7639E3007B04
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BC330B22;
	Sat, 31 Jan 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdY9sAoL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5BE2FD7B1
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825355; cv=pass; b=jEUmgjK9oEkquhvtwvWhrq/tzGBXOrUaHz5y9OUYE98P0MTm3d+V8dnqzCSfXEZ9q7cH/pSR3apvPrxX4DtlS9H746m4GUHqeOjRmZgQj4bbXTKFi94u7IN6yctOm1PiN9tkrembInpCvnmp7geeO1Kfxh5xBFIjXNMCEh7HqKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825355; c=relaxed/simple;
	bh=q1+m69AC8OyppS+g1qL0airmm2fN+rGF7m5h75RejBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+BNFxKREAIksMawfrwwigPe+MVvdOInoTicJAwuGW86jXZQ1QyidN13r5mmyils9jrHsUyhaCbX9qNABf58+KzH3101FfdRSQEem61aeiGVKjeyphl1HgqVzC47NLL3sp3bqsCA2yGWYvz7WCWJ15ppfPsTbVk9lrQ36Y719m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdY9sAoL; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8849dc12f6so406058366b.1
        for <linux-efi@vger.kernel.org>; Fri, 30 Jan 2026 18:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769825352; cv=none;
        d=google.com; s=arc-20240605;
        b=YRfcv/0+UGOLY61NfBeWXmg0Ypa3vz3FDCnXyYJ8LR4iT5nYa60cDDsPpJp2ZqhSDE
         /2g8Tlh+uGPodNMwZjR8Vef6SEs/bFQr045m2OzfUCFlG+Nlr6Q09j+1dxGuSR9uPPtg
         SEzFbpPKgBmdh5dGncspf1giV3HGFwO7/6Fu5NFzX38cvRy+unMhVKSsPvhBeC+8qGbw
         0mS5qQ6IEBFWzBusTHQf6QPxgfxAc/5MjExGdjEqiEUV8JzF4yqFtyHc03V/su41E5p5
         aqaQGn1IeM674FT6H9YqqPoeK1c+YPUifiaX4nTbpZGWJQPaoY3CwbQjtJ5wAAK2T5ll
         Wbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        fh=NxTbjVRpUsQf1Gs+uLc3BIqFLhMI3HZfNK8Cv4xpznQ=;
        b=cFctxcOldsvvvASMVbMh/bGcshl6b72rMQeIlNZJsasXlle3Y1Urfn8+c98pnMptp8
         1qd/rsqusxwpGstrcAISFEf/UEBCBUA1u83OQnVrUtg4g801PGteU26cqcrTvDCsv+Aq
         PvjLNXPHEKizlCgl641IWUn0KVwHlkTEXsloFeIbbhck/5e2C0lxjLu7VjeCLCYqB5k6
         6BxoEe70GC4ZX152oyhqCxyj1H6fwopIEYJQxBVSrRu3d750vLGPRTXtoyTbwLcCt+4b
         eCatVijYoPMsy61S8ra1cP705ugAhwB2as/9MsZZ7xNDfEBJjYHwmgJImfz1RLLRJvQq
         BiAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769825352; x=1770430152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=mdY9sAoLvV09pJjCxND5Iu74NfN+XMMgrupYs9by8DK5G2zZFOokwzfRRZKmBD1gRY
         AjgQpgB5EjSE4J0xzK51/PodGanFU83GL26fHQqfL9/acxZXA7eQC4icggJ3OPvsx39F
         rYB9x3Oswo696/SSnggh0yy/9Iw7SYfPVlLnKssfKPM5puJqBDEgC8TBKfmP2p9p8y9J
         mT2bVhCFO3fDAmUxql8ri6GZjywb818fU2vt3kLT6LeM+Nf8WkTqwYY0efhXBrLT+AY4
         ERI/xwg6zoS67zkSfCmJiRPlXMmkdYhH8jWl+xYzOwFG7Hx6lv8E8XyifBvgTABOhkOv
         aGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825352; x=1770430152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=krerLGW+p+MFWPqUbWIa706z2k2Fq0PWLegD6lrksHndGmueUvaLW+Ve4F3a6g7xjr
         RpYMRSf/b73pt9BjiPngR6Rkf31XCXzD0jxLsPcmLPUA8V6fnBG67QEjz+L49bQdaW4W
         GJBXUyrlhBFLUFxK93Lp/tVeKVscBP14EF6EY4RQGVIAle7BmzoUCvnkaTufrFcJySMC
         o28+OUYtbkh5iDdkAZc3OvNE75vKPNR/XhdfJz3evE6zz7MjkcNDayqglIra+FyQktLX
         PRe9pWr3KvfwNS9BHvVbUfzvw55Jh6Y9ROVTvnbTG9RC31gZyVOeawsTdwkMcLjlNAcl
         s8ug==
X-Forwarded-Encrypted: i=1; AJvYcCUNEVJ16SV5jBMlm/mHSkzFwuJX5FcOa2m9+0xzpbzRTqYufDpWYzH/wpfmZSs7B6POuwG5sv3YL9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3FaqnuY8bjsTYSpo6heyyp7bgMHno1aW1YoWpoH3DJlouENS
	9HtrFcsuYkLeZD7ltM8khU03ADdjAhqGSHM+9FWzU97T9+DdXHijowuzVpa1jy+Km4plTfMYRUX
	QzjNvORArEprYiQal1ImneeLLW/8AoSOQGaq/Z6Qv
X-Gm-Gg: AZuq6aLhZGPkDzTzdcP/Afcek4acz9+MYQt6Cpir1nVskMn/88GbAf+h8cIymx47mc4
	d/FridqSV2wE/82pag4+9wIUyiZOEJmcIfGZKEU4Dq4UbxB2q9pJ+fF1mUCoIsEg4DNbhNazWiA
	A2H+K6nng8VttBR5HWXsZ1zKLz9/N5vOLr09Ezbhb9dHi29v0YCGu7EBuGcHvTysYldBVgved5X
	UO26XM3IBXr4tEV4SEr/z/dJ7Wa9CmggLtToc7FOOEestVo732oP5916ioOgafB0yerBDksFWXF
	LSM=
X-Received: by 2002:a17:906:f5a8:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b8dff5d84a1mr304116566b.28.1769825351931; Fri, 30 Jan 2026
 18:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
 <20260131011831.GZ3183987@ZenIV>
In-Reply-To: <20260131011831.GZ3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 18:09:00 -0800
X-Gm-Features: AZwV_QgpcNm32QTyYTJNZ2e8MpZD_azq4tiS_evKebHi_xWHPJAAyFUDpR04HdE
Message-ID: <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6067-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE52BC0388
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 5:16=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:
>
> > > How lovely...  Could you slap
> > >         WARN_ON(ret =3D=3D -EAGAIN);
> > > right before that
> > >         if (ret < 0)
> > >                 return ret;
> >
> > Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs wi=
th
> > this addition.
>
> What the hell?  Other than that mutex_lock(), the only change in there
> is the order of store to file->private_data and call of ffs_data_opened()=
;
> that struct file pointer is not visible to anyone at that point...

Agree, 09e88dc22ea2 (serialize ffs_ep0_open() on ffs->mutex) in itself
is quite straightforward. Not familiar with this code path so just
speculating, but is there any interaction with previous patches (e.g.
refcounting)?

> Wait, it also brings ffs_data_reset() on that transition under ffs->mutex=
...
> For a quick check: does
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-=
wsamuel2
> git switch --detach FETCH_HEAD
> demonstrate the same breakage?

Had to adjust forward declaration of ffs_data_reset() to build, but
unfortunately same breakage.

