Return-Path: <linux-efi+bounces-5207-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34DDC1779D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 01:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189C51A66DAC
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EB1D7E42;
	Wed, 29 Oct 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rm/tQAfY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE921CAA7D
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696501; cv=none; b=CbceqYwsL6K9xz+RBdXjLyQnAcjHkfrHpxyaAn+6qBtlY1hgnWYGfKkNPE9B9F8/WW0QVdazM9xuI2XxzvJtR2VmgDUrUSt6Rz7lbezrP7bc6sRgxYoMGSTARCa3BR+Fq9Ho3iXTJbYYic+1Gqx9jZJqKiOWL1/Ds3rFOwe0QEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696501; c=relaxed/simple;
	bh=4+0VmKS7izmdzBSkGnuSr1zXLYq/caM1BpBnvQPHwUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRqDXAqPL4EYAW3QU+8nS3jY+4RK2I0oUiCb+J6ho8itbKNBMDC6u6tl0wOgmz66hJ06XEj7P+LiQrWUuTWJuRr6AKe0XhstpVDELPlxyac5ymswcyIX/MCiHW9gJHGZOKq4kzT9VvRKKqFv6mbSHup77ECBLHchM5hNvF128F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rm/tQAfY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6443371a91.2
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696499; x=1762301299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZjzJP5BDJixdHcjsD4MEtXcdIeCfYM/75TifkWeDww=;
        b=Rm/tQAfYDRv9P5gu7ha5CsCLxdHAVSufx4wPrLRv39Ao5X4Zd0nLl4WMq66DKWF21j
         pzblNcL+S7EmmehpeXxiCucHVp/gIxF+345p35vVv7k3j4S9XiyILrrjYNpDck8Nwjvf
         u0v4idUFcDSYLq+/hsZKpXYxYmCl3he69VZ7RAvIotMFQhDCV2Kqsptie1SrDLZP1AA0
         kxbVDhUun37cH9zNf8QuTePAzGTU4YKjhVH0cU+/jVfx/MbmEfEddQxZN+GQ58Zt0VjO
         DdJYJ6gKRYAwQ0SnbRvOZxH3etqOX762S1vBeYEBv174TLf5QcBHlHYWHsPxQFrzkq1d
         oq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696499; x=1762301299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZjzJP5BDJixdHcjsD4MEtXcdIeCfYM/75TifkWeDww=;
        b=qwA/3bSqll+WrUTz/CNIUHiMi0PeTPxj9VEGXPAcjBQltGnyL80UTlc0Rr69Bb65vN
         GUwyLuR2yV3swmd/fAKppGzwmdEmBdLMk/yuc4bGIhLmiwAZComp51afGslYBNPReD9H
         L+MO5mW7laelzQtGSwkzBNc/rea3Yn0pJknt/WsIFKNazWHStObI+Sxd3cTPmmtQs8vx
         VA0Aprlxtu2GpERRxqGfq+Mo4jUCdJXGLn+pCEZe7kPWzto/cJUslhpAtgklk9GSiDqa
         f2RXirYIBCemkGHgPU/rEQF7eKXunQG4PLDdJmgaFRoV9JvnikDs7CbHJ/WkrL1snO45
         h5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWWe9bgwoL5F+rGaB13cnmAB3rjKlxj5i90cYNvOmrEY6YxrN6hNULfPWDhsJ3liJGIJU3EiwgWdwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qEpgiprL6hNEyyhWyaDqeGzP1Ekwx9LncGvHV03LCGllV60X
	rtOYNZNi+5i0VC9TRUyBzax7wCtO2oPcDkuwLHIKBigx4ZB9bz8Qn1quTcnWFHZ29YAfXbKyIdD
	VqWZztDqwUtuf+tQXZiO+cVXaaKZw2/DsPAuGzU5Z
X-Gm-Gg: ASbGnctD5hsGBwwXbM5ZDfJjhq2NifTvMW+wghBFzN4bcpbL9ceRrFc8xytuDRE+oDT
	PvIDDUiJ65slrg/LRqbcJ2o2TbqpAQYs2O753w6UzHMDIl/wjCRwTV9+Aos5n6IVwMXaycxbpLB
	m37McshgeTPtJkRR5oZ4AkD8w8EYf77njPxoqqVJ+nSg8C9iFrvWJ+TNrE0f1TEOSODtzlgDQjj
	ATtvfTAu3QI02Rlp5uL++lwc6kt9wGo4Imw/WwrPw1vfhwMSAKKrOE4J2XU
X-Google-Smtp-Source: AGHT+IGEKRPFq5L2rd6w/ubcuTn//BXhetf/wOj9xAOGHPjYYno+UXGan0WlvoJBaoZ1JF4tIK0SCxZjeiDlUqLjb6g=
X-Received: by 2002:a17:90b:4a05:b0:339:ef05:3575 with SMTP id
 98e67ed59e1d1-3403a294f2fmr971614a91.26.1761696498871; Tue, 28 Oct 2025
 17:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-34-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-34-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:08:07 -0400
X-Gm-Features: AWmQ_blBn2fdqYcxKi_H91_QLngZD09fAUzDyH5oMtRPekpRq9pqWMOuQKzGUHw
Message-ID: <CAHC9VhSeiK=qqLMUDAKRTgS5EEHdVvLD7-afuDqJWYFindvfUA@mail.gmail.com>
Subject: Re: [PATCH v2 33/50] selinuxfs: don't stash the dentry of /policy_capabilities
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
> Don't bother to store the dentry of /policy_capabilities - it belongs
> to invariant part of tree and we only use it to populate that directory,
> so there's no reason to keep it around afterwards.
>
> Same situation as with /avc, /ss, etc.  There are two directories that
> get replaced on policy load - /class and /booleans.  These we need to
> stash (and update the pointers on policy reload); /policy_capabilities
> is not in the same boat.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

