Return-Path: <linux-efi+bounces-6051-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLhzKuewemk79QEAu9opvQ
	(envelope-from <linux-efi+bounces-6051-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 01:59:19 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E4AA6D3
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F23213006224
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jan 2026 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F5301472;
	Thu, 29 Jan 2026 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgiTQEnp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D521242D60
	for <linux-efi@vger.kernel.org>; Thu, 29 Jan 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648352; cv=pass; b=WZEzuEENmmP3s0+zq+BHwk8WIYJvfCMfyWUeFPzGo54orEj7QY7vbm5ukTwt3tOoFQCk6YUHUL2wH7gRU3RDvgytgRjb25xMOvGDdPNYGfOz9HN+peqSQh/8V23mEknEjONgQGGf9YR+8mzq7I2W5T04MnF/G6UwELzr5IVJPgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648352; c=relaxed/simple;
	bh=+L+EqsxFGbq9nKKnaprPm9Ir3tOy0vr3+xqa2zLh1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi0/QvzcPDJxyoO7qcyEMmqTC3AfGE37qsQmYQ5Z8xC/rp1gFoeb9IKOH/KLa3H2u0tuugMUVddRKss8SZuqJ+P3r0IyjV6eHuuK2L2Vq0dJp0DHhw4qkTybff2nRb9bOT+4qRZ0UZwkHmRBb2Q8X4H3m2QcpyJnzXt0MvuTFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgiTQEnp; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so764773a12.3
        for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 16:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769648348; cv=none;
        d=google.com; s=arc-20240605;
        b=TWxb89tBd6vzmmX9TQtC70/Muy/ApMRyJVsoR7sc1o/yZdmRz5iNEOYQMl1VfhG7ve
         t7bh4MZ7TiNlLK94rbWaebRiVt8DbzZGD5RAcYH2vCipja8+v6h7/0UDhzs/TpphiXuv
         Vj+loPTfuBgJZvfn86PvKPVK78MPU+BYdeXWPLhEJOznksmo9tTRMxUAOHNww/6Lo+DX
         Xx4iD/EKgVR6FAZ8xWNSv+h8te9lePJ1km6MELZbzDWWckmhYHziOww4hJ85cR/a927E
         N5uIa9cOxqYK5M1yQQJLqXooIHswN4d6pz8tRS2y/QsnLfS6TrE+i4JI4QR5lg9UzUz6
         jNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        fh=wsMtivbbZIQKnS9E8ySJ21Arr/mxSFH5eVyCVXw3j58=;
        b=IMyfgxeRKstENAprvuj8djkkhnCFHa+6fgZEDOz5AGy+vRkKzAAvpbn1Pmvd6ThzGv
         7w4pOtkjiO9zxoxi0deIQRjjLigqQWllzVBSt9txqWCqyC0eltZanabrx/jcXpx0nfuF
         L/Z+M7+VHEhjg/Z0eB6yWxCJE+tcrOzq7iZW2p+WjfXKYeD6ybDObOmG6O9G8g9y216K
         ay//2as8T/SexvtECtHBqksrAVa6YujvZ84YgU8LW3mGKbo7Cl2275hZrV9weanGC0oL
         ex0lhouB28FbA8elEQpKIaTNrnvQlXhb29qZncbE7Hf5r88BtYmJ+cZ/0dNdECbaIUA3
         +bRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648348; x=1770253148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=kgiTQEnpKJp/pjWzH8UIBoZE2prYNeOdPAmDcSgp2w5aKDPBJN5uF6sIQ17O5EEcaN
         ACyLVBvVNlwDDlteA0YIqufuqAY74ZjqMbYJ4tJU9NEEZn94CcJXo/9Epjd/HQczmXSw
         oQ68UlJ+ysPe1pwWStyhBRWb1KgBhwrl8ect/5mMeMeC2LbIGU2krUo3qleFHZZcB5UL
         oZIcbiABabn8ZJ0AByRhAkYpLWueJfg6OQRWhq9Hw7bnfLKCMVArAe1ksTnsKICVRJSs
         d5Dacf8qFkgg7Xd+y+e6WdzSOZLhxyO4qtDTDvpFsyFA0L760P9y01OOVPtjLx3ifnCU
         1Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648348; x=1770253148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=gKyzSxGJIkSdujRbhIiOel3qde9XBOny7oumO1X9lYI7IGAlRgfr2eVm8NwbXHrZht
         sZsp+yADoR0ge8rUR6QpP2Tme/mleohydJscaEfwnQcOYhM6UJ2f5jYytgJTtjOCL5ak
         el3i5/nFeg9hTR0FgkFFOp57QjmSKy8XA7LzDAgAy4JlF/Rd7MTWwPf5YFbKQut/vr4S
         8hwr/EHc8FlZNyPEIZ0PyneH8UAe6peniTHmmabjwzO4NfEtHDzrBRls8jGOw/JkJ3Ub
         qdBnnhFP/9n5oxEyo9AUH5dCUCUsPHIM0QgbCbFGQwofyWhylDB6E3MkcmE1BuC2m3gc
         0mLw==
X-Forwarded-Encrypted: i=1; AJvYcCUjNSgG2iGIpFOJZzMTzwsKXpHPzjhkpuYq06ksBBROtaYAbVHuWuNsyBaL5nRfU7KLv3Vja1L6OdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQFiFXx9wf0snKyYo9czW/K4+comjbBeoex9ikW14/2K8V9G0
	kN1HSb+v6EIZgzuspz93v8dGYuq4CAwi20MHpFruF0fbicX+YxluXtcEdAkwFA2IkBW7nogHIYS
	3UyFkKPQO1VRHoZdHZHwMVZ6H+bah6oAXEK+Kx7W6
X-Gm-Gg: AZuq6aI3n28Rv07HH/eVG0UZiqc8lhsIV9II72FSB822vRy8XXMe1sm7O170Uuej5Tu
	Q7n5vRcFdRqX/6huEhCuPMBAwN2OJI8+ZOWqALK0w/xSJIKJNJ6HSGSjyvU/F3Ykxd3JHniyT65
	3u68fp6x+vbMljffkLvutP07mz+O/VRh4wMNtA3E9TbmSK7ulOp1P9ofP49c3Bc8T1R7UiPOcY5
	q8GBfMJz5oHQgEApQHtsmLel0fIhsNjRVqJY8rbeksJ/F8NTWiCZohNpfW29klXzNWqVMkuoD7B
	Gd2sL9U5ndWhLWfiXn1a7TwVJ/i30Q==
X-Received: by 2002:a17:906:f585:b0:b87:d722:f824 with SMTP id
 a640c23a62f3a-b8dab3cf66amr455166566b.63.1769648348337; Wed, 28 Jan 2026
 16:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
In-Reply-To: <20260128045954.GS3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 28 Jan 2026 16:58:57 -0800
X-Gm-Features: AZwV_Qg5mDXEWLmzjtDFHSng8MB2HQLUBKHQ6Wr860X_lRTmL3Z_ZmvOjLnN07o
Message-ID: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6051-lists,linux-efi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.org.uk:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C17E4AA6D3
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:58=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
> demonstrate that behaviour?

Reverting only 1544775687f0 (functionfs: need to cancel ->reset_work
in ->kill_sb()) does not fix the issue. With 6.19-rc7 as baseline, the
simplest working recipe at the moment is with 6ca67378d0e7,
c7747fafaba0, and e5bf5ee26663 reverted.

